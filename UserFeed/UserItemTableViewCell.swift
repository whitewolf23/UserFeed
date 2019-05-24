//
//  UserItemTableViewCell.swift
//  UserFeed
//
//  Created by 김민수 on 23/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import UIKit


class UserItemTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let coodinate = CGRect(x: 10, y: 6, width : self.frame.width - 20, height: 110)
        let view = UIView(frame: coodinate)
        view.backgroundColor = .red
        return view
    }()
    
    lazy var userimage: UIImageView = {
        let coodinate = CGRect(x: 4, y: 6, width : 100, height: 100)
        let image = UIImageView(frame: coodinate)
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        return image
    }()
    
    lazy var nameLabel : UILabel = {
        let coodinate = CGRect(x: 116, y: 8, width : backView.frame.width - 116 , height: 30)
        let label = UILabel(frame: coodinate)
        label.backgroundColor = .green
        label.textAlignment = .left
        return label
    }()
    
    lazy var scoreLabel : UILabel = {
        let coodinate = CGRect(x: 116, y: 50, width : backView.frame.width - 116 , height: 30)
        let label = UILabel(frame: coodinate)
        label.backgroundColor = .purple
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    override func layoutSubviews() {
//        contentView.backgroundColor = .green
//        backgroundColor = .blue
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(userimage)
        backView.addSubview(nameLabel)
        backView.addSubview(scoreLabel)
    }
    
    
    func configure (withViewModel viewModel: UserItemPresentable) -> (Void){
        nameLabel.text = viewModel.id
        scoreLabel.text = viewModel.textValue
    }
    
  
}
