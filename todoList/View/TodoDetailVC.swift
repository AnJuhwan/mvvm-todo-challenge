//
//  TodoDetailVC.swift
//  todoList
//
//  Created by 안주환 on 2023/02/19.
//

import Foundation
import UIKit

class TodoDetailVC : UIViewController {
    
    @IBOutlet weak var detailLabel:UILabel?
    
    
    
    var todo :String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel?.text = todo

    }
}
