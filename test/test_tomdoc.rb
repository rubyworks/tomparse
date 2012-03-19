require 'helper'

class TomDocTestCase < TomParse::Test

  def setup
    @comment = TomParse::TomDoc.new(<<comment)
    # Duplicate some text an abitrary number of times.
    #
    # text    - The String to be duplicated.
    # count   - The Integer number of times to
    #           duplicate the text.
    # reverse - An optional Boolean indicating
    #           whether to reverse the result text or not.
    #
    # Examples
    #   multiplex('Tom', 4)
    #   # => 'TomTomTomTom'
    #
    #   multiplex('Bo', 2)
    #   # => 'BoBo'
    #
    #   multiplex('Chris', -1)
    #   # => nil
    #
    # Returns the duplicated String when the count is > 1.
    # Returns the atomic mass of the element as a Float. The value is in
    #   unified atomic mass units.
    # Returns nil when the count is < 1.
    # Raises ExpectedString if the first argument is not a String.
    # Raises ExpectedInteger if the second argument is not an Integer.
comment

    @comment2 = TomParse::TomDoc.new(<<comment2)
    # Duplicate some text an abitrary number of times.
    #
    # Returns the duplicated String.
comment2

    @comment3 = TomParse::TomDoc.new(<<comment3)
    # Duplicate some text an abitrary number of times.
    #
    # Examples
    #
    #   multiplex('Tom', 4)
    #   # => 'TomTomTomTom'
    #
    #   multiplex('Bo', 2)
    #   # => 'BoBo'
comment3

    @comment4 = TomParse::TomDoc.new(<<comment4)
    # Duplicate some text an abitrary number of times.
    #
    # Yields the Integer index of the iteration.
    #
    # Signature
    #
    #   find_by_<field>[_and_<field>...](args)
    #
    # field - A field name.
comment4

    @comment5 = TomParse::TomDoc.new(<<comment5)
    Duplicate some text an abitrary number of times.
    
    Yields the Integer index of the iteration.
    
    Signature
    
      find_by_<field>[_and_<field>...](args)
    
    field - A field name.
comment5


    @comment6 = TomParse::TomDoc.new(<<comment6)
    # Duplicate some text an abitrary number of times.
    #
    # Examples
    #
    #   def multiplex(str, length)
    #     str * length
    #   end
comment6

  end

  test "knows when TomDoc is invalid" do
    assert_raises TomParse::ParseError do
      @comment3.validate
    end
  end

  test "parses a description" do
    assert_equal "Duplicate some text an abitrary number of times.",
      @comment.description
  end

  test "parses args" do
    assert_equal 3, @comment.args.size
  end

  test "knows an arg's name" do
    assert_equal :text, @comment.args.first.name
    assert_equal :count, @comment.args[1].name
    assert_equal :reverse, @comment.args[2].name
  end

  test "knows an arg's description" do
    assert_equal 'The Integer number of times to duplicate the text.',
      @comment.args[1].description

    reverse = 'An optional Boolean indicating whether to reverse the'
    reverse << ' result text or not.'
    assert_equal reverse, @comment.args[2].description
  end

  test "knows an arg's optionality" do
    assert_equal false, @comment.args.first.optional?
    assert_equal true, @comment.args.last.optional?
  end

  test "knows what to do when there are no args" do
    assert_equal 0, @comment2.args.size
  end

  test "knows how many examples there are" do
    assert_equal 3, @comment.examples.size
  end

  test "knows each example" do
    assert_equal "multiplex('Bo', 2)\n# => 'BoBo'",
      @comment.examples[1].to_s
  end

  test "correctly handles whitespace with examples" do
    assert_equal "def multiplex(str, length)\n  str * length\nend",
      @comment6.examples[0].to_s
  end

  test "knows what to do when there are no examples" do
    assert_equal 0, @comment2.examples.size
  end

  test "knows how many return examples there are" do
    assert_equal 3, @comment.returns.size
  end

  test "knows if the method raises anything" do
    assert_equal 2, @comment.raises.size
  end

  test "knows each return example" do
    assert_equal "Returns the duplicated String when the count is > 1.",
      @comment.returns.first.to_s

    string = ''
    string << "Returns the atomic mass of the element as a Float. "
    string << "The value is in unified atomic mass units."
    assert_equal string, @comment.returns[1].to_s

    assert_equal "Returns nil when the count is < 1.",
      @comment.returns[2].to_s
  end

  test "knows what to do when there are no return examples" do
    assert_equal 0, @comment2.examples.size
  end

  test "knows what the method yields" do
    assert_equal "Yields the Integer index of the iteration.", @comment4.yields
  end

  test "knows if the method has alternate signatures" do
    assert_equal 1, @comment4.signatures.size
    assert_equal "find_by_<field>[_and_<field>...](args)", @comment4.signatures.first
  end

  test "knows the fields associated with signatures" do
    assert_equal 1, @comment4.signature_fields.size

    arg = @comment4.signature_fields.first
    assert_equal :field, arg.name
    assert_equal "A field name.", arg.description
  end

  test "can hande comments without comment marker" do
    assert_equal "Duplicate some text an abitrary number of times.",
      @comment5.description
  end
end
