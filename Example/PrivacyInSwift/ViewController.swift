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
        Privacy.listCards()
//        Privacy.getCard(for: "") { card, error in
//            if let card = card {
//                print(card)
//            }
//        }
        
//        Privacy.createCard()
//        Privacy.updateCard()
    }
}

