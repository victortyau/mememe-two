//
//  ImageController.swift
//  mememe-two
//
//  Created by Victor Tejada Yau on 07/31/21.
//

import UIKit

class ImageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {

      @IBOutlet weak var topMessage: UITextField!
      @IBOutlet weak var bottomMessage: UITextField!
      @IBOutlet weak var imagePickerView: UIImageView!
      @IBOutlet var cameraButton: UIBarButtonItem!
      @IBOutlet weak var topBar: UIToolbar!
      @IBOutlet weak var bottomBar: UIToolbar!
    
      let imagePicker = UIImagePickerController()
      let memeTextAttributes: [NSAttributedString.Key: Any] = [
          NSAttributedString.Key.strokeColor: UIColor.black  /* TODO: fill in appropriate UIColor */,
          NSAttributedString.Key.foregroundColor: UIColor.white /* TODO: fill in appropriate UIColor */,
          NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
          NSAttributedString.Key.strokeWidth: -2.0 /* TODO: fill in appropriate Float */
      ]
      
      let buttonTags = ["TOP", "BOTTOM"]
      
      override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
         
          topMessage.text = buttonTags[0]
          setupTextField(textField: topMessage)
          
          bottomMessage.text = buttonTags[1]
          setupTextField(textField: bottomMessage)
          
          imagePicker.delegate = self
          
          cameraButton.isEnabled = UIImagePickerController.availableMediaTypes(for: .camera) != nil
      }
      
      func setupTextField(textField: UITextField) {
          textField.defaultTextAttributes = memeTextAttributes
          textField.textAlignment = .center
          textField.delegate = self
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          subscribeToKeyboardNotifications()
      }
      
      @IBAction func pickAnImage(_ sender: Any) {
          imagePicker.sourceType = .photoLibrary
          present(imagePicker, animated: true, completion: nil)
      }
      
      @IBAction func takePhoto(_ sender: Any) {
          let camera = UIImagePickerController()
          camera.sourceType = .camera
          camera.allowsEditing = true
          present(camera, animated: true, completion: nil)
      }
      
      @IBAction func onShare(_ sender: Any) {
          print("#padentro")
          let meme = generatedMemedImage()
          
          let uiController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
          uiController.completionWithItemsHandler = {
              (activity, completed, items, error) in
              if completed {
                  self.save()
              }
          }
          present(uiController, animated: true, completion: nil)
      }
      
      @IBAction func onCancel(_ sender: Any) {
          topMessage.text = buttonTags[0]
          bottomMessage.text = buttonTags[1]
          self.imagePickerView.image = nil
      }
      
      func save() {
          let meme = generatedMemedImage()
          let current_meme = Meme(top: topMessage.text!, bottom: bottomMessage.text!, image: imagePickerView.image, memeImage: meme)
          (UIApplication.shared.delegate as! AppDelegate).memes.append(current_meme)
      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              imagePickerView.image = pickedImage
          }
          dismiss(animated: true, completion: nil)
      }
      
      func imagePickerControllerDidCancel(_: UIImagePickerController) {
             dismiss(animated: true, completion: nil)
      }
      
      func textFieldDidBeginEditing(_ textField: UITextField) {
          if textField.text == buttonTags[0] || textField.text == buttonTags[1] {
              textField.text = ""
          }
      }
      
      func textFieldDidEndEditing(_ textField: UITextField) {
          if textField == topMessage && textField.text == "" {
              textField.text = buttonTags[0]
          }
          
          if textField == bottomMessage && textField.text == "" {
              textField.text = buttonTags[1]
          }
      }
      
      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          unsubscribeFromKeyboardNotifications()
      }
      
      
      func subscribeToKeyboardNotifications() {
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      }
      
      func unsubscribeFromKeyboardNotifications() {
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      }
      
      @objc func keyboardWillShow(_ notification: Notification) {
          view.frame.origin.y -= getKeyboardHeight(notification)
      }
      
      func getKeyboardHeight(_ notification: Notification)  -> CGFloat {
          let userInfo = notification.userInfo
          let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
          return keyboardSize.cgRectValue.height
      }
      
      func generatedMemedImage() -> UIImage {
          
          topBar.isHidden = true
          bottomBar.isHidden = true
          
          UIGraphicsBeginImageContext(self.view.frame.size)
          view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
          let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
          
          topBar.isHidden = false
          bottomBar.isHidden = false
          
          return memedImage
      }

}
