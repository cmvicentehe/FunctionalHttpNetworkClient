//
//  MessagesTableViewViewModel.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 21/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import UIKit

class MessagesTableViewViewModel: NSObject,
    TableViewViewModel,
    UITableViewDataSource,
    UITableViewDelegate {

    var items: [Message]?

    // MARK: TableViewViewModelInput methods
    func configure(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: TableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = Constants.Identifiers.Cells.messageCell
        guard let item = self.items?[indexPath.row],
         let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? MessageTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.bind(item: item)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
