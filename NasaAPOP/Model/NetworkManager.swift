//
// Created by Admin on 20.02.2022.
//

import Foundation


class NetworkManager {

    let url = "https://api.nasa.gov/planetary/apod?api_key=KhsyxIkSJ1yc5HGlhFxLoYRUeoc4j2u3s5KRiylg"

    func fetchData(completion: @escaping (Photo) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let data = data {
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
            }
            task.resume()
        }
    }
}

