//
//  ViewController.swift
//  todoList
//
//  Created by 안주환 on 2023/02/06.
//

import UIKit

protocol ViewControllerDelegate {
    func newAddTodo(newTodo: String)
    func deleteTodo(todoId: Int)
    func navToDetail(todo:String)
}

class ViewController: UIViewController, UITableViewDataSource {
    
    var todoViewModel = TodoViewModel()
    
    @IBOutlet var todoAddBtn: UIButton!
    @IBOutlet var todoTable: UITableView!
    @IBOutlet var clearButton: CustomButton!
    @IBOutlet var filterInput: UITextField!
    @IBOutlet var todoDetailNavigation: UIButton!
    
    var detailData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton.isHidden = true
        
        self.filterInput.addTarget(self, action: #selector(filterInputChanged(_ :)), for: .editingChanged)
        
        self.todoViewModel.visibleClearBtnEvent = { [weak self] visibleBtn in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.clearButton.isHidden = !visibleBtn
            }
            
        }
        
//        self.todoDetailNavigation.addTarget(self, action: #selector(navToDetail), for: .touchUpInside)
        
        
        self.todoAddBtn.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
        
        todoTable.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(#fileID, #function, #line, "- \(segue.destination)")
        
        if let detailVC = segue.destination as? TodoDetailVC {
            detailVC.todo = detailData
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseId, for: indexPath) as? TodoCell {
            
            let cellData = todoViewModel.todoList[indexPath.row]
            cell.configureUI(cellData: cellData, delegate: self)
            cell.todo = todoViewModel.todoList[indexPath.row]
            cell.delegate = self
            cell.todoButton.setTitle(todoViewModel.todoList[indexPath.row].todo, for: .normal)
            
            cell.closure = self.navToDetail
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func a(a: String) {}
    
    @objc func filterInputChanged(_ sender: UITextField) {
        
        if let filterInput : String = sender.text {
            self.todoViewModel.filterInputValue = sender.text ?? ""
        }
    }
    
    
    @objc func addTodo(_ sender: UIButton) {
        
        let addTodoModalStoryboard = UIStoryboard(name: "AddTodoModal", bundle: .main)
        
        if let addTodoModalVC = addTodoModalStoryboard.instantiateViewController(withIdentifier: "AddTodoModalVC") as? AddTodoModalVC {
            
            addTodoModalVC.delegate = self
            self.present(addTodoModalVC, animated: true)
        }
    }
    
    @objc func navToDetail(_ sender: UIButton) {
        self.performSegue(withIdentifier: "todoDetailVC", sender: self)
    }
    
}

extension ViewController : ViewControllerDelegate {
    func newAddTodo(newTodo:String) {
        self.todoViewModel.addTodo = Todo(id:todoViewModel.todoList.endIndex + 1 , todo:newTodo, done:false)
        self.todoTable.reloadData()
    }
    
    func deleteTodo(todoId: Int) {
        todoViewModel.todoList.remove(at: todoId - 1)
        self.todoTable.reloadData()
    }
    
    func navToDetail(todo:String) {
        detailData = todo
        self.performSegue(withIdentifier: "todoDetailVC", sender: self)
    }
}
