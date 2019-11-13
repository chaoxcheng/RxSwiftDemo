//
//  ImagePickerViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/11/13.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ImagePickerViewController: UIViewController {
    
    var imageView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .orange
        return temp
    }()
    
    var galleryButton: UIButton = {
        let temp = UIButton(type: .system)
        temp.setTitle("gallery", for: .normal)
        return temp
    }()
    
    var cropButton: UIButton = {
        let temp = UIButton(type: .system)
        temp.setTitle("crop", for: .normal)
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupAndLayoutSubviews()
        setupMapLatest()
    }
    
    func setupAndLayoutSubviews() {
        view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(300);
        }
        
        view.addSubview(galleryButton)
        galleryButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(imageView.snp_bottom).offset(50)
        }
        
        view.addSubview(cropButton)
        cropButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(galleryButton.snp_bottom).offset(50)
        }
    }
    
    func setupMapLatest() {
        
    }
    
}
