//
//  Array+Identifiable.swift
//  Memories
//
//  Created by Bryce on 2020/9/27.
//

import Foundation

extension Array where Element: Identifiable {
    func searchFirstIndex(of element: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == element.id {
                return index
            }
        }
        return nil
    }
}

extension Array {
    var only: Element? {
        if let element = self.first, count == 1 {
            return element
        }
        return nil
    }
}
