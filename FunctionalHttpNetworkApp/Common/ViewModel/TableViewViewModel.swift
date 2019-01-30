//
//  TableViewViewModel.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 16/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCell {
    associatedtype Item

    func bind(item: Item)
}

protocol TableViewViewModel {
    associatedtype Item
    var tableView: UITableView? { get set }
    var items: [Item]? { get set }
    func configure(tableView: UITableView)
}
