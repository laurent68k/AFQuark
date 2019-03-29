//
//  PdfGen.swift
//  My external Pod project
//
//  Created by Laurent Favard on 26/03/2019
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit

class AFPdf {

    //--------------------------------------------------------------------------------------------------------------
    private static var temporaryDirectory : URL? {
        
        if #available(iOS 10.0, *) {
            
            return FileManager.default.temporaryDirectory
        }
        
        return try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
    }
    //--------------------------------------------------------------------------------------------------------------

    /**
     Build from the formatter and return an URL to the PDF document
     */
    class func create(named fileName:String, from formatter: UIViewPrintFormatter) -> URL? {
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formatter, startingAtPageAt: 0)
        
        //  Create Paper Size for print
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw        
        let filedata = NSMutableData()
        UIGraphicsBeginPDFContextToData(filedata, CGRect.zero, nil)
        
        for i in 1...render.numberOfPages {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file you can also save this file by using another button
        
        var documentsDirectory = self.temporaryDirectory
        documentsDirectory?.appendPathComponent( fileName )
        
        if let documentsDirectory = documentsDirectory {
            
            filedata.write(to: documentsDirectory, atomically: true)
        }
        
        return documentsDirectory
    }    
}
