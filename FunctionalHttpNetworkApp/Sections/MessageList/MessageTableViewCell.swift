//
//  MessageTableViewCell.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 21/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import UIKit
import Foundation

class MessageTableViewCell: UITableViewCell {
    typealias Item = Message

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.username.text = nil
        self.content.text = nil
        self.date.text = nil
    }
}

extension MessageTableViewCell: TableViewCell {
    func bind(item: Message) {

        self.username.text = item.username
        self.content.text = item.content

        guard let serverDate = DateTools.convertDateStringToServerDateFormat(item.date) else {
            print("Invalid date format")
            self.date.text = ""
            return
        }
        self.date.text = DateTools.convertDateToAppDateFormat(serverDate)
    }
}
