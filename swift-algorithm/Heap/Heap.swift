//
//  Heap.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/22.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct Heap<Element: Equatable> {
    private(set) var elements: [Element] = []
    private let order: (Element, Element) -> Bool

    init(order: @escaping (Element, Element) -> Bool) {
        self.order = order
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    var peek: Element? {
        return elements.first
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 1
    }

    func rightChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
}

extension Heap: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}

// MARK: - Remove & Insert
extension Heap {
    @discardableResult
    mutating func removePeek() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            validateDown(from: 0)
        }
        return elements.removeLast()
    }

    @discardableResult
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                validateDown(from: index)
                validateUp(from: index)
            }
            return elements.removeLast()
        }
    }

    mutating func insert(_ element: Element) {
        elements.append(element)
        validateUp(from: elements.count - 1)
    }

    private mutating func validateUp(from index: Int) {
        var childIndex = index
        var parentIndex = self.parentIndex(ofChildAt: childIndex)

        while childIndex > 0 &&
            order(elements[childIndex], elements[parentIndex]) {
                elements.swapAt(childIndex, parentIndex)
                childIndex = parentIndex
                parentIndex = self.parentIndex(ofChildAt: childIndex)
        }
    }

    private mutating func validateDown(from index: Int) {
        var parentIndex = index
        while true {
            let leftIndex = leftChildIndex(ofParentAt: parentIndex)
            let rightIndex = rightChildIndex(ofParentAt: parentIndex)
            var targetParentIndex = parentIndex
            
            if leftIndex < count &&
                order(elements[leftIndex], elements[targetParentIndex]) {
                targetParentIndex = leftIndex
            }
            
            if rightIndex < count &&
                order(elements[rightIndex], elements[targetParentIndex]) {
                targetParentIndex = rightIndex
            }
            
            if targetParentIndex == parentIndex {
                return
            }
            
            elements.swapAt(parentIndex, targetParentIndex)
            parentIndex = targetParentIndex
        }
    }
}

// MARK: - Search
extension Heap {
    func index(of element: Element,
               searchingFrom index: Int = 0) -> Int? {
        if index >= count {
            return nil
        }
        if order(element, elements[index]) {
            return nil
        }
        if element == elements[index] {
            return index
        }
        
        let leftIndex = leftChildIndex(ofParentAt: index)
        if let i = self.index(of: element,
                              searchingFrom: leftIndex) {
            return i
        }
        
        let rightIndex = rightChildIndex(ofParentAt: index)
        if let i = self.index(of: element,
                              searchingFrom: rightIndex) {
            return i
        }
        
        return nil
    }
}
