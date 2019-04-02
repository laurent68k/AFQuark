//
//  Stack.swift
//  OpenSwiftLib
//
//  Created by Laurent on 13/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//
import Foundation
//import RxSwift

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
public class AFStack<Element: Equatable> : Sequence {
    
   /**
        Size of the Stack
     */
    public var size : Int {
    
        return self.array.count
    }
    
    /**
        Top element on the stack if any
     */
    public var topItem: Element? {

        return self.array.last
    }
    
    /**
        Bottom element on the stack if any
     */
    public var bottomItem: Element? {
        
        return self.array.first
    }
 
    public var isEmpty : Bool {
            
        return self.size == 0 && self.topItem == nil
    }

     /*public struct RxObservables {
        
        public var topItem : Variable<Element?> = Variable<Element?>(nil)
        public var bottomItem : Variable<Element?> = Variable<Element?>(nil)
        public var size : Variable<Int> = Variable<Int>(0)
        
        public var isEmpty : Observable<Bool> {
            
            return Observable.zip(self.size.asObservable(), self.topItem.asObservable(), resultSelector: {
                
                $0 == 0 && $1 == nil
            })
        }
    }*/
    
    //public let rx = RxObservables()
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    private (set) var name : String = String.empty
    private var array = [Element]()
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    public init() {
        
    }
    public init(withName name:String) {
        
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
    public func push(_ value:Element) {
        
        self.array.append(value)
        
//        self.size.value = self.array.count
//        self.topItem.value = self.array.last
//        self.bottomItem.value = self.array.first
    }
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    
    /**
        Pop the last object from the stack. Raise StackError.Empty is stack empty
     */
    public func pop() throws -> Element {
        
        if self.array.count > 0 {
            
            let element = self.array.removeLast()

//            self.size.value = self.array.count
//            self.topItem.value = self.array.last
//            self.bottomItem.value = self.array.first
            
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
        
        return array.reversed().makeIterator()
    }
    
    /**
     Get a sequence from the head to the tail
     */
    public func enumerated() -> EnumeratedSequence<[Element]> {
        
        return array.reversed().enumerated()
        
    }
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
}
