//
//  AFXibTableViewCell.swift
//  AFQuark
//
//  Created by Laurent Favard on 05/03/2018.
//  Copyright © 2018 Laurent Favard. All rights reserved.
//


import UIKit

/**
 Base class for implementing easily your own XIB UITableViewCell
 */
open class AFXibTableViewCell : UITableViewCell {
    
    /**
        represent any free user object 
      */
    var anyObject : Any?
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    //  MARK: - Initializers
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style:style, reuseIdentifier:reuseIdentifier)
    }
    
    public required init?(coder aCoder: NSCoder) {
        
        super.init(coder: aCoder)
    }

    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    //  MARK: - Class functions to override for a UITableView for instance.
    /**
     Reuse identifier to use in UITableView for dequeuing
     */
    open class func reuseIdentifier() -> String {
      
        //  Override this identifier in the sub-class
        return "AFXibTableViewCell"
    }

    /**
     Register to the UITableView this kind of cell: Must be override
     */
    open class func register(to tableView:UITableView) {
        
        let className = String(describing: AFXibTableViewCell.self)
        
        tableView.register( UINib(nibName: className, bundle: nil), forCellReuseIdentifier: AFXibTableViewCell.reuseIdentifier())
    }
}
