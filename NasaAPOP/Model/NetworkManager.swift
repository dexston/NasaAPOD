//
// Created by Admin on 20.02.2022.
//

import Foundation
import UIKit


class NetworkManager {

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private let url = "https://api.nasa.gov/planetary/apod?api_key=KhsyxIkSJ1yc5HGlhFxLoYRUeoc4j2u3s5KRiylg&date="

    func fetchData(for date: Date, completion: @escaping (Photo) -> Void) {
        let urlWithDate = url + dateFormatter.string(from: date)
        guard let url = URL(string: urlWithDate) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if error == nil,
            let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let dateFormatter = self?.dateFormatter else { fatalError() }
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

    func fetchImage(from url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else { return }
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

