//
//  InsertionSort.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/28.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

func insertionSort<T>(_ collection: inout T)
    where T: BidirectionalCollection & MutableCollection,
    T.Element: Comparable {
        guard collection.count > 1 else {
            return
        }
        for current in collection.indices {
            var moving = current
            while moving > collection.startIndex {
                let previous = collection.index(before: moving)
                if collection[previous] > collection[moving] {
                    collection.swapAt(previous, moving)
                } else {
                    break
                }
                moving = previous
            }
        }
}
