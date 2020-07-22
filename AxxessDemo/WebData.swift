//
//  WebData.swift
//  AxxessDemo
//
//  Created by Augment Deck Technologies on 19/07/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//

import Foundation
import RealmSwift

class WebItem: Object {
    
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var date: String = ""
     @objc dynamic var data: String = ""
   // @objc dynamic var category: Category!
    override static func primaryKey() -> String? {
        return "itemId"
    }
    convenience init(itemId: String, id: String, type: String, date: String, data: String) {
        self.init()
        self.itemId = itemId
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
}

