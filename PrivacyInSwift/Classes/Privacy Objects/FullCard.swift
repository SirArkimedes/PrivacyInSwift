//
//  FullCard.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import SwiftyJSONModel

// MARK: - FullCard

/// https://developer.privacy.com/docs#schema-card
public struct FullCard {
    /// Globally unique identifier
    var token: String

    /// An ISO 8601 timestamp for when the card was created
    var created: String
    /// Three digit cvv printed on the back of the card
    var cvv: String
    /// See `FundingAccount`
    var funding: FundingAccount
    /// Two digit (MM) expiry month
    var expMonth: String
    /// Four digit (YYYY) expiry year
    var expYear: String
    /// Hostname of card’s locked merchant (will be empty if not applicable)
    var hostname: String?
    /// Last four digits of the card number
    var lastFour: String
    /// Friendly name to identify the card
    var memo: String
    /// Sixteen digit card number
    var pan: String
    /// Amount (in cents) to limit approved authorizations. Transaction requests above the spend limit will be declined
    var spendLimit: Int
    /// See `SpendLimitDuration`
    var spendLimitDuration: SpendLimitDuration
    /// See `State`
    var state: State
    /// See `CardType`
    var type: CardType
}

// MARK: - Card types

extension FullCard {
    public enum SpendLimitDuration: String, JSONString {
        case TRANSACTION
        case MONTHLY
        case ANNUALLY
        case FOREVER
    }

    public enum State: String, JSONString {
        case OPEN
        case PAUSED
        case CLOSED
    }

    public enum CardType: String, JSONString {
        case SINGLE_USE
        case MERCHANT_LOCKED
        case UNLOCKED
    }
}

// MARK: - JSONModelType

extension FullCard: JSONModelType {
    public enum PropertyKey: String {
        case token
        case created
        case cvv
        case funding
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case hostname
        case lastFour = "last_four"
        case memo
        case pan
        case spendLimit = "spend_limit"
        case spendLimitDuration = "spend_limit_duration"
        case state
        case cardType = "type"
    }

    public init(object: JSONObject<PropertyKey>) throws {
        token = try object.value(for: .token)

        created = try object.value(for: .created)
        cvv = try object.value(for: .cvv)
        funding = try object.value(for: .funding)
        expMonth = try object.value(for: .expMonth)
        expYear = try object.value(for: .expYear)
        hostname = try object.value(for: .hostname)
        lastFour = try object.value(for: .lastFour)
        memo = try object.value(for: .memo)
        pan = try object.value(for: .pan)
        spendLimit = try object.value(for: .spendLimit)
        spendLimitDuration = try object.value(for: .spendLimitDuration)
        state = try object.value(for: .state)
        type = try object.value(for: .cardType)
    }

    public var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .token: token,
            .created: created,
            .cvv: cvv,
            .funding: funding,
            .expMonth: expMonth,
            .expYear: expYear,
            .hostname: hostname,
            .lastFour: lastFour,
            .memo: memo,
            .pan: pan,
            .spendLimit: spendLimit,
            .spendLimitDuration: spendLimitDuration,
            .state: state,
            .cardType: type,
        ]
    }
}
