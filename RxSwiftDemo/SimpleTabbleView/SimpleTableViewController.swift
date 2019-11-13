//
//  SimpleTableViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/11/13.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class SimpleTableViewController: UIViewController, UITableViewDelegate {
    
    var disposeBag = DisposeBag()
    
    var tableView: UITableView = {
        let temp = UITableView(frame: .zero, style: .plain)
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element , cell) in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { (value) in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
    }

}
