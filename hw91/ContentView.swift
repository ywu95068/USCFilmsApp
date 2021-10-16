//
//  ContentView.swift
//  hw91
//
//  Created by 吴月 on 4/27/21.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selection = 1
    var body: some View {
        VStack{
            TabView(selection: $selection) {
                    
                Search().tabItem { Text("Search"); Image(systemName: "magnifyingglass")}.tag(2)
                Home().tabItem { Text("Home"); Image(systemName: "house") }.tag(1)
                Text("Watchlist is empty").tabItem { Text("WatchList"); Image(systemName: "heart") }.tag(3)
                    .foregroundColor(.secondary)
            }
        }
        }

    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

struct nowPlaying {
    var body: some View{
        Text("Now Playing")
    }
}

