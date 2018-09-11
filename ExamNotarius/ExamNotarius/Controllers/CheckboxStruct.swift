//
//  CheckboxStruct.swift
//  ExamNotarius
//
//  Created by Александр on 08.04.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation

struct Character {
    var title: String
    var id: Int
    var isSelected: Bool! = false
    init(title: String, id: Int) {
        self.title = title
        self.id = id
    }
}
