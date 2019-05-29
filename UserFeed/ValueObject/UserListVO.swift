//
//  UserListVO.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import ObjectMapper

class UserListVO : Mappable{
    
    var total_count : Int?
    var incomplete_results : Bool?
    var items : [UserVO]? // {}
    

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items <- map["items"]
    
        print("=========================")
        print("total_count : \((total_count))")
        print("incomplete_results : \((incomplete_results))")
        print("items : \((items))")
        print("=========================")
    }
}
