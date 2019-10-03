//
//  CatProfile.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 17/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit

class CatProfile
{
    // MARK: - Public API

    var catID = ""
    var catImage: UIImage
    var catName = ""
    var catDescription = ""
    var catBreed = ""
    var catAge = ""
    var catGender = ""
    var catColour = ""
    var additionalInfo = ""
    
    init(catName: String, catImage: UIImage, catBreed:String, catAge:String, catGender: String, catColour: String)
    {

        self.catImage = catImage
        self.catName = catName
        self.catAge = catAge
        self.catBreed = catBreed
        self.catGender = catGender
        self.catColour = catColour

    
    }
    
    // MARK: - Private
    // dummy data
  static func createCatProfile() -> [CatProfile]
    {
        return [
            CatProfile(catName: "Miu", catImage: UIImage(named: "kitten")!, catBreed: "Long hair", catAge: "3 months", catGender: "Female", catColour: "Yellow"),
            
            CatProfile(catName: "Jack", catImage: UIImage(named: "cat2")!, catBreed: "Persian", catAge: "1 year", catGender: "Male", catColour: "black"),
            
            CatProfile(catName: "Tompok", catImage: UIImage(named: "cat3")!, catBreed: "Mix", catAge: "9 months", catGender: "Female", catColour: "orange"),
            
            CatProfile(catName: "Ginger", catImage: UIImage(named: "cat4")!, catBreed: "Long Hair", catAge: "3 years", catGender: "Female", catColour: "orange"),
            
        ]
    }
}
