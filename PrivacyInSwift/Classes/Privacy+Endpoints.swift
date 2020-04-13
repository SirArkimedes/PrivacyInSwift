//
//  Privacy+Endpoints.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import Alamofire

extension PrivacyInSwift {
    public typealias GetCardCompletion = (FullCard?, Error?) -> ()

    public func listCards() {
        AlamofirePrivacy.get(route: "card") { (page: Page<FullCard>?, error: Error?) in
            if let error = error {
                print(error)
            } else if let page = page {
                print(page.data)
            }
        }
    }

    public func getCard(for token: String, completion: @escaping GetCardCompletion) {
        AlamofirePrivacy.get(route: "card", parameters: ["card_token": token]) { (page: Page<FullCard>?, error: Error?) in
            if let error = error {
                print(error)
                completion(nil, error)
            } else if let page = page, page.data.count == 1 {
                completion(page.data[0], nil)
            }
        }
    }

    public func createCard() {
        AlamofirePrivacy.post(route: "card", parameters: ["type": "SINGLE_USE"])
    }

    public func updateCard() {
        AlamofirePrivacy.put(route: "card", parameters: [
            "card_token": "52a89ed9-764c-4744-a20a-19b274c0e5dc",
            "memo": "Testing"
        ])
    }
}
