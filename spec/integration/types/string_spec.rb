require 'spec_helper'

RSpec.describe 'When using strings' do
  it 'can be a value' do
    value = compile { 'hello, world' }
    expect(value).to eq 'hello, world'
  end
end
