//
//  DetailCatInfoController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 24/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//


import UIKit

class DetailCatInfoController : UIViewController {
    
   
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var about: UILabel!
    
    @IBOutlet weak var otherInfo: UILabel!
    
    @IBOutlet weak var colour: UILabel!
    @IBOutlet weak var breed: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    //var cats = [CatList]()
    
    var getCatImage = UIImage()
    var getCatName = ""
    var getCatBreed = ""
    var getCatAge = ""
    var getCatColour = ""
    var getCatGender = ""
    var getCatDescription = ""
    var getCatAddInfo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
           //configNavigationBar()
        loadDetailCat()
        
    }
    
    func loadDetailCat() {
        

        
        image.image = getCatImage
        name.text = getCatName
        gender.text = getCatGender
        about.text = getCatDescription
        age.text = getCatAge
        breed.text = getCatBreed
        colour.text = getCatColour
        otherInfo.text = getCatAddInfo
//
        
        
        
    }

    /*func configNavigationBar() {
        
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 23, width: self.view.frame.size.width, height: 50))
        
        // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.white
        
        // Create a navigation item with a title
                let navigationItem = UINavigationItem()
                navigationItem.title = "Detail Cat Info"
        
        //Back button logged user off to login page
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
    }
    
    @objc func handleBack() {
        
        dismiss(animated: true, completion: nil)
    }
    */

}
