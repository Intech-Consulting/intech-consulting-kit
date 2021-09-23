//
//  CLLocationManager.swift
//  ZamzamKit
//
//  Created by Basem Emara on 2/18/16.
//  Copyright © 2016 Zamzam. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLLocationManager {
    
    /// Determines if location services is enabled and authorized for always or when in use.
    static var isAuthorized: Bool {
        var authorization: [CLAuthorizationStatus] = [.authorizedAlways]
        #if os(iOS)
        authorization.append(.authorizedWhenInUse)
        #endif
        return CLLocationManager.locationServicesEnabled()
            && CLLocationManager.authorizationStatus()
                .within(authorization)
    }

}
