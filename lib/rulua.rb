module Rulua
  def self.tranverse(node)
    case node
    when RubyVM::AbstractSyntaxTree::Node
      case node.type
      when :FALSE
        'false'
      when :TRUE
        'true'
      when :STR
        node.children[0].inspect
      when :ARRAY
        node.children[0..-2].map do |child|
          tranverse(child)
        end
      when :SCOPE
        ['do', tranverse(node.children[2]), 'end'].join("\n")
      when :CALL
        children = node.children
        case children[0].type
        when :LIT
          "#{children[1]}(#{tranverse(children[2]).join(', ')})"
        else
          raise "don't know how to use receiver: #{node.children[0]}"
        end
      else
        raise "don't know how to to use type: #{node.type}"
      end
    else
      raise "don't know type: #{node.inspect}"
    end
  end

  def self.pretty(node)
    case node
    when RubyVM::AbstractSyntaxTree::Node
      [node.type, node.children.map { |c| map(c) }]
    else
      node
    end
  end
end
