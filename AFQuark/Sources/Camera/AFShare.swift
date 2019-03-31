//
//  AFShare.swift
//  AFQuark
//
//  Created by Laurent Favard on 31/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit

/**
 *  Convenience class for share handling
 */
open class AFShare {
    
    open class func shareImages(_ viewController: UIViewController, anchorObject: Any, images: [UIImage], excludedTypes: [UIActivity.ActivityType]? = nil) {
        
        var imagesData : [Any] = []
        
        for image in images {
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                
                imagesData.append(imageData)
            }
        }
        
        if imagesData.count > 0 {
            
            let activityController = UIActivityViewController(activityItems: imagesData, applicationActivities: nil)
            
            if let excludedTypes = excludedTypes {
                
                activityController.excludedActivityTypes = excludedTypes
            }
            else {
                activityController.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook,
                                                            UIActivity.ActivityType.postToTwitter,
                                                            UIActivity.ActivityType.postToWeibo,
                                                            UIActivity.ActivityType.print,
                                                            UIActivity.ActivityType.assignToContact,
                                                            UIActivity.ActivityType.addToReadingList,
                                                            UIActivity.ActivityType.postToFlickr,
                                                            UIActivity.ActivityType.postToVimeo,
                                                            UIActivity.ActivityType.postToTencentWeibo]
            }
            
            if let popoverPresentationController = activityController.popoverPresentationController {
                
                popoverPresentationController.sourceView = (anchorObject as? UIView)
                popoverPresentationController.barButtonItem = (anchorObject as? UIBarButtonItem)
            }
            
            viewController.present(activityController, animated: true, completion: nil)
        }
    }
    
    /**
     Handle the schemes sharing
     */
    func shareAppLink(_ viewController: UIViewController, _ anchorObject: Any, appName: String, appLink: String, coverImage: UIImage?) {
        
        let description = NSLocalizedString("I recommend the application \(appName) available on the App Store\n\n", comment: "")
        
        let data : [Any]
        if let image = coverImage {
            
            data = [description, image, appLink]
        }
        else {
            
            data = [description, appLink]
        }
        
        let activityController = UIActivityViewController(activityItems: data, applicationActivities: nil)
        
        activityController.excludedActivityTypes = [UIActivity.ActivityType.postToWeibo,
                                                    UIActivity.ActivityType.assignToContact,
                                                    UIActivity.ActivityType.addToReadingList,
                                                    UIActivity.ActivityType.postToFlickr,
                                                    UIActivity.ActivityType.postToVimeo,
                                                    UIActivity.ActivityType.postToTencentWeibo]
        
        if let popoverPresentationController = activityController.popoverPresentationController {
            
            popoverPresentationController.sourceView = (anchorObject as? UIView)
            popoverPresentationController.barButtonItem = (anchorObject as? UIBarButtonItem)
        }
        
        viewController.present(activityController, animated: true, completion: nil )
    }
}
