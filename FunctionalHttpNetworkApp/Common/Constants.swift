//
//  Constants.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 20/12/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

struct Constants {
    struct Services {
        struct Endpoints {
            static let messages = "/messages"
            static let sendMessage = "/send"
            static let deleteMessage = "/delete/{{messageId}}"
        }
    }
    
    struct Keys {
        static let scheme = "SCHEME"
        static let hostUrl = "HOST_URL"
        static let port = "PORT"
        static let username = "username"
        static let content = "content"
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
    }
    
    struct Identifiers {
        struct Storyboards {
            static let home = "Home"
        }
        struct Cells {
            static let messageCell = "MessageCell"
        }
        struct ViewControllers {
            static let homeVC = "HomeVC"
            static let messageListVC = "MessageListVC"
            static let newMessageVC = "NewMessageVC"
        }
    }

}
