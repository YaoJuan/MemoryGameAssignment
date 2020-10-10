//
//  ProjectExtensive.swift
//  Memories
//
//  Created by Bryce on 2020/9/28.
//

import Foundation


//
public struct ProjectExtensive<Base> {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}
//
public protocol ProjectExtensionCompatible {
    associatedtype ProjectBase
    var pe: ProjectExtensive<Self.ProjectBase> { get }
    static var pe: ProjectExtensive<Self.ProjectBase>.Type { get }
}
//
public extension ProjectExtensionCompatible {
    var pe:  ProjectExtensive<Self> {
        return  ProjectExtensive(self)
    }
//
    static var pe:  ProjectExtensive<Self>.Type {
        return  ProjectExtensive.self
    }
}

extension Array: ProjectExtensionCompatible {}

extension ProjectExtensive where Base == Array<Any> {
    func only() -> Base.Element? {
        if let element = self.base.first {
            return element
        }
        return nil
    }
}
