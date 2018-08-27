//
//  ViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 10/5/17.
//  Copyright © 2017 Jaydev Shah. All rights reserved.
//

import UIKit

// The MemeEditorViewController shows a Meme in full and allows the user to edit it
// or it display a blank screen for creation of a new Meme. Conformance with the
// MemeDetailAndEditor protocol enables functionality that is common between the
// detail and editor view controllers (also the cell in the Meme collection view
// controller
class MemeEditorViewController: UIViewController, MemeDetailAndEditor, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
	
	// MARK: IBOutlets for UI Elements
	@IBOutlet weak var memeImage: UIImageView!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	@IBOutlet weak var cameraButton: UIBarButtonItem!
	@IBOutlet weak var toolBar: UIToolbar!
	
	// MARK: Properties
	// Store the current Meme for display
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
		dismiss(animated: true) { UIViewController.attemptRotationToDeviceOrientation() }
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
	
	// Helper function called when the textfields are edited or the image is set
	// if we're editing, then make sure at least one element has been changed
	// otherwise if we're making a new Meme, make sure all 3 elements have been set
	// before enabling the share button
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
	
	// MARK: Override functions
	// Use the setupView function to help with initial setup
	override func viewDidLoad() {
		super.viewDidLoad()
		// Set up default text field values using the MemeDetailAndEditor protocol
		setupView()
		topTextField.delegate = self
		bottomTextField.delegate = self
	}
	
	// Subscribe to keyboard notifications and enable the camera button on appear
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		// enable the camera button if possible, subscribe to keyboard notifications
		cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
		subscribeToKeyboardNotifications()
	}
	
	// On disappear, unsubscribe to keyboard notifications
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		unsubscribeFromKeyboardNotifications()
	}
	
	// Shift the screen if necessary
	@objc func keyboardWillShow(_ notification: Notification) {
		// when the keyboard activates, look at the activeTextField in order to shift the view up if needed for
		// the bottom text field.
		if activeTextField == bottomTextField {
			view.frame.origin.y = -getKeyboardHeight(notification)
		} else {
			view.frame.origin.y = 0
		}
	}
	
	// Shift the screen back
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
	
	// Use NotificationCenter to add UIKeyboardWillShow/Hide observers, tie them to the keyboardWillShow
	// and keyboardWillHide methods
	func subscribeToKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
	}
	
	// Unsubscribe from keyboard notifications
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
	
	// Helper function to create image picker and present it, using the sourceType parameter
	// to determine the sourceType
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
				// Use unwind segue to unwind to sent memes view controller (actually to the containing
				// tab bar view controller)
				self.performSegue(withIdentifier: "unwindFromEditorSegue", sender: self)
			}
		}
		// Present the share view controller
		present(shareViewController, animated: true)
	}
	
	// Cancel button pressed
	@IBAction func cancelMeme(_ sender: Any) {
		// Dismiss Keyboard
		topTextField.resignFirstResponder()
		bottomTextField.resignFirstResponder()
		// Use unwind segue to unwind to sent memes view controller (actually to the containing
		// tab bar view controller)
		self.performSegue(withIdentifier: "unwindFromEditorSegue", sender: self)
	}
	
	// Helper function to save the memedImage, text and original image into memeModel and then append
	// the memeModel to the allMemes array
	func saveMeme(with memedImage: UIImage) {
		let memeModel = MemeModel(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.memeImage.image!, memedImage: memedImage)
		MemeModel.allMemes.append(memeModel)
	}
	
	// Helper function to generate memed image.
	// Take the current display, hide the Nav bar and Tool bar, and resize the image as needed, in order
	// to return an image we can save that shows the whole Meme Image.
	func generateMemedImage() -> UIImage {
		toggleBars()
		
		// Render view to an image
		UIGraphicsBeginImageContext(self.view.frame.size)
		view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
		let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		toggleBars()
		
		return memedImage
	}
	
	// Helper function to show and hide toolbars for generating memed Image
	func toggleBars() {
		// navBar should always exist, but treat it as optional in case we go back to a single
		// view controller like in MemeEditor 1.0
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
}
