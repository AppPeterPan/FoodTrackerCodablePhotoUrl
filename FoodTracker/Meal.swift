//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log


struct Meal: Codable {
    
    //MARK: Archiving Paths
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("meals")
    
    //MARK: Properties
    
    var name: String
    var photoID: String?
    var rating: Int
    
    var image: UIImage? {
        if let photoURL = photoURL {
            return UIImage(contentsOfFile: photoURL.path)
        } else {
            return nil
        }
    }
    
    var photoURL: URL? {
        if let photoID = photoID {
            let filename = "\(photoID).jpg"
            return Meal.documentsDirectory.appendingPathComponent(filename)
        } else {
            return nil
        }
        
    }
    
    static func saveMeals(_ meals: [Meal]) {
        
        let propertyEncoder = PropertyListEncoder()
        let mealsData = try? propertyEncoder.encode(meals)
        try? mealsData?.write(to: archiveURL)

    }
    
    static func loadMeals() -> [Meal]?  {
        let propertyDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: archiveURL), let meals = try? propertyDecoder.decode([Meal].self, from: data) {
            return meals 
        } else {
            return nil
        }
    }
}
