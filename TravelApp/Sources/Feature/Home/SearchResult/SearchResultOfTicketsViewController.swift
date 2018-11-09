//
//  SearchResultOfTicketsViewController.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

class SearchResultOfTicketsViewController: UIViewController, Identifiable {

    //MARK: - Properties
    
    private var viewModel: SearchResultOfTicketsViewModelProtocol?
    private var searchFormModel: HomeSearchFormModel?
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.appPaleGrey
            tableView.rowHeight = 272
            tableView.estimatedRowHeight = 272
            tableView.estimatedSectionHeaderHeight = SearchResultTicketHeaderView.heightForHeader
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView()
            tableView.register(cellType: SearchResultTicketHeaderView.self)
            tableView.register(cellType: FlightTableViewCell.self)
        }
    }
    @IBOutlet private weak var bottomContentView: UIView! {
        didSet {
            bottomContentView.backgroundColor = UIColor.appSilver
            bottomContentView.layer.borderColor = UIColor.appSilver.cgColor
            bottomContentView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet private weak var filterButton: UIButton! {
        didSet {
            filterButton.applyCustomAppearance2()
            filterButton.setTitle(Localizable.searchResultFilter.localize().uppercased(), for: .normal)
            filterButton.setImage(UIImage(named: "filtro"), for: .normal)
            filterButton.accessibilityIdentifier = "filterButton"
        }
    }
    @IBOutlet private weak var orderButton: UIButton! {
        didSet {
            orderButton.applyCustomAppearance2()
            orderButton.setTitle(Localizable.searchResultOrder.localize().uppercased(), for: .normal)
            orderButton.setImage(UIImage(named: "ordenar"), for: .normal)
            orderButton.accessibilityIdentifier = "orderButton"
        }
    }
    
    // MARK: - Life Cycle Methods
    
    static func instantiate(viewModel: SearchResultOfTicketsViewModelProtocol = SearchResultOfTicketsViewModel(), searchFormModel: HomeSearchFormModel) -> SearchResultOfTicketsViewController {
        let viewController: SearchResultOfTicketsViewController = UIStoryboard.viewController(from: .home)
        viewController.viewModel = viewModel
        viewController.searchFormModel = searchFormModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localizable.searchResultTitle.localize().uppercased()
        navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: #selector(didTouchBackButton))
        
        bindEventView()
        viewModel?.loadTravels(withSearchModel: searchFormModel)
    }
    
    // MARK: - Action Methods
    
    @objc private func didTouchBackButton() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func didTouchFilterButton(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        
        let alertVC = UIAlertController(title: "Escolha a companhia aérea para filtrar", message: nil, preferredStyle: .actionSheet)
        for item in viewModel.airlineList() {
            let airlineAction = UIAlertAction(title: item, style: .default) { (_) in
                viewModel.filterByAirline(item)
            }
            alertVC.addAction(airlineAction)
        }
        let clearAction = UIAlertAction(title: "Limpar filtro", style: .destructive) { (_) in
            viewModel.resetFilter()
        }
        alertVC.addAction(clearAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func didTouchOrderButton(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        
        let alertVC = UIAlertController(title: "Escolha como deseja ordernar", message: nil, preferredStyle: .actionSheet)
        let priceAction = UIAlertAction(title: "Preço", style: .default) { (_) in
            viewModel.order(by: .price)
        }
        alertVC.addAction(priceAction)
        
        let clearAction = UIAlertAction(title: "Ordenação natural", style: .destructive) { (_) in
            viewModel.order(by: .standard)
        }
        alertVC.addAction(clearAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func bindEventView() {
        viewModel?.searchResultViewEvent.bind({ [weak self] (viewEvent) in
            guard let weakSelf = self else { return }
            weakSelf.tableView.backgroundView = nil
            switch viewEvent {
            case .loading:
                weakSelf.showLoading()
            case .fullError:
                weakSelf.showError()
            case .fullEmptyState:
                weakSelf.showEmptyState()
            case .loaded:
                weakSelf.loadSuccess()
            }
        })
    }
    
    private func showLoading() {
        let loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loading.startAnimating()
        loading.frame = tableView.bounds
        tableView.backgroundView = loading
    }
    private func showError() {
        let errorView = SearchResultErrorView.fromNib(withOwner: self) as SearchResultErrorView?
        errorView?.frame = view.bounds
        errorView?.delegate = self
        tableView.backgroundView = errorView
    }
    
    private func showEmptyState() {
        
        let label = UILabel(frame: tableView.bounds)
        label.text = Localizable.searchResultEmptyStateMessage.localize()
        label.textColor = UIColor.appCoolGrey
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        tableView.backgroundView = label
    }
    private func loadSuccess() {
        tableView.backgroundView = nil
        tableView.setContentOffset( .zero, animated: false)
        tableView.reloadData()
    }
}

extension SearchResultOfTicketsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.flightViewModelViewModelList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellViewModel = viewModel?.flightViewModelViewModelList[indexPath.row] {
            let cell: FlightTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(cellViewModel)
            return cell
        }
        return UITableViewCell()
    }
}

extension SearchResultOfTicketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeaderView: SearchResultTicketHeaderView = tableView.dequeueReusableHeaderFooterView()
        return tableHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SearchResultTicketHeaderView.heightForHeader
    }
}

extension SearchResultOfTicketsViewController: SearchResultErrorViewProtocol {
    func didClickTryAgain(errorView: SearchResultErrorView) {
        viewModel?.loadTravels(withSearchModel: searchFormModel)
    }
}
