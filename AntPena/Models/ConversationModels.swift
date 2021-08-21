//
//  ConversationModels.swift
//  AntPena
//
//  Created by Hevin Jant on 8/21/21.
//  Copyright © 2021 Hevin Jant. All rights reserved.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
