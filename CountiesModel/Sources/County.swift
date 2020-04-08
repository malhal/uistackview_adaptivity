//
//  County.swift
//  CountiesModel
//
//  Created by Stephen Anthony on 15/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

/*!
The struct used to represent an individual county.
*/
public struct County: Codable, Hashable {
    public let name: String
    public let population: Population
    private let latitude: Double
    private let longitude: Double
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    public let url: URL
    
    /// Models the population data for a county.
    public struct Population: Codable, Hashable {
        public let total: Int
        public let year: Int
        public let source: URL
    }
    
    /// All of the counties available to the application.
    public static var allCounties: [County] = {
        let countyDictionaries = NSArray(contentsOf: Bundle.countiesModelBundle.url(forResource: "Counties", withExtension: "plist")!) as! Array<Dictionary<String, AnyObject>>
        return countyDictionaries.map { (countryDictionary) -> County in
            let population = Population(total: countryDictionary["population"] as! Int, year: 2020, source: URL(string: "https://darjeelingsteve.com")!)
            return County(name: countryDictionary["name"] as! String, population: population, latitude: countryDictionary["latitude"] as! Double, longitude: countryDictionary["longitude"] as! Double, url: URL.init(string: countryDictionary["url"] as! String)!)
        }
    }()
}

extension County: Comparable {
    public static func < (lhs: County, rhs: County) -> Bool {
        return lhs.name < rhs.name
    }
}

extension County {
    public var populationDescription: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return String(format: NSLocalizedString("Population: %@", comment: "County population label text"), numberFormatter.string(from: NSNumber(value: population.total))!)
        }
    }
    
    public var flagImage: UIImage? {
        get {
            return UIImage(named: name, in: Bundle.countiesModelBundle, with: nil)
        }
    }
}
