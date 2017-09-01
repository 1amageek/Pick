//
//  AssetsViewController.swift
//  Pick
//
//  Created by 1amageek on 2017/09/01.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class AssetsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public class Option {
        var numberOfColumnsInRow: Int = 3
        var limitOfSelection: Int = 4
    }

    public var options: Option = Option() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var dataSource: DataSourceProtocol?

    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let view: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.allowsMultipleSelection = true
        view.register(AssetsViewCell.self, forCellWithReuseIdentifier: "AssetsViewCell")
        return view
    }()

    public override func loadView() {
        super.loadView()
        self.view.addSubview(collectionView)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }

    @objc private func cancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc private func add() {
        
    }

    // MARK: -

    public var isLimited: Bool {
        return (collectionView.indexPathsForSelectedItems?.count ?? 0) >= self.options.limitOfSelection
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !self.isLimited
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isLimited {
            self.reloadVisbleCells()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (collectionView.indexPathsForSelectedItems?.count ?? 0) == self.options.limitOfSelection - 1 {
            self.reloadVisbleCells()
        }
    }

    public func reloadVisbleCells() {
        self.collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell: AssetsViewCell = self.collectionView.cellForItem(at: indexPath) as! AssetsViewCell
            self._configure(cell: cell, at: indexPath)
        }
    }

    // MARK: -

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AssetsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetsViewCell", for: indexPath) as! AssetsViewCell
        self._configure(cell: cell, at: indexPath)
        return cell
    }

    private func _configure(cell: AssetsViewCell, at indexPath: IndexPath) {
        let indexPaths: [IndexPath] = collectionView.indexPathsForSelectedItems ?? []
        if isLimited {
            cell.alpha = !indexPaths.contains(indexPath) ? 0.5 : 1
        } else {
            cell.alpha = 1
        }
    }

    // MARK: -

    private var margin: CGFloat {
        let numberOfColumnsInRow: CGFloat = CGFloat(self.options.numberOfColumnsInRow)
        return UIScreen.main.bounds.width.truncatingRemainder(dividingBy: numberOfColumnsInRow) == 0 ? 1 : 1.5
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumnsInRow: CGFloat = CGFloat(self.options.numberOfColumnsInRow)
        let spacing: CGFloat = margin * (numberOfColumnsInRow - 1)
        let side: CGFloat = (UIScreen.main.bounds.width - spacing) / numberOfColumnsInRow
        return CGSize(width: side, height: side)
    }
}
