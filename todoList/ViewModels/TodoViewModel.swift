//
//  Todo.swift
//  todoList
//
//  Created by 안주환 on 2023/02/11.
//

import Foundation


class TodoViewModel : NSObject {
    
    var todoList = [Todo]()
    
    var filterInputValue : String = "" {
        didSet {
            visibleClearBtnEvent?(filterInputValue.isValue)
        }
    }
    
    var addTodo : Todo = Todo(id:0,todo:"",done:false) {
        didSet {
            todoList.append(addTodo)
            print(todoList)
        }
    }
    
    var visibleClearBtnEvent: ((_ isVisible: Bool) -> Void)? = nil
    
    var addTodoList: ((_ value:String) -> Void)? = nil
}
