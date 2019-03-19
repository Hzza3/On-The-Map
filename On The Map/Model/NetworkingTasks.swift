//
//  NetworkingTasks.swift
//  On The Map
//
//  Created by Epic Systems on 3/4/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

class NetworkingTasks {
    
    // MARK: shared session
    var session = URLSession.shared
    
    // MARK: Shared Instances
    static func shared() -> NetworkingTasks {
        struct singlton {
            static var sharedInstance = NetworkingTasks()
        }
        return singlton.sharedInstance
    }
    
    // MARK: - Helpers
    enum APIType {
        case udacity
        case parse
    }
    
    
    // MARK: create a UDACITY URL from parameters
    func makeURLFromParameters(_ parameters: [String:AnyObject]? = nil, withPathExtension: String? = nil, apiType: APIType = .udacity) -> URL {
        
        var components = URLComponents()
        switch apiType {
            
        case .udacity:
            
            components.scheme = UdacityConstants.ApiScheme
            components.host = UdacityConstants.ApiHost
            components.path = UdacityConstants.ApiPath + (withPathExtension ?? "")
            
        case .parse:
            
            components.scheme = ParseConstants.ApiScheme
            components.host = ParseConstants.ApiHost
            components.path = ParseConstants.ApiPath + (withPathExtension ?? "")
            
        }
        
        components.queryItems = [URLQueryItem]()
        
        if let parameters = parameters {
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        
        return components.url!
    }
    
    // MARK: given raw JSON, return a usable Foundation object
    private func convertData(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: String?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            
            completionHandlerForConvertData(nil, "Could not parse the data as JSON: '\(data)'")
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    // MARK: Task For GET Method
    func getTask(url: URL, apiType: APIType = .udacity, completionHandlerForGetTask: @escaping (_ result: AnyObject?, _ error: String?) -> Void) -> URLSessionDataTask {
        
        let request = NSMutableURLRequest(url: url)
        
        if apiType == .parse {
            
            request.addValue(ParseConstants.ParseAPIJsonHeaderValue.ApplicationID, forHTTPHeaderField: ParseConstants.ParseAPIJsonHeaderKeys.ApplicationID)
            request.addValue(ParseConstants.ParseAPIJsonHeaderValue.APIKey, forHTTPHeaderField: ParseConstants.ParseAPIJsonHeaderKeys.APIKey)
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                completionHandlerForGetTask(nil, error)
            }
            
            guard (error == nil) else {
                sendError("request error")
                return
            }
            
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("wrong code")
                return
            }
            
            guard let data = data else {
                sendError("no data")
                return
            }
            
            if apiType == .udacity {
                let range = Range(5..<data.count)
                let newData = data.subdata(in: range)
                self.convertData(newData, completionHandlerForConvertData: completionHandlerForGetTask)
            } else {
                self.convertData(data, completionHandlerForConvertData: completionHandlerForGetTask)
            }
        }
        
        task.resume()
        
        return task
    }
    
    // MARK: Task For POST Method
    func postTask (apiType: APIType = .udacity, url: URL, jsonBody: String, completionHandlerForPostTask: @escaping (_ result: AnyObject?, _ error: String?) -> Void) -> URLSessionDataTask{
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        if apiType == .parse {
            
            request.addValue(ParseConstants.ParseAPIJsonHeaderValue.ApplicationID, forHTTPHeaderField: ParseConstants.ParseAPIJsonHeaderKeys.ApplicationID)
            request.addValue(ParseConstants.ParseAPIJsonHeaderValue.APIKey, forHTTPHeaderField: ParseConstants.ParseAPIJsonHeaderKeys.APIKey)
            request.addValue(ParseConstants.ParseAPIJsonHeaderValue.ContentType, forHTTPHeaderField: ParseConstants.ParseAPIJsonHeaderKeys.ContentType)

        } else {
            request.addValue(UdacityConstants.UdacityAPIJsonHeaderValue.Accept, forHTTPHeaderField: UdacityConstants.UdacityAPIJsonHeaderKeys.Accept)
            request.addValue(UdacityConstants.UdacityAPIJsonHeaderValue.ContentType, forHTTPHeaderField: UdacityConstants.UdacityAPIJsonHeaderKeys.ContentType)
        }
        
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                completionHandlerForPostTask(nil, error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {  //connection
                sendError("request error")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("wrong code")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("no data")
                return
            }
            
            if apiType == .udacity {
                
                let range = Range(5..<data.count)
                let newData = data.subdata(in: range)
                /* 5/6. Parse the data and use the data (happens in completion handler) */
                self.convertData(newData, completionHandlerForConvertData: completionHandlerForPostTask)
                
            } else {
                self.convertData(data, completionHandlerForConvertData: completionHandlerForPostTask)
            }
        }
        task.resume()
        return task
    }
    
    //MARK: - Task for delete method
    func deleteTask (apiType: APIType = .udacity, url: URL, completionHandlerForDeleteTask: @escaping (_ result: AnyObject?, _ error: String?) -> Void) -> URLSessionDataTask{
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                completionHandlerForDeleteTask(nil, error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {  //connection
                sendError("request error")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("wrong code")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("no data")
                return
            }
            
            if apiType == .udacity {
               
                let range = Range(5..<data.count)
                let newData = data.subdata(in: range)
                /* 5/6. Parse the data and use the data (happens in completion handler) */
                self.convertData(newData, completionHandlerForConvertData: completionHandlerForDeleteTask)
                
            } else {
                self.convertData(data, completionHandlerForConvertData: completionHandlerForDeleteTask)
            }
            
            
        }
        task.resume()
        return task
    }
    
}
