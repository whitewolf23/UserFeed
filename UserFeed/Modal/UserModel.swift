//
//  UserModel.swift
//  UserFeed
//
//  Created by 김민수 on 23/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import UIKit

class UserModel {
    var profile : UIImage?
    var login : String?
    var score : Int?
    
    init(profile : UIImage, login : String , score: Int) {
        self.profile = profile
        self.login = login
        self.score = score
    }

}
