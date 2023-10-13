//
//  CoinsListModels.swift
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

enum CoinsList
{
  // MARK: Use cases
  
  enum FetchGlobalValues {
    struct Request {
        let baseCoin: String
    }
    struct Response {
        let baseCoin: String
        let totalMarketCap: [String: Double]
        let totalVolume: [String: Double]
    }
    struct ViewModel {
        struct GlobalValues {
            let title: String
            let value: String
        }
        let globalValues: [GlobalValues]
    }
  }
    
    enum FetchListCoins {
        struct Request {
            let baseCoin: String
            let orderBy: String
            let top: Int
            let pricePercentage: String
        }
        
        struct Response {
            let baseCoin: String
            let id: String
            let symbol: String
            let name: String
            let image: String
            let currentPrice: Double
            let marketCap: Double
            let marketCapRank: Int?
            let priceChangePercentage: Double
        }
        
        struct ViewModel {
            struct Coin {
                let id,
                name,
                rank,
                iconUrl,
                symbol,
                price,
                priceChangePercentage,
                marketCapitalization: String
            }
            let coins: [Coin]
        }
    }
}
