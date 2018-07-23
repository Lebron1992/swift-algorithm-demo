//
//  PriorityQueue.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/23.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct PriorityQueue<Element: Equatable> {
    private var heap: Heap<Element>
    
    init(order: @escaping (Element, Element) -> Bool) {
        heap = Heap(order: order)
    }
    
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    var peek: Element? {
        return heap.peek
    }
    
    mutating func enqueue(_ element: Element) {
        heap.insert(element)
    }
    
    mutating func dequeue() -> Element? {
        return heap.removePeek()
    }
}
