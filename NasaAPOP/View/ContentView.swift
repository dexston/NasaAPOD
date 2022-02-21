//
//  ContentView.swift
//  NasaAPOP
//
//  Created by Admin on 20.02.2022.
//
//

import SwiftUI

struct ContentView: View {

    var networkManager = NetworkManager()

    @State var title = "empty"
    @State var date = Date()
    @State var explanation = "empty"
    @State var copyright = "empty"
    @State var url = "empty"
    @State var mediaType = "empty"

    var body: some View {
        VStack{
            Text(title)
            Text("\(date)")
            Text(explanation)
            Text(mediaType)
            Text(url)
        }
                .padding()
                .onAppear{
                    networkManager.fetchData { photo in
                        title = photo.title
                        date = photo.date
                        explanation = photo.explanation
                        //copyright = photo.copyright
                        url = photo.url
                        mediaType = photo.mediaType
                    }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
