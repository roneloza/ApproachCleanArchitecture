//
//  SearchResultViewModel.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/12/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class SearchResultViewModel: ViewModelList {
    
    var orderNumber: Int = 1
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let artworkUrl: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let trackTimeMillis: Int?
    
    var trackPriceFormat: String? {
        
        return "\((self.currency ?? "USD")) \((self.trackPrice ?? 0.00))"
    }
    
    var trackTime: String {
        
        return self.trackTimeMillis?.msToSeconds.minuteSecondMS ?? "0.00"
    }
    
    var artworkURL: URL? {
        
        return URL.init(string: self.artworkUrl ?? "")
    }
    
    init(artistName: String?,
         collectionName: String?,
         trackName: String?,
         artworkUrl: String?,
         collectionPrice: Double?,
         trackPrice: Double?,
         releaseDate: String?,
         country: String?,
         currency: String?,
         primaryGenreName: String?,
         trackTimeMillis: Int?) {
        
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.trackTimeMillis = trackTimeMillis
    }
}
