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
        
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/start-image/720*1184").responseData { (response) in
            
            switch response.result {
            case .Success :
                if let value = response.result.value {
                    let json = JSON(value)
                    let url = json["img"]
                    print("JSON: \(url)")
                }
            case .Failure(let error) :
                
            }
        }
    }
    
    
}
