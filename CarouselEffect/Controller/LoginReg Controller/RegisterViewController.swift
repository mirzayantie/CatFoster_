//
//  RegisterViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var emailTextfield: UITextField!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var regButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //save some dummy value for test
        //let ref = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/")
        
        // ref.updateChildValues(["someValues":1234])
        
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        userProfileImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func registerButtonPressed(_ sender: AnyObject) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text, let name = nameTextfield.text else {
            print ("Form is not valid")
            return
        }
        //register the user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
                
                let alertController = UIAlertController(title: "Error!", message: "Error \(error!.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                // authenticate the user
                let ref = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/")
                let userReference = ref.child("users").childByAutoId()
                let values = ["name": name, "email": email, "password": password]
                
                userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    print("Saved user successfully into Firebase database")
                })
                
                print ("Register is successful!")
                self.performSegue(withIdentifier: "regGoToCatProfile", sender: self)
            }
        }
        
    }
}
