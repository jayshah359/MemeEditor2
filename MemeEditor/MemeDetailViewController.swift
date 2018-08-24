//
//  MemeDetailViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/23/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, MemeDetailAndEditor {
	
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	
	var currentMeme: MemeModel? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detailToEditorSegue" {
			let editorController = segue.destination as! MemeEditorViewController
			editorController.currentMeme = self.currentMeme
		}
	}
}

protocol MemeDetailAndEditor {
	var memeImage: UIImageView! { get set }
	var bottomTextField: UITextField! { get set }
	var topTextField: UITextField! { get set }
	var currentMeme: MemeModel? { get set }
	func configureText(textField: UITextField, withText text: String, withSize size: CGFloat)
	func setupView(withFontSize size: CGFloat)
}

extension MemeDetailAndEditor {
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
	
	func setupView(withFontSize size: CGFloat = 40) {
		configureText(textField: topTextField, withText: currentMeme?.topText ?? "TOP", withSize: size)
		configureText(textField: bottomTextField, withText: currentMeme?.bottomText ?? "BOTTOM", withSize: size)
		memeImage.image = currentMeme?.originalImage
	}
}
