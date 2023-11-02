//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Murad Yarmamedov on 31.10.23.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let crypoList: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().fetchData(url: url) { result in
            self.loading.onNext(false)
            switch result{
            case .success(let crypoList):
                self.crypoList.onNext(crypoList)
            case .failure(let error):
                switch error{
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}
