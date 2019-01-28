//
//  MessageListVC.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 07/10/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import UIKit

class MessageListVC: UIViewController {
    @IBOutlet weak var messageList: UITableView!

    var presenter: MessageListPresenterInput?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem.title = NSLocalizedString("message_list", comment: "")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear(with: self.messageList)
    }
}

extension MessageListVC: MessageListUI {
    func showMessages() {
        DispatchQueue.main.async { [weak self] in
            self?.messageList.reloadData()
        }
    }
    
    func show<ServiceError>(error: ServiceError) {
        #warning("TODO: Implement this method")
    }

    #warning("TODO: Show an Activity indicator")
    #warning("TODO: Implement message deletion")
}
