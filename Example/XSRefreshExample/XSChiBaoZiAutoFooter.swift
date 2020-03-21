//
//  XSChiBaoZiAutoFooter.swift
//  XSRefreshExample
//
//  Created by 邵晓飞 on 2020/3/22.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class XSChiBaoZiAutoFooter: XSRefreshAutoGifFooter {
    
    override func prepare() {
        super.prepare()
        
        var refreshingImages: [UIImage] = []
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)") ?? UIImage()
            refreshingImages.append(image)
        }        
        setImages(refreshingImages, for: .refreshing)
    }

}
