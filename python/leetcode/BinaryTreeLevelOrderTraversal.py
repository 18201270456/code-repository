# Definition for a  binary tree node
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None


class Solution:
    # @param root, a tree node
    # @return a list of lists of integers
    def levelOrder(self, root):
        levels = self.tree_by_level(root)
        
        result = []
        for level in levels:
            result.append(map(lambda node: node.val, level))
        
        return result
    
    
    def tree_by_level(self, root):
        ''' Return a list of lists of tree nodes by level.
        
        Example:
            [
              [root],
              [node1, node2],
              [node3, node4, node5]
            ]
        '''
        if root == None: return []
        
        result = []
        result.append([root])
        
        while True:
            child_level = []
            
            for node in result[-1]:
                if node.left != None:
                    child_level.append(node.left)
                if node.right != None:
                    child_level.append(node.right)
            
            if child_level == []:
                break
            
            result.append(child_level)
        
        
        return result






















