require 'rufus-lua'
require 'spec_helper'
require 'tempfile'
require_relative '../../lib/rulua'

RSpec.describe 'When specifying a lua function' do
  context '#assert' do
    it 'succeeds on a true assertion' do
      expect do
        compile { :lua.assert(true, 'message') }
      end.to_not raise_error
    end

    it 'errors on a false assertion' do
      expect do
        compile { :lua.assert(false, 'message') }
      end.to raise_error(/message/)
    end
  end

  context '#print' do
    it 'outputs to stdout' do
      expect do
        compile(process: true) do
          :lua.print('hello, world')
        end
      end.to output("hello, world\n").to_stdout_from_any_process
    end
  end
end
