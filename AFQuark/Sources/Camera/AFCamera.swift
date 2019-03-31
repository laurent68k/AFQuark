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
 *  Convenience class for camera handling: Available for iOS only
 */
#if os(iOS)
open class AFCamera {

   /**
    *   Handle the photo shoot with the camera. Need to implement UIImagePickerControllerDelegate on your UIViewController
    */
    open class func capture(_ viewController: UIViewController) {
        
        let imagePicker = self.createImagePicker(viewController)
        
        if let imagePicker = imagePicker {
            
            //  Request the camera access. If has been deny iOS will present an Alert to ask the user to allows or not
            AVCaptureDevice.requestAccess(for: .video) {
                
                granted in
                
                //  Cause this error in the Ouput console: I use the DispatchQueue to be sure to avoid any thread issue
                //  [UIView setAnimationsEnabled:] being called from a background thread. Performing any operation from a background thread on UIView or a subclass is not supported and may result in unexpected and insidious behavior
                DispatchQueue.main.async {

                    if granted {
                        
                        viewController.present(imagePicker, animated: true, completion: nil)
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
        }
    }
   
    /**
     Create the UIImagePickerController to present
     */
    private static func createImagePicker(_ viewController: UIViewController) -> UIImagePickerController? {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false   //  Crop editing not allowed
            
            return imagePicker
        }

        AFAlert.okAlert(viewController, title:  NSLocalizedString( "Camera", comment:""), message: NSLocalizedString("Your device does not have a camera", comment:""))
        return nil
    }
}
#endif
