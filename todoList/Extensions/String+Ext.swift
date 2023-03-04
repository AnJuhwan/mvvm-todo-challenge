//
//  String+Ext.swift
//  todoList
//
//  Created by 안주환 on 2023/02/11.
//

import Foundation

extension String {
    var isValue : Bool {
        let valueLength = self != "" ? true : false
        return valueLength
    }
}
