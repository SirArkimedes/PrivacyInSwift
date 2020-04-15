//
//  Transaction.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/14/20.
//

import Foundation
import SwiftyJSON
import SwiftyJSONModel

// MARK: - Transaction

public struct Transaction {
    /// Globally unique identifier
    var token: String

    /// Authorization amount (in cents) of the transaction. This may change over time
    var amount: Int
    /// See `FullCard`
    var card: FullCard
    /// See `Event`
    var events: [Event]
    /// A list of objects that describe how this transaction was funded, with the amount represented in cents. A reference to the funding account for the card that made this transaction may appear here and the token will match the token for the funding account in the card field. If any promotional credit was used in paying for this transaction, its type will be PROMO.
    var funding: [JSON]
    /// See `Merchant`
    var merchant: Merchant
    /// APPROVED or decline reason.
    var result: String
    /// Amount (in cents) of the transaction that has been settled. This may change over time
    var settledAmount: Int
    /// See `Status`
    var status: Status
}

// MARK: - Transaction types

extension Transaction {
    enum Status: String, JSONString {
        case PENDING
        case VOIDED
        case SETTLING
        case SETTLED
        case BOUNCED
    }
}

// MARK: - JSONModelType

extension Transaction: JSONModelType {
    public enum PropertyKey: String {
        case token
        case amount
        case card
        case events
        case funding
        case merchant
        case result
        case settledAmount = "settled_amount"
        case status
    }

    public init(object: JSONObject<PropertyKey>) throws {
        token = try object.value(for: .token)
        amount = try object.value(for: .amount)
        card = try object.value(for: .card)
        events = try object.value(for: .events)
        funding = try object.value(for: .funding)
        merchant = try object.value(for: .merchant)
        result = try object.value(for: .result)
        settledAmount = try object.value(for: .settledAmount)
        status = try object.value(for: .status)
    }

    public var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .token: token,
            .amount: amount,
            .card: card,
            .events: events.jsonRepresantable,
            .funding: funding.jsonRepresantable,
            .merchant: merchant,
            .result: result,
            .settledAmount: settledAmount,
            .status: status,
        ]
    }
}
