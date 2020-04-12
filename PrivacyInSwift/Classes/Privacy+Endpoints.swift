//
//  Privacy+Endpoints.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 4/11/20.
//

import Foundation
import Alamofire

extension Privacy {
    /*
     Returns:
     page_size    For pagination. The default value page size is 50 and the maximum is 1,000
     begin        Date string in the form YYYY-MM-DD, only cards created after the specified date will be included
     end          Date string in the form YYYY-MM-DD, only cards created before the specified date will be included
     card_token   Returns a specific card
     */
    public func listCards() {
        AlamofirePrivacy.get(route: "card", privacy: Privacy.instance)
    }

    public func createCard() {
        AlamofirePrivacy.post(route: "card", parameters: ["type": "SINGLE_USE"], privacy: Privacy.instance)
    }

    public func updateCard() {
        AlamofirePrivacy.put(route: "card", parameters: [
            "card_token": "52a89ed9-764c-4744-a20a-19b274c0e5dc",
            "memo": "Testing"
        ], privacy: Privacy.instance)
    }
}
