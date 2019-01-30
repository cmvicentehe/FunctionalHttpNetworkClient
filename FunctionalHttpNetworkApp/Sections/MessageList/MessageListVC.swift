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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    func showActicityIndicator() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }

    func showMessages() {
        DispatchQueue.main.async { [weak self] in
            self?.messageList.reloadData()
        }
    }
}
