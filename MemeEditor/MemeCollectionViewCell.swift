//
//  MemeCollectionViewCell.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/29/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell, SentMemeViewCell {
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var textLabel: UILabel!
}

protocol SentMemeViewCell {
	var imageView: UIImageView? { get }
}
