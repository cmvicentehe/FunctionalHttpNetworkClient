//
//  TableViewViewModel.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 16/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import UIKit

class TableViewViewModel<Item>: NSObject,
    UITableViewDataSource,
    UITableViewDelegate {
    var items: [Item]?

    // MARK: TableViewViewModelInput methods
    func configure(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func update(items: [Item]) {
        self.items = items
    }

    // MARK: TableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #warning("Create a generic cell using bind method by passing generic item and each cell has a protocol with the specialization of this bind method")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        if let message = self.items?[indexPath.row] as? Message {
            cell.textLabel?.text = message.content
        }
        return cell
    }
}
