//
//  AVLTree.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/11.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct AVLTree<Element: Comparable> {
    private(set) var root: AVLNode<Element>?
    init() {  }
}
extension AVLTree: CustomStringConvertible {
    var description: String {
        return root?.description ?? "empty tree"
    }
}

// MARK: - Lookup
extension AVLTree {
    func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

// MARK: - Insert
extension AVLTree {
    mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?,
                        value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight,
                                  balancedNode.rightHeight) + 1
        return balancedNode
    }
}

// MARK: - Remove
extension AVLNode {
    var minNode: AVLNode {
        return leftChild?.minNode ?? self
    }
}
extension AVLTree {
    mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?,
                        value: Element) -> AVLNode<Element>? {
        
        guard let node = node else { return nil }
        
        if node.value == value {
            
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.minNode.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
            
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight,
                                  balancedNode.rightHeight) + 1
        return balancedNode
    }
}

// MARK: - Rotate
extension AVLTree {
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let pivot = node.rightChild else { return node }
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let pivot = node.rightChild else { return node }
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
}

// MARK: - Balance
extension AVLTree {
    func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild,
                leftChild.balanceFactor == -1 {
                
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild,
                rightChild.balanceFactor == 1 {
                
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
}
