//
//  SimpleTableSectionViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/11/13.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class SimpleTableSectionViewController: UIViewController {
    
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
        
        
        
    }
}
