//
//  Page.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/12/20.
//

import Foundation
import SwiftyJSON
import SwiftyJSONModel

struct Page: JSONModelType {
    let data: JSON
    let page: Int
    let totalEntries: Int
    let totalPages: Int

    enum PropertyKey: String {
        case data
        case page
        case totalEntries = "total_entries"
        case totalPages = "total_pages"
    }

    init(object: JSONObject<PropertyKey>) throws {
        data = try object.value(for: .data)
        page = try object.value(for: .page)
        totalEntries = try object.value(for: .totalEntries)
        totalPages = try object.value(for: .totalPages)
    }

    var dictValue: [PropertyKey: JSONRepresentable?] {
        return [
            .data: data,
            .page: totalEntries,
            .totalPages: totalPages,
        ]
    }
}
