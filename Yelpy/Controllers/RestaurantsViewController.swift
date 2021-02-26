//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage
import Lottie
import SkeletonView

 class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // –––––– TODO: Initialize restaurantsArray
    
    var restaurantsArray: [Restaurant] = []
    var filteredRestaurants: [Restaurant] = []
    var refresh = true
    
    // –––––  Lab 4: create an animation view
    var animationView: AnimationView?
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ––––– Lab 4 TODO: Start animations
        self.startAnimations()
        
        animationView = .init(name: "animationName")
        animationView?.frame = view.bounds
        animationView?.play()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Search Bar delegate
        searchBar.delegate = self
        getAPIData()
        
//         –––––  Lab 4: stop animations, you can add a timer to stop the animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            // Put your code which should be executed with a delay here
            self.stopAnimations()
        }
        
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(stopAnimations), userInfo: nil, repeats: false)
//        stopAnimations()
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else{
                return
            }
//            self.stopAnimations()
            self.restaurantsArray = restaurants
            self.filteredRestaurants = restaurants
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let r = filteredRestaurants[indexPath.row]
            let detailVC = segue.destination as! RestaurantDetailViewController
            detailVC.r = r
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        cell.r = filteredRestaurants[indexPath.row]
        if self.refresh{
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        return cell
    }

}

// ––––– TODO: Create tableView Extension and TableView Functionality
 extension RestaurantsViewController: UISearchBarDelegate {
     
     // Search bar functionality
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if searchText != "" {
             filteredRestaurants = restaurantsArray.filter { (r: Restaurant) -> Bool in
                 return r.name.lowercased().contains(searchText.lowercased())
             }
         }
         else {
             filteredRestaurants = restaurantsArray
         }
         tableView.reloadData()
     }
     
     
     // Show Cancel button when typing
     func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         self.searchBar.showsCancelButton = true
     }
     
     // Logic for searchBar cancel button
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.showsCancelButton = false // remove cancel button
         searchBar.text = "" // reset search text
         searchBar.resignFirstResponder() // remove keyboard
         filteredRestaurants = restaurantsArray // reset results to display
         tableView.reloadData()
     }
     
 }

extension RestaurantsViewController: SkeletonTableViewDataSource{
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RestaurantCell"
    }
    // ––––– Lab 4 TODO: Call animation functions to start
    func startAnimations(){
        animationView = .init(name: "4762-food-carousel")
        
        animationView!.frame = CGRect(x: view.frame.width / 3, y:95, width: 100, height: 100)
        
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        
        animationView!.loopMode = .loop
        
        animationView!.animationSpeed = 5
        
        animationView!.play()
        view.showGradientSkeleton()
        
    }
    
    // ––––– Lab 4 TODO: Call animation functions to stop
    @objc func stopAnimations(){
        animationView?.stop()
//        view.hideSkeleton()
        view.subviews.last?.removeFromSuperview()
        view.hideSkeleton()
        refresh = false
    }
}
