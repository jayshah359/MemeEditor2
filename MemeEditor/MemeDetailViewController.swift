//
//  MemeDetailViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/23/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, UITextFieldDelegate {
	
//	@IBOutlet weak var memeImage: UIImageView!
//	@IBOutlet weak var bottomTextField: UITextField!
//	@IBOutlet weak var topTextField: UITextField!
	
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	
	var currentMeme: MemeModel? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureText(textField: topTextField, withText: currentMeme?.topText ?? "TOP")
		configureText(textField: bottomTextField, withText: currentMeme?.bottomText ?? "BOTTOM")
		memeImage.image = currentMeme?.originalImage
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		topTextField.isEnabled = false
		bottomTextField.isEnabled = false
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detailToEditorSegue" {
			let editorController = segue.destination as! MemeEditorViewController
			editorController.currentMeme = self.currentMeme
		}
	}
	
	// Format the selected textField with Meme styling and center it, set self as the delegate
	func configureText(textField: UITextField, withText text: String) {
		// Define the text attributes for the meme text. black stroke, white text, Helvetica font
		// -3.0 stroke width needed for the stroke to apply to the exterior so the font color will work
		let memeTextAttributes:[String:Any] = [
			NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
			NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
			NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
			NSAttributedStringKey.strokeWidth.rawValue: -3.0]
		textField.defaultTextAttributes = memeTextAttributes
		textField.textAlignment = .center
		textField.text = text
		textField.delegate = self
	}
}
