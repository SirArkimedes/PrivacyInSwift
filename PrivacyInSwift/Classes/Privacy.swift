//
//  Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation

public class Privacy {
    static public let instance = Privacy()

    private(set) var productionApiKey: String?
    private(set) var sandboxApiKey: String?

    public func start(productionApiKey: String, sandboxApiKey: String?) {
        self.productionApiKey = productionApiKey
        self.sandboxApiKey = sandboxApiKey
    }
}
