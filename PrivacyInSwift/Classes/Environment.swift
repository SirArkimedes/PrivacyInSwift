//
//  Environment.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation

public enum Environment {
    case production
    case sandbox

    static let productionRoute = "https://api.privacy.com"
    static let sandboxRoute = "https://sandbox.privacy.com"

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
