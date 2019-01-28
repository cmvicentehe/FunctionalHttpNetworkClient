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
            let contentNotNil = content else {
                #warning("TODO: Show an alert")
                print("Username or content is nil")
                return
        }

        self.interactor.sendMessage(by: usernameNotNil, with: contentNotNil)
    }
}

extension NewMessagePresenter: NewMessageInteractorOutput {
    func messageSent() {
         #warning("TODO: Show an alert and clean view")
    }
    func error<ServiceError>(_ error: ServiceError) {
         #warning("TODO: Show an alert")
    }
}
