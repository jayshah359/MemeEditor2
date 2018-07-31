//
//  ViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 10/5/17.
//  Copyright © 2017 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, MemeDetailAndEditor, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
	
	// MARK: IBOutlets for UI Elements
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	@IBOutlet weak var cameraButton: UIBarButtonItem!
	@IBOutlet weak var toolBar: UIToolbar!
	
	
	// MARK: Properties
	var currentMeme: MemeModel? = nil

	// Variable to keep track of active text field to be used to slide up current view
	var activeTextField: UITextField?
	
	// MARK: UIImagePickerControllerDelegate functions
	// Handles user cancellation of image picker
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
	// Handles setting the image when the user uses the image picker
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			memeImage.image = image
			activateShareButton()
			
		}
		dismiss(animated: true, completion: {
			UIViewController.attemptRotationToDeviceOrientation()
		})

	}
	
	// MARK: UITextFieldDelegate functions
	// On return from a text field, resign the fist responder
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		activateShareButton()
		return true
	}
	
	// If editing in a text field, note the active text field and if it has the default text in order to clear the default
	// text value. keyboardWillShow() will make use of the activeTextField
	func textFieldDidBeginEditing(_ textField: UITextField) {
		activeTextField = textField
		if (textField == topTextField && textField.text == "TOP") || (textField == bottomTextField && textField.text == "BOTTOM") {
			textField.text = ""
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		// Set up default text field values
		setupView()
		topTextField.delegate = self
		bottomTextField.delegate = self
//		shareButton.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		// enable the camera button if possible, subscribe to keyboard notifications
		cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
		subscribeToKeyboardNotifications()
//		topTextField.isEnabled = true
//		bottomTextField.isEnabled = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		unsubscribeFromKeyboardNotifications()
	}
	
	@objc func keyboardWillShow(_ notification: Notification) {
		// when the keyboard activates, look at the activeTextField in order to shift the view up if needed for
		// the bottom text field.
		if activeTextField == bottomTextField {
			view.frame.origin.y = -getKeyboardHeight(notification)
		} else {
			view.frame.origin.y = 0
		}
	}
	
	@objc func keyboardWillHide(_ notifcation: Notification) {
		// Shift the view back when the keyboard hides
		view.frame.origin.y = 0
	}
	
	// Calculate the keyboard height in order to shift the view if needed.
	func getKeyboardHeight(_ notification: Notification) -> CGFloat {
		if let keyboardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
			return keyboardSize.cgRectValue.height
		} else {
			return CGFloat(0)
		}
	}
	
	func subscribeToKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
	}
	
	func unsubscribeFromKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
	}
	
	// MARK: IBAction functions
	// Pick image from library
	@IBAction func pickImage(_ sender: Any) {
		configureImagePicker(with: .photoLibrary)
	}
	
	// Pick image from Camera
	@IBAction func pickImageFromCamera(_ sender: Any) {
		configureImagePicker(with: .camera)
	}
	
	// Create image picker and present it, using the sourceType parameter to determine the sourceType
	func configureImagePicker(with sourceType: UIImagePickerControllerSourceType) {
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = sourceType
		imagePickerController.delegate = self
		present(imagePickerController, animated: true, completion: nil)
	}
	
	// Share button pressed
	@IBAction func shareMeme(_ sender: Any) {
		// Generate the meme Image
		let memedImage = generateMemedImage()
		let shareViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
		// on completion of sharing the meme, save the meme
		shareViewController.completionWithItemsHandler = { (_,successful,_,_) in
			if successful {
				// call save method here
				self.saveMeme(with: memedImage)
				// Pop View Controller and return to sent memes view controller

				self.performSegue(withIdentifier: "unwindFromEditorSegue", sender: self)

			}
		}
		// Present the share view controller
		present(shareViewController, animated: true)
	}
	
	// Save the memedImage, text and original image into memeModel.
	func saveMeme(with memedImage: UIImage) {
		let memeModel = MemeModel(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.memeImage.image!, memedImage: memedImage)
		MemeModel.allMemes.append(memeModel)
	}
	
	// Cancel button pressed
	@IBAction func cancelMeme(_ sender: Any) {
		// Reset the Meme Image and buttons, reset the text field values
//		memeImage.image = nil
//		shareButton.isEnabled = false
//		topTextField.text = "TOP"
//		bottomTextField.text = "BOTTOM"
		
		// Dismiss Keyboard
		topTextField.resignFirstResponder()
		bottomTextField.resignFirstResponder()
		
		// Pop View Controller and return to sent memes view controller
		self.performSegue(withIdentifier: "unwindFromEditorSegue", sender: self)
	}
	
	// Take the current display, hide the Nav bar and Tool bar, and resize the image as needed, in order to return an
	// image we can save that shows the whole Meme Image.
	func generateMemedImage() -> UIImage {
		
		toggleBars()
		
		// Render view to an image
		UIGraphicsBeginImageContext(self.view.frame.size)
		view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
		let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		toggleBars()
		
		return memedImage
	}
	
	func toggleBars() {
		//var navHeight: CGFloat = 0.0
		let navBar = navigationController?.navigationBar
		let navHeight = navBar?.frame.size.height ?? 0.0
		let toolHeight = toolBar.frame.size.height
		if toolBar.isHidden {
			navBar?.isHidden = false
			toolBar.isHidden = false
			memeImage.frame.origin.y += navHeight
			memeImage.frame.size.height -= navHeight + toolHeight
		} else {
			navBar?.isHidden = true
			toolBar.isHidden = true
			memeImage.frame.origin.y -= navHeight
			memeImage.frame.size.height += navHeight + toolHeight
		}
	}
	
	func activateShareButton() {
		if let currentMeme = currentMeme {
			if (memeImage.image != currentMeme.originalImage || topTextField.text != currentMeme.topText || bottomTextField.text != currentMeme.bottomText) {
				shareButton.isEnabled = true
			} else {
				shareButton.isEnabled = false
			}
		} else if (memeImage.image != nil && topTextField.text != "TOP" && bottomTextField.text != "BOTTOM") {
			shareButton.isEnabled = true
		} else {
			shareButton.isEnabled = false
		}
	}
}

