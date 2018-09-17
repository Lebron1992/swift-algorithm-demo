//
//  Prim.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/9/17.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

class Prim<T: Hashable> {
    typealias Graph = AdjacencyList<T>
    
    init() { }
    
    func produceMinimumSpanningTree(for graph: Graph) -> (cost: Double, mst: Graph) {
        
        var cost = 0.0
        let mst = Graph()
        var visited: Set<Vertex<T>> = []
        var priorityQueue = PriorityQueue<Edge<T>>(order: {
            $0.weight ?? 0 < $1.weight ?? 0
        })
        
        copyVertices(from: graph, to: mst)
        
        guard let start = graph.vertices.first else {
            return (cost: cost, mst: mst)
        }
        
        visited.insert(start)
        addAvailableEdges(for: start,
                          in: graph,
                          check: visited,
                          to: &priorityQueue)
        
        while let smallestEdge = priorityQueue.dequeue() {
            let vertex = smallestEdge.destination
            guard !visited.contains(vertex) else {
                continue
            }
            
            visited.insert(vertex)
            cost += (smallestEdge.weight ?? 0)
            
            mst.addUndirectedEdge(between: smallestEdge.source,
                                  and: smallestEdge.destination,
                                  weight: smallestEdge.weight)
            
            addAvailableEdges(for: vertex,
                              in: graph,
                              check: visited,
                              to: &priorityQueue)
        }
        
        return (cost: cost, mst: mst)
    }
    
    // MARK: - Private
    
    private func copyVertices(from graph: Graph, to graph2: Graph) {
        graph.vertices.forEach {
            graph2.createVertex(value: $0.value)
        }
    }
    
    private func addAvailableEdges(for vertex: Vertex<T>,
                                   in graph: Graph,
                                   check visited: Set<Vertex<T>>,
                                   to priorityQueue: inout PriorityQueue<Edge<T>>) {
        for edge in graph.edges(from: vertex)
            where !visited.contains(edge.destination) {
                priorityQueue.enqueue(edge)
        }
    }
}
