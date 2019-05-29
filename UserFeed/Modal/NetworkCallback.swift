//
//  NetworkCallback.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

protocol NetworkCallback {
    func networkResult(resultData:Any, code:String)
    func networkFailed()
}
