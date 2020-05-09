//
//  Event.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/14/20.
//

import SwiftyJSONModel

// MARK: - Merchant

public struct Event {
    /// Globally unique identifier
    var token: String

    /// Amount of the transaction event
    var amount: Int
    /// Date and time this event entered the system
    var created: String
    /// APPROVED or decline reason. See below for full enumeration
    var result: String
    /// See `EventType`
    var type: EventType
}

// MARK: - Event types

extension Event {
    enum EventType: String, JSONString {
        case AUTHORIZATION
        case AUTHORIZATION_ADVICE
        case CLEARING
        case VOID
        case RETURN
    }
}

// MARK: - JSONModelType

extension Event: JSONModelType {
    public enum PropertyKey: String {
        case token
        case amount
        case created
        case result
        case type
    }

    public init(object: JSONObject<PropertyKey>) throws {
        token = try object.value(for: .token)
        amount = try object.value(for: .amount)
        created = try object.value(for: .created)
        result = try object.value(for: .result)
        type = try object.value(for: .type)
    }

    public var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .token: token,
            .amount: amount,
            .created: created,
            .result: result,
            .type: type,
        ]
    }
}
