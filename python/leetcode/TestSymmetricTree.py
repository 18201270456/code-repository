

import unittest

from SymmetricTree import *


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


    def test_none_symmetric(self):
        my_solution = Solution()
        
        self.assertFalse(my_solution.isSymmetric(self.get_a_none_symmetric_tree()), "NON-SYMMETRIC tree, return False")


    def test_symmetric(self):
        my_solution = Solution()
        
        self.assertTrue(my_solution.isSymmetric(self.get_a_symmetric_tree()), "SYMMETRIC tree, return True")


    def test_special_data(self):
        my_solution = Solution()
        
        self.assertTrue(my_solution.isSymmetric(None))
        self.assertTrue(my_solution.isSymmetric(TreeNode(3)))
        



if __name__ == '__main__':
    unittest.main()

















