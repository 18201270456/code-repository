# Definition for a  binary tree node
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None



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
    
    
    
    
    def isSymmetric2(self, root):  # iteratively 
        
        
        s = []
        l = []
        
        s.append(root)
        
        l.append(root.left)
        l.append(root.right)
        
        s.append(l)
        
        t = []
        for item in l:
            t.append(l.left)
        
        
        serialization = []
        while root != None:
            serialization.append(root.left)
            serialization.append(root.right)
        
        try:
            while root != None:
                if root.left.val == root.right.val:
                    root = root.left
                
                
        except:
            return False
        while root != None:
            if root.left != None:
                root.left.val == root.right.val
    
    
    def traverse_tree(self, root):
        
        l = []
        l.append(root)
        
        s = []
        while True:
            for item in s:
                l.append((lambda x: "#" if x==None else x.val)(item.left))
                l.append((lambda x: "#" if x==None else x.val)(item.right))
        
        
        
        
        









    
    
    
    



