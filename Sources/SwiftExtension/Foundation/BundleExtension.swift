//
//  BundleExtension.swift
//  XebiaiOS
//
//  Created by Amine Bensalah on 13/01/2017.
//  Copyright © 2017 nebuladev.info. All rights reserved.
//

import Foundation

public extension Bundle {
    var bundleName: String? {
        infoDictionary?["CFBundleName"] as? String
    }

    var appName: String? {
        infoDictionary?["CFBundleDisplayName"] as? String
    }

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }

    var appEnvironement: String? {
        infoDictionary?["WCAppName"] as? String
    }
}

public extension Bundle {
    
    /**
     Gets the contents of the specified file.
     
     - parameter file: Name of file to retrieve contents from.
     - parameter bundle: Bundle where defaults reside.
     - parameter encoding: Encoding of string from file.
     
     - returns: Contents of file.
     */
    func string(file: String, inDirectory: String? = nil, encoding: String.Encoding = .utf8) -> String? {
        guard let resourcePath = path(forResource: file, ofType: nil, inDirectory: inDirectory) else { return nil }
        return try? String(contentsOfFile: resourcePath, encoding: encoding)
    }
    
    /**
     Gets the contents of the specified plist file.
     
     - parameter plist: property list where defaults are declared
     - parameter bundle: bundle where defaults reside
     
     - returns: dictionary of values
     */
    func contents(plist: String, inDirectory: String? = nil) -> [String: Any] {
        guard let resourcePath = path(forResource: plist, ofType: nil, inDirectory: inDirectory),
            let contents = NSDictionary(contentsOfFile: resourcePath) as? [String: Any]
            else { return [:] }
        
        return contents
    }
}
