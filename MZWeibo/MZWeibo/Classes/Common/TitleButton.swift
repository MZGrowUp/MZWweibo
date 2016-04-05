//
//  TitleButton.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.sizeToFit()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("-----")
        /*
        titleLabel?.frame.offsetInPlace(dx: -imageView!.bounds.width, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.bounds.width, dy: 0)
*/
        titleLabel?.frame.origin.x = 0;
        imageView?.frame.origin.x = titleLabel!.frame.size.width
    }
}
