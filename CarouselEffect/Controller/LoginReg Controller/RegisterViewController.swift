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
    
    @IBOutlet var emailTextfield: DesignableTextField!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var nameTextfield: DesignableTextField!
    
    @IBOutlet var passwordTextfield: DesignableTextField!
    
    @IBOutlet weak var continueButton: RoundButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //save some dummy value for test
        //let ref = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/")
        
        // ref.updateChildValues(["someValues":1234])
        
    }
    //MARK : ImagePicker
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        //imagePickerController.allowsEditing = true
        print("in")
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
    
    // MARK Authenticate user and save profile image to storage
    @IBAction func continueButtonClicked(_ sender: RoundButton) {
        
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
                return
            }
            
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            
            // authenticate the user
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpeg")
            
            guard let uploadData = UIImage().jpegData(compressionQuality: 0.75) else {
                return
            }
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                let profileImageURL = metadata?.storageReference?.downloadURL(completion: { (url, err) in
                    if err != nil {
                        print(err!)
                        return
                    }
                    let profileImageURLSuccess = url?.absoluteString
                    let values = ["name": name, "email": email, "password": password, "profileImageURL": profileImageURLSuccess]
                    
                    self.registerUserIntoDatabase(uid: uid, values: values as [String : AnyObject])
                    
                }) //profileImageURL end
                
            }) //put data end
            
        } //register user end
        
    } //continue buttonclicked func end
    
    private func registerUserIntoDatabase(uid: String, values: [String:AnyObject]) {
        let ref = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        
        
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            print("Saved user successfully into Firebase database")
            self.dismiss(animated: true, completion: nil)
        })
        
        print ("Register is successful!")
        self.performSegue(withIdentifier: "regGoToCatProfile", sender: self)
        
    }
    
    //            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
    //                if error != nil {
    //                    print(error!)
    //                    return
    //                }
    //
    //                if let profileImageURL = metadata?.storageReference?.downloadURL(completion: { (url, err) in
    //                    if err != nil {
    //                        print(err!)
    //                        return
    //                    }
    //                let values = ["name": name, "email": email, "password": password, "profileImageURL": profileImageURL]
    //
    //                self.registerUserIntoDatabase(uid: uid, values: values)
    //
    //                })
    //
    //            })
}

