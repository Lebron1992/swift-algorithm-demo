//
//  Edge.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/9/6.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double?
}
