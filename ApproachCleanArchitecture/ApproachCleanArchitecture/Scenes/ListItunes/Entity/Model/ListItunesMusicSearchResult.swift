//
//  ListItunesResult.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

//{
//    "wrapperType": "track",
//    "kind": "song",
//    "artistId": 1798556,
//    "collectionId": 1292109608,
//    "trackId": 1292110101,
//    "artistName": "Maroon 5",
//    "collectionName": "Red Pill Blues (Deluxe)",
//    "trackName": "Wait",
//    "collectionCensoredName": "Red Pill Blues (Deluxe)",
//    "trackCensoredName": "Wait",
//    "artistViewUrl": "https://itunes.apple.com/us/artist/maroon-5/1798556?uo=4",
//    "collectionViewUrl": "https://itunes.apple.com/us/album/wait/1292109608?i=1292110101&uo=4",
//    "trackViewUrl": "https://itunes.apple.com/us/album/wait/1292109608?i=1292110101&uo=4",
//    "previewUrl": "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview118/v4/a4/0c/14/a40c14ec-e51e-a2d9-7539-125c771b3d5f/mzaf_2581099706344857298.plus.aac.p.m4a",
//    "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/dc/56/dc/dc56dcff-5129-f70e-f2f8-9fd8a20bcc1f/source/30x30bb.jpg",
//    "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/dc/56/dc/dc56dcff-5129-f70e-f2f8-9fd8a20bcc1f/source/60x60bb.jpg",
//    "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/dc/56/dc/dc56dcff-5129-f70e-f2f8-9fd8a20bcc1f/source/100x100bb.jpg",
//    "collectionPrice": 11.99,
//    "trackPrice": 1.29,
//    "releaseDate": "2017-10-31T07:00:00Z",
//    "collectionExplicitness": "explicit",
//    "trackExplicitness": "notExplicit",
//    "discCount": 1,
//    "discNumber": 1,
//    "trackCount": 13,
//    "trackNumber": 3,
//    "trackTimeMillis": 190643,
//    "country": "USA",
//    "currency": "USD",
//    "primaryGenreName": "Pop",
//    "isStreamable": true
//}

class ListItunesMusicSearchResult: ObjectCodable {
    
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    
    init(wrapperType: String?,
         kind: String?,
         artistId: Int?,
         collectionId: Int?,
         trackId: Int?,
         artistName: String?,
         collectionName: String?,
         trackName: String?,
         collectionCensoredName: String?,
         trackCensoredName: String?,
         artistViewUrl: String?,
         collectionViewUrl: String?,
         trackViewUrl: String?,
         previewUrl: String?,
         artworkUrl30: String?,
         artworkUrl60: String?,
         artworkUrl100: String?,
         collectionPrice: Double?,
         trackPrice: Double?,
         releaseDate: String?,
         collectionExplicitness: String?,
         trackExplicitness: String?,
         discCount: Int?,
         discNumber: Int?,
         trackCount: Int?,
         trackNumber: Int?,
         trackTimeMillis: Int?,
         country: String?,
         currency: String?,
         primaryGenreName: String?,
         isStreamable: Bool?) {
        
        self.wrapperType = wrapperType
        self.kind = kind
        self.artistId = artistId
        self.collectionId = collectionId
        self.trackId = trackId
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.collectionCensoredName = collectionCensoredName
        self.trackCensoredName = trackCensoredName
        self.artistViewUrl = artistViewUrl
        self.collectionViewUrl = collectionViewUrl
        self.trackViewUrl = trackViewUrl
        self.previewUrl = previewUrl
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.collectionExplicitness = collectionExplicitness
        self.trackExplicitness = trackExplicitness
        self.discCount = discCount
        self.discNumber = discNumber
        self.trackCount = trackCount
        self.trackNumber = trackNumber
        self.trackTimeMillis = trackTimeMillis
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.isStreamable = isStreamable
    }
    
}
