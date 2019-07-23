//
//  UIImage.swift
//  AFQuark
//
//  Created by Laurent Favard on 28/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//
//  From Marcos Griselli on 6/9/17.
//  Copyright © 2017 Marcos Griselli. All rights reserved.
//

import UIKit

public extension AFBase where Base: UIImage {
    
    func resize(targetSize: CGSize) -> UIImage? {
        
        let size = self.base.size
        
        let widthRatio  = targetSize.width  /  self.base.size.width
        let heightRatio = targetSize.height /  self.base.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.base.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func scale(by scale: CGFloat) -> UIImage? {
        
        let size = self.base.size
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        return self.resize(targetSize: scaledSize)
    }
}

