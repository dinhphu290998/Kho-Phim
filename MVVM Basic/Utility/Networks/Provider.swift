//
//  Provider.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

typealias ReponseResult = ((_ success: Bool, _ error: String?, _ data: Any?) -> (Void))?

class Provider {
    
    var session: Alamofire.Session?
    fileprivate var request: Request?
    fileprivate let networkTimeout: TimeInterval = 30.0
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = networkTimeout
        configuration.timeoutIntervalForResource = networkTimeout
        session = Alamofire.Session(configuration: configuration)
    }
    
    func requestAPI(api: String,parameter: Parameters? = nil,headers: HTTPHeaders? = nil,method: HTTPMethod,encoding: JSONEncoding,completion: ReponseResult) {
        guard let url = URL.init(string: api) else {return}
        session?.request(url, method: method, parameters: parameter, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let data):
                completion?(true, nil, data)
                break
            case .failure( let error):
                completion?(false, "kDefaultInternetError \(error.localizedDescription)", nil)
                break
            }
        })
    }
}
