//
//  AFAboutViewController.swift
//  AFQuark
//
//  Created by Laurent Favard on 12/04/2018.
//  Copyright © 2018 Laurent Favard. All rights reserved.
//


import Foundation
import UIKit
import MessageUI
import StoreKit

open class AFAboutViewController: UIViewController {
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    weak var giveOpinionButton: UIButton? {

        didSet {

            self.giveOpinionButton?.addTarget(self, action: #selector(giveNote), for: .touchUpInside)
        }
    }

    weak var versionLabel: UILabel? {

        didSet {

            let version : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? String.empty
            let build : String = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? String.empty

            self.versionLabel?.text = "Version \(version) Build \(build)"
        }
    }
    //---------------------------------------------------------------------------------------------------------------------------------------------
    //  MARK: - Initialisers
    open override func viewDidLoad() {
        
        super.viewDidLoad()

        if #available(iOS 10.3, *) {
            self.giveOpinionButton?.isHidden = false
        }
        else {
            self.giveOpinionButton?.isHidden = true
        }        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
        
    @objc func giveNote() {
    
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
        else {
            // Fallback on earlier versions
        }
    }
    
    //  MARK: - Public Functions    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let locationPoint = touch.location(in: self.view)
            let subView = self.view.hitTest(locationPoint, with: event)
            
            if subView === self.view {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
