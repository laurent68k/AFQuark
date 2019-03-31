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
     Format and return the self date and time: 28 March 2019 at 19:08
     
     */
    var asDateTimeLocalized : String {
        
        //  Format the ouput now with a specific formatter regarding the current localization
        let dateOutputFormatter  = DateFormatter()
        
        dateOutputFormatter.dateStyle = .long
        dateOutputFormatter.timeStyle = .short
        //dateOutputFormatter.locale = Locale.autoupdatingCurrent
        
        let outputDate = dateOutputFormatter.string(from: self)
        
        return outputDate
    }
    
    /**
     Format and return the self date only: 28 March 2019
     
     */
    var asDateLocalized : String {
        
        //  Format the ouput now with a specific formatter regarding the current localization
        let dateOutputFormatter  = DateFormatter()
        
        dateOutputFormatter.dateStyle = .long
        dateOutputFormatter.timeStyle = .none
        //dateOutputFormatter.locale = Locale.autoupdatingCurrent
        
        let outputDate = dateOutputFormatter.string(from: self)
        
        return outputDate
    }
    
    /**
     Format self as localized short date and time: 28/03/2019 19:08
     */
    var asShortDateTimeLocalized : String {
        
        //  Format the ouput now with a specific formatter regarding the current localization
        let dateOutputFormatter  = DateFormatter()
        
        dateOutputFormatter.dateStyle = .short
        dateOutputFormatter.timeStyle = .short
        //dateOutputFormatter.locale = Locale.autoupdatingCurrent
        
        let outputDate = dateOutputFormatter.string(from: self)
        
        return outputDate
    }
    
    /**
     Format self as localized long date and time: Thursday 28 March 2019 at 19:08
     */
    var asLongDateTimeLocalized: String {
        
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .full
        
        // get the date time String from the date object
        return formatter.string(from: currentDateTime)
    }
}

