//
//  DiscoverTableViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !userLogin
        {
            visitorView?.setUpVisitorViewInfo(false, imageName: "visitordiscover_image_message", message: "")
        }

    }
}
