//
//  SelectionSort.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/28.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

func selectionSort<T>(_ collection: inout T)
    where T: MutableCollection, T.Element: Comparable {
        guard collection.count > 1 else {
            return
        }
        for current in collection.indices {
            var lowest = current
            var next = collection.index(after: current)
            while next < collection.endIndex {
                if collection[next] < collection[lowest] {
                    lowest = next
                }
                next = collection.index(after: next)
            }
            if lowest != current {
                collection.swapAt(lowest, current)
            }
        }
}
