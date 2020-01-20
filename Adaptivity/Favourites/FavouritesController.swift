//
//  FavouritesController.swift
//  Counties
//
//  Created by Stephen Anthony on 20/01/2020.
//  Copyright © 2020 Darjeeling Apps. All rights reserved.
//

import Foundation

/// The object responsible for managing the list of the user's favourite
/// counties.
final class FavouritesController {
    
    /// The shared instance of `FavouritesController`. Should be used over
    /// individual instances.
    static let shared = FavouritesController()
    
    private static let favouriteCountiesKey = "FavouriteCounties"
    
    /// The counties that the user has chosen as their favourites.
    var favouriteCounties: [County] {
        return ubiquitousKeyValueStore.array(forKey: FavouritesController.favouriteCountiesKey) as? [County] ?? []
    }
    
    private let ubiquitousKeyValueStore: UbiquitousKeyValueStorageProviding
    
    /// Initialises a new `FavouritesController` backed by the given ubiquitous
    /// key-value store.
    /// - Parameter ubiquitousKeyValueStore: The ubiquitous key-value store used
    /// to persist the user's favourite counties.
    init(ubiquitousKeyValueStore: UbiquitousKeyValueStorageProviding = NSUbiquitousKeyValueStore.default) {
        self.ubiquitousKeyValueStore = ubiquitousKeyValueStore
    }
    
    /// Adds the given county to the user's favourites.
    /// - Parameter county: The county to add to the user's favourites.
    func add(county: County) {
        guard favouriteCounties.firstIndex(of: county) == nil else { return }
        ubiquitousKeyValueStore.set(favouriteCounties + [county], forKey: FavouritesController.favouriteCountiesKey)
    }
    
    /// Removes the given county from the user's favourites.
    /// - Parameter county: The county to remove from the user's favourites.
    func remove(county: County) {
        guard let countyIndex = favouriteCounties.firstIndex(of: county) else { return }
        var mutableFavourites = favouriteCounties
        mutableFavourites.remove(at: countyIndex)
        ubiquitousKeyValueStore.set(mutableFavourites, forKey: FavouritesController.favouriteCountiesKey)
    }
}

protocol UbiquitousKeyValueStorageProviding {
    func set(_ anObject: Any?, forKey aKey: String)
    func array(forKey aKey: String) -> [Any]?
}

extension NSUbiquitousKeyValueStore: UbiquitousKeyValueStorageProviding {}
