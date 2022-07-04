import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#endif

public protocol AppKitable {
    var appDisplayName: String? { get }
    var appBundleID: String? { get }
    var appVersion: String? { get }
    var appBuild: String? { get }
}

public extension AppKitable {

	/// App's name.
	var appDisplayName: String? {
		// http://stackoverflow.com/questions/28254377/get-app-name-in-swift
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
	}
	
	/// App's bundle ID.
	var appBundleID: String? {
		return Bundle.main.bundleIdentifier
	}
	
	/// App's current version.
	var appVersion: String? {
		return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
	}

	/// App current build number.
	var appBuild: String? {
		return Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
	}
}

// MARK: - Environment
public extension AppKitable {
	
	/// Check if app is running in TestFlight mode.
	var isInTestFlight: Bool {
		// http://stackoverflow.com/questions/12431994/detect-testflight
		return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
	}

	/// Check if application is running on simulator (read-only).
	var isRunningOnSimulator: Bool {
		// http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if targetEnvironment(simulator)
			return true
		#else
			return false
		#endif
	}

}
