//
//  FullCard.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import SwiftyJSON

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

// MARK: - Codable

extension FullCard: Codable {
    enum CodingKeys: String, CodingKey {
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
        case cardType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)

        created = try container.decode(String.self, forKey: .created)
        cvv = try container.decode(String.self, forKey: .cvv)
        funding = try container.decode(FundingAccount.self, forKey: .funding)
        expMonth = try container.decode(String.self, forKey: .expMonth)
        expYear = try container.decode(String.self, forKey: .expYear)
        hostname = try container.decode(String.self, forKey: .hostname)
        lastFour = try container.decode(String.self, forKey: .lastFour)
        memo = try container.decode(String.self, forKey: .memo)
        pan = try container.decode(String.self, forKey: .pan)
        spendLimit = try container.decode(Int.self, forKey: .spendLimit)
        spendLimitDuration = try container.decode(SpendLimitDuration.self, forKey: .spendLimitDuration)
        state = try container.decode(State.self, forKey: .state)
        type = try container.decode(CardType.self, forKey: .cardType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(token, forKey: .token)

        try container.encode(created, forKey: .created)
        try container.encode(cvv, forKey: .cvv)
        try container.encode(funding, forKey: .funding)
        try container.encode(expMonth, forKey: .expMonth)
        try container.encode(expYear, forKey: .expYear)
        try container.encode(hostname, forKey: .hostname)
        try container.encode(lastFour, forKey: .lastFour)
        try container.encode(memo, forKey: .memo)
        try container.encode(pan, forKey: .pan)
        try container.encode(spendLimit, forKey: .spendLimit)
        try container.encode(spendLimitDuration , forKey: .spendLimitDuration)
        try container.encode(state, forKey: .state)
        try container.encode(type, forKey: .cardType)
    }
}

// MARK: - Card types

extension FullCard {
    public enum SpendLimitDuration: String, Codable {
        case TRANSACTION
        case MONTHLY
        case ANNUALLY
        case FOREVER
    }

    public enum State: String, Codable {
        case OPEN
        case PAUSED
        case CLOSED
    }

    public enum CardType: String, Codable {
        case SINGLE_USE
        case MERCHANT_LOCKED
        case UNLOCKED
    }
}
