//
//  ViewController.swift
//  UserFeed
//
//  Created by 김민수 on 20/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//protocol UserView: class {
//    func insertUserItem() -> ()
//    func removeUserItem(at index: Int) -> ()
//    func updateUserItem(at index: Int) -> ()
//    func reloadItems() -> ()
//}

class ViewController: UIViewController {
    
    let cellId = "cell"
    var viewModel : UserViewModel?
    let disposeBag = DisposeBag()
    var filterArray = [UserItemPresentable]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = UserViewModel()
        
        viewModel?.filteredItems.asObservable().bind(to :tableView.rx.items(cellIdentifier : cellId, cellType: UserItemTableViewCell.self )) { index, item, cell in
                cell.configure(withViewModel: item)
            }.disposed(by: disposeBag)
        
        let searchBar = searchBarController.searchBar
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debug()
            .bind(to:(viewModel?.searchValue)!)
            .disposed(by: disposeBag)
        
        view.backgroundColor = .white
    }
    
    lazy var searchBarController : UISearchController = {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.showsCancelButton = false
        return searchBarController
    }()
    
    // 클로저를 이용한 tableview 선언
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
//        table.estimatedRowHeight = 118

//        table.delegate = self
//        table.dataSource = self
//        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.register(UserItemTableViewCell.self, forCellReuseIdentifier: cellId)
        return table
    }()
    
  
    
    // fileprivate : 해당 세부 정보가 전체 파일 내에서 사용 될 때 특정 기능의 구현 세부 정보를 숨길 수 있습니다.
    fileprivate func setupUI() {
        view.addSubview(tableView)

        let TableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(TableViewConstraints)
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    
   
    
}


//extension ViewController : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isSearching {
//            return filterArray.count
//        } else {
////            return testArray.count
//            guard let items = viewModel?.items else {
//                return 0
//            }
//            return (viewModel?.items.value.count)!
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var filter : UserItemPresentable?
//        if isSearching {
//            filter = filterArray[indexPath.row]
//        } else {
//            filter = viewModel?.items.value[indexPath.row]
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserItemTableViewCell
//        cell.configure(withViewModel: filter!)
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 118
//    }
//
//
//
//}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            
             filterArray = (viewModel?.items.value.filter({$0.textValue?.range(of: searchBar.text!, options: .caseInsensitive) != nil }))!
    
            tableView.reloadData()
        }
    }
    
}

//extension ViewController : UserView {
//    func insertUserItem() {
//
//    }
//
//    func removeUserItem(at index: Int) {
//
//    }
//
//    func updateUserItem(at index: Int) {
//
//    }
//
//    func reloadItems() {
//
//    }
//
//}
