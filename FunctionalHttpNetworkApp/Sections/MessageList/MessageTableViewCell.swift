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

    private func formate(date: String,
                         using resultDateFormatter: DateFormatter) -> String {
        let currentDateFormatter = DateFormatter()
        #warning("TODO: Modify this format from server")
        currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateNotNil = currentDateFormatter.date(from: date) else {
            print("Invalid data conversion")
            return ""
        }

        return resultDateFormatter.string(from: dateNotNil)
    }
}

extension MessageTableViewCell: TableViewCell {
    func bind(item: Message) {
        let resultDateFormatter = DateFormatter()
        resultDateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        self.username.text = item.username
        self.content.text = item.content
        #warning("TODO: Create static date tools that manages dates")
        self.date.text = self.formate(date: item.date,
                                      using: resultDateFormatter)
    }
}
