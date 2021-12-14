//
//  LoginViewModel.swift
//  LoginHistory
//
//  Created by Lyvennitha on 14/12/21.
//

import Foundation
class LoginViewModel {
    
    class func getDetails(parameters: [String: Any], onResponse: @escaping (Result<LoginDataResponse, Error>)->()) {
        LoginModelAPI.getDetails(parameter: parameters) { result in
            switch result{
            case .success(let data):
                onResponse(.success(data))
            case .failure(let err):
                onResponse(.failure(err))
                
            }
        }
    }
}
