require 'byebug'
class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = Array.new()
    end

    def parent=(node)
        if node
            if @parent == nil
                @parent = node
                @parent.children << self
            else
                @parent.children.delete_if {|child| child == self}
                @parent = node
                @parent.children << self
            end
        else
            @parent = node
        end
    end

    def add_child(childNode)
        childNode.parent = self
    end

    def remove_child(childNode)
        if @children.any? {|child| child == childNode}
            childNode.parent = nil
        else
            raise "the childNode passed is not a child of this parent"
        end 
    end

    def dfs(targetValue)
        if self.value == targetValue
            return self
        elsif self.children.empty?
            return nil
        else
            self.children.each do |child|
                searchResult = child.dfs(targetValue)
                return searchResult if searchResult != nil
            end
            return nil
        end
    end

    def bfs(targetValue)
        queue = [self]
        until queue.empty?
            node = queue.pop()
            if node.value == targetValue
                return node
            end
            node.children.each do |child|
                queue.unshift(child)
            end
        end
        return nil
    end

    def inspect()
        @value.inspect
    end
end


