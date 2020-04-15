//
//  FundingAccount.swift
//  Alamofire
//
//  Created by Andrew Robinson on 4/12/20.
//

import Foundation
import SwiftyJSONModel

// MARK: - FundingAccount

public struct FundingAccount {
    /// A globally unique identifier for this FundingAccount
    var token: String

    /// Account name identifying the funding source. This may be null
    var accountName: String?
    /// An ISO 8601 string representing when this funding source was added to the Privacy account. This may be null
    var created: String?
    /// The last 4 digits of the account (e.g. bank account, debit card) associated with this `FundingAccount`. This may be null
    var lastFour: String?
    /// The nickname given to the `FundingAccount` or null if it has no nickname
    var nickname: String?
    /// See `State`
    var state: State
    /// See `FundingType`
    var type: FundingType
}

// MARK: - FundingAccount types

extension FundingAccount {
    enum State: String, JSONString {
        case ENABLED
        case PENDING
    }

    enum FundingType: String, JSONString {
        case DEPOSITORY_CHECKING
        case DEPOSITORY_SAVINGS
        case CARD_DEBIT
    }
}

// MARK: - JSONModelType

extension FundingAccount: JSONModelType {
    public enum PropertyKey: String {
        case token
        case accountName = "account_name"
        case created
        case lastFour = "last_four"
        case nickname
        case state
        case type
    }

    public init(object: JSONObject<PropertyKey>) throws {
        token = try object.value(for: .token)
        
        accountName = try object.value(for: .accountName)
        created = try object.value(for: .created)
        lastFour = try object.value(for: .lastFour)
        nickname = try object.value(for: .nickname)
        state = try object.value(for: .state)
        type = try object.value(for: .type)
    }

    public var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .token: token,
            .accountName: accountName,
            .created: created,
            .lastFour: lastFour,
            .nickname: nickname,
            .state: state,
            .type: type,
        ]
    }
}
