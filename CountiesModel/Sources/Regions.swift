//
//  Regions.swift
//  CountiesModel iOS
//
//  Created by Stephen Anthony on 07/04/2020.
//  Copyright © 2020 Darjeeling Apps. All rights reserved.
//

import Foundation

/// Represents a set of regions within a country.
public struct Regions {
    
    /// The regions of a country.
    public let regions: [Region]
    
    init?(configurationURL: URL) {
        guard let data = try? Data(contentsOf: configurationURL),
            let regions = try? JSONDecoder().decode([Region].self, from: data) else {
            return nil
        }
        self.regions = regions
    }
}

/// Represents an individual region within a country.
public struct Region: Codable {
    
    /// The title of the regions.
    public let title: String
    
    /// The counties within the region.
    public let counties: [County]
}