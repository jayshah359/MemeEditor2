//
//  MemeCollectionFlowLayout.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 8/22/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeCollectionViewFlowLayout: UICollectionViewFlowLayout {
	let space: CGFloat = 3.0
	let minColumnWidth: CGFloat = 125.0
	
	override func prepare() {
		super.prepare()
		
		guard let cv = collectionView else { return }

		let cvWidth = cv.bounds.insetBy(dx: cv.layoutMargins.left, dy: cv.layoutMargins.top).width
		let maxNumColumns = Int(cvWidth / minColumnWidth)
		let cellSize = (cvWidth / CGFloat(maxNumColumns)).rounded(.down)
		
		self.itemSize = CGSize(width: cellSize, height: cellSize)
		self.minimumInteritemSpacing = space
		self.minimumLineSpacing = space
		self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
		self.sectionInsetReference = .fromSafeArea
	}
}
