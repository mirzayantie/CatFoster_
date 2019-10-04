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
    
    
    
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
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
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
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
                    
            self.saveFIRData()
            
            self.performSegue(withIdentifier: "goToHome", sender: self)
            
        } //create user end
        
    } //continue buttonclicked func end
    

    
    func saveFIRData() {
            self.uploadImage(self.userProfileImage.image!) { (url) in
                
            self.saveUserData(name: self.emailTextfield.text!, imageURL: url!, email: self.emailTextfield.text!, password: self.passwordTextfield.text!){ success in
                    if success != nil {
                        print("user data saved in database!")
                }
            }
        }
    }
        
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) ->())){

        //2. create a new storage reference
                //guard let uid = Auth.auth().currentUser?.uid else {return}
                
                // authenticate the user
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("image").child("profile_images").child("\(imageName).png")
        
        let imgData = userProfileImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            } else {
                print ("error")
                completion(nil)
            }
        }
    }
    
    func saveUserData(name: String, imageURL: URL, email: String, password: String, completion: @escaping ((_ url: URL?) -> ())){
        
        var dict = [String: Any]()
        dict.updateValue(name, forKey: "name")
        dict.updateValue(imageURL.absoluteString, forKey: "profile_photo")
        dict.updateValue(email, forKey: "email")
        
        self.ref.child("user").childByAutoId().setValue(dict)

    }
    
    /*private func registerUserIntoDatabase(uid: String, values: [String:AnyObject]) {
        
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
        
    } */
   
}

