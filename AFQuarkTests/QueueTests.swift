//
//  QueueTests.swift
//  OpenSwiftLibTests
//
//  Created by Laurent on 20/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//

import XCTest
@testable import AFQuark

class QueueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test001() {
        
        let queue : AFQueue = AFQueue<String>()
        
        for i in 1...100 {
            
            queue.enqueue( String("Value \(i)"))
            XCTAssert(queue.size == i, "test001 failed: Expected \(i) element(s) in the queue" )
        }
    }
    
    func test002() {
        
        let queue : AFQueue = AFQueue<String>()
        
        queue.enqueue("Car")
        XCTAssert(queue.size == 1, "test002 failed: Expected 1 element in the queue" )
        
        queue.enqueue("Motorbike")
        XCTAssert(queue.size == 2, "test002 failed: Expected 2 element in the queue" )
        
        queue.enqueue("Bike")
        XCTAssert(queue.size == 3, "test002 failed: Expected 3 element in the queue" )
        
        do {
            let value = try queue.dequeue()
            XCTAssert(value == "Car", "test002 failed: Expected 'Car' element from the queue" )
        }
        catch {
            
        }
        
        do {
            let value = try queue.dequeue()
            XCTAssert(value  == "Motorbike", "test002 failed: Expected 'Motorbike' element from the queue" )
        }
        catch {
            
        }
        
        do {
            let value = try queue.dequeue()
            XCTAssert(value  == "Bike", "test002 failed: Expected 'Bike' element from the queue" )
        }
        catch {
            
        }
        
    }
    
    func test003() {
        
        let queue : AFQueue = AFQueue<String>()
        
        do {
            _ = try queue.dequeue()
            XCTAssert(false, "test003 failed: Expected 'QueueError.Empty' exceptton from the queue" )
        }
        catch AFQueueError.Empty {
            
        }
        catch {
            
        }
    }
    
    func test004() {
        
        let values = [ "Car", "Motorbike", "Bike" ]
        let queue : AFQueue = AFQueue<String>()
        
        for value in values {
            
            queue.enqueue(value)
        }
        
        var increment = 0
        for value in queue {
            
            print("value: \(value)")
            XCTAssert(value == values[increment], "test004 failed: Value is '\(value)' Expected '\(values[increment])' from the queue()" )
            
            increment += 1
        }
    }
    
    func test005() {
        
        let values = [ "Car", "Motorbike", "Bike" ]
        let queue : AFQueue = AFQueue<String>()
        
        for value in values {
            
            queue.enqueue(value)
        }
        
        //var decrement = values.count - 1
        var increment = 0
        for (index,value) in queue.enumerated() {
            
            print("index: \(index) value: \(value)")
            
            XCTAssert(value == values[increment], "test005 failed: Value is '\(value)' Expected '\(values[increment])' from the queue()" )
            XCTAssert(index == increment, "test005 failed: Index is '\(index)' Expected '\(increment)' from the queue()" )
            
            //decrement -= 1
            increment += 1
        }
    }
    
    func test009() {
        
        let queue : AFQueue = AFQueue<String>()
        
        queue.enqueue("Car")
        queue.enqueue("Motorbike")
        queue.enqueue("Bike")
        
        XCTAssert(queue.headItem == "Car", "test002 failed: Expected 'Car' element from the queue" )
        XCTAssert(queue.tailItem == "Bike", "test002 failed: Expected 'Car' element from the queue" )
    }
    
    func test010() {
        
        let values = [ "Car", "Motorbike", "Bike" ]
        let queue : AFQueue = AFQueue<String>()
        
        for value in values {
            
            queue.enqueue(value)
        }
        
        var increment = 0
        for value in queue.map( { $0.uppercased() } ) {
            
            print("index: \(index) value: \(value)")
            
            XCTAssert(value == values[increment].uppercased(), "test005 failed: Value is '\(value)' Expected '\(values[increment].uppercased())' from the queue.map()" )
            
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
