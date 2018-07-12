//
//  AVLNode.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/11.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

final class AVLNode<T> {
    var value: T
    
    var leftChild: AVLNode?
    var rightChild: AVLNode?
    
    var height = 0
    
    var leftHeight: Int {
        return leftChild?.height ?? -1
    }
    var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    var balanceFactor: Int {
        return leftHeight - rightHeight
    }
    
    init(_ value: T) {
        self.value = value
    }
}

extension AVLNode: CustomStringConvertible {
    var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         top: String = "",
                         root: String = "",
                         bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top: top + " ",
                       root: top + "┌───",
                       bottom: top + "| ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChild,
                  top: bottom + "| ",
                  root: bottom + "└───",
                  bottom: bottom + " ")
    }
}

// MARK: - Traverse
extension AVLNode {
    func traverseInOrder(_ closure: (T) -> Void) {
        leftChild?.traverseInOrder(closure)
        closure(value)
        rightChild?.traverseInOrder(closure)
    }
    
    func traversePreOrder(_ closure: (T) -> Void) {
        closure(value)
        leftChild?.traversePreOrder(closure)
        rightChild?.traversePreOrder(closure)
    }
    
    func traversePostOrder(_ closure: (T) -> Void) {
        leftChild?.traversePostOrder(closure)
        rightChild?.traversePostOrder(closure)
        closure(value)
    }
}
