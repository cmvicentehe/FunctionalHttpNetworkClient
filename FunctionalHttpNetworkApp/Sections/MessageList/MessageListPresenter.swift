//
//  MessageListPresenter.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 08/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

protocol MessageListUI: class {}

protocol MessageListPresenterInput {
    var view: MessageListUI? { get set }
    var interactor: MessageListInteractorInput { get set }
    var wireframe: MessageListWireframeInput { get set }

    func viewDidLoad()
}

class MessageListPresenter {
    weak var view: MessageListUI?
    var interactor: MessageListInteractorInput
    var wireframe: MessageListWireframeInput
    
    init(view: MessageListUI, interactor: MessageListInteractorInput, wireframe: MessageListWireframeInput) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MessageListPresenter: MessageListPresenterInput {
    func viewDidLoad() {
        self.interactor.retrieveMessages()
    }
}

extension MessageListPresenter: MessageListInteractorOutput {}
