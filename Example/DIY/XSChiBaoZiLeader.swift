//
//  XSChiBaoZiLeader.swift
//  Example
//
//  Created by 邵晓飞 on 2020/3/30.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

class XSChiBaoZiLeader: XSRefreshGifLeader {
    
    override func prepare() {
        super.prepare()

        xs.width = 64
        
        var idleImages: [UIImage] = []
        for i in 1 ... 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)") ?? UIImage()
            idleImages.append(image)
        }
        setImages(idleImages, for: .idle)

        var refreshingImages: [UIImage] = []
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)") ?? UIImage()
            refreshingImages.append(image)
        }
        setImages(refreshingImages, for: .pulling)

        setImages(refreshingImages, for: .refreshing)

    }

}
