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

import RxSwift
import RealmSwift

protocol UserMenuItemViewPresentable {
    var title: String? { get set }
    var backColor: String? { get }
}

protocol UserMenuItemViewDelegate {
    func onUserItemSelected() -> ()
}

class UserMenuItemViewModel : UserMenuItemViewPresentable, UserMenuItemViewDelegate {
    var title: String?
    var backColor : String?
    weak var parent : UserItemViewDelegete?
    
    init(parentViewModel : UserItemViewDelegete) {
        self.parent = parentViewModel
    }
    
    func onUserItemSelected() {
        
    }
}

class RemoveMenuItemViewModel : UserMenuItemViewModel {
    override func onUserItemSelected() {
        print("지우기")
        parent?.onRemoveSelected()
    }
}

class DoneMenuItemViewModel : UserMenuItemViewModel {
    override func onUserItemSelected() {
        print("끝~")
        parent?.onDoneSelected()
    }
}

protocol UserItemViewDelegete : class {
    func onItemSelected() -> (Void)
    func onRemoveSelected() -> (Void)
    func onDoneSelected() -> (Void)
}

protocol UserItemPresentable {
    var id: String? { get }
    var textValue : String? { get }
    var login : String? { get }
    var score : String? { get }
    var isDone : Bool? { get set }
    var menuItems : [UserMenuItemViewPresentable]? { get }
}


class UserItemViewModel : UserItemPresentable {
    var id : String? = "0"
    var textValue: String?
    var login: String?
    var score: String?

    var isDone: Bool? = false
    var menuItems: [UserMenuItemViewPresentable]? = []
    weak var parent : UserViewDelegate?
    
    init(id: String, textValue: String, login:String, score: String, parentViewModel: UserViewDelegate) {
        self.id = id
        self.textValue = textValue
        self.parent = parentViewModel
        self.login = login
        self.score = score
        
        let removeMenuItem = RemoveMenuItemViewModel(parentViewModel: self)
        removeMenuItem.title = "Remove"
        removeMenuItem.backColor = "ff0000"
        
        let doneMenuItem = DoneMenuItemViewModel(parentViewModel: self)
        doneMenuItem.title = isDone! ? "undone" : "done"
        doneMenuItem.backColor = "000000"
        
        menuItems?.append(contentsOf: [removeMenuItem, doneMenuItem])
    }
}

extension UserItemViewModel : UserItemViewDelegete {
    func onItemSelected() {
        print("선택!!")
    }
    
    func onRemoveSelected() {
        parent?.onTodoDelete(todoId: id!)
    }
    
    func onDoneSelected() {
        parent?.onTodoDone(todoId: id!)
    }
}

protocol UserViewDelegate: class {
    func onAddTodoItem() -> ()
    func onTodoDelete(todoId: String) -> ()
    func onTodoDone(todoId: String) -> ()
}

protocol UserViewPresentable {
    var newUserItem : String? { get }
    var searchValue : Variable<String> { get }
}

class UserViewModel : UserViewPresentable {
    var searchValue: Variable<String> = Variable("")

    var newUserItem: String?
    var items : Variable<[UserItemPresentable]> = Variable([])
    var filteredItems : Variable<[UserItemPresentable]> = Variable([])

    let disposeBag = DisposeBag()
    
    lazy var searchValueObservale : Observable<String> = self.searchValue.asObservable()
    lazy var itemsObservable : Observable<[UserItemPresentable]> = self.items.asObservable()
    lazy var filteredItemsOvservable : Observable<[UserItemPresentable]> = self.filteredItems.asObservable()
   
    init() {
        fetchUsers()
        
        searchValueObservale.subscribe(onNext: { (value) in
            print("검색어\(value)")
            
            self.itemsObservable.map({
                $0.filter({
                    if value.isEmpty { return true }
                    return ($0.textValue?.lowercased().contains(value.lowercased()))!
                })
            }).bind(to: self.filteredItems)
                .disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func fetchUsers() -> (Void) {
        let usersObservable = ApiService.sharedInstance.fetchAllUsers()
        
        usersObservable.subscribe(onNext : { (jsonResponse) in
            print("jsonResponse", jsonResponse)
            
            if let userArray = jsonResponse["items"].array {
                userArray.forEach({ (UserItemDict) in
                    if let itemDict = UserItemDict.dictionary {
                        if let login = itemDict["login"]?.string,
                            let score = itemDict["score"]?.string {
                            print("login : \(login)")
                            print("score : \(score)")
                            
                        }
                    }
                    
                })
            }
        }, onError: { (error) in
            print("error")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
            
        }).disposed(by: disposeBag)
    }
}

