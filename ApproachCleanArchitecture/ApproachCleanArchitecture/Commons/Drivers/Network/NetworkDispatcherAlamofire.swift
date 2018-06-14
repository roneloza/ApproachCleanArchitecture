//
//  NetworkDispatcherAlamofire.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation
import Alamofire

class NetworkDispatcherAlamofire: BaseNetworkDispatcher {
    
    private func httpMethod(opt: NetworkHTTPMethod) -> HTTPMethod  {
        
        switch opt {
        case .GET:
            return HTTPMethod.get
            
        case .POST:
            return HTTPMethod.post
            
        case .DELETE:
            return HTTPMethod.delete
            
        case .HEAD:
            return HTTPMethod.head
            
        case .PATCH:
            return HTTPMethod.patch
            
        case .PUT:
            return HTTPMethod.put
            
        }
    }
    
    private func httpUrlEncoded(opt: NetworkURLEncode?) -> ParameterEncoding  {
        
        switch opt {
        case .JSONEncoding?:
            return JSONEncoding.default
            
        case .URLEncoding?:
            return URLEncoding.default
            
        case .none:
            return URLEncoding.default
        }
    }
    
    override func requestBase(request: NetworkRequest, success: @escaping (Data?) -> Void
        , failure: @escaping (ErrorModelable)->Void) {
        
        if let baseURL = self.baseURLDeaults,
            let url = URL.init(string: baseURL + "/" + request.path) {
            
            let method = self.httpMethod(opt: request.method)
            
            let urlParams = request.parameters
            
            let encoding = self.httpUrlEncoded(opt: request.URLEncoding)
            
            var headers: [String: String] = self.headersDeaults
            
            if let dict = request.headers {
                
                headers = headers.merging(dict, uniquingKeysWith: { (first, _) in first })
            }
            
            Alamofire.request(url, method: method, parameters: urlParams, encoding: encoding, headers: headers).responseJSON { (jsonData) in
                
                //            sleep(3)
                
                if let response = jsonData.response {
                    
                    switch response.statusCode {
                        
                    case 200..<400:
                        
                        success(jsonData.data)
                    default:
                        
                        if let data = jsonData.data {
                            
                            failure(RequestError.FailWithData(data: data, httpStatus: response.statusCode))
                        }
                        else {
                            
                            failure(RequestError.FailWithText(message: response.debugDescription, httpStatus: response.statusCode))
                        }
                    }
                }
                else {
                    
                    failure(RequestError.EmptyNetworkResponse)
                }
            }
        }
        else {
            
            failure(RequestError.FailURLMalformed)
        }
    }
}
