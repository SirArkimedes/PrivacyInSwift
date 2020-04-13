//
//  Alamofire+Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Alamofire
import SwiftyJSON
import SwiftyJSONModel

struct AlamofirePrivacy {

    /*
     {
       "data": [
         // API OBJECTS
       ],
       "page": Integer,
       "total_entries": Integer,
       "total_pages": Integer
     }
     */
    struct Page: JSONModelType {
        let data: JSON
        let page: Int
        let totalEntries: Int
        let totalPages: Int

        enum PropertyKey: String {
            case data
            case page
            case totalEntries = "total_entries"
            case totalPages = "total_pages"
        }

        init(object: JSONObject<PropertyKey>) throws {
            data = try object.value(for: .data)
            page = try object.value(for: .page)
            totalEntries = try object.value(for: .totalEntries)
            totalPages = try object.value(for: .totalPages)
        }

        var dictValue: [PropertyKey: JSONRepresentable?] {
            return [
                .data: data,
                .page: totalEntries,
                .totalPages: totalPages,
            ]
        }
    }

    // MARK: - Builders

    static func get(route: String, privacy: Privacy) {
        let r = createRoute(for: privacy, with: route)
        let headers = standardHeadersAppendingApiKey(for: privacy)
        AF.request(r, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let page = try! Page(json: json)
                print(page)
            case .failure(let error):
                print(error)
            }
        }
    }

    static func post(route: String, parameters: [String: AnyHashable], privacy: Privacy) {
        let r = createRoute(for: privacy, with: route)
        let headers = standardHeadersAppendingApiKey(for: privacy)
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

    static func put(route: String, parameters: [String: AnyHashable], privacy: Privacy) {
        let r = createRoute(for: privacy, with: route)
        let headers = standardHeadersAppendingApiKey(for: privacy)
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
