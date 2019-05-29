//
//  UserItem.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import RealmSwift

class UserItem : Object {
    @objc dynamic var userId : Int = 0
    @objc dynamic var userValue : String = ""
    @objc dynamic var idDone : Bool = false
    @objc dynamic var createAt : Date? = Date()
    @objc dynamic var updateAt : Date?

    override static func primaryKey() -> String? {
        return "userId"
    }
}
