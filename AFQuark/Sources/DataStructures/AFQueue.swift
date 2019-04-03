//
//  Queue.swift
//  AFQuark
//
//  Created by Laurent on 20/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//
import Foundation

/// ---------------------------------------------------------------------------------------------------------------------------------------------
/// ---------------------------------------------------------------------------------------------------------------------------------------------
public enum AFQueueError : Error {
    
    case    Empty
}

/// ---------------------------------------------------------------------------------------------------------------------------------------------
/// ---------------------------------------------------------------------------------------------------------------------------------------------
/**
    Queue FIFO data structure 
 */
open class AFQueue<Element: Equatable> : Sequence {
    
    /**
     Size of the queue
     */
    open var size : Int {
        
        return self.array.count
    }
    
    /**
     Head element of the queue if any
     */
    open var headItem: Element? {
        
        return self.array.first
    }
    
    /**
     Tail element of the queue if any
     */
    open var tailItem: Element? {
        
        return self.array.last
    }
    
    open var isEmpty : Bool {

        return self.size == 0 && self.headItem == nil
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
     Enqueue a new element in the queue
     */
    open func enqueue(_ value:Element) {
        
        self.array.append(value)
        
        self.changeHandler?(self.array.count, self.array.last, self.array.first)
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    
    /**
     Dequeue the first element from the queue. Raise QueueError.Empty is queue empty
     */
    open func dequeue() throws -> Element {
        
        if self.array.count > 0 {
            
            let element = self.array.removeFirst()
            
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
        
        return array.makeIterator()
    }
    
    /**
     Get a sequence from the head to the tail
     */
    open func enumerated() -> EnumeratedSequence<[Element]> {
        
        return array.enumerated()
        
    }
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
}
