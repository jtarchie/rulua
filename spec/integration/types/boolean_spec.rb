require 'spec_helper'

RSpec.describe 'When using booleans' do
  it 'can be a value of true' do
    value = compile { true }
    expect(value).to eq true
  end

  it 'can be a value of false' do
    value = compile { false }
    expect(value).to eq false
  end
end
