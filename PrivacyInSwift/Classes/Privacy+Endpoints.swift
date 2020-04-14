//
//  Privacy+Endpoints.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import Alamofire

extension PrivacyInSwift {

    public func listCards(completion: @escaping (Result<[FullCard], Error>) -> ()) {
        AlamofirePrivacy.get(route: "card") { (result: Result<Page<FullCard>, Error>) in
            switch result {
            case .success(let page):
                completion(.success(page.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCard(
        for token: String,
        completion: @escaping (Result<FullCard, Error>) -> ()
    ) {
        AlamofirePrivacy.get(
            route: "card",
            parameters: ["card_token": token]
        ) { (result: Result<Page<FullCard>, Error>) in
            switch result {
            case .success(let page):
                if page.data.count == 1 {
                    completion(.success(page.data[0]))
                } else {
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func createCard(completion: @escaping (Result<FullCard, Error>) -> ()) {
        AlamofirePrivacy.post(
            route: "card",
            parameters: ["type": "SINGLE_USE"]
        ) { (result: Result<FullCard, Error>) in
            completion(result)
        }
    }

    public func updateCard(completion: @escaping (Result<FullCard, Error>) -> ()) {
        AlamofirePrivacy.put(route: "card", parameters: [
            "card_token": "52a89ed9-764c-4744-a20a-19b274c0e5dc",
            "memo": "Testing"
        ]) { (result: Result<FullCard, Error>) in
            completion(result)
        }
    }

    public func addBank(
        routingNumber: String,
        accountNumber: String,
        accountName: String? = nil,
        completion: @escaping (Result<FundingAccount, Error>) -> ()
    ) {
        var parameters: [String: AnyHashable] = [
            "routing_number": routingNumber,
            "account_number": accountNumber,
        ]
        if let accountName = accountName {
            parameters["account_name"] = accountName
        }

        AlamofirePrivacy.post(
            route: "fundingsource/bank",
            parameters: parameters
        ) { (result: Result<DataWrapped<FundingAccount>, Error>) in
            switch result {
            case .success(let dataWrapped):
                completion(.success(dataWrapped.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
