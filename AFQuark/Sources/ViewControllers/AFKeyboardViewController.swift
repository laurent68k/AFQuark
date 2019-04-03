//
//  AncestorViewControlleur.swift
//  iMO
//
//  Created by Laurent Favard on 12/04/2018.
//  Copyright © 2018 Laurent Favard. All rights reserved.
//


import UIKit
import AVFoundation

/**
 *  Base class introducing:
 *  - The Keyboard management
 *  - NotificationCenter observers storage
 */
open class AFKeyboardViewController: UIViewController, UITextFieldDelegate {
    
    /// ---------------------------------------------------------------------------------------------------------------------------------------------   
    public var observers = [NSObjectProtocol]()
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    public var tapDismissKeyboard : UITapGestureRecognizer?    
    public var textFieldForKeyboard : UITextInput?
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    private var movableKeyboardView : UIView?
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    static let cancelImage = SystemSoundID(1112)
    static let pasteImageSound = SystemSoundID(1111)
    static let positiveAckSound = SystemSoundID(1054)
    static let negativeAckSound = SystemSoundID(1053)
    static let mailSent = SystemSoundID(1001)
    /// ---------------------------------------------------------------------------------------------------------------------------------------------
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    open override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //  Good citizen...
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        if let tapDismissKeyboard = self.tapDismissKeyboard {
            
            self.view.removeGestureRecognizer(tapDismissKeyboard)
        }
        
        for observer in self.observers {
            
            NotificationCenter.default.removeObserver(observer)
        }
    }


    //--------------------------------------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------------------------------------
    //  MARK: - Keyboard Management
    
    /**
     Add an OK button in the keyboard for these input fields. Don't forget to call initKeyboardObservers in viewDidAppear().
     */
    open func addOKItemOnKeyboard(for textFields:[UITextInput]) {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpaceLeft)
        items.append(done)
        items.append(flexSpaceRight)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        for textField in textFields {
            
            if let view = textField as? UITextField {
                
                view.inputAccessoryView = doneToolbar
            }
            else if let view = textField as? UITextView {
                
                view.inputAccessoryView = doneToolbar
            }
            else {
                
            }
        }
    }
        
    /**
     Initialize the keyboard with a view to respond ti dismiss keyboard 
     */
    func initKeyboardObservers(withMovableView keyboardView:UIView) {
        
        self.movableKeyboardView = keyboardView
        
        self.tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        if let tapDismissKeyboard = self.tapDismissKeyboard {
            
            tapDismissKeyboard.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tapDismissKeyboard)
        }
        
        let notificationCenter = NotificationCenter.default
        let mainQueue = OperationQueue.main
        
        self.observers.append( notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: mainQueue)
        {
            [unowned self] notification in
            
            self.keyboardWillShow(notification: notification)
        })
        
        self.observers.append( notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: mainQueue)
        {
            [unowned self] notification in
            
            self.keyboardWillHide(notification: notification)
        })
    }
    
    //--------------------------------------------------------------------------------------------------------------

    @objc private func doneButtonAction() {
        
        self.view.endEditing(true)
    }

    @objc private func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if let keyboardView = self.movableKeyboardView, keyboardView.frame.origin.y == 0 {
                
                if let textField = textFieldForKeyboard {
                    
                    let yKeyboard = self.view.frame.size.height - keyboardSize.height
                    
                    var superView : UIView? = nil
                    var frame = CGRect()
                    
                    //  Get the superview from the TextField or TextView
                    if let object = (textField as? UITextField) {
                        
                        superView = object.superview
                        frame = object.frame
                        
                        
                    }
                    else if let object = (textField as? UITextView) {
                        
                        superView = object.superview
                        frame = object.frame
                    }
                    
                    if let originField = superView?.convert(frame.origin, to: self.view) {
                        
                        let yField = originField.y + frame.size.height
                        
                        if yField > yKeyboard {
                            
                            let delta = (yField - yKeyboard) + 20               //  Add 20 px to have a nice space with the field
                            
                            //print("keyboardWillShow content: \(textField.text) with delta: \(delta)")
                            
                            keyboardView.frame.origin.y -= delta
                        }
                        else {
                            //  Moving the view is unuseful
                        }
                    }
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        
        if let keyboardView = self.movableKeyboardView, keyboardView.frame.origin.y != 0 {
            
            keyboardView.frame.origin.y = 0
        }
    }

}
