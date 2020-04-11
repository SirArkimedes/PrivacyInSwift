//
//  Alamofire+Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Alamofire
import SwiftyJSON

struct AlamofirePrivacy {

    // MARK: - Builders

    static func get(route: String, privacy: Privacy) {
        let route = createRoute(for: privacy, with: route)
        let headers = standardHeadersAppendingApiKey(for: privacy)
        AF.request(route, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }

    static func post(route: String, json: JSON, privacy: Privacy) {
        let route = createRoute(for: privacy, with: route)
        let headers = standardHeadersAppendingApiKey(for: privacy)
        AF.request(route, method: .post, parameters: json, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Helpers

    static private func createRoute(for privacy: Privacy, with customRoute: String) -> String {
        return "\(privacy.environment.route())/\(privacy.apiVersion.rawValue)/\(customRoute)"
    }

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
