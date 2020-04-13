//
//  Privacy+Endpoints.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import Alamofire

extension Privacy {
    public func listCards() {
        AlamofirePrivacy.get(route: "card") { page, error in
            if let error = error {
                print(error)
            } else if let page = page {
                var cards = [FullCard]()
                for json in page.data.array ?? [] {
                    cards.append(try! FullCard(json: json))
                }
                print(cards)
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
