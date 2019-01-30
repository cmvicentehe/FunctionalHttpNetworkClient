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

    var tableView: UITableView?
    var items: [Message]?
    weak var presenter: MessageListPresenterInput?
    var indexPathToDelete: IndexPath?

    // MARK: TableViewViewModelInput methods
    func configure(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
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

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let message = self.items?[indexPath.row]
            self.indexPathToDelete = indexPath
            guard let idNotNil = message?.messageId else {
                    print("Invalid message id")
                    return
            }
            self.presenter?.userDidTapMessage(with: idNotNil)
        }
    }

    func deleteRowAtIndexPath() {
        guard let indexPathNotNil = self.indexPathToDelete else {
            print("Index path to be deleted is nil")
            return
        }
        DispatchQueue.main.async { [weak self] in
            let row = indexPathNotNil.row
            self?.items?.remove(at: row)
            self?.tableView?.deleteRows(at: [indexPathNotNil],
                                       with: .fade)
            self?.indexPathToDelete = nil
        }
    }
}
