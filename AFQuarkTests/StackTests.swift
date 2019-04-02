//
//  OpenSwiftLibTests.swift
//  OpenSwiftLibTests
//
//  Created by Laurent on 13/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//

import XCTest
@testable import AFQuark

class StackTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func test001() {

        let stack : AFStack = AFStack<String>()
        
        for i in 1...100 {
            
            stack.push( String("Value \(i)"))
            XCTAssert(stack.size == i, "test001 failed: Expected \(i) element(s) in the stack" )
        }
    }
    
    func test002() {
        
        let stack : AFStack = AFStack<String>()
        
        stack.push("Car")
        XCTAssert(stack.size == 1, "test002 failed: Expected 1 element in the stack" )
        
        stack.push("Motorbike")
        XCTAssert(stack.size == 2, "test002 failed: Expected 2 element in the stack" )
        
        stack.push("Bike")
        XCTAssert(stack.size == 3, "test002 failed: Expected 3 element in the stack" )
        
        do {
            let value = try stack.pop()
            XCTAssert(value == "Bike", "test002 failed: Expected 'Bike' element from the stack" )
        }
        catch {
        
        }
        
        do {
            let value = try stack.pop()
            XCTAssert(value  == "Motorbike", "test002 failed: Expected 'Motorbike' element from the stack" )
        }
        catch {
        
        }

        do {
            let value = try stack.pop()
            XCTAssert(value  == "Car", "test002 failed: Expected 'Car' element from the stack" )
        }
        catch {
        
        }

    }

    func test003() {
        
        let stack : AFStack = AFStack<String>()
        
        do {
            _ = try stack.pop()
            XCTAssert(false, "test003 failed: Expected 'StackError.Empty' exceptton from the stack" )
        }
        catch AFStackError.Empty {
            
        }
        catch {
            
        }
    }

    func test004() {

        let values = [ "Car", "Motorbike", "Bike" ]
        let stack : AFStack = AFStack<String>()
        
        for value in values {
            
            stack.push(value)
        }

        var decrement = values.count - 1
        for value in stack {
            
            print("value: \(value)")
            XCTAssert(value == values[decrement], "test004 failed: Value is '\(value)' Expected '\(values[decrement])' from the stack.makeIterator()" )
            
            decrement -= 1
        }
    }

    func test005() {
        
        let values = [ "Car", "Motorbike", "Bike" ]
        let stack : AFStack = AFStack<String>()
        
        for value in values {
            
            stack.push(value)
        }
        
        var decrement = values.count - 1
        var increment = 0
        for (index,value) in stack.enumerated() {
            
            print("index: \(index) value: \(value)")
            
            XCTAssert(value == values[decrement], "test005 failed: Value is '\(value)' Expected '\(values[decrement])' from the stack.enumerated()" )
            XCTAssert(index == increment, "test005 failed: Index is '\(index)' Expected '\(increment)' from the stack.enumerated()" )

            decrement -= 1
            increment += 1
        }
    }
    
    func test009() {
        
        let stack : AFStack = AFStack<String>()
        
        stack.push("Car")
        stack.push("Motorbike")
        stack.push("Bike")
        
        XCTAssert(stack.topItem == "Bike", "test002 failed: Expected 'Car' element from the stack" )
        XCTAssert(stack.bottomItem == "Car", "test002 failed: Expected 'Car' element from the stack" )
    }

    func test010() {
        
        let values = [ "Car", "Motorbike", "Bike" ]
        let stack : AFStack = AFStack<String>()
        
        for value in values {
            
            stack.push(value)
        }
        
        var decrement = values.count - 1
        var increment = 0
        for value in stack.map( { $0.uppercased() } ) {
            
            print("index: \(index) value: \(value)")
            
            XCTAssert(value == values[decrement].uppercased(), "test005 failed: Value is '\(value)' Expected '\(values[increment].uppercased())' from the statck.amp()" )
            
            decrement -= 1
            increment += 1
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
