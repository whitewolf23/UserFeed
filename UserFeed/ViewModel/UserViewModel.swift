//
//  UserViewModel.swift
//  UserFeed
//
//  Created by 김민수 on 21/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//


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

import RxSwift

class UserViewModel {
    

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
//    var newUserItem : String?
    var items : [UserItemPresentable] = []
}


