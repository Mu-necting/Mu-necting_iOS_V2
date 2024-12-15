//
//  CommentModel.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import Foundation

class MessageModel {
    private(set) var messages: [String] = []
    
    // 메시지를 추가하고 배열 업데이트
    func addMessage(_ message: String) {
        messages.append(message)
    }
    
    // 메시지 개수 반환
    func getMessageCount() -> Int {
        return messages.count
    }
    
    // 특정 인덱스의 메시지 반환
    func getMessage(at index: Int) -> String? {
        guard index >= 0 && index < messages.count else { return nil }
        return messages[index]
    }
}
