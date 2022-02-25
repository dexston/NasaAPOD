//
// Created by Admin on 21.02.2022.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {

    @Published var photo: Photo?
    @Published var image: UIImage?
    @Published var showExplanation = false

    private let networkManager = NetworkManager()

    func fetchAPOD() {
        networkManager.fetchData { [weak self] photo in
            self?.photo = photo
            self?.networkManager.fetchImage(from: photo.url) { [weak self] image in
                self?.image = image
            }
        }
    }
}