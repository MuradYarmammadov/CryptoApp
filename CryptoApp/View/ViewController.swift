//
//  ViewController.swift
//  CryptoApp
//
//  Created by Murad Yarmamedov on 30.10.23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var cryptoTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    let cryptoVM = CryptoViewModel()
    var cryptoList = [Crypto]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        cryptoTableView.backgroundColor = .black
        configureTableView()
        setupBindings()
        cryptoVM.requestData()
    }
    
    private func configureTableView(){
//        cryptoTableView.dataSource = self
        cryptoTableView.delegate = self
    }
    
    private func setupBindings(){
        
//        cryptoVM
//            .loading
//            .subscribe { bool in
//            if bool == true {
//                self.activityIndicatorView.startAnimating()
//            } else {
//                self.activityIndicatorView.stopAnimating()
//            }
//        }.disposed(by: disposeBag)
        
        cryptoVM
            .loading
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }.disposed(by: disposeBag)
        
//        cryptoVM
//            .crypoList
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptoList in
//                self.cryptoList = cryptoList
//                self.cryptoTableView.reloadData()
//            }.disposed(by: disposeBag)
        
        cryptoVM
            .crypoList
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: cryptoTableView.rx.items(cellIdentifier: "cryptoCell", cellType: CryptoTableViewCell.self)) {row,item,cell in
                cell.item = item
            }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cryptoList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        var content = cell.defaultContentConfiguration()
//        content.text = cryptoList[indexPath.row].currency
//        content.secondaryText = cryptoList[indexPath.row].price
//        cell.contentConfiguration = content
//        return cell
//    }
//
//
//}

