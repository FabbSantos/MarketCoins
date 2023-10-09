//
//  API.swift
//  MarketCoins
//
//  Created by Fabricio Bahiense on 10/9/23.
//

import Foundation

struct API {
    static let baseURL = "https://api.coingecko.com/api/v3"
    static let coinsMarkets = "/coins/markets"
    static let coindByMarketChart = "/coins/%@/market_chart/range"
    static let coinsByIdOlhc = "/coins/%@/ohlc"
    static let global = "/global"
    static let coinsById = "/coins/%@"
}
