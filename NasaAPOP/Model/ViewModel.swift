//
// Created by Admin on 21.02.2022.
//

import Foundation

class ViewModel: ObservableObject {

    @Published var photo: Photo?

    private let networkManager = NetworkManager()

    func fetchAPOD() {
        networkManager.fetchData { [weak self] photo in
            self?.photo = photo
        }
    }


}