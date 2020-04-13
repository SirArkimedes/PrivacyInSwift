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
        Privacy.listCards { result in
            switch result {
            case .success(let cards):
                print(cards)
            case .failure(let error):
                print(error)
            }
        }
//        Privacy.getCard(for: "") { result in
//            switch result {
//            case .success(let card):
//                print(card)
//            case .failure(let error):
//                print(error)
//            }
//        }

//        Privacy.createCard()
//        Privacy.updateCard()
    }
}

