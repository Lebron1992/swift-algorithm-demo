//
//  BinarySearch.swift
//  swift-algorithm
//
//  Created by 曾文志 on 2018/7/22.
//  Copyright © 2018 Lebron. All rights reserved.
//

import Foundation

extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element,
                      in range: Range<Index>? = nil) -> Index? {
        
        let range = range ?? startIndex..<endIndex
        guard range.lowerBound < range.upperBound else { return nil }
        
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        let middleValue = self[middle]
        
        if middleValue == value {
            return middle
            
        } else if value < middleValue {
            return binarySearch(for: value, in: range.lowerBound..<middle)
            
        } else {
            return binarySearch(for: value, in: middle..<range.upperBound)
        }
    }
}
