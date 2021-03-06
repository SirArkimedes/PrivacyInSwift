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

    private static let privacy = PrivacyInSwift.instance

    // MARK: - Builders

    static func pagedGet<T: JSONModelType>(
        route: String,
        parameters: [String: AnyHashable]? = nil,
        completion: @escaping (Result<Page<T>, Error>) -> ()
    ) {
        let customRoute = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            customRoute,
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let page = try? Page<T>(json: json) {
                    completion(.success(page))
                } else {
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func get<T: JSONModelType>(
        route: String,
        parameters: [String: AnyHashable]? = nil,
        completion: @escaping (Result<[T], Error>) -> ()
    ) {
        let customRoute = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            customRoute,
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var objects = [T]()
                for (_, value) in json {
                    if let object = try? T(json: value) {
                        objects.append(object)
                    }
                }
                completion(.success(objects))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func post<T: JSONModelType>(
        route: String,
        parameters: [String: AnyHashable],
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        let customRoute = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            customRoute,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let object = try? T(json: json) {
                    completion(.success(object))
                } else {
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func put<T: JSONModelType>(
        route: String,
        parameters: [String: AnyHashable],
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        let customRoute = createRoute(with: route)
        let headers = standardHeadersAppendingApiKey()
        AF.request(
            customRoute,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let object = try? T(json: json) {
                    completion(.success(object))
                } else {
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                completion(.failure(error))
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
