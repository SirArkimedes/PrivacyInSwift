//
//  Privacy.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

/**
 The main interface between the PrivacyInSwift and Privacy.com API.
 */
public let Privacy = PrivacyInSwift.instance

/**
 Do not reference this class directly! Use `Privacy` instead.
 */
public class PrivacyInSwift {
    static let instance = PrivacyInSwift(productionApiKey: "", sandboxApiKey: "")

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

    /**
     The main interface to insert your Production API key.

     Provide your Sandbox API key and set the `environment` variable to `.sandbox` if you want to
     use the `sandbox.privacy.com` endpoint. Generally used for testing.

     - Note: Find all keys at `https://privacy.com/account`.
     */
    public func start(productionApiKey: String, sandboxApiKey: String? = "") {
        self.productionApiKey = productionApiKey
        self.sandboxApiKey = sandboxApiKey ?? ""
    }
}
