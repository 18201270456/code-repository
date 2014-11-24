# Definition for a  binary tree node
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None



class Solution:
    # @param root, a tree node
    # @return a boolean
    def isSymmetric(self, root):  # recursively 
        if root == None:
            return True
        
        return self.is_mirrored(root.left, root.right)
    
    
    def is_mirrored(self, left, right):
        if left == None and right == None:
            return True
        
        if left != None and right != None:
            if left.val == right.val:
                return self.is_mirrored(left.left, right.right) and self.is_mirrored(left.right, right.left)
        
        return False
    









    
    
    
    



