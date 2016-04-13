//
//  MainViewController.swift
//  ZhiHuDaily
//
//  Created by 俞诚恺 on 16/4/12.
//  Copyright © 2016年 sun. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, SDCycleScrollViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.alpha = 0
        navigationItem.title = "首页"
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self, action: #selector(MainViewController.chick))
        tableView.delegate = self
        tableView.dataSource = self
//        automaticallyAdjustsScrollViewInsets = false
        
        let imagesURLStrings = ["https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg","https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"
        ]
        let cycleScrollView = SDCycleScrollView.init(frame: CGRectMake(64, 0, view.bounds.size.width, 180), delegate: self, placeholderImage: nil)
        cycleScrollView.imageURLStringsGroup = imagesURLStrings
        tableView.tableHeaderView = cycleScrollView
        
    }
    
    func chick()  {
        let launchVC = mm_drawerController
        launchVC.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    
    
}
