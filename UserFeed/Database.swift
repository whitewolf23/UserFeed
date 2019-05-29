//
//  Database.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import RealmSwift


class Database {
    static let singleton = Database()
    
    private init() {}
    
    func createOrUpdate(userItemValue : String) -> (Void) {
        let realm = try! Realm()
        
        var userId: Int? = 1
        
        if let  lastEntity = realm.objects(UserItem.self).last {
            userId = lastEntity.userId + 1
        }

        let userItemEntity = UserItem()
        userItemEntity.userId = userId!
        userItemEntity.userValue = userItemValue
        
        try! realm.write {
            realm.add(userItemEntity, update: true)
        }
    }
    
    func fetch() -> (Results<UserItem>){
        let realm = try! Realm()
        
        let userItemResults = realm.objects(UserItem.self)
        
        return userItemResults
    }
    
    func delete(primaryKey: Int) -> (Void) {
        let realm = try! Realm()
        
        if let userItemEntity = realm.object(ofType: UserItem.self, forPrimaryKey: primaryKey) {
            try! realm.write {
                realm.delete(userItemEntity)
            }
        }
    }
}
