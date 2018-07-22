//
//  Trie.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/22.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

final class Trie<CollectionType: Collection>
    where CollectionType.Element: Hashable {
    
    typealias Node = TrieNode<CollectionType.Element>
    
    private let root = Node(key: nil, parent: nil)
    
    init() { }
}

// MARK: - Insert
extension Trie {
    func insert(_ collection: CollectionType) {
        var current = root
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]!
        }
        current.isTerminating = true
    }
}

// MARK: - Contains
extension Trie {
    func contains(_ collection: CollectionType) -> Bool {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return false
            }
            current = child
        }
        return current.isTerminating
    }
}

// MARK: - Remove
extension Trie {
    func remove(_ collection: CollectionType) {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            current = child
        }
        
        guard current.isTerminating else { return }
        
        current.isTerminating = false
        
        while let parent = current.parent,
            current.children.isEmpty && !current.isTerminating {
                parent.children[current.key!] = nil
                current = parent
        }
    }
}

// MARK: - Prefix matching
extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root
        for element in prefix {
            guard let child = current.children[element] else {
                return []
            }
            current = child
        }
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: CollectionType,
                             after node: Node) -> [CollectionType] {
        var results: [CollectionType] = []
        
        if node.isTerminating {
            results.append(prefix)
        }
        
        for child in node.children.values {
            guard let key = child.key else { return results }
            var prefix = prefix
            prefix.append(key)
            results.append(contentsOf: collections(startingWith: prefix,
                                                   after: child))
        }
        
        return results
    }
}
