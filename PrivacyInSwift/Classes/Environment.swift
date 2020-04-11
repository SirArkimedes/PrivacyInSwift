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

    func url() -> URL {
        let urlString: String
        switch self {
        case .production:
            urlString = Environment.productionRoute
        case .sandbox:
            urlString = Environment.sandboxRoute
        }
        return URL(string: urlString)!
    }
}
