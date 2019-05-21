//
//  ViewController.swift
//  UserFeed
//
//  Created by 김민수 on 20/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // cell identifier
    let cellIdentifier = "cell"
    
    // init tableview closure
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    // search
//    let seachBarController = UISearchController(searchResultsController: nil)

    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
//    lazy var searchBarController : UISearchController = {
//        let searchBarController = UISearchController(searchResultsController: nil)
//        searchBarController.dimsBackgroundDuringPresentation = false
//        searchBarController.hidesNavigationBarDuringPresentation = false
//        searchBarController.searchBar.placeholder = "Search here..."
//
//        return searchBarController
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)

//        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false

        // tableview constraints
        let constraints = [
            
            // top
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            // left
            searchBar.heightAnchor.constraint(equalToConstant: 200),
            // right
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            // bottom
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // top
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            // left
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            // right
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // bottom
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]

        // activate constraints
        NSLayoutConstraint.activate(constraints)


    }
    
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "dsjfkajkljf"
        
        return cell
    }
    
    
}
