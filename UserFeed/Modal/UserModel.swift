//
//  UserModel.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON

class UserModel : NetworkModel {
    func callAPI(url: String){
//        let URL : String = "\(baseURL)/users?q=\(keyword)"
        print(url)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response : DataResponse<UserListVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let list = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
}
