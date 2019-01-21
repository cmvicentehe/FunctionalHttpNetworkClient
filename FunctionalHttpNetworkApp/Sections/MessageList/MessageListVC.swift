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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(with: self.messageList)
    }
}

extension MessageListVC: MessageListUI {
    func showMessages() {
        DispatchQueue.main.async {
             self.messageList.reloadData()
        }
    }
    
    func show<ServiceError>(error: ServiceError) {
        #warning("TODO: Implement this method")
    }
}
