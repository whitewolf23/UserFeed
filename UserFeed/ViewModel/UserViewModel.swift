//
//  UserViewModel.swift
//  UserFeed
//
//  Created by 김민수 on 21/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//


//{
//    "total_count": 1,
//    "incomplete_results": false,
//    "items": [
//    {
//    "login": "whitewolf23",
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
//    ]
//}

protocol UserItemPresentable {
    var id: String? { get }
    var textValue: String? { get }
}

struct UserItemViewModel : UserItemPresentable {
    var id : String? = "0"
    var textValue : String?
}


protocol UserItemViewDelegate {
    func onUserItemAdded() -> ()
}


struct UserViewModel {
    
    init() {
        let item1 = UserItemViewModel(id: "1", textValue: "로이")
        let item2 = UserItemViewModel(id: "2", textValue: "제이슨")
        let item3 = UserItemViewModel(id: "3", textValue: "세미")
        let item4 = UserItemViewModel(id: "4", textValue: "매튜")
        let item5 = UserItemViewModel(id: "5", textValue: "댄")
        let item6 = UserItemViewModel(id: "6", textValue: "애쉬")
        let item7 = UserItemViewModel(id: "7", textValue: "제이")

//        items.append([item1, item2, item3, item4, item5, item6, item7] as! UserItemPresentable)
        items.append(contentsOf: [item1, item2, item3, item4, item5, item6, item7])
//        items.append([item1, item2, item3, item4, item5, item6, item7] )
    }
    var newUserItem : String?
    var items : [UserItemPresentable] = []
}


extension UserViewModel: UserItemViewDelegate {
    func onUserItemAdded() {
        
    }
}
