//
//  Stack.swift
//  AFQuark
//
//  Created by Laurent on 13/11/2017.
//  Copyright © 2017 Laurent68k. All rights reserved.
//

import Foundation


/**
 Files class to access files in the documents sandbox
 */
open class AFFiles {

    /**
     Get the file image from Documents
     */
    open class func image(forName name:String) -> Data? {
        
        guard !name.isEmpty else {
            
            return nil
        }
        
        var documentDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
        let file = "\(name).jpg"
        
        documentDirectory?.appendPathComponent(file)
        
        //print("reading from: \(String(describing: documentDirectory?.absoluteString))")
        
        var data : Data?
        if let document = documentDirectory {
            
            data = try? Data(contentsOf: document)
        }
        return data
    }
    
    /**
     Save the file image in Documents
     */
    open class func saveImage(_ data:Data?, forName name:String) {
        
        guard !name.isEmpty else {
            
            return
        }
        
        var documentDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
        let file = "\(name).jpg"
        
        documentDirectory?.appendPathComponent(file)
        
        //print("writing from: \(String(describing: documentDirectory?.absoluteString))")
        
        if let document = documentDirectory {
            
            try? data?.write(to: document)
        }
    }
    
    /**
     Remove the file image in Documents
     */
    open class func deleteImage(forName name:String) {
        
        guard !name.isEmpty else {
            
            return
        }
        
        var documentDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
        let file = "\(name).jpg"
        
        documentDirectory?.appendPathComponent(file)
        
        //print("deleting from: \(String(describing: documentDirectory?.absoluteString))")
        
        if let document = documentDirectory {
            
            try? FileManager.default.removeItem(at: document)
        }
    }

}