//
//  NewMessagePresenter.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 22/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

protocol NewMessageUI: class {
    func displayUsernameLabel(_ usernameLabel: String)
    func displayContentLabel(_ contentLabel: String)
    func displaySendButtonTextLabel(_ sendButtonTextLabel: String)
    func clearTextfields()
    func showActicityIndicator()
    func hideActivityIndicator()
}

protocol NewMessagePresenterInput {
    var view: NewMessageUI? { get set }
    var interactor: NewMessageInteractorInput { get set }
    var wireframe: NewMessageWireframe { get set }

    func viewDidLoad()
    func userDidTapSendButton(with username: String?, content: String?)
}

class NewMessagePresenter {
    weak var view: NewMessageUI?
    var interactor: NewMessageInteractorInput
    var wireframe: NewMessageWireframe

    init(view: NewMessageUI?,
         interactor: NewMessageInteractorInput,
         wireframe: NewMessageWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension NewMessagePresenter: NewMessagePresenterInput {
    func viewDidLoad() {
        self.view?.displayUsernameLabel(NSLocalizedString("username", comment: ""))
        self.view?.displayContentLabel(NSLocalizedString("content", comment: ""))
        self.view?.displaySendButtonTextLabel(NSLocalizedString("send", comment: ""))
    }

    func userDidTapSendButton(with username: String?, content: String?) {
        guard let usernameNotNil = username,
                usernameNotNil != "",
            let contentNotNil = content,
                contentNotNil != "" else {
                let title = NSLocalizedString("app_name",
                                              comment: "")
                let message = NSLocalizedString("empty_username_content",
                                                comment: "")
                self.wireframe.showAlert(with: title,
                                         message: message)
                return
        }
        self.view?.showActicityIndicator()
        self.interactor.sendMessage(by: usernameNotNil,
                                    with: contentNotNil)
    }
}

extension NewMessagePresenter: NewMessageInteractorOutput {
    func messageSent() {
        let title = NSLocalizedString("app_name",
                                      comment: "")
        let message = NSLocalizedString("message_sent_success",
                                        comment: "")
        self.view?.hideActivityIndicator()
        self.wireframe.showAlert(with: title,
                                 message: message) {
            self.view?.clearTextfields()
        }
    }
    func error<ServiceError>(_ error: ServiceError) {
        let title = NSLocalizedString("app_name",
                                      comment: "")
        let message = String(describing: error)
        self.view?.hideActivityIndicator()
        self.wireframe.showAlert(with: title,
                                 message: message)
    }
}
