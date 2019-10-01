//
//  LoginViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

     //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var loginButton: RoundButton!
    
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hide nav
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //show nav
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    

    @IBAction func logInPressed(_ sender: RoundButton) {
        
        //added to avoid error while logging in but fail
        //UserDefaults.standard.set("LoggedIn", forKey: "accessToken")
        
       // changeRoot()
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        mainTabController.selectedViewController = mainTabController.viewControllers?[0]
        
        present(mainTabController, animated: true,completion: nil)
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print ("Form is not valid")
            return
        }
        //Log in the user
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                //print(error!)
                let alertController = UIAlertController(title: "Error!", message: "Error \(error!.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                print ("Login is successful!")
                //self.performSegue(withIdentifier: "goToCatProfile", sender: self)
            }
        }
    }

    
    
}



