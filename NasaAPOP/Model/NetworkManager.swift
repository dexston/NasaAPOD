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

    func fetchData(for date: Date) async -> Photo? {
        let urlWithDate = url + dateFormatter.string(from: date)
        guard let url = URL(string: urlWithDate) else { fatalError() }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try decoder.decode(Photo.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }

    func fetchImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print(error)
            return nil
        }
    }
}

