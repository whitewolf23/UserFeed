//
//  ViewController.swift
//  UserFeed
//
//  Created by 김민수 on 20/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    let cellId = "cell"
    var viewModel : UserViewModel?
    var filterArray = [UserItemPresentable]()
    var isSearching = false
    var page = 1

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
        table.delegate = self
        table.dataSource = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let usermodel = UserModel(self)
        usermodel.callAPI(url: "https://api.github.com/search/users?q=v")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = UserViewModel()
        view.backgroundColor = .white
    }
    
}

extension ViewController : NetworkCallback {
    func networkResult(resultData: Any, code: String) {
        
    }
    
    func networkFailed() {
        
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterArray.count
        } else {
            return (viewModel?.items.count)!
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var filter : UserItemPresentable?
        if isSearching {
            filter = filterArray[indexPath.row]
        } else {
            filter = viewModel?.items[indexPath.row]
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserItemTableViewCell


        cell.configure(withViewModel: filter!)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true

             filterArray = (viewModel?.items.filter({$0.textValue?.range(of: searchBar.text!, options: .caseInsensitive) != nil }))!

            tableView.reloadData()
        }
    }
}
