//
//  LaunchViewController.swift
//  ZhiHuDaily
//
//  Created by 俞诚恺 on 16/4/10.
//  Copyright © 2016年 sun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LaunchViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var drawerController: MMDrawerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 判断是否有缓存
        if let launchUrl = NSUserDefaults.standardUserDefaults().stringForKey("launchUrl") {
            backgroundView.sd_setImageWithURL(NSURL.init(string: launchUrl))
        }
        
        loadImageData()
    }
    
    // 加载图片数据
    private func loadImageData() {
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/start-image/720*1184").responseSwiftyJSON ({[unowned self] (request, Response, json, error) -> Void in
            
            guard error == nil else {
                SVProgressHUD.showErrorWithStatus(error.debugDescription)
                return
            }
            
            if json != .null {
                
                let dict = json.rawValue as! NSDictionary
                let url = dict["img"] as! String
                
                NSUserDefaults.standardUserDefaults().setObject(url, forKey: "launchUrl")
                self.backgroundView.sd_setImageWithURL(NSURL(string: url))
                
                // 图片放大 透明度渐变过程
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue(), {
                    
                    UIView.animateWithDuration(2.0, animations: {
                        self.backgroundView.alpha = 0.0
                        self.backgroundView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                        }, completion: { (_) in
                            self.setupViewController()
                    })
                })
            }
            
            })
    }
    
    // 设置首页及抽屉
    private func setupViewController() -> Void {
        let drawerVC = DrawerViewController()
        let mainVC = MainViewController()
        let nav = UINavigationController(rootViewController: mainVC)
        
        drawerController = MMDrawerController(centerViewController: nav, leftDrawerViewController: drawerVC)
        // 抽屉能滑出的距离
        drawerController.maximumLeftDrawerWidth = UIScreen.mainScreen().bounds.size.width * 0.6
        // 抽屉打开和关闭能使用的手势
        drawerController.openDrawerGestureModeMask = .All
        drawerController.closeDrawerGestureModeMask = .All
        
        // 设置抽屉出现及消失时透明度变化过程
        drawerController.setDrawerVisualStateBlock { (viewController, drawerSide, alpha) in
            
            var drawerVC: UIViewController?
            if drawerSide == MMDrawerSide.Left {
                drawerVC = viewController.leftDrawerViewController;
            }
            drawerVC?.view.alpha = alpha
        }
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = drawerController
        
    }
    
}

    

