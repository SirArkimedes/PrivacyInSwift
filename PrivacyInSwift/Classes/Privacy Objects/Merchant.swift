//
//  Merchant.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/14/20.
//

import SwiftyJSONModel

// MARK: - Merchant

public struct Merchant {
    /// Unique identifier to identify the payment card acceptor
    var acceptorId: String
    /// City of card acceptor
    var city: String
    /// Country of card acceptor
    var country: String
    /// Short description of card acceptor
    var descriptor: String
    /// Merchant category code
    var mcc: String
    /// Geographic state of card acceptor
    var state: String
}

// MARK: - JSONModelType

extension Merchant: JSONModelType {
    public enum PropertyKey: String {
        case acceptorId = "acceptor_id"
        case city
        case country
        case descriptor
        case mcc
        case state
    }

    public init(object: JSONObject<PropertyKey>) throws {
        acceptorId = try object.value(for: .acceptorId)
        city = try object.value(for: .city)
        country = try object.value(for: .country)
        descriptor = try object.value(for: .descriptor)
        mcc = try object.value(for: .mcc)
        state = try object.value(for: .state)
    }

    public var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .acceptorId: acceptorId,
            .city: city,
            .country: country,
            .descriptor: descriptor,
            .mcc: mcc,
            .state: state,
        ]
    }
}
