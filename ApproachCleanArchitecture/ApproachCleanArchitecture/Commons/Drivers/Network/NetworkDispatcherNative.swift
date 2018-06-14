//
//  NetworkDispatcherNative.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/12/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class NetworkDispatcherNative: BaseNetworkDispatcher {
    
    private let session: URLSession = URLSession(configuration: .default)
    
    private func httpMethod(opt: NetworkHTTPMethod) -> String  {
        
        switch opt {
        case .GET:
            return "GET"
            
        case .POST:
            return "POST"
            
        case .DELETE:
            return "DELETE"
            
        case .HEAD:
            return "HEAD"
            
        case .PATCH:
            return "PATCH"
            
        case .PUT:
            return "PUT"
            
        }
    }
    
    private func makeRequest(url :URL, request: NetworkRequest) -> URLRequest {
        
        var urlRequest = URLRequest.init(url: url);
        
        switch request.method {
        case .POST,
             .PUT,
             .DELETE,
             .PATCH:
            
            switch request.bodyEncode {
                
            case .Raw:
                
                if  request.URLEncoding == .JSONEncoding {
                    
                    let postData = try? JSONSerialization.data(withJSONObject: request.parameters!, options: .prettyPrinted)
                    urlRequest.httpBody = postData
                }
            case .Form_URLEncoded:
                
                var postData = Data.init()
                
                if let params = request.parameters {
                    
                    var counter = 0
                    
                    for (key, value) in params {
                        
                        if let data = "\(counter == 0 ? "" : "&")\(key)=\(value)".data(using: String.Encoding.utf8) {
                         
                            postData.append(data)
                        }
                        
                        counter += 1
                    }
                }
                
                urlRequest.httpBody = postData
                
            case .Form_Data:
                
                var body = ""
                
                if let bodyFormData = request.bodyFormData {
                    
                    for param in bodyFormData {
                        
                        if let paramName = param.key {
                            
                            body += "--\(request.bodyFormDataBoundary)\r\n"
                            body += "Content-Disposition:form-data; name=\"\(paramName)\""
                            
                            if let filename = param.value,
                                let filePath = param.filePath,
                                let fileContent = try? String.init(contentsOfFile: filePath, encoding: .utf8) {
                                
                                let contentType = param.mimeType.rawValue
                                
                                body += "; filename=\"\(filename)\"\r\n"
                                body += "Content-Type: \(contentType)\r\n\r\n"
                                body += fileContent
                            }
                            else if let paramValue = param.value {
                                
                                body += "\r\n\r\n\(paramValue)"
                            }
                        }
                    }
                    
                    body += "\r\n--\(request.bodyFormDataBoundary)--\r\n";
                    let postData = body.data(using: String.Encoding.utf8)
                    urlRequest.httpBody = postData
                }
            }
        default:
            
            let customURL = self.makeURL(url: url, params: request.parameters)
            urlRequest = URLRequest.init(url: customURL)
        }
        
        var allHTTPHeaderFields: [String: String] = self.headersDeaults
        
        if let dict = request.headers {
            
            allHTTPHeaderFields = allHTTPHeaderFields.merging(dict, uniquingKeysWith: { (first, _) in first })
        }
        
        urlRequest.allHTTPHeaderFields = allHTTPHeaderFields
        urlRequest.httpMethod = self.httpMethod(opt: request.method)
        
        return urlRequest;
    }
    
    private func makeURL(url: URL, params: [String: String]?) -> URL {
        
        var urlComponents = URLComponents.init(url: url, resolvingAgainstBaseURL: true)
        
        if let params = params {
            
            var queries : [URLQueryItem]? = []
            
            for (key, value) in params {
                
                let query = URLQueryItem(name: key, value: value)
                queries?.append(query)
            }
            
            urlComponents?.queryItems = queries
        }
        
        return urlComponents?.url ?? url
    }
    
    override func requestBase(request: NetworkRequest, success: @escaping (Data?) -> Void, failure: @escaping (ErrorModelable) -> Void) {
        
        if let baseURL = self.baseURLDeaults,
            let url = URL.init(string: baseURL + "/" + request.path) {
            
            let request = self.makeRequest(url: url, request: request)
            
            self.session.dataTask(with :request) { (data :Data?, response :URLResponse?, error:Error?) in
                
//                sleep(3)
                
                if let httpResponse = (response as? HTTPURLResponse) {
                    
                    switch httpResponse.statusCode {
                        
                    case 200..<400:
                       
                        success(data)
                    default:
                        
                        if let errorData = data {
                            
                            failure(RequestError.FailWithData(data: errorData, httpStatus: httpResponse.statusCode))
                        }
                        else {
                            
                            failure(RequestError.FailWithText(message: httpResponse.debugDescription, httpStatus: httpResponse.statusCode))
                        }
                    }
                }
                else {
                    
                    failure(RequestError.EmptyNetworkResponse)
                }
                
                
                }.resume()
        }
        else {
            
            failure(RequestError.FailURLMalformed)
        }
    }
}
