//
//  MemeCollectionFlowLayout.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 8/22/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

// This subclass of UICollectionViewFlowLayout allows us to customize the item size of the collection view
class MemeCollectionViewFlowLayout: UICollectionViewFlowLayout {
	// MARK: Properties
	// Define the interitem and line spacing as well as the minimum cell size
	let space: CGFloat = 3.0
	let minColumnWidth: CGFloat = 125.0
	
	// MARK: Override functions
	// Prepare will be called when the bounds are invalidated (on rotate or resize) so we can recalculate
	// cell size
	override func prepare() {
		super.prepare()
		
		guard let cv = collectionView else { return }

		// get the new bounds' width, div by the min col width to know how many columns, then  determine
		// exact column width
		let cvWidth = cv.bounds.insetBy(dx: cv.layoutMargins.left, dy: cv.layoutMargins.top).width
		let maxNumColumns = Int(cvWidth / minColumnWidth)
		let cellSize = (cvWidth / CGFloat(maxNumColumns)).rounded(.down)
		
		// set cell size to computed new width, set spacing and insets too
		self.itemSize = CGSize(width: cellSize, height: cellSize)
		self.minimumInteritemSpacing = space
		self.minimumLineSpacing = space
		self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
		self.sectionInsetReference = .fromSafeArea
	}
}
