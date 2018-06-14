//
//  ListItunesPresenter.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/12/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class ListItunesMusicPresenter: ObjectDebug {
    
    private weak var output: ListItunesMusicPresenterOutput!
    
    init(output: ListItunesMusicPresenterOutput) {
        
        self.output = output
    }
}

extension ListItunesMusicPresenter {
    
    func cleanDataOnRefresh() {
        
        self.output.listViewModel.sections = nil
    }
    
    func presentLoadingOnRefresh() {
        
        self.output.listViewModel.state = .requesting
    }
    
    func presentLoadingOnLoad() {
        
        self.output.listViewModel.state = self.output.listViewModel.sections == nil ? .requesting : self.output.listViewModel.state
    }
    
    private func removeObjectAtFirstSection(at indexPath: IndexPath?) {
        
        if let sections = self.output.listViewModel.sections {
            
            if sections.count > 0,
                let section = self.output.listViewModel.sections?[0] ,
                let items = section.items,
                let indexPath = indexPath,
                items.count > indexPath.row {
                
                self.output.listViewModel.sections?[0].items?.remove(at: indexPath.row)
            }
        }
    }
    
    private func newSection(data: ListItunesMusicSearch?) -> SectionSearchResultViewModel? {
        
        var section: SectionSearchResultViewModel?
        
        if let models = data?.results,
            models.count > 0 {
            
            var objects: [SearchResultViewModel] = []
            
            var index = 1
            for model in models {
                
                let item = SearchResultViewModel.init(artistName: model.artistName, collectionName: model.collectionName, trackName: model.trackName, artworkUrl: model.artworkUrl100, collectionPrice: model.collectionPrice, trackPrice: model.trackPrice, releaseDate: model.releaseDate, country: model.country, currency: model.currency, primaryGenreName: model.primaryGenreName, trackTimeMillis: model.trackTimeMillis)
                
                item.orderNumber = index
                item.cellIdentifier = "Cell"
    
                objects.append(item)
                index += 1
            }
            
            section = SectionSearchResultViewModel.init(resultCount: data?.resultCount)
            section?.items = objects
        }
        
        return section
    }
}

extension ListItunesMusicPresenter: ListItunesMusicPresenterInput {
    
    func presentFetchSearchItunes(with model: ListItunesMusicSearch) {
        
        if let sections = self.output.listViewModel.sections {
            
            if sections.count == 1 {
                
                let section = self.newSection(data: model)
                
                if let items = section?.items {
                    
                    self.output.listViewModel.sections?[0].items?.append(contentsOf: items)
                }
            }
            else {
                
            }
        }
        else {
            
            self.output.listViewModel.sections = []
            
            if let data = self.newSection(data: model) {
                
                self.output.listViewModel.sections?.append(data)
            }
        }
        
        let count = (self.output.listViewModel.sections?.count) ?? 0
        
        self.output.listViewModel.state = self.output.listViewModel.sections != nil && count > 0 ? .success : .empty
        
        self.output.displayFetchSearchItunes(with: self.output.listViewModel)
    }
    
    func presentFetchSearchItunesError(with error: ErrorModelable) {
        
        self.output.listViewModel.state = (self.output.listViewModel.sections != nil && self.output.listViewModel.sections!.count > 0 ?  .success : .empty)
        
        let viewError = ListItunesPresentationError.init(bussinessError: error) ?? .Unhandled
        
        self.output.displayFetchSearchItunesError(with: viewError)
    }
}
