//
//  LinkedList.swift
//  swift-algorithm
//
//  Created by Lebron on 2018/6/5.
//  Copyright © 2018 Lebron. All rights reserved.
//

// MARK: - LinkedListNode
final class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    
    init(value: T, next: LinkedListNode? = nil) {
        self.value = value
        self.next = next
    }
}
extension LinkedListNode: CustomStringConvertible {
    var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> \(String(describing: next)) "
    }
}

// MARK: - LinkedList
struct LinkedList<T> {
    var head: LinkedListNode<T>?
    var tail: LinkedListNode<T>?
    init() { }
    
    mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else { return }
        guard var oldNode = head else { return }

        head = LinkedListNode(value: oldNode.value)
        var newNode = head

        while let nextOldNode = oldNode.next {
            let nextNewNode = LinkedListNode(value: nextOldNode.value)
            newNode?.next = nextNewNode
            newNode = nextNewNode
            oldNode = nextOldNode
        }

        tail = newNode
    }
}
extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else { return "Empty list" }
        return String(describing: head)
    }
}

// MARK: - Add Values
extension LinkedList {
    mutating func append(_ value: T) {
        copyNodes()
        
        guard !isEmpty else {
            let node = LinkedListNode(value: value)
            head = node
            tail = node
            return
        }
        let next = LinkedListNode(value: value)
        tail?.next = next
        tail = next
    }
    
    mutating func insert(_ value: T, after node: LinkedListNode<T>) {
        copyNodes()
        guard tail !== node else { append(value); return }
        node.next = LinkedListNode(value: value, next: node.next)
    }
}

// MARK: - Remove Values
extension LinkedList {
    mutating func removeLast() -> T? {
        copyNodes()
        
        guard let head = head else { return nil }
        
        guard head.next != nil else {
            let headValue = head.value
            self.head = nil
            tail = nil
            return headValue
        }
        
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }
    
    mutating func remove(after node: LinkedListNode<T>) -> T? {
        copyNodes()
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
}

// MARK: - Access Values
extension LinkedList {
    func node(at index: Int) -> LinkedListNode<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
}

// MARK: - Getters
extension LinkedList {
    var isEmpty: Bool {
        return head == nil
    }
}

// MARK: - Collection
extension LinkedList: Collection {
    
    struct Index: Comparable {
        var node: LinkedListNode<T>?
        
        static func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    var startIndex: Index {
        return Index(node: head)
    }
    
    var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    subscript(index: Index) -> T {
        return index.node!.value
    }
}
