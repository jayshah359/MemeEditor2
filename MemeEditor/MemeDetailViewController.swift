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
//		topTextField.isEnabled = false
//		bottomTextField.isEnabled = false
	}
	
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//
//	}
	
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
	func configureText(textField: UITextField, withText text: String)
	func setupView()
}

extension MemeDetailAndEditor {
	// Format the selected textField with Meme styling and center it
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
		//textField.delegate = self
	}
	
	func setupView() {
		configureText(textField: topTextField, withText: currentMeme?.topText ?? "TOP")
		configureText(textField: bottomTextField, withText: currentMeme?.bottomText ?? "BOTTOM")
		memeImage.image = currentMeme?.originalImage
	}
}
