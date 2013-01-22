require 'helper'

testcase "Tags" do

  context "TODO" do

    setup do
      @tomdoc = TomParse::TomDoc.new(<<-END)
        # This is an example of tags.
        #
        # TODO: Something we have to do.
      END
    end

    test "tags has todo" do
      assert @tomdoc.tags['todo'] == "Something we have to do."
    end

  end

  context "FOO" do

    setup do
      @tomdoc = TomParse::TomDoc.new(<<-END)
        # This is an example of tags.
        #
        # FOO: They can be anything really.
      END
    end

    test "tags has foo" do
      assert @tomdoc.tags['foo'] == "They can be anything really."
    end

  end


end
