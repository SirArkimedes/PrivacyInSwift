//
//  Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation

public let Privacy = PrivacyInSwift.instance

public class PrivacyInSwift {
    static public let instance = PrivacyInSwift(productionApiKey: "", sandboxApiKey: "")

    /// Specifies which privacy.com environment to connect to. Defaults to `.production`.
    public var environment: Environment = .production

    /// Specifies which version of the privacy.com API the request will hit.
    public var apiVersion: ApiVersion = .v1

    private(set) var productionApiKey: String
    private(set) var sandboxApiKey: String

    private init(productionApiKey: String, sandboxApiKey: String) {
        self.productionApiKey = productionApiKey
        self.sandboxApiKey = sandboxApiKey
    }

    public func start(productionApiKey: String, sandboxApiKey: String) {
        self.productionApiKey = productionApiKey
        self.sandboxApiKey = sandboxApiKey
    }
}
