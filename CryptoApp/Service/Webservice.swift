//
//  Webservice.swift
//  CryptoApp
//
//  Created by Murad Yarmamedov on 31.10.23.
//

import Foundation

enum cryptoError: Error {
    case serverError
    case parsingError
}

class Webservice {
    
    func fetchData(url: URL, completion: @escaping (Result<[Crypto],cryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
               let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
    
}
