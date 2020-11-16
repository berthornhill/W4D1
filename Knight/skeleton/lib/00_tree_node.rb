class PolyTreeNode
    attr_accessor :value, :parent, :children
    def initialize(value, parent = nil, children = [])
        @value = value
        @parent = parent
        @children = children
    end

    def parent=(node)
        if !node.nil?
            if !self.parent.nil?
                self.parent.children.delete(self)
            end
            @parent = node
            if !node.children.include?(self)
                node.children << self    
            end
        else
            @parent = nil
        end
    end

    def add_child(node)        
        if !self.children.include?(node)
            node.parent = self
        end
    end

    def remove_child(node)
        if node.parent == nil
            raise "node is not a child node"
        end
        node.parent = nil
    end

    def inspect
        @value.inspect
    end

#            a
#         b     c
#       d  e

    def dfs(value)
        return self if self.value == value
        return nil if self.children == []
        check = nil
        self.children.each do |child|
            check = child.dfs(value)
            return check if check != nil
        end
        return check
    end

    def bfs(value)
        queue = []
        if self == nil
            return nil
        end
        queue << self
        until queue.empty?                                     
        # while !queue.empty?
            if queue.first.value == value
                return queue.first
            else    
                queue += queue.first.children
                queue.shift
            end
        end
        return nil
    end

end


