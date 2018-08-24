//
//  MemeDetailViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/23/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

// The MemeDetailViewController simply shows the Meme in full. Conformance with the
// MemeDetailAndEditor protocol enables functionality that is common between the
// detail and editor view controllers (also the cell in the Meme collection view
// controller
class MemeDetailViewController: UIViewController, MemeDetailAndEditor {	
	// MARK: IBOutlets for UI Elements
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	
	// MARK: Properties
	// Store the current Meme for display
	var currentMeme: MemeModel? = nil
	
	// MARK: Override functions
	// Use the MemeDetailAndEditor protocol's setupView function to set the text and image
	// from the currentMeme
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	// If we hit the edit button, segue to the editor view controller
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detailToEditorSegue" {
			let editorController = segue.destination as! MemeEditorViewController
			editorController.currentMeme = self.currentMeme
		}
	}
}

// This protocol defines common properties and functions that the detail and editor view
// controllers both have
protocol MemeDetailAndEditor {
	// MARK: IBOutlets for UI Elements
	// Bottom and top text fields, and the main image view
	var memeImage: UIImageView! { get set }
	var bottomTextField: UITextField! { get set }
	var topTextField: UITextField! { get set }
	// MARK: Properties
	// Stores the current Meme
	var currentMeme: MemeModel? { get set }
	
	// MARK: Functions
	// setupView loads the image and textfields with values from the currentMeme if present
	// if not, it uses the default text values. configureText sets the fornt and colors, etc
	func configureText(textField: UITextField, withText text: String, withSize size: CGFloat)
	func setupView(withFontSize size: CGFloat)
}

// This extension provides default implementations of the configureText and setupView functions
// We don't need to override these
extension MemeDetailAndEditor {
	// MARK: Functions
	// Format the selected textField with Meme styling and center it
	func configureText(textField: UITextField, withText text: String, withSize size: CGFloat) {
		// Define the text attributes for the meme text. black stroke, white text, Helvetica font
		// -3.0 stroke width needed for the stroke to apply to the exterior so the font color will work
		let memeTextAttributes:[String:Any] = [
			NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
			NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
			NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: size)!,
			NSAttributedStringKey.strokeWidth.rawValue: -3.0]
		textField.defaultTextAttributes = memeTextAttributes
		textField.textAlignment = .center
		textField.text = text
	}
	
	// Pulls the values from the current Meme. Handles the empty current Meme case for the editor
	// view controller as well as using a default size of 40.
	func setupView(withFontSize size: CGFloat = 40) {
		configureText(textField: topTextField, withText: currentMeme?.topText ?? "TOP", withSize: size)
		configureText(textField: bottomTextField, withText: currentMeme?.bottomText ?? "BOTTOM", withSize: size)
		memeImage.image = currentMeme?.originalImage
	}
}
