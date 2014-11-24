
import unittest

from SymmetricTree import Solution


class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


class TestSolution(unittest.TestCase):

    def setUp(self):
        pass
    
    
    def get_a_symmetric_tree(self):
        n1       = TreeNode(1)
        n1.left  = TreeNode(2)
        n1.right = TreeNode(3)
        
        n2       = TreeNode(1)
        n2.left  = TreeNode(3)
        n2.right = TreeNode(2)
        
        root       = TreeNode(0)
        root.left  = n1
        root.right = n2
        
        return root
    
    
    def get_a_none_symmetric_tree(self):
        n1       = TreeNode(1)
        n1.left  = TreeNode(2)
        n1.right = TreeNode(3)
        
        n2       = TreeNode(1)
        n2.left  = TreeNode(2)
        n2.right = TreeNode(3)
        
        root       = TreeNode(0)
        root.left  = n1
        root.right = n2
        
        return root


    def test_all(self):
        my_solution = Solution()
        
        self.assertFalse(my_solution.isSymmetric(self.get_a_none_symmetric_tree()), "NON-SYMMETRIC tree, return False")
        
        self.assertTrue(my_solution.isSymmetric(self.get_a_symmetric_tree()), "SYMMETRIC tree, return True")
        self.assertTrue(my_solution.isSymmetric(None))
        self.assertTrue(my_solution.isSymmetric(TreeNode(3)))
        



if __name__ == '__main__':
    unittest.main()

















