//
//  ApiService.swift
//  UserFeed
//
//  Created by 김민수 on 29/05/2019.
//  Copyright © 2019 김민수. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

protocol ApiServiceProtocol {
    associatedtype ResponseData
    func fetchAllUsers() -> (ResponseData)
}

class ApiService : ApiServiceProtocol {

    static let sharedInstance : ApiService = ApiService()
    
    private init() {}
    
    typealias ResponseData = Observable<JSON>
    
    func fetchAllUsers() -> (Observable<JSON>){
        let baseURL = "https://api.github.com/search"
        let url  = URL(string: "\(baseURL)/users?q=v")
        print("url", url)
        return Observable.create({ (observer) -> Disposable in
            
           let request =  Alamofire.request(url!).responseData{ (responseData) in
                switch (responseData.result) {
                case .success(let value):
                    if let statusCode = responseData.response?.statusCode, statusCode == 200 {
                        let responseJson = JSON(value)
                        observer.onNext(responseJson)
                        observer.onCompleted()
                    } else {
                        print("기대하지 않은 응답")
                        observer.onError(NSError(domain: "domainName", code: -1, userInfo: nil))
                    }
                    break
                case .failure(let error):
                    print("뭔가 잘못됨")
                    observer.onError(NSError(domain: "domainName", code: -1, userInfo: nil))
                    break
                }
                
            }
            
            return Disposables.create {
                request.cancel()
            }
        })
        
       
    }
}
