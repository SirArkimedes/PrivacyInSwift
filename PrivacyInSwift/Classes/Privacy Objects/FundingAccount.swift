//
//  FundingAccount.swift
//  Alamofire
//
//  Created by Andrew Robinson on 4/12/20.
//

import Foundation

public struct FundingAccount: Codable {
    /// A globally unique identifier for this FundingAccount
    var token: String

    var accountName: String
    var created: String
    var lastFour: String
    var nickname: String
    /// See `State`
    var state: State
    /// See `FundingType`
    var type: FundingType
}

extension FundingAccount {
    enum State: String, Codable {
        case ENABLED
        case PENDING
    }

    enum FundingType: String, Codable {
        case DEPOSITORY_CHECKING
        case DEPOSITORY_SAVINGS
        case CARD_DEBIT
    }
}
