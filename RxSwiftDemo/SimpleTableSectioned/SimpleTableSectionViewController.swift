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
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                1.0,
                2.0,
                3.0
            ]),
            SectionModel(model: "Second section", items: [
                1.0,
                2.0,
                3.0
            ]),
            SectionModel(model: "Third section", items: [
                1.0,
                2.0,
                3.0
            ])
        ])
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, self.dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                print("Tapped `\(pair.1)` @ \(pair.0)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx
        .setDelegate(self)
        .disposed(by: disposeBag)
        
    }
}

extension SimpleTableSectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
