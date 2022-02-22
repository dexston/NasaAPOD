//
// Created by Admin on 21.02.2022.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {

    @Published var photo: Photo?
    @Published var image: UIImage?

    private let networkManager = NetworkManager()

    func fetchAPOD() {
        networkManager.fetchData { [weak self] photo in
            self?.photo = photo
            self?.networkManager.fetchImage(from: photo.url) { [weak self] image in
                self?.image = image
            }
        }
    }

    func fetchImage() {
        guard let photo = photo else { return }
        networkManager.fetchImage(from: photo.url) { [weak self] image in
            self?.image = image
        }
    }

    func getDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }


}