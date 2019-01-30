//
//  NewMessageVC.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 07/10/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import UIKit

class NewMessageVC: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextield: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: NewMessagePresenterInput?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem.title = NSLocalizedString("Send message", comment: "")
    }

    override func loadView() {
        super.loadView()
        self.initializeViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }

    private func initializeViews() {
        let titleColor = self.sendButton.titleColor(for: .normal)?.cgColor
        self.usernameLabel.text = nil
        self.contentLabel.text = nil
        self.sendButton.setTitle(nil, for: .normal)
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.borderColor = titleColor
        self.sendButton.layer.cornerRadius = 6
        self.clearTextfields()
    }

    @IBAction func sendButtonTapped(_ sender: Any) {
        let username = self.usernameTextield.text
        let content = self.contentTextView.text
        self.presenter?.userDidTapSendButton(with: username,
                                             content: content)
    }
}

extension NewMessageVC: NewMessageUI {
   func displayUsernameLabel(_ usernameLabel: String) {
         self.usernameLabel.text = usernameLabel
    }

    func displayContentLabel(_ contentLabel: String) {
        self.contentLabel.text = contentLabel
    }

    func displaySendButtonTextLabel(_ sendButtonTextLabel: String) {
        self.sendButton.setTitle(sendButtonTextLabel, for: .normal)
    }

    func clearTextfields() {
        self.usernameTextield.text = nil
        self.contentTextView.text = nil

    }

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
}
