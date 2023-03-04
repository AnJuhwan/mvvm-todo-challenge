//
//  TodoCell.swift
//  todoList
//
//  Created by 안주환 on 2023/02/19.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId : String { get }
}

extension ReuseIdentifiable {
    static var reuseId : String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell : ReuseIdentifiable{} 

class TodoCell: UITableViewCell {
    
    @IBOutlet var deleteBtn: CustomButton!
    @IBOutlet var todoButton: UIButton!
    
    var todo: Todo? = nil
    
    var delegate : ViewControllerDelegate?
    var closure : ((_ todo:String) -> Void)? = nil
    
    static var reuseId : String = String(describing: TodoCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteBtn.tintColor = .white
        
        deleteBtn.addTarget(self, action: #selector(deleteBtnClicked(_:)), for: .touchUpInside)
        todoButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
        
        
    }
    
    func configureUI(cellData: Todo, delegate:ViewControllerDelegate) {
        self.todo = cellData
        self.delegate = delegate
        self.todoButton.setTitle(cellData.todo, for: .normal)
    }
    
    @objc fileprivate func deleteBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- \(sender)")
        if let todoId = todo?.id {
            delegate?.deleteTodo(todoId: todoId)
        }
    }
    
    @objc fileprivate func goToDetail(_ sender: UIButton) {
        if let todo = todo?.todo {
//            delegate?.navToDetail(todo: todo)
            self.closure?(todo)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
