//
//  Queue.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/8.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct Queue<Element> {
    
    private var elements: [Element] = []
    
    init() { }
    
    // MARK: - Getters
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var peek: Element? {
        return elements.first
    }
    
    // MARK: - Enqueue & Dequeue
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        return isEmpty ? nil : elements.removeFirst()
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}


