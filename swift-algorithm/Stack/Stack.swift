//
//  Stack.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/6/23.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct Stack<Element> {
    private var elements: [Element] = []
    init() { }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "====top====\n"
        let bottomDivider = "\n====bottom====\n"
        let stackElements = elements
            .reversed()
            .map { "\($0)" }
            .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}

// MARK: - Push & Pop
extension Stack {
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

// MARK: - Getters
extension Stack {
    var top: Element? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
}
