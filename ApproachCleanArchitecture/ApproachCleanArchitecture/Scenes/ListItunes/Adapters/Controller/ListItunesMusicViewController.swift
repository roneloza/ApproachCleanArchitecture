//
//  ListItunesViewController.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

//MARK: - The configurator’s job is to hook up all the VIP components -
extension ListItunesMusicViewController: ListItunesMusicPresenterOutput {}
extension ListItunesMusicInteractor: ListItunesMusicViewControllerOutput {}
extension ListItunesMusicPresenter: ListItunesMusicInteractorOutput {}

//MARK: - Input Port -
extension ListItunesMusicViewController: ListItunesMusicViewControllerInput {
    
    func displayFetchSearchItunes(with viewModel: ListItunesMusicViewModel) {
        
        self.isRequestingSearchItunes = false
        
        DispatchQueue.main.async { [unowned self] in
            
            self.endRefreshTableUI()
        }
    }
    
    func displayFetchSearchItunesError(with error: ErrorViewModelable) {
        
        self.isRequestingSearchItunes = false
        
        DispatchQueue.main.async { [unowned self] in
            
            self.endRefreshTableUI()
            self.displayError(error, handler: nil)
        }
    }
}

class ListItunesMusicViewController: BaseUIViewController {
 
    //MARK: - IBOutlet -
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var refreshControl: UIRefreshControl!
    @IBOutlet private weak var searchBar: UISearchBar!;
    
    //MARK: - Data -
    lazy var listViewModel: ListItunesMusicViewModel! = ListItunesMusicViewModel.init(sections: nil)
    
    //MARK: - The configurator VIP components  -
    private lazy var presenter = {
        
        [unowned self] in
        
        return ListItunesMusicPresenter.init(output: self)
        }()
    
    private lazy var outputPort: ListItunesMusicViewControllerOutput =  {
        
        [unowned self] in
        
        let interactor = ListItunesMusicInteractor.init(output: self.presenter, networkWorker: ItunesServiceNetwork.init(dispatcher: NetworkDispatcherNative(), serializable: SerializableServiceNative()))
        
        return interactor
        }()
    
    //MARK: - Vars -
    private var searchText = ""
    private var searchTextTemp = ""
    private var isRequestingSearchItunes = false
    
    //MARK: - Life Cycle -
    deinit {
        
        self.listViewModel = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchItunes(with: self.searchText)
    }
}

private extension ListItunesMusicViewController {
    
    func setupViews() {
        
        self.tableView.addSubview(self.refreshControl)
        self.tableView.decelerationRate = UIScrollViewDecelerationRateFast
    }
}

//MARK: - UI -
private extension ListItunesMusicViewController {
    
    func beginRefreshTableUI() {
        
        self.tableView.reloadData()
    }
    
    func endRefreshTableUI() {
        
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

//MARK: - <UITableViewDataSource, UITableViewDelegate> -
extension ListItunesMusicViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.listViewModel.state.size(section: indexPath.section, row: indexPath.row, contentSize: tableView.bounds.size.height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.listViewModel.state.sections(data: self.listViewModel.sections)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listViewModel.state.rows(section: section, data: self.listViewModel.sections)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = self.listViewModel.state.cellIdentifier(section: indexPath.section, row: indexPath.row, data: self.listViewModel.sections)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = (cell as? SearchItuneMusicTableViewCell),
            let vm = self.listViewModel.state.item(section: indexPath.section, row: indexPath.row, data: self.listViewModel.sections) as? SearchResultViewModel {
            
            cell.bind(viewModel: vm)
        }
        
        return cell
    }
}

//MARK: - UISearchBarDelegate -

extension ListItunesMusicViewController: UISearchBarDelegate {
    
    private func isFiltering() -> Bool {
        
        return !(self.searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count < 1)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if self.isFiltering() {
            
            self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text {
         
            if self.searchTextTemp.compare(searchText) != ComparisonResult.orderedSame {
                
                self.searchText = searchText
                
                self.searchItunes(with: self.searchText)
            }
            
            self.searchTextTemp = searchText
        }
    }
}

//MARK: - Use Cases -
private extension ListItunesMusicViewController {
    
    @IBAction func didRefreshControl() {
        
        self.searchItunes(with: self.searchText)
    }
}

//MARK: - Use Cases -
private extension ListItunesMusicViewController {
    
    func searchItunes(with text: String) {
        
        if (!self.isRequestingSearchItunes) {
            
            self.isRequestingSearchItunes = true
            
            self.presenter.cleanDataOnRefresh()
            self.presenter.presentLoadingOnRefresh()
            
            self.beginRefreshTableUI()
            
            let request = ListItunesMusicRequest.init(networkRequest: NetworkRequestItunes.fecthSearchItunes(terms: text, limit: self.listViewModel.limit), term: text, limit: self.listViewModel.limit)
            
            self.outputPort.fetchSearchItunes(with: request)
        }
    }
}
