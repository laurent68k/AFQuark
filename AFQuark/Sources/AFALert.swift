//
//  AFAlert
//  My external Pod project
//
//  Created by Laurent Favard on 26/03/20189
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit

/**
 *  Convenience class for alert box
 */

open class AFAlert {

   /**
    *   create and show an alert box on the screen with a OK/Cancel buttons and an optional handlers
    */
    open class func okCancelAlert(_ viewController: UIViewController, title: String, message: String,
                                                okHandler: (() -> Void )? = nil, cancelHandler: (() -> Void )? = nil ) {
        
        let okAction = UIAlertAction(title: NSLocalizedString( "OK", comment:""), style: .default, handler: {

            _ in
            
            okHandler?()
        })

        let cancelAction = UIAlertAction(title: NSLocalizedString( "Cancel", comment:""), style: .cancel, handler: {

            _ in
            
            cancelHandler?()
        })

        //  cancel must be placed at the left, Ok at the right
        AFAlert.alert( viewController, title: title, message: message, withActions: [okAction, cancelAction ])
    }

   /**
    *   create and show an alert box on the screen with a default OK button and an optional OK handler
    */
    open class func okAlert(_ viewController: UIViewController, title: String, message: String, completionHandler: (() -> Void)? = nil) {
        
        let action = UIAlertAction(title: NSLocalizedString( "OK", comment:""), style: .default, handler: {
            
            _ in

            completionHandler?()
        })

        AFAlert.alert( viewController, title: title, message: message, withActions: [action])
    }

   /**
    *   create and show an alert box on the screen which will automatcially close after the delay, with an optional close handler
    */
    open class func toast(_ viewController: UIViewController, title: String, message: String, delaySeconds: Double = 1.0, completionHandler: (() -> Void )? = nil) {
        
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        viewController.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) {

            alert.dismiss(animated: true, completion: nil )
            completionHandler?()
        }
    }


   /**
    *   create and show an alert box on the screen
    */
    open class func alert(_ viewController: UIViewController, title: String, message: String, withActions actions: [UIAlertAction]?) {

        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let actions = actions {

            for action in actions {           

                alert.addAction(action)
            }
        }

        viewController.present(alert, animated: true, completion: nil)
    }

   /**
    *   create and show an alert sheet box on the screen with an anchor UIButton or UIBarButtonItem
    */
    open class func alertSheet(_ viewController: UIViewController, title: String, message: String, forButton anchorObject: Any, withActions actions: [UIAlertAction]) {

        let alert = UIAlertController(title: title, message:message, preferredStyle: .actionSheet)

        for action in actions {           

            alert.addAction(action)
        }

        if let button = anchorObject as? UIButton {

            alert.popoverPresentationController?.sourceView = button
            alert.popoverPresentationController?.sourceRect = button.bounds
        }
        else if let barItem = anchorObject as? UIBarButtonItem {

            // Required for iPad, not for iPhone
            alert.popoverPresentationController?.barButtonItem = barItem
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
