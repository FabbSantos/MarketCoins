//
//  GlobalStore.swift
//  MarketCoins
//
//  Created by user239336 on 10/9/23.
//

import Foundation

protocol GlobalStoreProtocol: GenericStoreProtocol {
    func fetchGlobal(completion: @escaping completion<GlobalModel?>)
}

class GlobalStore: GenericStoreRequest, GlobalStoreProtocol {
    func fetchGlobal(completion: @escaping completion<GlobalModel?>) {
        do {
            guard let url = try GlobalRouter.global.asURLRequest()
                else { return completion(nil, error) }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
}
