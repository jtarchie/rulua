RSpec.configure do |config|
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
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
