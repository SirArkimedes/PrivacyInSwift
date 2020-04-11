//
//  Card.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation

public struct FundingAccount {
}

/// https://developer.privacy.com/docs#schema-card
public struct Card {
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

extension Card {
    public enum SpendLimitDuration: String {
        case TRANSACTION
        case MONTHLY
        case ANNUALLY
        case FOREVER
    }

    public enum State: String {
        case OPEN
        case PAUSED
        case CLOSED
    }

    public enum CardType: String {
        case SINGLE_USE
        case MERCHANT_LOCKED
        case UNLOCKED
    }
}
