import UIKit

var greeting = "Hello, playground"


class Node {
    let data : Int
    var left: Node?
    var right: Node?
    
    init(data: Int, left: Node? = nil, right: Node? = nil) {
        self.data = data
        self.left = left
        self.right = right
    }
    
}

func createNode(data: Int) -> Node {
    return Node(data: data)
}

func insertNode(rootNode: Node, node: Node)  {
    if node.data <= rootNode.data {
        if rootNode.left == nil {
            rootNode.left = node
            return
        } else if let leftNode = rootNode.left {
            insertNode(rootNode: leftNode, node: node)
        }
        
    } else if node.data >= rootNode.data {
        if rootNode.right == nil {
            rootNode.right = node
            return
        } else if let rightNode = rootNode.right {
            insertNode(rootNode: rightNode, node: node)
        }
    }
  
}
func preOrderTraversal(root: Node?) {
    if let node = root {  // This is base conditio. This means enter if only if node is not nil
        print(node.data)
        preOrderTraversal(root: node.left)
        preOrderTraversal(root: node.right)
    }
}
func inOrderTraversal(root: Node?) {
    if let node = root {  // This means enter if only if node is not nil
        inOrderTraversal(root: node.left)
        print(node.data)
        inOrderTraversal(root: node.right)
    }
}

func testTreeInsertion() {
    var  rootNode = createNode(data: 5)
    
    let treeInput = [2,3,4,6,7,8,9]
    
    for nodeData in treeInput {
        insertNode(rootNode: rootNode, node: createNode(data: nodeData))
    }
    
    print("Doing PreOrder traversal")
    preOrderTraversal(root: rootNode)
    print("Doing inorder traversal")
    inOrderTraversal(root: rootNode)
}

print("Startign to run tree")
testTreeInsertion()
print("Finish running tree")
