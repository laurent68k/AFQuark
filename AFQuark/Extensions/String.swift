//
//  String.swift
//  AFQuark
//
//  Created by Laurent Favard on 28/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import Foundation

public extension String {
    
    static let empty = ""
    static let utcDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    static let utcTimeFormat = "HH:mm:ss:mmmZZZZZ"
    
    /**
     Return the translated string if any
     */
    var asLocalizable : String {
        
        return NSLocalizedString( self, comment:"")
    }
    
    /**
     Convert in Date the UTC date string representation
     */
    var asDateTime : Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String.utcDateTimeFormat     //"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale.autoupdatingCurrent
        
        return dateFormatter.date(from: self )
    }
    
    var fromNumberLocalToInteger : Int? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale.current
        
        return formatter.number(from: self)?.intValue
        
    }
    
   var fromNumberLocalToDouble : Double? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        return formatter.number(from: self)?.doubleValue
        
    }
    
}
