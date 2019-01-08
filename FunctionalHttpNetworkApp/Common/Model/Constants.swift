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
        static let scheme = "https"
        struct Endpoints {
            static let messages = "messages"
            static let sendMessage = "send"
            static let deleteMessage = "delete/{{messageId}}"
        }
    }
    
    struct Keys {
        static let hostUrl = "HOST_URL"
        static let username = "username"
        static let content = "content"
    }
    
    struct Identifiers {
        struct Storyboards {
            static let main = "Main"
        }
        struct viewControllers {
            static let homeVC = "HomeVC"
            static let messageListVC = "MessageListVC"
            static let sendMessageVC = "SendMessageVC"
        }
    }
}
