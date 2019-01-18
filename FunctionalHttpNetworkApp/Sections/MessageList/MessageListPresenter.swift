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
    func showMessages()
    func show<ServiceError>(error: ServiceError)
}

protocol MessageListPresenterInput {
    var view: MessageListUI? { get set }
    var interactor: MessageListInteractorInput { get set }
    var wireframe: MessageListWireframeInput { get set }

    func viewDidLoad(with tableView: UITableView)
}

class MessageListPresenter {
    weak var view: MessageListUI?
    var interactor: MessageListInteractorInput
    var wireframe: MessageListWireframeInput
    var tableViewViewModel: TableViewViewModel<Message>
    
    init(view: MessageListUI,
         interactor: MessageListInteractorInput,
         wireframe: MessageListWireframeInput,
         tableViewViewModel: TableViewViewModel<Message>) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.tableViewViewModel = tableViewViewModel
    }
}

extension MessageListPresenter: MessageListPresenterInput {
    func viewDidLoad(with tableView: UITableView) {
        self.tableViewViewModel.configure(tableView: tableView)
        self.interactor.retrieveMessages()
    }
}

extension MessageListPresenter: MessageListInteractorOutput {
    func messages(_ messages: [Message]) {
        self.tableViewViewModel.update(items: messages)
        self.view?.showMessages()
    }
    
    func error<ServiceError>(_ error: ServiceError) {
        self.view?.show(error: error)
    }
}
