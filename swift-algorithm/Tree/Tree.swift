//
//  Tree.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/10.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

final class TreeNode<T> {
    var value: T
    private(set) var children: [TreeNode] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func addChild(_ child: TreeNode) {
        children.append(child)
    }
}

// MARK: - Traverse
extension TreeNode {
    func traverseDepthFirst(_ closure: (TreeNode) -> Void) {
        closure(self)
        children.forEach {
            $0.traverseDepthFirst(closure)
        }
    }
    
    func traverseLevelOrder(_ closure: (TreeNode) -> Void) {
        closure(self)
        var queue = Queue<TreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            closure(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}
