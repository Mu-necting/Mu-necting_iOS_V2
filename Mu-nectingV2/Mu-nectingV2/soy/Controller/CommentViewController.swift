//
//  CommentViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class CommentViewController: UIViewController {
    private let model = MessageModel()
    
    override func loadView() {
        let commentView = CommentView(controller: self) // `CommentView` 초기화 시 controller 주입
        view = commentView
    }
    
    func addMessage(_ message: String) {
        model.addMessage(message)
    }
    
    func getMessageCount() -> Int {
        return model.getMessageCount()
    }
    
    func getMessage(at index: Int) -> String? {
        return model.getMessage(at: index)
    }
}
