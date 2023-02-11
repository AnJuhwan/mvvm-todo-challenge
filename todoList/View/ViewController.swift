//
//  ViewController.swift
//  todoList
//
//  Created by 안주환 on 2023/02/06.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var todoViewModel = TodoViewModel()
    
    @IBOutlet var todoAddBtn: UIButton!
    @IBOutlet var todoTable: UITableView!
    @IBOutlet var clearButton: CustomButton!
    @IBOutlet var filterInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterInput.addTarget(self, action: #selector(filterInputChanged(_ :)), for: .editingChanged)
        
        self.todoViewModel.visibleClearBtnEvent = { [weak self] visibleBtn in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.clearButton.isHidden = !visibleBtn
            }
        }
        
        self.todoAddBtn.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
        
        todoTable.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyCell")
        cell.textLabel?.text = todoViewModel.todoList[indexPath.row].todo
        cell.detailTextLabel?.text = "....."
        return cell
        
    }
    
    @objc func filterInputChanged(_ sender: UITextField) {
        
        if let filterInput : String = sender.text {
            self.todoViewModel.filterInputValue = sender.text ?? ""
        }
    }
    
    @objc func addTodo(_ sender: UIButton) {
        self.todoViewModel.addTodo = Todo(id:todoViewModel.todoList.endIndex + 1 , todo:todoViewModel.filterInputValue, done:false)
        self.todoTable.reloadData()
    }
    
}

