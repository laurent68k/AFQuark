//
//  ViewController.swift
//  AFQuarkApp
//
//  Created by Laurent Favard on 26/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit
import AFQuark

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func alertOk(_ sender: Any) {
        
        AFAlert.okAlert(self, title: "Quark", message: "Alert box with OK button", completionHandler: {
            
            print("On OK confirmed")
        })
    }
    
    @IBAction func alertOkCancel(_ sender: Any) {
        
        AFAlert.okCancelAlert(self, title: "Quark", message: "Alert box with OK and Cancel buttons", okHandler: {
            
            print("On OK button")
            
        }, cancelHandler: {
                
            print("On Cancel Button")
        })
    }
    
    @IBAction func alertToast(_ sender: Any) {
        
        AFAlert.toast(self, title: "Quark", message: "Alert box as toast", delaySeconds: 1.5, completionHandler: {
            
            print("Alert toast closed")
        })
    }
    
    @IBAction func alertMultiple(_ sender: Any) {
        
        var actions: [UIAlertAction] = []
        
        actions.append( UIAlertAction(title: "Button 1", style: .default, handler: { _ in print("Button 1 pressed")}))
        actions.append( UIAlertAction(title: "Button 2", style: .default, handler: { _ in print("Button 2 pressed")}))
        actions.append( UIAlertAction(title: "Button 3", style: .default, handler: { _ in print("Button 3 pressed")}))
        
        AFAlert.alert(self, title: "Quark", message: "Alert with multiple buttons", withActions: actions)
    }
    
    @IBAction func alertSheetMultiple(_ sender: Any) {

        var actions: [UIAlertAction] = []
        
        actions.append( UIAlertAction(title: "Button 1", style: .default, handler: { _ in print("Button 1 pressed")}))
        actions.append( UIAlertAction(title: "Button 2", style: .default, handler: { _ in print("Button 2 pressed")}))
        actions.append( UIAlertAction(title: "Button 3", style: .default, handler: { _ in print("Button 3 pressed")}))
        
        AFAlert.alertSheet(self, title: "Quark", message: "Alert Sheet with multiple buttons", forButton: sender, withActions: actions)
    }
}

