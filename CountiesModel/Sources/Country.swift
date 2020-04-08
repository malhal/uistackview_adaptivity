//
//  Country.swift
//  CountiesModel iOS
//
//  Created by Stephen Anthony on 07/04/2020.
//  Copyright © 2020 Darjeeling Apps. All rights reserved.
//

import Foundation

/// Represents a set of regions within a country.
public struct Country: Codable {
    
    /// `Country` representation of the United Kingdom.
    public static let unitedKingdom = try! JSONDecoder().decode(Country.self, from: Data(contentsOf: Bundle(for: BundleClass.self).url(forResource: "United Kingdom", withExtension: "json")!))
    
    /// The name of the country.
    public let name: String
    
    /// The regions of the country.
    public let regions: [Region]
    
    /// Allows for a `Country`'s counties to be looked up by name.
    /// - Parameter name: The name of the county we wish to find.
    /// - Returns: The county with the given name, if any.
    public func county(forName name: String) -> County? {
        let allCounties = regions.map({ $0.counties }).reduce([], +)
        return allCounties.first(where: { $0.name == name })
    }
    
    /// All of the receiver's counties in alphabetical order.
    public var allCounties: [County] {
        return regions.map({ $0.counties }).reduce([], +).sorted()
    }
}

/// Represents an individual region within a country.
public struct Region: Codable {
    
    /// The name of the regions.
    public let name: String
    
    /// The counties within the region.
    public let counties: [County]
}

private class BundleClass {}