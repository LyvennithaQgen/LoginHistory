//
//  NetworkLayer.swift
//  NewsApp
//
//  Created by Lyvennitha on 14/12/21.
//

import Foundation

class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    let baseURL = "http://app.dotnetethic.com/iOS/1.1.1/SVCs/WSUserService.svc/MobSignIn"
    
    func getContactList<T:Codable>(offset: String?=nil, onResponse: @escaping (Result<T, Error>)->()){
        isInternetAvailable(available: {
            let url = "\(self.baseURL)?offset=\(offset ?? "1")"
            var urlRequest = URLRequest(url: URL.init(string: url)!)
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                do{
                    let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json!, options: [.prettyPrinted, .withoutEscapingSlashes])
                    print("prettyPrint",String(decoding: jsonData!, as: UTF8.self))
                    let result = try JSONDecoder().decode(T.self, from: data!)
                    onResponse(.success(result))
                } catch {
                    onResponse(.failure(error))
                }
            }
            task.resume()
        }, onError: { error in
            onResponse(.failure(error))
        })
        
    }
    
    func postDetails<T:Codable>(parameters: [String: Any], onResponse: @escaping (Result<T, Error>)->()){
        isInternetAvailable(available: {
            let url = "\(self.baseURL)"
            var urlRequest = URLRequest(url: URL.init(string: url)!)
            urlRequest.httpMethod = "POST"
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            urlRequest.httpBody = httpBody
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                do{
                    if data != nil{
                        let json = try? JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as? [String: Any]
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                                    print("response = \(String(describing: response))")
                                }
                        let jsonData = try? JSONSerialization.data(withJSONObject: json!, options: [.prettyPrinted, .withoutEscapingSlashes])
                        print("prettyPrint",String(decoding: jsonData!, as: UTF8.self))
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .deferredToDate
                    let result = try decoder.decode(T.self, from: data!)
                    onResponse(.success(result))
                    }
                } catch {
                    onResponse(.failure(error))
                }
            }
            task.resume()
        }, onError: { error in
            onResponse(.failure(error))
        })
        
    }
    
    
    fileprivate func getError(code: Int, message: String) -> Error {
        return NSError(domain:"LoginHistory", code:code, userInfo:[NSLocalizedDescriptionKey: message])
    }
    
    fileprivate func isInternetAvailable(available: @escaping () -> (), onError: @escaping(Error) -> ()) {
        if let isInternetAvailable = try? Reachability().isReachable , isInternetAvailable {
            available()
        } else {
            onError(self.getError(code: URLError.Code.notConnectedToInternet.rawValue, message:  "Internet not available"))
        }
    }
}


