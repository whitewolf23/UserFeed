//
//  ViewController.swift
//  UserFeed
//
//  Created by 김민수 on 20/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellId = "cell"
    
    let testArray = ["jason", "tom", "ash", "jay", "ellein", "semi"]
    
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return table
    }()
    
    
    lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
//        bar.tintColor = .red
        return bar
    }()
    
    fileprivate func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
  
        let searchBarConstraints = [
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
        
        let TableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(searchBarConstraints)
        NSLayoutConstraint.activate(TableViewConstraints)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = testArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = data
        
        return cell
    }
    
    
    
}
