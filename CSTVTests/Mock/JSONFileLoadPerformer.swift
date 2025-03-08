//
//  JSONFileLoadPerformer.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import Foundation

protocol JSONFileLoadPerformer { }

extension JSONFileLoadPerformer {
    func load<T: Decodable>(fileName: String, type: T.Type, delay: DispatchTime = .now() + 0.1, completion: @escaping ((_ result: T?, _ error: Error?) -> Void)) {
        DispatchQueue.global().asyncAfter(deadline: delay) {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                print("Failed to load \(fileName).json. \nMake sure the file is added correctly (Build Phases > Copy Bundle Resources)")
                completion(nil, NSError(domain: "Failed to load file \(fileName)", code: 1))
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let result = try decoder.decode(type, from: data)
                
                print("Sucesso: \(result)")
                completion(result, nil)
            } catch let DecodingError.dataCorrupted(context) {
                completion(nil, NSError(domain: "Erro: Data corrompida - \(context.codingPath) - \(context.debugDescription)", code: 0))
            } catch let DecodingError.keyNotFound(key, context) {
                completion(nil, NSError(domain: "Erro: Chave '\(key.stringValue)' não encontrada - \(context.codingPath) - \(context.debugDescription)", code: 0))
            } catch let DecodingError.typeMismatch(type, context) {
                    completion(nil, NSError(domain: "Erro: Tipo incompatível \(type) - \(context.codingPath) - \(context.debugDescription)", code: 0))
            } catch let DecodingError.valueNotFound(type, context) {
                        completion(nil, NSError(domain: "Erro: Valor não encontrado \(type) - \(context.codingPath) - \(context.debugDescription)", code: 0))
            } catch {
                completion(nil, NSError(domain: "Erro desconhecido: \(error)", code: 0))
            }
        }
    }
}
