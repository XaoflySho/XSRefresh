//
//  NewCollectionViewCell.swift
//  Example
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.xs.cornerRadius = 5
        backView.xs.shadowRadius = 10
        backView.xs.shadowColor = .darkGray
        backView.xs.shadowOpacity = 0.6
        backView.xs.shadowOffset = .zero
    }

}
