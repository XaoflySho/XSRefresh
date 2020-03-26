//
//  NewCollectionViewController.swift
//  Example
//
//  Created by 邵晓飞 on 2020/3/25.
//  Copyright © 2020 zlucy. All rights reserved.
//

import UIKit
import XSRefresh

private let reuseIdentifier = "Cell"

class NewCollectionViewController: UIViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var dataSource: [UIColor] = {
        var array: [UIColor] = []
        for _ in 0 ..< 10 {
            array.append(self.randomColor())
        }
        
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "\(NewCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.xs.leader = XSRefreshStateLeader { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.collectionView.xs.leader?.endRefreshing()
            }
        }
        
        collectionView.xs.trailer = XSRefreshStateTrailer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.collectionView.xs.trailer?.endRefreshing()
            }
        }
    }

}

extension NewCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.xs.safeAreaSize
    }
    
}

extension NewCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewCollectionViewCell
        
        cell.backView.backgroundColor = dataSource[indexPath.item]
        
        return cell
    }
    
}

extension NewCollectionViewController: UICollectionViewDelegate {
    
}

extension NewCollectionViewController {
    
    func randomColor() -> UIColor {
        let r = CGFloat.random(in: 0 ..< 255)
        let g = CGFloat.random(in: 0 ..< 255)
        let b = CGFloat.random(in: 0 ..< 255)
        
        let color = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        
        return color
    }
    
}
