import UIKit

var greeting = "Hello, playground"


class Node {
    var isVisited: Bool?
    var data : Int
    var left: Node?
    var right: Node?
    
    init(data: Int, left: Node? = nil, right: Node? = nil, isVisited: Bool? = false) {
        self.data = data
        self.left = left
        self.right = right
        self.isVisited = isVisited
    }
    
}


func createRootNode(val: Int) -> Node {
   return Node(data: val)
}

func inserNode(rootNode: Node, val: Int)  {
    let newNode = Node(data: val)
    if newNode.data <= rootNode.data {
        if rootNode.left == nil {
            rootNode.left = newNode
            return
        } else if let leftNode = rootNode.left {
            inserNode(rootNode: leftNode, val: val)
        }
        
    } else if newNode.data >= rootNode.data {
        if rootNode.right == nil {
            rootNode.right = newNode
            return
        } else if let rightNode = rootNode.right {
            inserNode(rootNode: rightNode, val: val)
        }
    }
}

func preOrderTraversal(root: Node) {
    print(root.data)
    if let node = root.left {
        preOrderTraversal(root: node)
    }
    if let node = root.right {
        preOrderTraversal(root: node)
    }
}

func bredthFirstSearchTraversal(treeNodes: [Node], level: Int)  {
/* Overall logic is insert marker node in the Q after every level. Initially after root node, insert marker node (node with -1 value) . After root node
 everytime we insert left and right nodes recurecesily insert marker node. Increment the width counter ONLY WHEN marker node is removed or addded*/
    var nodes = treeNodes
    var treeWidth = level
    var rootNode = nodes.removeFirst()
    
    if treeNodes.isEmpty {
        return
    }

    if let leftNode = rootNode.left {
        nodes.append(leftNode)
    }
    if let rightNode = rootNode.right {
        nodes.append(rightNode)
    }

    
    var nextNode = nodes.removeFirst()
    if nextNode.data == -1 {
        treeWidth += 1
        if !nodes.isEmpty {
            nextNode = nodes.removeFirst()
            nodes.append(getMarkerNode())
        }
    }
    print("Width is \(treeWidth)")

    return bredthFirstSearchTraversal(treeNodes: nodes, level: treeWidth)

    
}

func getMarkerNode() -> Node {
    return Node(data: -1)
}
func deleteNode(root: Node?, val: Int) -> Node? {
        guard let rootNode = root else {
            return nil
        }
        
        if val < rootNode.data {
            rootNode.left = deleteNode(root: rootNode.left, val: val)
        } else if val > rootNode.data {
            rootNode.right = deleteNode(root: rootNode.right, val: val)
        } else {
            if rootNode.left == nil && rootNode.right == nil {
                return nil
            } else if rootNode.left == nil {
                return rootNode.right
            } else if rootNode.right == nil {
                return rootNode.left
            } else {
                /* If 2 children, find either MAX from the left tree of the node or MIN from the right subtree of the node (See below the explanation) .
                 In this case we are finding min child in the RIGHT subtree ( one in left most position is min) and replace it's data with the node data and call DELETE on last node */
                            var cursor = rootNode.right
                            while cursor?.left != nil {
                                cursor = cursor?.left
                            }
                            if let cursor {
                                rootNode.data = cursor.data
                                rootNode.right = deleteNode(root: rootNode.right, val: cursor.data)
                            }
                           
                            
                        }
            
        }
       
        
        return rootNode
}

func createTree() {
    let treeData = [10,4,2,16,7,1,20,15,3,25,6]
    let rootNode = createRootNode(val: 5)
    
    for  leafData in treeData {
        inserNode(rootNode: rootNode, val: leafData)
    }
    
    preOrderTraversal(root: rootNode)
    print("Tree height \(getTreeHeight(rootNode: rootNode, height: 0))")
    print("Breadth First Search")
    var nodes = [Node]()
    nodes.append(rootNode)
    nodes.append(getMarkerNode())
    bredthFirstSearchTraversal(treeNodes: nodes, level: 0)

    deleteNode(root: rootNode, val: 2)
    print("/////")
    preOrderTraversal(root: rootNode)

}

createTree()
/*
 If 2 children, find either MAX from the left tree of the node or MIN from the right subtree of the node .
 Preorder tree traversal givens sorted array . e.g.
    4,5,7,8,9,10,22
 In this array to delete 8 , everything in left of 8 is left subtree so we need to choose max of left subtree which is 7  OR
 we need to choose min of right subtree which is 9
 */

func getTreeHeight(rootNode: Node?, height: Int) -> Int {

    if rootNode == nil {
        return height
    }
    let leftHeight = getTreeHeight(rootNode: rootNode?.left, height: height + 1)
    let rightHeight = getTreeHeight(rootNode: rootNode?.right, height: height + 1 )
    
    return max(leftHeight, rightHeight)

}
