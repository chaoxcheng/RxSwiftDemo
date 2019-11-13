//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/10/16.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let dataSource = ["Example",
                      "Numbers",
                      "SimpleValidation",
                      "ImagePicker",
                      "SimpleTable"]
    
    let mapSource = ["ExampleViewController",
                     "NumbersViewController",
                     "SimpleValidationViewController",
                     "ImagePickerViewController",
                     "SimpleTableViewController"]
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect.zero, style: .plain)
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        temp.dataSource = self
        temp.delegate = self
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let string = mapSource[indexPath.row]
        // 1. 获取命名空间(CFBundleExecutable这个键对应的值就是项目名称,也就是命名空间)
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
               return
        }
        // 2. 将字符串转化为类
        let name = nameSpace + "." + string
        guard let cls = NSClassFromString(name) else {
               return
        }
                    
        // 3. 将anyClass转换为指定的类型
        guard let vcCls = cls as? UIViewController.Type else {
              return
        }
        let vc = vcCls.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
