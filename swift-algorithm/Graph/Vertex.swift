//
//  Vertex.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/9/6.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct Vertex<T> {
    let index: Int
    let value: T
}

extension Vertex: Hashable {
    var hashValue: Int {
        return index.hashValue
    }
    
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(index): \(value)"
    }
}
