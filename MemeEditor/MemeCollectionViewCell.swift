//
//  MemeCollectionViewCell.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/29/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell, MemeDetailAndEditor {
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	var currentMeme: MemeModel?
}
