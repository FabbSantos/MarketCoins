//
//  CoinsListViewController.swift
//  MarketCoins
//
//  Created by Fabricio Bahiense on 10/10/23.
//  Copyright (c) 2023 Fabricio Bahiense. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinsListDisplayLogic: AnyObject {
  func displayGlobalValues(viewModel: CoinsList.FetchGlobalValues.ViewModel)
  func displayListCoins(viewModel: CoinsList.FetchListCoins.ViewModel)
  func displayError(error: String)
}

class CoinsListViewController: UIViewController {
    
    @IBOutlet weak var globalCollectionView: UICollectionView! {
        didSet {
            globalCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var filterCollectionView: UICollectionView!{
        didSet {
            filterCollectionView.delegate = self
            filterCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var listCoinsTableView: UITableView! {
        didSet {
            listCoinsTableView.delegate = self
            listCoinsTableView.dataSource = self
        }
    }
    
    
    private var globalViewModel: CoinsList.FetchGlobalValues.ViewModel?
    private var coinsViewModel: CoinsList.FetchListCoins.ViewModel?
    
  var interactor: CoinsListBusinessLogic?
  var router: (NSObjectProtocol & CoinsListRoutingLogic & CoinsListDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup(){
    let viewController = self
    let interactor = CoinsListInteractor()
    let presenter = CoinsListPresenter()
    let router = CoinsListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad(){
    super.viewDidLoad()
      
//      let nib = UINib(nibName: CoinHeaderView.identifier, bundle: nil)
//      listCoinsTableView.register(nib, forHeaderFooterViewReuseIdentifier: CoinHeaderView.identifier)
      
      doFetchGlobalValues()
      doFetchListCoins()
  }
  
    func doFetchGlobalValues() {
        let request = CoinsList.FetchGlobalValues.Request(baseCoin: "brl")
        interactor?.doFetchGlobalValues(request: request)
    }
    
    func doFetchListCoins () {
        let request = CoinsList.FetchListCoins.Request(
            baseCoin: "brl",
            orderBy: "market_cap_desc",
            top: 10,
            pricePercentage: "1h")
        interactor?.doFetchListCoins(request: request)

    }
}

extension CoinsListViewController: CoinsListDisplayLogic {
    func displayGlobalValues(viewModel: CoinsList.FetchGlobalValues.ViewModel){
        globalViewModel = viewModel
        DispatchQueue.main.async {
            self.globalCollectionView.reloadData()
        }
    }
    func displayListCoins(viewModel: CoinsList.FetchListCoins.ViewModel){
        coinsViewModel = viewModel
        DispatchQueue.main.async {
            self.listCoinsTableView.reloadData()
        }
    }
    
    func displayError(error: String) {
        print(error)
    }
}

extension CoinsListViewController: UICollectionViewDelegate {
    
}

extension CoinsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == globalCollectionView {
            return globalViewModel?.globalValues.count ?? 0
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == globalCollectionView {
            guard let viewModel = globalViewModel else { return UICollectionViewCell() }
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalValuesViewCell.identifier, for: indexPath) as? GlobalValuesViewCell {
                let globalValues = viewModel.globalValues[indexPath.row]
                cell.titleLabel.text = globalValues.title
                cell.valueLabel.text = globalValues.value
                
                return cell
            }
        }
        
        if collectionView == filterCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterViewCell.identifier, for: indexPath) as? FilterViewCell {
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension CoinsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CoinHeaderView.identifier) as? CoinHeaderView{
            return header
        }
        return UIView()
    }
    
}
extension CoinsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinsViewModel?.coins.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CoinViewCell.identifier, for: indexPath) as? CoinViewCell {
            guard let viewModel = coinsViewModel else { return UITableViewCell()}
            
            let coin = viewModel.coins[indexPath.row]
            cell.rankLabel.text = coin.rank
            cell.iconImageView.loadImage(from: coin.iconUrl)
            cell.symbolLabel.text = coin.symbol
            cell.priceLabel.text = coin.price
            cell.percentageLabel.text = coin.priceChangePercentage
            cell.marketCapitalizationLabel.text = coin.marketCapitalization
            
            return cell
        }
        return UITableViewCell()
    }
}
