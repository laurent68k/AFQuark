//
//  Stack.swift
//  AFQuark
//
//  Created by Laurent on 13/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//

import Foundation

/// ---------------------------------------------------------------------------------------------------------------------------------------------
/// ---------------------------------------------------------------------------------------------------------------------------------------------
public enum AFStackError : Error {

    case    Empty
}

/// ---------------------------------------------------------------------------------------------------------------------------------------------
/// ---------------------------------------------------------------------------------------------------------------------------------------------
/**
 Stack LIFO data structure
 */
open class AFStack<Element: Equatable> : Sequence {
    
   /**
        Size of the Stack
     */
    open var size : Int {
    
        return self.array.count
    }
    
    /**
        Top element on the stack if any
     */
    open var topItem: Element? {

        return self.array.last
    }
    
    /**
        Bottom element on the stack if any
     */
    open var bottomItem: Element? {
        
        return self.array.first
    }
 
    open var isEmpty : Bool {
            
        return self.size == 0 && self.topItem == nil
    }

    public typealias ChangeHandler = ( (Int, Element?, Element?) -> Void)
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    private (set) var name : String = String.empty
    private var array = [Element]()
    private var changeHandler: ChangeHandler? = nil
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    public init( changeHandler: ChangeHandler? = nil) {
        
        self.changeHandler = changeHandler
        self.changeHandler?(self.array.count, self.array.last, self.array.first)
    }
    
    public convenience init(withName name:String, changeHandler: ChangeHandler? = nil) {
        
        self.init(changeHandler: changeHandler)
        self.name = name
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    deinit {
        
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /**
        Push a new object of any type on the stack
     */
    open func push(_ value:Element) {
        
        self.array.append(value)
        
        self.changeHandler?(self.array.count, self.array.last, self.array.first)
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    
    /**
        Pop the last object from the stack. Raise StackError.Empty is stack empty
     */
    open func pop() throws -> Element {
        
        if self.array.count > 0 {
            
            let element = self.array.removeLast()

            self.changeHandler?(self.array.count, self.array.last, self.array.first)
            
            return element
        }
        throw AFStackError.Empty
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    
    /**
        Find and return the index of an object in the Stack
     */
    open func find(indexOf valueToFind: Element) -> Int? {
        
        for (index, value) in self.array.enumerated() {
            
            if value == valueToFind {
                return index
            }
        }
        
        return nil
    }
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /**
     Get an iterator from the head to the tail
     
     Called when caller perform a "for in" on the Stack object, or when calling .map()
     */
    open func makeIterator() -> Array<Element>.Iterator {
        
        return array.reversed().makeIterator()
    }
    
    /**
     Get a sequence from the head to the tail
     */
    open func enumerated() -> EnumeratedSequence<[Element]> {
        
        return array.reversed().enumerated()
        
    }
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
}
