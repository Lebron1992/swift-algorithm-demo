//
//  TrieNode.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/22.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

final class TrieNode<Key: Hashable> {
    var key: Key?
    weak var parent: TrieNode?
    var children: [Key: TrieNode] = [:]
    var isTerminating = false
    
    init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
