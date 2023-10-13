//
//  CryptocurrencyError.swift
//  MarketCoins
//
//  Created by Fabricio Bahiense on 10/10/23.
//

import Foundation

enum CryptocurrencyError: Error {
    case internalServerError
    case badRequestError
    case notFoundError
    case undefinedError
    
    var errorDescription: String {
        switch self {
        case .internalServerError:
            return "Ocorreu um erro no servidor. Tente novamente mais tarde."
        case .badRequestError:
            return "Sua requisicao nao foi bem sucedida."
        case .notFoundError:
            return "O servico que voce esta buscando nao existe."
        case .undefinedError:
            return "Ocorreu um erro. Tente novamente mais tarde. "
        }
    }
    
}
