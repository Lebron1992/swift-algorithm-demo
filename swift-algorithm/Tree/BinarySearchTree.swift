//
//  BinarySearchTree.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/10.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct BinarySearchTree<Element: Comparable> {
    private(set) var root: BinaryTreeNode<Element>?
    init() {  }
}

// MARK: - Lookup
extension BinarySearchTree {
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
extension BinarySearchTree {
    mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryTreeNode<Element>?,
                        value: Element) -> BinaryTreeNode<Element> {
        guard let node = node else {
            return BinaryTreeNode(value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
}

// MARK: - Remove
extension BinaryTreeNode {
    var minNode: BinaryTreeNode {
        return leftChild?.minNode ?? self
    }
}

extension BinarySearchTree {
    mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryTreeNode<Element>?,
                value: Element) -> BinaryTreeNode<Element>? {
        
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
        
        return node
    }
}
