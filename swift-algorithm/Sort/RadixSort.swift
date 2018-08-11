//
//  RadixSort.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/31.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    
    /// radix sort for base 10 integers
    mutating func radixSort() {
        let base = 10
        var done = false
        var digits = 1
        
        while !done {
            done = true
            var bucket: [[Int]] = .init(repeating: [], count: base)
            forEach { (number) in
                let remaining = number / digits
                let digit = remaining % base
                bucket[digit].append(number)
                if remaining > 0 {
                    done = false
                }
            }
            digits *= base
            self = bucket.flatMap { $0 }
        }
    }
}
