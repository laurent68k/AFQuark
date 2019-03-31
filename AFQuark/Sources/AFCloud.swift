//
//  AFiCloud
//  My external Pod project
//
//  Created by Laurent Favard on 26/03/2019
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit

open class AFiCloud {
    
    //--------------------------------------------------------------------------------------------------------------
    
    public static let shared = AFiCloud()
    
    //--------------------------------------------------------------------------------------------------------------
    /**
     Cloud folder to use inside the shared cloud folder Application
     */
    public static var cloudFolder : String {
        
        return UIDevice.current.name
    }
    
    /**
     File Manager to use
     */
    private var fileManager: FileManager {
        
        return FileManager.default
    }
    
    /**
     URL to access the working folder for the iCloud iOS daemon
     */
    private var iCloudDocumentsURL : URL? 
    
    //--------------------------------------------------------------------------------------------------------------
    
    private init() {
        
        //  Start an asynchronous request to get the iCloud url to use:
        //  Apple: this method might take a nontrivial amount of time to set up iCloud and return the requested URL,
        //  you should always call it from a secondary thread
        DispatchQueue.main.async {
            
            //  Keyword 'Documents' is very IMPORTANT and must be added at the hand
            let remoteUrl = self.fileManager.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
            
            self.iCloudDocumentsURL = remoteUrl
        }
    }
    
    //--------------------------------------------------------------------------------------------------------------
    
    open func synchronize(fromSource localCloudFolder: URL) {
        
        //is iCloud working?
        if let iCloudDocumentsURL = self.iCloudDocumentsURL {
            
            let iCouldDestination = iCloudDocumentsURL.appendingPathComponent( AFiCloud.cloudFolder )
            
            //Create the Directory if it doesn't exist
            if (!self.fileManager.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: nil)) {
                
                do {
                    try self.fileManager.createDirectory(at: iCloudDocumentsURL, withIntermediateDirectories: true, attributes:nil)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            do {
                try self.fileManager.removeItem(at: iCouldDestination)
            }
            catch {
                print(error.localizedDescription)
            }
            
            do {
                try self.fileManager.copyItem(at: localCloudFolder, to: iCouldDestination)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        else {
            print("iCloud is NOT working or not available yet")
        }
    }
}
