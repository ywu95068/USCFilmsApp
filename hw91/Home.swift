//
//  Home.swift
//  hw91
//
//  Created by 吴月 on 4/28/21.
//

import SwiftUI

struct Home: View {
    @State private var movie=true
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
        VStack(alignment: .leading){
            VStack(alignment: .leading){
            Text("USC Films")
                .font(.system(.largeTitle))
                .fontWeight(.bold)
            if movie{
                Text("Now playing")
                    .font(.system(.title))
                    .fontWeight(.bold)
                causellist(keyurl: "popular_movie", type: "movie")
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 280, trailing: 0))
                VStack(alignment: .leading){
                Text("Top Rated")
                    .font(.system(.title))
                    .fontWeight(.bold)
                showlist(type:"movie",info:true,urlkey: "Toprated_movie")
                    .padding(.bottom)
            } .frame(height: 270)
                .padding(EdgeInsets(top: -50, leading: 0, bottom: 0, trailing: 0))
                VStack(alignment: .leading){
                Text("Popular")
                    .font(.system(.title))
                    .fontWeight(.bold)
                showlist(type:"movie",info:true,urlkey: "popular_movie")
                } .frame(height: 270)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            }
            else{
                Text("Trending")
                    .font(.system(.title))
                    .fontWeight(.bold)
                causellist(keyurl: "Trending_tv", type: "tv")
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 250, trailing: 0))
                VStack(alignment: .leading){
                Text("Top Rated")
                    .font(.system(.title))
                    .fontWeight(.bold)
                showlist(type:"tv",info:true,urlkey: "Toprated_tv")
            } .frame(height: 270)
                .padding(EdgeInsets(top: -50, leading: 0, bottom: 0, trailing: 0))
                VStack(alignment: .leading){
                Text("Popular")
                    .font(.system(.title))
                    .fontWeight(.bold)
                showlist(type:"tv",info:true,urlkey: "popular_tv")
            } .frame(height: 270)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            }
      
            }
           
        }.toolbar{ if movie{
                Button("TV show"){
                    self.changeType()
                }
            }
            else{
                Button("Movies"){
                    self.changeType()
                }
            }}
                VStack(alignment:.center){
                       Link("Powered by TMDB\nDeveloped by Yue Wu", destination: URL(string: "https://www.themoviedb.org")!)
                       .font(.subheadline)
                       .foregroundColor(.secondary)
                    Spacer()}.padding(EdgeInsets(top: 100, leading: 15, bottom: 5, trailing: 15))
        }.padding()
           
            Spacer()
        }
        
    }
    func changeType(){
        if(self.movie){
            self.movie=false
        }
        else{
            self.movie=true
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
