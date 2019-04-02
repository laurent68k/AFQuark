//
//  Queue.swift
//  OpenSwiftLib
//
//  Created by Laurent on 20/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//
import Foundation
//import RxSwift

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
public class AFQueue<Element: Equatable> : Sequence {
    
    /**
     Size of the queue
     */
    public var size : Int {
        
        return self.array.count
    }
    
    /**
     Head element of the queue if any
     */
    public var headItem: Element? {
        
        return self.array.first
    }
    
    /**
     Tail element of the queue if any
     */
    public var tailItem: Element? {
        
        return self.array.last
    }
    
    public var isEmpty : Bool {

        return self.size == 0 && self.headItem == nil
    }

    /*public struct RxObservables {
        
        public var headItem : Variable<Element?> = Variable<Element?>(nil)
        public var tailItem : Variable<Element?> = Variable<Element?>(nil)
        public var size : Variable<Int> = Variable<Int>(0)
        
        public var isEmpty : Observable<Bool> {
            
            return Observable.zip(self.size.asObservable(), self.headItem.asObservable(), resultSelector: {
                
                $0 == 0 && $1 == nil
            })
        }
    }
    
    public let rx = RxObservables()*/
    public typealias ChangeHandler = ( (Int, Element?, Element?) -> Void)
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    private (set) var name : String = String.empty
    private var array = [Element]()
    private var changeHandler: ChangeHandler? = nil
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    public init( changeHandler: ChangeHandler? = nil) {
        
        self.changeHandler = changeHandler
    }
    
    convenience init(withName name:String, changeHandler: ChangeHandler? = nil) {
        
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
    public func enqueue(_ value:Element) {
        
        self.array.append(value)
        
        self.changeHandler?(self.array.count, self.array.last, self.array.first)
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    
    /**
     Dequeue the first element from the queue. Raise QueueError.Empty is queue empty
     */
    public func dequeue() throws -> Element {
        
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
    public func find(indexOf valueToFind: Element) -> Int? {
        
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
    public func makeIterator() -> Array<Element>.Iterator {
        
        return array.makeIterator()
    }
    
    /**
     Get a sequence from the head to the tail
     */
    public func enumerated() -> EnumeratedSequence<[Element]> {
        
        return array.enumerated()
        
    }
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
}
