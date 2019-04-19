//
//  Date.swift
//  AFQuark
//
//  Created by Laurent Favard on 28/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import Foundation

public extension Date {
    
    /**
     Format and return the self date and time
     
     */
    var asDateTimeLocalized : String {
        
        //  Format the ouput now with a specific formatter regarding the current localization
        let dateOutputFormatter  = DateFormatter()
        
        dateOutputFormatter.dateStyle = .long
        dateOutputFormatter.timeStyle = .short
        dateOutputFormatter.locale = Locale.autoupdatingCurrent
        
        let outputDate = dateOutputFormatter.string(from: self)
        
        return outputDate
    }
    
    /**
     Format and return the self date only
     
     */
    var asDateLocalized : String {
        
        //  Format the ouput now with a specific formatter regarding the current localization
        let dateOutputFormatter  = DateFormatter()
        
        dateOutputFormatter.dateStyle = .long
        dateOutputFormatter.timeStyle = .none
        dateOutputFormatter.locale = Locale.autoupdatingCurrent
        
        let outputDate = dateOutputFormatter.string(from: self)
        
        return outputDate
    }
    
    /**
     Format self as localized short date and time: dd/mm/yyyy hh:mm
     */
    var asShortDateTimeLocalized : String {
        
        //  Format the ouput now with a specific formatter regarding the current localization
        let dateOutputFormatter  = DateFormatter()
        
        //dateOutputFormatter.formatterBehavior = .behavior10_4
        
        dateOutputFormatter.dateStyle = .short
        dateOutputFormatter.timeStyle = .short
        dateOutputFormatter.locale = Locale.autoupdatingCurrent
        
        let outputDate = dateOutputFormatter.string(from: self)
        
        return outputDate
    }
}
