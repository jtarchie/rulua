require 'rufus-lua'
require 'spec_helper'
require 'tempfile'
require_relative '../../lib/rulua'

RSpec.describe 'When specifying a lua function' do
  def compile(process: false, &block)
    expect do
      node = RubyVM::AbstractSyntaxTree.of(block)
      expect(node).to_not be_nil

      lua = Rulua.tranverse(node)

      if process
        file = Tempfile.new
        file.write lua
        file.close
        system("lua #{file.path}")
      else
        state = Rufus::Lua::State.new
        state.eval(lua)
      end
    end
  end

  context '#assert' do
    it 'succeeds on a true assertion' do
      compile do
        :lua.assert(true, 'message')
      end.to_not raise_error
    end

    it 'errors on a false assertion' do
      compile do
        :lua.assert(false, 'message')
      end.to raise_error(/message/)
    end
  end

  context '#print' do
    it 'outputs to stdout' do
      compile(process: true) do
        :lua.print('hello, world')
      end.to output("hello, world\n").to_stdout_from_any_process
    end
  end
end
