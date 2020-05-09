//
//  ViewController.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 04/11/2020.
//  Copyright (c) 2020 Andrew Robinson. All rights reserved.
//

import UIKit
import PrivacyInSwift
import SwiftyJSONModel

///
/// Update the Sandbox token in `AppDelegate.swift` if you want to try it for yourself!
///

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logTextView: UITextView!

    private var data = [QueryType]()

    override func viewDidLoad() {
        super.viewDidLoad()

        data = [
            .listCards,
            .listFundingAccounts,
            .createCard,
            .addBank,
            .listTransactions,
        ]

        logTextView.text = "Tap an endpoint above!"

        setColors()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BaseCell")
    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setColors()
    }

    private func setColors() {
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                view.backgroundColor = .black
                logTextView.backgroundColor = .white
                logTextView.textColor = .black
            default:
                view.backgroundColor = .white
                logTextView.backgroundColor = .black
                logTextView.textColor = .white
            }
        }
    }
}

// MARK: - Helper types

enum QueryType {
    case listCards
    case listFundingAccounts
    case createCard
    case addBank
    case listTransactions

    func title() -> String {
        switch self {
        case .listCards: return "List Cards"
        case .listFundingAccounts: return "List Funding Accounts"
        case .createCard: return "Create Card"
        case .addBank: return "Add Bank"
        case .listTransactions: return "List Transactions"
        }
    }

    func runQuery(completion: @escaping (String) -> ()) {
        switch self {
        case .listCards:
            Privacy.listCards { result in
                completion(self.arrayHandler(result: result))
            }
        case .listFundingAccounts:
            Privacy.listFundingAccounts { result in
                completion(self.arrayHandler(result: result))
            }
        case .createCard:
            Privacy.createCard(type: .UNLOCKED) { result in
                completion(self.modelHandler(result: result))
            }
        case .addBank:
            Privacy.addBank(routingNumber: "123456789", accountNumber: "123456789012") { result in
                completion(self.modelHandler(result: result))
            }
        case .listTransactions:
            Privacy.listTransactions() { result in
                completion(self.arrayHandler(result: result))
            }
        }
    }

    private func modelHandler<T: JSONModelType>(result: Result<T, Error>) -> String {
        switch result {
        case .success(let value):
            print(value)
            return value.dictValue.description
        case .failure(let error):
            return error.localizedDescription
        }
    }

    private func arrayHandler<T: JSONModelType>(result: Result<[T], Error>) -> String {
        switch result {
        case .success(let value):
            print(value)

            var string = ""
            value.forEach({ string += "\($0.dictValue.description)\n\n" })
            return string.isEmpty ? "Empty!" : string
        case .failure(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath)
        let cellData = data[indexPath.row]
        cell.textLabel?.text = cellData.title()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = data[indexPath.row]

        cellData.runQuery { endResult in
            self.logTextView.text = endResult
        }
    }
}
