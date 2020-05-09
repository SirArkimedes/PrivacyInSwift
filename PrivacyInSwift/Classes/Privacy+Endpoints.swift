//
//  Privacy+Endpoints.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Alamofire

extension PrivacyInSwift {

    /**
     The endpoint relating to `GET` on `/card`.

     Use `getCard(...)` to get information about an individual card.
     More details: https://developer.privacy.com/docs#endpoints-list-cards

     - Note: Does not currently support begin and end date filtering.

     - Parameter page: For pagination. The default is one.
     - Parameter pageSize: For pagination. The default value page size is 50 and the maximum is 1,000
     - Parameter completion: A `Result` closure. Returns `Card`s if the request succeeded. Returns
     an `Error` if the request fails or we cannot parse the data.
     */
    public func listCards(
        page: Int? = nil,
        pageSize: Int? = nil,
        completion: @escaping (Result<[Card], Error>) -> ()
    ) {
        // TODO: Add begin and end parameters.
        var parameters: [String: AnyHashable] = [:]
        if let page = page {
            parameters["page"] = page
        }
        if let pageSize = pageSize {
            parameters["page_size"] = pageSize
        }

        AlamofirePrivacy.pagedGet(
            route: "card",
            parameters: parameters
        ) { (result: Result<Page<Card>, Error>) in
            switch result {
            case .success(let page):
                completion(.success(page.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /**
    The endpoint relating to `GET` on `/card`.

    More details: https://developer.privacy.com/docs#endpoints-list-cards

    - Parameter token: The token for the card to retrieve.
    - Parameter completion: A `Result` closure. Returns a `Card` if the request succeeded. Returns
    an `Error` if the request fails or we cannot parse the data.
    */
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

    /**
     The endpoint relating to `GET` on `/fundingsource`.

     More details: https://developer.privacy.com/docs#endpoints-list-funding-accounts

     - Parameter completion: A `Result` closure. Returns `FundingAccounts`s if the request succeeds.
     Returns an `Error` if the request fails or we cannot parse the data.
     */
    public func listFundingAccounts(completion: @escaping (Result<[FundingAccount], Error>) -> ()) {
        listFundingAccounts(type: nil, completion: completion)
    }

    /**
    The endpoint relating to `GET` on `/fundingsource/bank`.

    More details: https://developer.privacy.com/docs#endpoints-list-funding-accounts

    - Parameter completion: A `Result` closure. Returns `FundingAccounts`s if the request succeeds.
    Returns an `Error` if the request fails or we cannot parse the data.
    */
    public func listFundingBanks(completion: @escaping (Result<[FundingAccount], Error>) -> ()) {
        listFundingAccounts(type: "bank", completion: completion)
    }

    /**
    The endpoint relating to `GET` on `/fundingsource/card`.

    More details: https://developer.privacy.com/docs#endpoints-list-funding-accounts

    - Parameter completion: A `Result` closure. Returns `FundingAccounts`s if the request succeeds.
    Returns an `Error` if the request fails or we cannot parse the data.
    */
    public func listFundingCards(completion: @escaping (Result<[FundingAccount], Error>) -> ()) {
        listFundingAccounts(type: "card", completion: completion)
    }

    /**
     The endpoint relating to `GET` on `/transaction`.

     More details: https://developer.privacy.com/#endpoints-list-transactions

     - Note: Does not currently support begin and end date filtering.

     - Parameter approvalStatus: Card filtering approval status. See `TransactionApprovalStatus`.
     - Parameter page: For pagination. The default is one.
     - Parameter pageSize: For pagination. The default value page size is 50 and the maximum is 1,000
     - Parameter completion: A `Result` closure. Returns `Transaction`s if the request succeeded. Returns
     an `Error` if the request fails or we cannot parse the data.
     */
    public func listTransactions(
        approvalStatus: TransactionApprovalStatus = .all,
        page: Int? = nil,
        pageSize: Int? = nil,
        completion: @escaping (Result<[Transaction], Error>) -> ()
    ) {
        // TODO: Add begin and end parameters.
        var parameters: [String: AnyHashable] = [:]
        if let page = page {
            parameters["page"] = page
        }
        if let pageSize = pageSize {
            parameters["page_size"] = pageSize
        }

        AlamofirePrivacy.pagedGet(
            route: "transaction/\(approvalStatus.rawValue)",
            parameters: parameters
        ) { (result: Result<Page<Transaction>, Error>) in
            switch result {
            case .success(let page):
                completion(.success(page.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /**
     The endpoint relating to `POST` on `/card`.

     More details: https://developer.privacy.com/docs#endpoints-create-card

     - Parameter type: See `Card.CardType`. Unlocked cards require additional privileges.
     - Parameter memo: Friendly name to identify the card.
     - Parameter fundingToken: The token for the desired `FundingAccount` to use when making
     transactions with this card.
     - Parameter spendLimit: The token for the desired `FundingAccount` to use when making
     transactions with this card.
     - Parameter spendLimitDuration: Amount (in cents) to limit approved authorizations. Transaction
     requests above the spend limit will be declined.
     - Parameter state: See `Card.State`. Precondition: Cannot pass `Card.State.CLOSED`.
     - Parameter completion: A `Result` closure. Returns a `Card` if the card creation succeded.
     Returns an `Error` if the request fails or we cannot parse the data.
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

    /**
     The endpoint relating to `PUT` on `/card`.

     Updates the specified properties of the card. Unsupplied properties will remain unchanged.
     More details: https://developer.privacy.com/docs#endpoints-update-card

     - Note: Setting a card to a CLOSED state is a final action that cannot be undone.

     - Parameter cardToken: The unique token of the card to update.
     - Parameter state: See `Card.State`.
     - Parameter fundingToken: The token for the desired `FundingAccount` to use when making
     transactions with this card.
     - Parameter memo: Friendly name to identify the card.
     - Parameter spendLimit: The token for the desired `FundingAccount` to use when making
     transactions with this card.
     - Parameter spendLimitDuration: Amount (in cents) to limit approved authorizations. Transaction
     requests above the spend limit will be declined.
     - Parameter completion: A `Result` closure. Returns a `Card` if the card update succeded.
     Returns an `Error` if the request fails or we cannot parse the data.
     */
    public func updateCard(
        cardToken: String,
        state: Card.State? = nil,
        fundingToken: String? = nil,
        memo: String? = nil,
        spendLimit: Int? = nil,
        spendLimitDuration: Card.SpendLimitDuration? = nil,
        completion: @escaping (Result<Card, Error>) -> ()
    ) {
        var parameters: [String: AnyHashable] = [
            "card_token": cardToken,
        ]
        if let state = state {
            parameters[Card.PropertyKey.state.rawValue] = state.rawValue
        }
        if let fundingToken = fundingToken {
            parameters["funding_token"] = fundingToken
        }
        if let memo = memo {
            parameters[Card.PropertyKey.memo.rawValue] = memo
        }
        if let spendLimit = spendLimit {
            parameters[Card.PropertyKey.spendLimit.rawValue] = spendLimit
        }
        if let spendLimitDuration = spendLimitDuration {
            parameters[Card.PropertyKey.spendLimitDuration.rawValue] = spendLimitDuration
        }

        AlamofirePrivacy.put(
            route: "card",
            parameters: parameters
        ) { (result: Result<Card, Error>) in
            completion(result)
        }
    }

    /**
     The endpoint relating to `POST` on `/fundingsource/bank`.

     Adds a bank account as a funding source using routing and account numbers. Returns a
     `FundingAccount` object containing the bank information.
     More details: https://developer.privacy.com/docs#endpoints-add-bank-account

     - Parameter routingNumber: The routing number of the bank account.
     - Parameter accountNumber: The account number of the bank account.
     - Parameter accountName: The name associated with the bank account. This property is only for
     identification purposes, and has no bearing on the external properties of the bank.
     - Parameter completion: A `Result` closure. Returns a `FundingAccount` if the bank added
     successfully. Returns an `Error` if the request fails or we cannot parse the data.
     */
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
            parameters[FundingAccount.PropertyKey.accountName.rawValue] = accountName
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
