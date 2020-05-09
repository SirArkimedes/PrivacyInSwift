//
//  Environment.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation

/**
 Specifies which URL the SDK will use to make its requests.
 */
public enum Environment {
    case production
    case sandbox

    private static let productionRoute = "https://api.privacy.com"
    private static let sandboxRoute = "https://sandbox.privacy.com"

    func route() -> String {
        let route: String
        switch self {
        case .production:
            route = Environment.productionRoute
        case .sandbox:
            route = Environment.sandboxRoute
        }
        return route
    }
}
