//
//  Binding+Closure.swift
//  Memories
//
//  Created by Bryce on 2020/10/16.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping(Value) -> Void) -> Binding {
        return Binding(get: {
            return self.wrappedValue
        }, set: { selection in
            self.wrappedValue = selection
            handler(selection)
        })
    }
}
