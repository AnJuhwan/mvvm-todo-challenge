//
//  AddTodoModal.swift
//  todoList
//
//  Created by 안주환 on 2023/02/18.

import Foundation
import UIKit

class AddTodoModalVC : UIViewController {
    
    enum ButtonType : Int {
        case cancle = 0
        case register = 1
    }
    
    @IBOutlet var todoInput: UITextField!
    var delegate : ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    
    /// addTodoModal 버튼 클릭 handler
    /// - Parameter sender: tag 0: 취소 , tag 1: 적용,등록
    @IBAction func btnClickHandler(_ sender: CustomButton) {
        
        let buttonType = ButtonType(rawValue: sender.tag) ?? .cancle
        
        switch buttonType {
        case .register:
            delegate?.newAddTodo(newTodo: todoInput.text ?? "")
            self.dismiss(animated: true)
        default:
            self.dismiss(animated: true)
        }
        
    }
}
