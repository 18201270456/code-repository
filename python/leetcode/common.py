# Definition for a  binary tree node
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None




def tree_by_level(root):
    '''
    Return a list of lists of tree nodes by level.
    
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


def binary_tree_serialization(root):
    '''
    OJ's Binary Tree Serialization:
    
    The serialization of a binary tree follows a level order traversal, where 
    '#' signifies a path terminator where no node exists below.
    
    Here's an example:
       1
      / \
     2   3
        /
       4
        \
         5
    
    The above binary tree is serialized as "{1,2,3,#,#,4,#,#,5}".
    '''
    
    if root == None: return []
    
    result = []
    result.append(root.val)
    
    levels = tree_by_level(root)
    
    for level in levels[0:-1]:
        for node in level:
            result.append("#" if node.left is None else node.left.val)
            result.append("#" if node.right is None else node.right.val)
    
    return result


def serialization_backto_binary_tree(serial):
    '''
    From:
        serial = [1,2,3,#,#,4,#,#,5]
    
    To:
       1
      / \
     2   3
        /
       4
        \
         5
    '''
    
    root = TreeNode()
    
    
    
    






if __name__ == "__main__":
    
    n1       = TreeNode(1)
    n1.left  = TreeNode(2)
    n1.right = TreeNode(3)
    
    n2       = TreeNode(1)
    n2.right = TreeNode(2)
    
    root       = TreeNode(0)
    #root.left  = n1
    #root.right = n2
    
    print binary_tree_serialization(root)







