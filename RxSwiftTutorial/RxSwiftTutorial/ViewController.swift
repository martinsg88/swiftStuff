//
//  ViewController.swift
//  RxSwiftTutorial
//
//  Created by Guilherme Martins on 2021/03/07.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    let justObservable = Observable.just("Hello RxSwift")
    let arrayObservable = Observable.from([1,2,3])
    let dictionaryObservable = Observable.from([1:"Hello",2:"Rx"])
    let bag = DisposeBag()

    
    override func viewDidLoad() {
        setupObservables()
        super.viewDidLoad()
    }
    
    private func setupObservables() {
        let dictionarySubscribe = dictionaryObservable
            .subscribe{ event in
                print(event)
            }.disposed(by: bag)
        
        let arraySubscription = arrayObservable
            .subscribe { event in
                switch event {
                case .next(let value):
                    print(value)
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            }.disposed(by: bag)
    }
}

