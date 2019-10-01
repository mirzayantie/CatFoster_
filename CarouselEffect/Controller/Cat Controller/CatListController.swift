//
//  CatListController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 24/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

class CatListController: UITableViewController {
    
    //var catList : [CatProfile] = CatProfile.createCatProfile()
    var catList : [CatProfile] = [CatProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configNavigationBar()
        loadCatList()
        
    }
    
    //MARK: Private Methods. load from server
    private func loadCatList() {
        //access firebase database
        let ref = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/")
        print("in")
        //var ref: DatabaseReference!
        //ref = Database.database().reference()
        let catRef = ref.child("cat")
        //read data
        catRef.observe(DataEventType.value, with: { (snapshot) in
            //clear local data
            self.catList = []
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            print("Amount of data from server \(postDict.count)")
            var catName = ""
            var catImage = ""
            var catBreed = ""
            var catAge = ""
            var catColour = ""
            var catGender = ""
            var catDescription = ""
            var catAddInfo = ""
            //var currentid = ""
            
            //var mealRating = 0
            
            for (key, value) in postDict {
                print("\(key) -> \(value)")
                    
                    catName = value["name"] as! String
                    //catImage = value["photo"] as! String
                    catBreed = value["breed"] as! String
                    catAge = value["age"] as! String
                    catGender = value["gender"] as! String
                    catColour = value["colour"] as! String
                    catDescription = value["description"] as! String
                    catAddInfo = value["otherInfo"] as! String
                    
                    //mealRating = value["rating"] as! Int
                let cats = CatProfile(catID: key, catName: catName, catImage: UIImage(named: "cat"), catBreed: catBreed, catAge: catAge, catGender: catGender, catDescription: catDescription, catColour: catColour, additionalInfo: catAddInfo)
                
                
                
                self.catList += [cats]
                
                print("Amount of data from local \(self.catList.count)")
            }
            //reload local data when get data from server
            self.tableView.reloadData()
        })
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "catViewCell", for: indexPath) as? CatViewCell else {
            fatalError("The dequeued cell is not an isntance of MealTableViewCell")
        }
        
        let cats = catList[indexPath.row]
        print("try to display to UI")
        
        cell.catName.text = cats.catName
        cell.catImage.image = cats.catImage
        cell.catGender.text = cats.catGender
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCatController = storyboard?.instantiateViewController(withIdentifier: "DetailCatInfoController") as? DetailCatInfoController
   
        detailCatController?.getCatName = catList[indexPath.row].catName
        detailCatController?.getCatAge = catList[indexPath.row].catAge
        detailCatController?.getCatColour = catList[indexPath.row].catColour
        detailCatController?.getCatBreed = catList[indexPath.row].catBreed
        detailCatController?.getCatGender = catList[indexPath.row].catGender
        detailCatController?.getCatDescription = catList[indexPath.row].catDescription
        detailCatController?.getCatAddInfo = catList[indexPath.row].additionalInfo
        detailCatController?.getCatImage = (catList[indexPath.row].catImage as UIImage?)!

        self.navigationController?.pushViewController(detailCatController!, animated: true)
    }
    
    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //reomve data in firebase
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let catsRef = ref.child("cats")
            catsRef.child(catList[indexPath.row].id).removeValue()
            // Delete the row from the data source
            catList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    } */
    
    /*func configNavigationBar() {
     
     // Create the navigation bar
     let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
     
     // Offset by 20 pixels vertically to take the status bar into account
     
     navigationBar.backgroundColor = UIColor.white
     
     // Create a navigation item with a title
     //        let navigationItem = UINavigationItem()
     //        navigationItem.title = "All Cats"
     
     //Back button logged user off to login page
     navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
     
     let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
     let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
     
     navigationItem.rightBarButtonItem = searchBarButtonItem
     
     // Assign the navigation item to the navigation bar
     navigationBar.items = [navigationItem]
     
     // Make the navigation bar a subview of the current view controller
     self.view.addSubview(navigationBar)
     
     }
     
     @objc func handleBack() {
     
     dismiss(animated: true, completion: nil)
     }
     
     
     @objc func handleSearch() {
     //
     }*/
    
    
}
