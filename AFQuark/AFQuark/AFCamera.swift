//
//  AFCamera.swift
//  My external Pod project
//
//  Created by Laurent Favard on 26/03/20189
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit
import AVFoundation


/**
 *  Convenience class for camera handling
 */
open class AFCamera {

   /**
    *   Handle the photo shoot with the camera. Need to implement UIImagePickerControllerDelegate on your UIViewController
    */
    open class func shoot(_ viewController: UIViewController) {
        
        //  Request the camera access. If has been deny iOS will present an Alert to ask the user to allows or not
        AVCaptureDevice.requestAccess(for: .video) {
            
            granted in
            
            if granted {
            
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.allowsEditing = false   //  Crop editing not allowed
                    
                    viewController.present(imagePicker, animated: true, completion: nil)
                }
                else {
                    
                    AFAlert.okAlert(viewController, title:  NSLocalizedString( "Camera", comment:""), message: NSLocalizedString("Your device does not have a camera", comment:""))
                }
            }
            else {
                
                if #available(iOS 10, *) {

                    let cancel = UIAlertAction(title: NSLocalizedString( "Cancel", comment:""), style: .cancel, handler: nil)                    
                    let ok = UIAlertAction(title: NSLocalizedString( "Settings", comment:""), style: .default, handler: {
                        
                        _ in
                        
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            
                            UIApplication.shared.open(settingsUrl, completionHandler: nil )
                        }
                    })

                    AFAlert.alert( viewController, title: NSLocalizedString( "Camera", comment:""), message: NSLocalizedString( "The application is not allowed to access the camera. Allow it in the settings.", comment:""), withActions: [cancel, ok])
                }
                else {
                    
                    AFAlert.okAlert( viewController, title:  NSLocalizedString( "Camera", comment:""), message: NSLocalizedString( "The application is not allowed to access the camera. Allow it in the settings.", comment:""))
                }
            }
        }
    }

    open class func shareImages(_ viewController: UIViewController, _ anchorObject: AnyObject, images: [UIImage]) {

        var imagesData : [Any] = []
        
        for image in images {
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                
                imagesData.append(imageData)
            }
        }
        
        if imagesData.count > 0 {
            
            let activityController = UIActivityViewController(activityItems: imagesData, applicationActivities: nil)
            
            activityController.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook,
                                                        UIActivity.ActivityType.postToTwitter,
                                                        UIActivity.ActivityType.postToWeibo,
                                                        UIActivity.ActivityType.print,
                                                        UIActivity.ActivityType.assignToContact,
                                                        UIActivity.ActivityType.addToReadingList,
                                                        UIActivity.ActivityType.postToFlickr,
                                                        UIActivity.ActivityType.postToVimeo,
                                                        UIActivity.ActivityType.postToTencentWeibo]
            
            if let popoverPresentationController = activityController.popoverPresentationController {
                
                popoverPresentationController.sourceView = (anchorObject as? UIView)
                popoverPresentationController.barButtonItem = (anchorObject as? UIBarButtonItem)
            }
            
            viewController.present(activityController, animated: true, completion: nil)
        }
    }

}
