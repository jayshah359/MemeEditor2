//
//  MemeStructModel.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 3/19/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

// Struct to store Meme
struct MemeModel {
	// MARK: Properties
	// Basic info includes the text from the top and bottom lines, the original image and once constructed
	// and saved, the final memed image
	let topText: String
	let bottomText: String
	let originalImage: UIImage
	let memedImage: UIImage?
}

// This extension adds static variable allMemes. An array of MemeModel objects
extension MemeModel {
	// MARK: Properties
	// Keys used build a pre-populated array of Memes
	static let TopTextKey = "TopText"
	static let BottomTextKey = "BottomText"
	static let ImageKey = "ImageKey"
	
	// Generate an array full of all of the pre-populated memes
	// Create and empty array first, then call the localMemeData function. Loop thru the results
	// and create a Meme for each item by using the keys to get the image, and top and bottom text
	// Store the Meme in the memeArray. If localMemeData returns an empty dictionary we won't have
	// any pre-populated Memes
	static var allMemes: [MemeModel] = {
		var memeArray = [MemeModel]()
		for d in MemeModel.localMemeData() {
			if let imageName = d[MemeModel.ImageKey],
				let image = UIImage(named: imageName),
				let topText = d[MemeModel.TopTextKey],
				let bottomText = d[MemeModel.BottomTextKey]	{
				memeArray.append(MemeModel(topText: topText, bottomText: bottomText, originalImage: image, memedImage: nil))
			}
		}
		return memeArray
	}()
	
	// MARK: Functions
	// Returns a hard-coded, prepopulated array of dictionaries, 1 per Meme. The image key refers to the image name in the
	// asset catalog. This is useful for testing or starting the app with some memes already listed in the sent memes
	// view, but for production we should return an empty array.
	static func localMemeData() -> [[String : String]] {
		return [
//			[MemeModel.TopTextKey : "Top Text 1", MemeModel.BottomTextKey : "Bottom Text 1",  MemeModel.ImageKey : "Image1"],
//			[MemeModel.TopTextKey : "Top Text 2", MemeModel.BottomTextKey : "Bottom Text 2",  MemeModel.ImageKey : "Image2"],
//			[MemeModel.TopTextKey : "Top Text 3", MemeModel.BottomTextKey : "Bottom Text 3",  MemeModel.ImageKey : "Image1"]
		]
	}
}
