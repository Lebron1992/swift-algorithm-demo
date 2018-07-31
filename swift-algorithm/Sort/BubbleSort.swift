//
//  BubbleSort.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/28.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

func bubbleSort<T>(_ collection: inout T)
    where T: MutableCollection, T.Element: Comparable {
        guard collection.count > 1 else {
            return
        }
        for end in collection.indices.reversed() {
            var swapped = false
            var current = collection.startIndex
            while current < end {
                let next = collection.index(after: current)
                if collection[next] < collection[current] {
                    collection.swapAt(next, current)
                    swapped = true
                }
                current = next
            }
            if !swapped {
                return
            }
        }
}
