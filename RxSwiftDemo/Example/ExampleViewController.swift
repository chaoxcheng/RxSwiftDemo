//
//  ExampleViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/11/12.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ExampleViewController: UIViewController {
    
    enum RxDemoError: Error {
        case anError
    }
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let block = { (name: String) in
            print("my name is \(name)")
        }
        
        block("cc")
        
        let message: Observable<String> = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("😊")
            observer.onNext("😊xx")
            observer.onNext("😊xxx")
            observer.onError(RxDemoError.anError)
            observer.onCompleted()
            return Disposables.create()
        }
        
        message.subscribe(onNext: { (name) in
            print(name)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("完成")
        }) {
            print(self.disposeBag)
        }
        
    }
}
