//
//  ProfileTableViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !userLogin
        {
            visitorView?.setUpVisitorViewInfo(false, imageName: "visitordiscover_image_profile", message: "")
        }
    }
}
