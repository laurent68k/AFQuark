//
//  AFBase.swift
//  AFQuark
//
//  Created by Laurent Favard on 28/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//
//  Based on Reactive (RxCocoa) architecture from Krunoslav Zaher on 4/1/15.
//

/**
 Use `AFBase` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend AFBase protocol with constrain on Base
 // Read as: AFBase Extension where Base is a SomeType
 extension AFBase where Base: SomeType {
 // 2. Put any specific AFBase extension for SomeType here
 }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */

public struct AFBase<Base> {
    /// Base object extended
    public let base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has AFBase extensions.
public protocol AFBaseCompatible {
    /// Extended type
    associatedtype CompatibleType

    /// Quark extensions.
    static var quark: AFBase<CompatibleType>.Type { get set }

    /// Quark extensions.
    var quark: AFBase<CompatibleType> { get set }
}

extension AFBaseCompatible {
    
    /// Quark extensions.
    public static var quark: AFBase<Self>.Type {
        get {
            return AFBase<Self>.self
        }
        set {
            // this enables using AFBase to "mutate" base type
        }
    }

    /// Quark extensions.
    public var quark: AFBase<Self> {
        get {
            return AFBase(self)
        }
        set {
            // this enables using AFBase to "mutate" base object
        }
    }
}

import class Foundation.NSObject

/// Extend NSObject with `quark` proxy.
extension NSObject: AFBaseCompatible {
    
    
}
