//
// Created by Admin on 20.02.2022.
//

import Foundation
import UIKit


class NetworkManager {

    private let url = "https://api.nasa.gov/planetary/apod?api_key=KhsyxIkSJ1yc5HGlhFxLoYRUeoc4j2u3s5KRiylg"

    func fetchData(completion: @escaping (Photo) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error == nil,
            let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                do {
                    let result = try decoder.decode(Photo.self, from: data)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }

    func fetchImage(from url: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error == nil,
               let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        task.resume()
    }
}

