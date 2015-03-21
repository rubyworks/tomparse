require_relative 'helper'

testcase "Options" do
  context "multiple options" do
    setup do
      @comment = TomParse::TomDoc.new %{
        # Duplicate some text an arbitrary number of times.
        #
        # text - The String to be duplicated.
        #
        # Options
        #
        #   works - The Boolean indicating whether this works. Required.
        #   really_works - The Boolean indicating whether this really works.
        #
        # Returns the duplicated String when the count is > 1.
      }
    end

    test "converts all options" do
      @comment.options.size.assert == 2
    end

    test "knows options names" do
      @comment.options.map(&:name).assert == [
        :works,
        :really_works
      ]
    end

    test "knows the options descriptions" do
      @comment.options.map(&:description).assert == [
        'The Boolean indicating whether this works. Required.',
        'The Boolean indicating whether this really works.'
      ]
    end

    test "knows the whether the option is required" do
      @comment.options.map(&:required?).assert == [
        true,
        false
      ]
    end
  end
end
