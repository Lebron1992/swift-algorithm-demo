//
//  Graph.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/9/6.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

enum EdgeType {
    case directed
    case undirected
}

protocol Graph {
    associatedtype Element
    
    func createVertex(value: Element) -> Vertex<Element>
    
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    
    func addEdge(_ edge: EdgeType,
                 from source: Vertex<Element>,
                 to destination: Vertex<Element>,
                 weight: Double?)
    
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}

extension Graph {
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    func addEdge(_ edge: EdgeType,
                 from source: Vertex<Element>,
                 to destination: Vertex<Element>,
                 weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

extension Graph {
    func breathFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = Queue<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            for edge in neighborEdges
                where !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
            }
        }
        
        return visited
    }
    
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack = Stack<Vertex<Element>>()
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        
        outer: while let vertex = stack.top {
            let neighborEdges = edges(from: vertex)
            guard !neighborEdges.isEmpty else {
                stack.pop()
                continue
            }
            for edge in neighborEdges {
                if !pushed.contains(edge.destination) {
                    stack.push(edge.destination)
                    pushed.insert(edge.destination)
                    visited.append(edge.destination)
                    continue outer
                }
            }
            stack.pop()
        }
        
        return visited
    }
}
