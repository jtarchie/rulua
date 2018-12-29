module Helpers
  module Compile
    def compile(process: false, &block)
      node = RubyVM::AbstractSyntaxTree.of(block)
      expect(node).to_not be_nil

      lua = Rulua.tranverse(node)

      if process
        file = Tempfile.new
        file.write lua
        file.close
        expect(system("lua #{file.path}")).to be_truthy
      else
        state = Rufus::Lua::State.new
        state.eval(lua)
      end
    end
  end
end
