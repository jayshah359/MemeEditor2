//
//  MemeStructModel.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 3/19/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeModel
// Struct to store meme when using save function and future functionality
struct MemeModel {
	// MARK: Properties
	let topText: String
	let bottomText: String
	let originalImage: UIImage
	let memedImage: UIImage?
}

// MARK: MemeModel (All Memes)
// This extension adds static variable allMemes. An array of MemeModel objects
extension MemeModel {
	
	static let TopTextKey = "TopText"
	static let BottomTextKey = "BottomText"
	static let ImageKey = "ImageKey"
	
	// Generate an array full of all of the memes
	static var allMemes: [MemeModel] = {
		var memeArray = [MemeModel]()
		for d in MemeModel.localMemeData() {
			if let imageName = d[MemeModel.ImageKey],
				let image = UIImage(named: imageName),
				let topText = d[MemeModel.TopTextKey],
				let bottomText = d[MemeModel.BottomTextKey]
			{
				memeArray.append(MemeModel(topText: topText, bottomText: bottomText, originalImage: image, memedImage: nil))
			}
		}
		return memeArray
	}()
	
	static func localMemeData() -> [[String : String]] {
		return [
			[MemeModel.TopTextKey : "Top Text 1", MemeModel.BottomTextKey : "Bottom Text 1",  MemeModel.ImageKey : "Image1"],
			[MemeModel.TopTextKey : "Top Text 2", MemeModel.BottomTextKey : "Bottom Text 2",  MemeModel.ImageKey : "Image2"],
			[MemeModel.TopTextKey : "Top Text 3", MemeModel.BottomTextKey : "Bottom Text 3",  MemeModel.ImageKey : "Image1"]
		]
	}
}
