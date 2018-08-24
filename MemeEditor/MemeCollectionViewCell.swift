//
//  MemeCollectionViewCell.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/29/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

// Defines the cell used in the Meme collection view. Conforms to MemeDetailAndEditor
// so it can configure the text fields and image
class MemeCollectionViewCell: UICollectionViewCell, MemeDetailAndEditor {
	// MARK: IBOutlets for UI Elements
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	
	// MARK: Properties
	// Stores the currently displayed Meme
	var currentMeme: MemeModel?
}
