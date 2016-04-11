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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let launchUrl = NSUserDefaults.standardUserDefaults().stringForKey("launchUrl") {
            backgroundView.sd_setImageWithURL(NSURL.init(string: launchUrl))
        }
        
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/start-image/720*1184").responseSwiftyJSON ({[unowned self] (request, Response, json, error) -> Void in
            
            
            if json != .null && error == nil{
                
                let dict = json.rawValue as! NSDictionary
                let url = dict["img"] as! String
                
                NSUserDefaults.standardUserDefaults().setObject(url, forKey: "launchUrl")
                self.backgroundView.sd_setImageWithURL(NSURL(string: url))
                
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue(), {
                    
                    UIView.animateWithDuration(2.0, animations: {
                        self.backgroundView.alpha = 0.0
                        self.backgroundView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                        }, completion: { (_) in
                            
                    })
                })
            }
            
            })
        
        }
    
}

    

