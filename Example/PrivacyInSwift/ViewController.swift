//
//  ViewController.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 04/11/2020.
//  Copyright (c) 2020 Andrew Robinson. All rights reserved.
//

import UIKit
import PrivacyInSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Privacy.listCards { result in self.standardHandler(result: result) }
//        Privacy.getCard(for: "") { result in self.standardHandler(result: result) }

//        Privacy.listFundingAccounts { result in self.standardHandler(result: result) }

//        Privacy.createCard(type: .UNLOCKED) { result in self.standardHandler(result: result) }
//        Privacy.updateCard(cardToken: "c7e4a88f-deb6-4a4d-9726-e028d2f2a21e", state: .PAUSED) { result in
//            self.standardHandler(result: result)
//        }

//        Privacy.addBank(routingNumber: "123456789", accountNumber: "123456789012"){ result in
//            self.standardHandler(result: result)
//        }
    }

    private func standardHandler<T>(result: Result<T, Error>) {
        switch result {
        case .success(let value):
            print(value)
        case .failure(let error):
            print(error)
        }
    }
}

