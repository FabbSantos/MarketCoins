//
//  GlobalModel.swift
//  MarketCoins
//
//  Created by Fabricio Bahiense on 10/9/23.
//

import Foundation

struct GlobalModel: Codable {
    let data: CryptocurrencyModel
}

struct CryptocurrencyModel: Codable {
    let activeCryptocurrencies,
        upcomingIcos,
        ongoingIcos,
        endedIcos,
        markets : Int
    let totalMarketCap,
        totalVolume,
        marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
}
