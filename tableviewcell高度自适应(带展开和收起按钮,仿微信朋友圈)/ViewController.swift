//
//  ViewController.swift
//  tableviewcell高度自适应(带展开和收起按钮,仿微信朋友圈)
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 80, height: 50))
        view.addSubview(btn)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }
    
    @objc func clickBtn() {
        let vc = SMCListsVC()
        self.present(vc, animated: true) {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

