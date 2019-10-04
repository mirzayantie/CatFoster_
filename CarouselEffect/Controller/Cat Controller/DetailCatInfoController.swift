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
    }

}
