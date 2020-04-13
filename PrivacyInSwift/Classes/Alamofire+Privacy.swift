//
//  Alamofire+Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Alamofire
import SwiftyJSON

struct AlamofirePrivacy {

    typealias GetCompletion = (Page?, Error?) -> ()

    private static let privacy = Privacy.instance

    // MARK: - Builders

    static func get(route: String, parameters: [String: AnyHashable]? = nil, completion: @escaping GetCompletion) {
        let r = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            r,
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let page = try? Page(json: json)
                completion(page, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    static func post(route: String, parameters: [String: AnyHashable]) {
        let r = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            r,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }

    static func put(route: String, parameters: [String: AnyHashable]) {
        let r = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            r,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseJSON { response in
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

    private static func createRoute(with customRoute: String) -> String {
        return "\(privacy.environment.route())/\(privacy.apiVersion.rawValue)/\(customRoute)"
    }

    private static func standardHeadersAppendingApiKey() -> HTTPHeaders {
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
