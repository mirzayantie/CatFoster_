//
//  CatProfileViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 17/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

class CatProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchController: UISearchController!

    @IBOutlet weak var showAllButton: UIButton!
    @IBOutlet weak var welcomeMessage: UILabel!
    
    var catProfile : [CatProfile] = [CatProfile]()
    var ref: DatabaseReference!
    let cellScale : CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //checkIfUserIsLoggedIn()
        setupCollectionView()
        loadCatList()
      
    }
    
    //MARK: Private Methods. load from server
    private func loadCatList() {
        //access firebase database
        
        let catRef = ref.child("cat")
        //read data
        catRef.observe(DataEventType.value, with: { (snapshot) in
            //clear local data
            self.catProfile = []
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            //print("Amount of data from server \(postDict.count)")
            var catName = ""
            var catImageURL = ""
            var catAge = ""
            var catGender = ""
            
            
            for (key, value) in postDict {
                print("\(key) -> \(value)")
                
                catName = value["name"] as! String
                catImageURL = value["photo"] as! String
                catAge = value["age"] as! String
                catGender = value["gender"] as! String
            
                
                let cats = CatProfile(catName: catName, catImageURL: catImageURL, catAge: catAge, catGender: catGender)
                
                self.catProfile += [cats]
                
                //print("Amount of data from local \(self.catList.count)")
            }
            //reload local data when get data from server
            self.collectionView.reloadData()
        })
    }
    func setupCollectionView() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth)/2.0
        let insetY = (view.bounds.width - cellHeight)/2.0
        
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let uid = Auth.auth().currentUser?.uid

                Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    //!!!!!it can output all data from firebase but cannot output data based on uid.!!!!!!!!!
                    print(snapshot)
                    //print("user found")
                    let value = snapshot.value as? NSDictionary
                    let name = value?["name"] as? String ?? ""
                    self.welcomeMessage.text = "Hello \(name)"
                }, withCancel: nil)
            
        } else {
            print("No user is signed in")
        }
    }
    
    
    //MARK : UICollectionViewDataSource method
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catProfile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as! CatCollectionViewCell
        
        let catProfiles = catProfile[indexPath.row]
        cell.catProfile = catProfiles
        return cell
        
    }
    
    //MARK : UIScrollViewDelegate method...what this line of code do???
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = layout.itemSize.width - layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: self)
            //navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("error: there was a problem logging out")
        }
        
    }
    
    
    @IBAction func showAllButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ShowAllCats", sender: self)
        
    }
}


