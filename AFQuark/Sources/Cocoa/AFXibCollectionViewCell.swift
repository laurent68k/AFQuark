//
//  AFXibCollectionViewCell.swift
//  AFQuark
//
//  Created by etudiant on 19/02/2018.
//  Copyright © 2018 etudiant. All rights reserved.
//

import UIKit

/**
 Base class for implementing easily your own XIB UICollectionViewCell
 */
open class AFXibCollectionViewCell : UICollectionViewCell {
    
    /**
        represent any free user object 
      */
    var anyObject : Any?
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    //  MARK: - Initializers
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    public required init?(coder aCoder: NSCoder) {
        
        super.init(coder: aCoder)
    }

    open override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    //  MARK: - Class functions to override for a UICollectionViewCell for instance.
    /**
     Reuse identifier to use in UICollectionViewCell for dequeuing
     */
    open class func reuseIdentifier() -> String {
      
        //  Override this identifier in the sub-class
        return "AFXibCollectionViewCell"
    }

    /**
     Register to the UICollectionViewCell this kind of cell: Must be override
     */
    open class func register(to collectionView:UICollectionView) {
        
        let className = String(describing: AFXibCollectionViewCell.self)
        
        collectionView.register( UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: AFXibCollectionViewCell.reuseIdentifier())
    }
}
