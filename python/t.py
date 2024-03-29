

class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

s = [1, 2, 3, '#', '#', 4, '#', '#', 5]




levels = []

count = 1
while len(s) > 0:
    map(lambda x: TreeNode(x) if x!='#' else None, s[0:count])
    s = s[count:]
    
    count = len(filter(lambda x: x!='#', s[0:count]))*2




val_levels = []

count = 1
while len(s) > 0:
    val_levels.append(s[0:count])
    s = s[count:]
    
    count = len(filter(lambda x: x!='#', val_levels[-1]))*2




node_levels = []
for val_level in val_levels:
    
    node_level = []
    for item in val_level:
        node = TreeNode(item) if item!='#' else None
        node_level.append(node)
    
    node_levels.append(node_level)
    


print node_levels


def rel_as_list(parent, child):
    for item in parent:
        if item == None:
            continue
        
        item.left = child[0]
        item.right = child[1]
        
        child = child[2:]

for i in range(len(node_levels)-1):
    rel_as_list(node_levels[i], node_levels[i+1])


print node_levels[2][2].right




