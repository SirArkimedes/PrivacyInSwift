//
//  Alamofire+Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Alamofire

struct AlamofirePrivacy {

    // MARK: - Builders

    static func get(route: String, privacy: Privacy) {
        let route = "\(privacy.environment.route())/\(privacy.apiVersion.rawValue)/card"
        let headers = standardHeadersAppendingApiKey(for: privacy)
        AF.request(route, headers: headers).responseJSON { response in
            print(response.debugDescription)
        }
    }

    // MARK: - Helpers

    static private func standardHeadersAppendingApiKey(for privacy: Privacy) -> HTTPHeaders {
        var headers: [String: String] = [
            "Content-Type": "application/json",
        ]

        let apiKey: String
        switch privacy.environment {
        case .production:
            apiKey = privacy.productionApiKey
        case .sandbox:
            apiKey = privacy.sandboxApiKey
        }

        headers["Authorization"] = "api-key \(apiKey)"
        return HTTPHeaders(headers)
    }
}
