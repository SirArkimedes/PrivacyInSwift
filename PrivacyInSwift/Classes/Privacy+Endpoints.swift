//
//  Privacy+Endpoints.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import Alamofire

extension PrivacyInSwift {

    public func listCards(completion: @escaping (Result<[Card], Error>) -> ()) {
        AlamofirePrivacy.pagedGet(route: "card") { (result: Result<Page<Card>, Error>) in
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
        completion: @escaping (Result<Card, Error>) -> ()
    ) {
        AlamofirePrivacy.pagedGet(
            route: "card",
            parameters: ["card_token": token]
        ) { (result: Result<Page<Card>, Error>) in
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

    private func listFundingAccounts(
        type: String? = nil,
        completion: @escaping (Result<[FundingAccount], Error>) -> ()
    ) {
        let route: String
        if let type = type {
            route = "fundingsource/\(type)"
        } else {
            route = "fundingsource"
        }
        AlamofirePrivacy.get(route: route) { (result: Result<[FundingAccount], Error>) in
            completion(result)
        }
    }

    public func listFundingAccounts(completion: @escaping (Result<[FundingAccount], Error>) -> ()) {
        listFundingAccounts(type: nil, completion: completion)
    }

    public func listFundingBanks(completion: @escaping (Result<[FundingAccount], Error>) -> ()) {
        listFundingAccounts(type: "bank", completion: completion)
    }

    public func listFundingCards(completion: @escaping (Result<[FundingAccount], Error>) -> ()) {
        listFundingAccounts(type: "card", completion: completion)
    }

    /**
     The enpoint relating to `POST` `/card`.

     More details: https://developer.privacy.com/docs#endpoints-create-card

     - Parameter type:
        See `Card.CardType`. Unlocked cards require additional privileges.
     - Parameter memo:
        Friendly name to identify the card.
     - Parameter fundingToken:
        The token for the desired `FundingAccount` to use when making transactions with this card.
     - Parameter spendLimit:
        The token for the desired `FundingAccount` to use when making transactions with this card.
     - Parameter spendLimitDuration:
        Amount (in cents) to limit approved authorizations. Transaction requests above the spend
        limit will be declined.
     - Parameter state:
        See `Card.State`.
     - Parameter completion:
        A `Result` closure. Returns a `Card` if the card creation succeded or an `Error` if the
        request fails or we cannot parse the data.
     */
    public func createCard(
        type: Card.CardType,
        memo: String? = nil,
        fundingToken: String? = nil,
        spendLimit: Int? = nil,
        spendLimitDuration: Card.SpendLimitDuration? = nil,
        state: Card.State = .OPEN,
        completion: @escaping (Result<Card, Error>) -> ()
    ) {
        precondition(state != .CLOSED, "Cannot create a Card that is closed!")

        var parameters: [String: AnyHashable] = [
            Card.PropertyKey.cardType.rawValue: type.rawValue,
            Card.PropertyKey.state.rawValue: state.rawValue,
        ]
        if let memo = memo {
            parameters[Card.PropertyKey.memo.rawValue] = memo
        }
        if let fundingToken = fundingToken {
            parameters["funding_token"] = fundingToken
        }
        if let spendLimit = spendLimit {
            parameters[Card.PropertyKey.spendLimit.rawValue] = spendLimit
        }
        if let spendLimitDuration = spendLimitDuration {
            parameters[Card.PropertyKey.spendLimitDuration.rawValue] = spendLimitDuration
        }

        AlamofirePrivacy.post(
            route: "card",
            parameters: parameters
        ) { (result: Result<Card, Error>) in
            completion(result)
        }
    }

    public func updateCard(completion: @escaping (Result<Card, Error>) -> ()) {
        AlamofirePrivacy.put(route: "card", parameters: [
            "card_token": "52a89ed9-764c-4744-a20a-19b274c0e5dc",
            "memo": "Testing"
        ]) { (result: Result<Card, Error>) in
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
