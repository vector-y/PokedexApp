//
//  Helpers.swift
//  PokedexApp
//
//  Created by Victor Tran on 6/9/22.
//

import Foundation

// both are extensions on bundle, so we can later call them on any kind of file we want as generic helpers

extension Bundle {
    // generic function that requires a the pokemon json file, returns the data from the file
    func decode<T:Decodable>(file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from the bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from the bundle.")
        }
        return loadedData
    }
    
    // fetches and decodes the json data
    func fetchData<T:Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (),
                                failure:@escaping(Error) -> ()){
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                return
            }
            
            do{
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }
        .resume()
    }
}
