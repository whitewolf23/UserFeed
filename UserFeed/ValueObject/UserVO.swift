//
//  UserVO.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import ObjectMapper

//"login": "whitewolf23",
//    "id": 19277100,
//    "node_id": "MDQ6VXNlcjE5Mjc3MTAw",
//    "avatar_url": "https://avatars3.githubusercontent.com/u/19277100?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/whitewolf23",
//    "html_url": "https://github.com/whitewolf23",
//    "followers_url": "https://api.github.com/users/whitewolf23/followers",
//    "following_url": "https://api.github.com/users/whitewolf23/following{/other_user}",
//    "gists_url": "https://api.github.com/users/whitewolf23/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/whitewolf23/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/whitewolf23/subscriptions",
//    "organizations_url": "https://api.github.com/users/whitewolf23/orgs",
//    "repos_url": "https://api.github.com/users/whitewolf23/repos",
//    "events_url": "https://api.github.com/users/whitewolf23/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/whitewolf23/received_events",
//    "type": "User",
//    "site_admin": false,
//    "score": 109.31056
//    }


class UserVO: Mappable {
    
    var login: String?
    var avatar_url: String?
    var score: Double?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        self.login <- map["login"]
        self.avatar_url <- map["avatar_url"]
        self.score <- map["score"]
    
        print("=========================")
        print("login : \(login!)")
        print("avatar_url : \(avatar_url!)")
        print("score: \((score))")
        print("=========================")
        
        
        
    }
    
    
}
