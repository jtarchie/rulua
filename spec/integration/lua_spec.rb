require 'rufus-lua'
require 'spec_helper'
require_relative '../../lib/rulua'

RSpec.describe 'When specifying a lua function' do
  def compile(&block)
    expect do
      node = RubyVM::AbstractSyntaxTree.of(block)
      expect(node).to_not be_nil

      lua = Rulua.tranverse(node)
      state = Rufus::Lua::State.new
      state.eval(lua)
    end
  end

  context ':lua.assert' do
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
end
