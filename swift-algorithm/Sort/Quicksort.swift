//
//  Quicksort.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/8/11.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

// MARK: - Lomuto Quicksort

func lomutoPartition<T: Comparable>(_ array: inout [T],
                                    low: Int,
                                    high: Int) -> Int {
    let pivot = array[high]
    
    var i = low
    for j in low..<high {
        if array[j] <= pivot {
            array.swapAt(i, j)
            i += 1
        }
    }
    
    array.swapAt(i, high)
    return i
}

func lomutoQuicksort<T: Comparable>(_ array: inout [T],
                                    low: Int,
                                    high: Int) {
    guard low < high else {
        return
    }
    let pivot = lomutoPartition(&array, low: low, high: high)
    lomutoQuicksort(&array, low: low, high: pivot - 1)
    lomutoQuicksort(&array, low: pivot + 1, high: high)
}

// MARK: - Hoare Quicksort

func hoarePartition<T: Comparable>(_ array: inout [T],
                                   low: Int,
                                   high: Int) -> Int {
    let pivot = array[low]
    var i = low - 1
    var j = high + 1
    
    while true {
        repeat { i += 1 } while array[i] < pivot
        repeat { j -= 1 } while array[j] > pivot
        if i < j {
            array.swapAt(i, j)
        } else {
            return j
        }
    }
}

func hoareQuicksort<T: Comparable>(_ array: inout [T],
                                   low: Int,
                                   high: Int) {
    guard low < high else {
        return
    }
    let pivot = hoarePartition(&array, low: low, high: high)
    hoareQuicksort(&array, low: low, high: pivot)
    hoareQuicksort(&array, low: pivot + 1, high: high)
}

// MARK: - Median Quicksort

func medianPivot<T: Comparable>(_ array: inout [T],
                                low: Int,
                                high: Int) -> Int {
    let center = (low + high) / 2
    if array[low] > array[center] {
        array.swapAt(low, center)
    }
    if array[low] > array[high] {
        array.swapAt(low, high)
    }
    if array[center] > array[high] {
        array.swapAt(center, high)
    }
    return center
}

func medianQuicksort<T: Comparable>(_ array: inout [T],
                                    low: Int,
                                    high: Int) {
    guard low < high else {
        return
    }
    let center = medianPivot(&array, low: low, high: high)
    array.swapAt(center, high)
    let pivot = lomutoPartition(&array, low: low, high: high)
    lomutoQuicksort(&array, low: low, high: pivot - 1)
    lomutoQuicksort(&array, low: pivot + 1, high: high)
}

// MARK: - Non-recursive

func nonrecursiveQuicksort<T: Comparable>(_ array: inout [T],
                                          low: Int,
                                          high: Int) {
    guard low < high else {
        return
    }
    var stack = Stack<Int>()
    stack.push(low)
    stack.push(high)
    
    while !stack.isEmpty {
        guard let end = stack.pop(),
            let start = stack.pop() else {
                continue
        }
        
        let pivot = lomutoPartition(&array, low: start, high: end)
        
        if (pivot - 1) > start {
            stack.push(start)
            stack.push(pivot - 1)
        }
        
        if (pivot + 1) < end {
            stack.push(pivot + 1)
            stack.push(end)
        }
    }
}
