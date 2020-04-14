//
//  DataWrapped.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/13/20.
//

import Foundation
import SwiftyJSONModel

// MARK: - DataWrapped

/**
 Used for particular endpoints that have a `"data" {}` value that wraps the actual data.

 A particular example of this, at the time of writing, is the "Add Bank" endpoint.

 ```
 {
   "data": {
     "account_name": "This is a test account!",
     "created": "2020-04-14 02:32:26",
     "last_four": "9012",
     "nickname": "",
     "state": "ENABLED",
     "token": "422f1590-91d8-42a4-bc3a-0dd5ffedf020",
     "type": "DEPOSITORY_CHECKING"
   }
 }
 ```
 This example has an outside value that is just "data" and then a `FundingAccount` sits inside
 a nested json dictionary.
*/
struct DataWrapped<T: JSONModelType>: JSONModelType {
    var data: T

    public enum PropertyKey: String {
        case data
    }

    public init(object: JSONObject<PropertyKey>) throws {
        data = try object.value(for: .data)
    }

    public var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .data: data,
        ]
    }
}
