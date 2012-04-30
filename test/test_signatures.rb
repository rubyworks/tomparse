require 'helper'

testcase "Signatures" do

  setup do  
    @comment = TomParse::TomDoc.new %{
      # Duplicate some text an abitrary number of times.
      #
      # Yields the Integer index of the iteration.
      #
      # Signature
      #
      #   find_by_<field>[_and_<field>...](args)
      #
      # field - A field name.
    }
  end

  test "knows what the method yields" do
    @comment.yields.assert == "Yields the Integer index of the iteration."
  end

  test "knows if the method has alternate signatures" do
    @comment.signatures.size.assert == 1
    @comment.signatures.first.assert == "find_by_<field>[_and_<field>...](args)"
  end

  test "knows the fields associated with signatures" do
    @comment.signature_fields.size.assert == 1

    arg = @comment.signature_fields.first
    arg.name.assert == :field
    arg.description.assert == "A field name."
  end

end
