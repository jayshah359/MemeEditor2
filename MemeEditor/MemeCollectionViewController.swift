//
//  MemeCollectionViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/15/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import Foundation
import UIKit

// Defines the Meme collection view controller. Conforms to SentMemeViewControllers protocol
// in order to store the selected item (for segue to the Meme detail view controller)
class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SentMemeViewControllers {
	// MARK: IBOutlets for UI Elements
	@IBOutlet weak var flowLayout: MemeCollectionViewFlowLayout!
	
	// MARK: Properties
	// Stores the selected item for segue to the Meme detail view controller
	var selectedItem: Int?
	
	// MARK: Override functions
	// Determines the number of rows simply by counting all the items in the MemeModel
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return MemeModel.allMemes.count
	}
	
	// When selecting a row, save it for the segue, and have the containing Tab bar controller do the segue
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		sentMemeView(didSelectItemAt: indexPath)
	}
	
	// To get the cell, look up the specific Meme, deque the cell and setup the image and text from the Meme
	// MemeDetailAndEditor protocol conformance on the cell allows use of the setupView function
	// A smaller font size of 12 is used instead of the default 40
	// If the Meme contains a final memedImage, we can hide the text and use that image
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let meme = MemeModel.allMemes[(indexPath as NSIndexPath).row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
		cell.currentMeme = meme
		cell.setupView(withFontSize: 12)
		if let memedImage = meme.memedImage {
			cell.memeImage.image = memedImage
			cell.bottomTextField.isHidden = true
			cell.topTextField.isHidden = true
		}
		return cell
	}
}
