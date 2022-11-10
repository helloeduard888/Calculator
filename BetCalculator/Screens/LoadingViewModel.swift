//
//  LoadingViewModel.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import Foundation

final class LoadingViewModel: ObservableObject {
    
    enum RequestResult: Codable {
        case proceedToWeb
        case proceedToApp
    }
    
    func makeRequest(completion: @escaping (RequestResult) -> Void) {
        let task = URLSession.shared.dataTask(with: Constants.getMainURL(includeParams: false)) { data, _, error in
            guard error == nil, let data = data, let string = String(data: data, encoding: .utf8)
            else {
                print(error?.localizedDescription)
                return completion(.proceedToApp)
            }
            print(string)
            completion(string == "0" ? .proceedToApp : .proceedToWeb)
        }
        task.resume()
    }
}
