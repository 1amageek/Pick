//
//  AssetsViewCell.swift
//  Pick
//
//  Created by 1amageek on 2017/09/01.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class AssetsViewCell: UICollectionViewCell {

    private(set) var imageView: UIImageView = {
        let view: UIImageView = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundColor = UIColor.lightGray
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.layer.borderWidth = 0
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
    }

    override public var isSelected: Bool {
        didSet {
            self.imageView.layer.borderWidth = isSelected ? 4 : 0
        }
    }
}
