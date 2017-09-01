//
//  DataSource.swift
//  Pick
//
//  Created by 1amageek on 2017/09/01.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

@objc public protocol DataSourceProtocol: class, UICollectionViewDataSource {
    func configure(cell: AssetsViewCell, at indexPath: IndexPath)
}

//extension DataSourceProtocol where Self: NSObject {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: AssetsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetsViewCell", for: indexPath) as! AssetsViewCell
//        self.configure(cell: cell, at: indexPath)
//        return cell
//    }
//}

public class DataSource: NSObject, DataSourceProtocol {

    public override init() {
        
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AssetsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetsViewCell", for: indexPath) as! AssetsViewCell
        self.configure(cell: cell, at: indexPath)
        return cell
    }

    public func configure(_ collectionView: UICollectionView, cell: AssetsViewCell, at indexPath: IndexPath) {
        if let indexPaths: [IndexPath] = collectionView.indexPathsForSelectedItems, indexPaths.contains(indexPath) {
            cell.alpha = 0.5
        }
    }

    public func configure(cell: AssetsViewCell, at indexPath: IndexPath) {
        
    }

}
