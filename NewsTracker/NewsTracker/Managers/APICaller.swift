//
//  APICaller.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 16/04/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
enum APIError: Error {
    case failedToGetData
}

struct Constants {
    
    static let apiKey = "95dcbad4cbf44c26845e8f30fb84424f"
    static let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
    
}

class APICaller {
    
    static let shared: APICaller = APICaller()
    var urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private init(){
        
    }
    
    func createRequest(with url: String, method: HTTPMethod) -> URLRequest? {
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method.rawValue
            return request
        }
        return nil
    }
    
    func executeRequest<T: Codable>(with request: URLRequest?, completionHandler: @escaping (Bool,T?) -> Void) {
        guard request != nil else {
            DispatchQueue.main.async {
                completionHandler(false, nil)
            }
            return
        }
        let dataTask = self.urlSession.dataTask(with: request!) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(false, nil)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(false, nil)
                }
                return
            }
            
            guard let resData = data else {
                DispatchQueue.main.async {
                    completionHandler(false, nil)
                }
                return
            }
//            let jsonObjc = try? JSONSerialization.jsonObject(with: resData, options: .mutableContainers)

            if let codableRepsone = try? JSONDecoder().decode(T.self, from: resData) {
                DispatchQueue.main.async {
                    completionHandler(true, codableRepsone)
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(false, nil)
                }
            }
        }
        dataTask.resume()
    }
    
}
