module TomParse

  # Main interface to parser.
  #
  # comment - code comment [String]
  #
  def self.parse(comment, parse_options={})
    TomDoc.new(comment, parse_options)
  end

  # Encapsulate parsed tomdoc documentation.
  #
  # TODO: Currently uses lazy evaluation, eventually this should
  # be removed and simply parsed at initialization time.
  #
  class TomDoc
    attr_accessor :raw

    # Public: Initialize a TomDoc object.
    #
    # text - The raw text of a method or class/module comment.
    #
    # Returns new TomDoc instance.
    def initialize(text, parse_options={})
      @raw = text.to_s.strip

      @arguments        = []
      @options          = []  # TODO
      @examples         = []
      @returns          = []
      @raises           = []
      @signatures       = []
      @signature_fields = []
      @tags             = {}

      parse unless @raw.empty?
    end

    # Raw documentation text.
    #
    # Returns String of raw documentation text.
    def to_s
      @raw
    end

    # Validate given comment text.
    #
    # Returns true if comment is valid, otherwise false.
    def self.valid?(text)
      new(text).valid?
    end

    # Validate raw comment.
    #
    # Returns true if comment is valid, otherwise false.
    def valid?
      return false if !raw.include?('Returns')
      return false if sections.size < 2
      true
    end

    # Validate raw comment.
    #
    # Returns true if comment is valid.
    # Raises ParseError if comment is not valid.
    def validate
      if !raw.include?('Returns')
        raise ParseError.new("No `Returns' statement.")
      end

      if sections.size < 2
        raise ParseError.new("No description section found.")
      end

      true
    end

    # The raw comment text cleaned-up and ready for section parsing.
    #
    # Returns cleaned-up comment String.
    def tomdoc
      lines = raw.split("\n")

      # remove remark symbol
      if lines.all?{ |line| /^\s*#/ =~ line }   
        lines = lines.map do |line|
          line =~ /^(\s*#)/ ? line.sub($1, '') : nil
        end
      end

      # for some reason the first line is coming in without indention
      # regardless, so we temporary remove it
      first = lines.shift

      # remove indention
      spaces = lines.map do |line|
        next if line.strip.empty?
        md = /^(\s*)/.match(line)
        md ? md[1].size : nil
      end.compact

      space = spaces.min || 0
      lines = lines.map do |line|
        if line.strip.empty?
          line.strip
        else
          line[space..-1]
        end
      end

      # put first line back
      lines.unshift(first.sub(/^\s*/,'')) if first

      lines.compact.join("\n")
    end

    # List of comment sections. These are divided simply on "\n\n".
    #
    # Returns Array of comment sections.
    def sections
      parsed {
        @sections
      }
    end

    # Description of method or class/module.
    #
    # Returns description String.
    def description
      parsed {
        @description
      }
    end

    # Description of method or class/module.
    #
    # Returns description String.
    def arguments
      parsed {
        @arguments
      }
    end
    alias args arguments

    # List of use examples of a method or class/module.
    #
    # Returns String of examples.
    def examples
      parsed {
        @examples
      }
    end

    # Description of a methods yield procedure.
    #
    # Returns String decription of yield procedure.
    def yields
      parsed {
        @yields
      }
    end

    # The list of retrun values a method can return.
    #
    # Returns Array of method return descriptions.
    def returns
      parsed {
        @returns
      }
    end

    # A list of errors a method might raise.
    #
    # Returns Array of method raises descriptions.
    def raises
      parsed {
        @raises
      }
    end

    # A list of alternate method signatures.
    #
    # Returns Array of signatures.
    def signatures
      parsed {
        @signatures 
      }
    end

    # A list of signature fields.
    #
    # Returns Array of field definitions.
    def signature_fields
      parsed {
        @signature_fields
      }
    end

    # A mapping of tags.
    #
    # Returns Hash of tags.
    def tags
      parsed {
        @tags
      }
    end

    # Check if method is public.
    #
    # Returns true if method is public.
    def public?
      parsed {
        @status == 'Public'
      }
    end

    # Check if method is internal.
    #
    # Returns true if method is internal.
    def internal?
      parsed {
        @status == 'Internal'
      }
    end

    # Check if method is deprecated.
    #
    # Returns true if method is deprecated.
    def deprecated?
      parsed {
        @status == 'Deprecated'
      }
    end

  private

    # Has the comment been parsed yet?
    def parsed(&block)
      parse unless @parsed
      block.call
    end

    # Internal: Parse the Tomdoc formatted comment.
    #
    # Returns true if there was a comment to parse.
    def parse
      @parsed = true

      sections = tomdoc.split("\n\n")

      return false if sections.empty?

      # The description is always the first section, but it may have
      # multiple paragraphs. This routine collects those together.
      desc = [sections.shift]
      loop do
         s = sections.first
         break if s.nil?
         break if s =~ /^\w+\s+\-/m
         break if section_type(s) != nil
         desc << sections.shift
      end
      sections = [desc.join("\n\n")] + sections
  
      @sections = sections.dup

      parse_description(sections.shift)

      if sections.first && sections.first =~ /^\w+\s+\-/m
        parse_arguments(sections.shift)
      end

      current = sections.shift
      while current
        case type = section_type(current)
        when :examples
          parse_examples(current, sections)
        when :yields
          parse_yields(current)
        when :returns
          parse_returns(current)  # also does raises
        when :raises
          parse_returns(current)  # also does returns
        when :signature
          parse_signature(current, sections)
        when Symbol
          parse_tag(current)
        end
        current = sections.shift
      end

      return @parsed
    end

    #
    #
    def section_type(section)
      case section
      when /^Examples/
        :examples
      when /^Yields/
        :yields
      when /^Returns/
        :returns
      when /^Raises/
        :raises
      when /^Signature/
        :signature
      when /^([A-Z]*)\:\ /
        $1.downcase.to_sym
      else
        nil
      end
    end

    # Recognized description status.
    TOMDOC_STATUS = ['Internal', 'Public', 'Deprecated']

    # Parse description.
    #
    # section - String containig description.
    #
    # Returns nothing.
    def parse_description(section)
      if md = /^([A-Z]\w+\:)/.match(section)
        @status = md[1].chomp(':')
        if TOMDOC_STATUS.include?(@status)
          @description = md.post_match.strip
        else
          @description = section.strip
        end
      else
        @description = section.strip
      end   
    end

    # Parse arguments section. Arguments occur subsequent to
    # the description.
    #
    # section - String containing argument definitions.
    #
    # Returns nothing.
    def parse_arguments(section)
      args = []
      last_indent = nil

      section.lines.each do |line|
        next if line.strip.empty?
        indent = line.scan(/^\s*/)[0].to_s.size

        if last_indent && indent > 0 && indent >= last_indent
          args.last.description << "\r\n" + line
        else
          param, desc = line.split(" - ")
          args << Argument.new(param.strip, desc.strip) if param && desc
        end

        last_indent = indent
      end

      args.each do |arg|
        arg.parse(arg.description)
      end

      @arguments = args
    end

    # Parse examples.
    #
    # section  - String starting with `Examples`.
    # sections - All sections subsequent to section.
    #
    # Returns nothing.
    def parse_examples(section, sections)
      examples = []

      section = section.sub('Examples', '').gsub(/^\s{2}/,'')

      examples << section unless section.empty?
      while sections.first && sections.first !~ /^\S/
        examples << sections.shift.gsub(/^\s{2}/,'')
      end

      @examples = examples
    end

    # Parse yields section.
    #
    # section - String contaning Yields line.
    #
    # Returns nothing.
    def parse_yields(section)
      @yields = section.strip
    end

    # Parse returns section.
    #
    # section - String contaning Returns and/or Raises lines.
    #
    # Returns nothing.
    def parse_returns(section)
      returns, raises, current = [], [], []

      lines = section.split("\n")  
      lines.each do |line|
        case line
        when /^Returns/
          returns << line
          current = returns
        when /^Raises/
          raises << line
          current = raises
        when /^\s+/
          current.last << line.squeeze(' ')
        else
          current << line  # TODO: What to do with non-compliant line?
        end
      end

      @returns.concat(returns)
      @raises.concat(raises)
    end

    # Parse signature section.
    #
    # section  - String starting with `Signature`.
    # sections - All sections subsequent to section.
    #
    # Returns nothing.
    def parse_signature(section, sections=[])
      signatures = []

      section = section.sub('Signature', '').strip

      signatures << section unless section.empty?

      while sections.first && sections.first !~ /^\S/
        sigs = sections.shift
        sigs.split("\n").each do |s|
          signatures << s.strip
        end
      end

      @signatures = signatures

      if sections.first && sections.first =~ /^\w+\s*\-/m
        parse_signature_fields(sections.shift)
      end
    end

    # Subsequent to Signature section there can be field
    # definitions.
    #
    # section  - String subsequent to signatures.
    #
    # Returns nothing.
    def parse_signature_fields(section)
      args = []
      last_indent = nil

      section.split("\n").each do |line|
        next if line.strip.empty?
        indent = line.scan(/^\s*/)[0].to_s.size

        if last_indent && indent > last_indent
          args.last.description << line.squeeze(" ")
        else
          param, desc = line.split(" - ")
          args << Argument.new(param.strip, desc.strip) if param && desc
        end

        last_indent = indent
      end

      @signature_fields = args
    end

    # Tags are arbitrary sections designated by all cap labels and a colon.
    #
    # label   - String name of the tag.
    # section - String of the tag section.
    #
    # Returns nothing.
    def parse_tag(section)

      md = /^([A-Z]*)\:\ /.match(section)

      label = md[1]
      text  = md.post_match

      @tags[label.downcase] = text
    end

  end

  # Encapsulate a method argument.
  #
  class Argument

    attr_accessor :name

    attr_accessor :description

    attr_accessor :options

    # Create new Argument object.
    #
    # name        - name of argument
    # description - argument description
    #
    def initialize(name, description = '')
      @name = name.to_s.intern
      parse(description)
    end

    # Is this an optional argument?
    #
    # Returns Boolean.
    def optional?
      @description.downcase.include? 'optional'
    end

    # Parse arguments section. Arguments occur subsequent to
    # the description.
    #
    # section - String containing argument definitions.
    #
    # Returns nothing.
    def parse(description)
      desc = []
      opts = []

      lines = description.lines.to_a

      until lines.empty? or /^\s+\:(\w+)\s+-\s+(.*?)$/ =~ lines.first
        desc << lines.shift.chomp.squeeze(" ")
      end

      opts = []
      last_indent = nil

      lines.each do |line|
        next if line.strip.empty?
        indent = line.scan(/^\s*/)[0].to_s.size

        if last_indent && indent > last_indent
          opts.last.description << line.squeeze(" ")
        else
          param, d = line.split(" - ")
          opts << Option.new(param.strip, d.strip) if param && d
        end

        last_indent = indent
      end

      @description = desc.join
      @options     = opts
    end

  end

  # Encapsulate a named parameter.
  #
  class Option

    attr_accessor :name

    attr_accessor :description

    # Create new Argument object.
    #
    # name        - name of option
    # description - option description
    #
    def initialize(name, description = '')
      @name = name.to_s.intern
      @description = description
    end

    # Is this a required option?
    #
    # Returns Boolean.
    def required?
      @description.downcase.include? 'required'
    end

  end

  # Raised when comment can't be parsed, which means it's most
  # likely not valid TomDoc.
  #
  class ParseError < RuntimeError
    # Create new ParseError object.
    #
    # doc - document string
    #
    def initialize(doc)
      @doc = doc
    end

    # Provide access to document string.
    #
    # Returns String.
    def message
      @doc
    end

    # Provide access to document string.
    #
    # Returns String.
    def to_s
      @doc
    end
  end

end
