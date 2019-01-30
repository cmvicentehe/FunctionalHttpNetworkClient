//
//  MessageListPresenter.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 08/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import UIKit

protocol MessageListUI: class {
    func showActicityIndicator()
    func hideActivityIndicator()
    func showMessages()
}

protocol MessageListPresenterInput: class {
    var view: MessageListUI? { get set }
    var interactor: MessageListInteractorInput { get set }
    var wireframe: MessageListWireframeInput { get set }

    func viewWillAppear(with tableView: UITableView)
    func userDidTapMessage(with idMessage: String)
}

class MessageListPresenter {
    weak var view: MessageListUI?
    var interactor: MessageListInteractorInput
    var wireframe: MessageListWireframeInput
    var tableViewViewModel: MessagesTableViewViewModel
    
    init(view: MessageListUI,
         interactor: MessageListInteractorInput,
         wireframe: MessageListWireframeInput,
         tableViewViewModel: MessagesTableViewViewModel) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.tableViewViewModel = tableViewViewModel
    }
}

extension MessageListPresenter: MessageListPresenterInput {
    func viewWillAppear(with tableView: UITableView) {
        self.tableViewViewModel.configure(tableView: tableView)
        self.view?.showActicityIndicator()
        self.interactor.retrieveMessages()
    }

    func userDidTapMessage(with idMessage: String) {
        self.view?.showActicityIndicator()
        self.interactor.deleteMessage(with: idMessage)
    }
}

extension MessageListPresenter: MessageListInteractorOutput {
    func messages(_ messages: [Message]) {
        self.view?.hideActivityIndicator()
        self.tableViewViewModel.items = messages
        self.view?.showMessages()
    }

    func messageDeleted() {
        self.view?.hideActivityIndicator()
        self.tableViewViewModel.deleteRowAtIndexPath()
    }
    
    func error<ServiceError>(_ error: ServiceError) {
        let title = NSLocalizedString("app_name",
                                      comment: "")
        let message = String(describing: error)
        self.view?.hideActivityIndicator()
        self.wireframe.showAlert(with: title,
                                 message: message,
                                 completion: nil)
    }
}
