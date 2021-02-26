//
//  FileSubviewsSkeletonables.swift
//  Yelpy
//
//  Created by Mark Falcone on 6/4/20.
//  Copyright © 2020 memo. All rights reserved.
//

//  Copyright © 2018 SkeletonView. Aopll rights reserved.
import UIKit
import SkeletonView

extension UIView {
    @objc var subviewsSkeletonables: [UIView] {
        return subviewsToSkeleton.filter { $0.isSkeletonable }
    }

    @objc var subviewsToSkeleton: [UIView] {
        return subviews
    }
}

extension UITableView {

    override var subviewsToSkeleton: [UIView] {
        return visibleCells
    }
}

extension UITableViewCell {

    override var subviewsToSkeleton: [UIView] {
        return contentView.subviews
    }
}

extension UICollectionView {

    override var subviewsToSkeleton: [UIView] {
        return subviews
    }
}

extension UICollectionViewCell {

    override var subviewsToSkeleton: [UIView] {
        return contentView.subviews
    }
}

extension UIStackView {

    override var subviewsToSkeleton: [UIView] {
        return arrangedSubviews
    }
}
