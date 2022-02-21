//
//  ContentView.swift
//  NasaAPOP
//
//  Created by Admin on 20.02.2022.
//
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack{
            if let photo = viewModel.photo {
                Text(photo.title)
                Text("\(photo.date)")
                if let copyright = photo.copyright {
                    Text(copyright)
                }
                Text(photo.explanation)
                Text(photo.mediaType)
                Text(photo.url)
            }
        }
                .padding()
                .onAppear{
                    viewModel.fetchAPOD()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
