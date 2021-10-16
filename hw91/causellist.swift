//
//  causellist.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//


import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher
struct videolist:Codable {
    var id:String
    var poster:String
    var title:String
    
}
struct causellist: View {
    var keyurl:String
    var type:String
    @State private var videos:[videolist]=[]
    @State private var changed=false
    var body: some View {
        VStack{
        if changed{
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
            ForEach(0..<videos.count){
                causel(thpic: self.videos[$0].poster, id: self.videos[$0].id, type: type)
                    
                    .clipped()
            }
                }}
        }
        .animation(.spring())
            
        }
        }.onAppear{self.getlist()}
        
    }

func getlist(){
    let url="https://test1-310121.wl.r.appspot.com/"+keyurl
    AF.request(url).responseJSON { (response) in
        switch response.result{
        case .success(let value):
            let json=JSON(value)
            for (key,subJson):(String, JSON) in json["resultsforphone"] {
                if let poster=subJson["poster_path"].string{
                    if let title=subJson["title"].string{
                        if let id=subJson["id"].int{
                        let post_path="https://image.tmdb.org/t/p/w500"+poster
                            let tem=videolist(id:String(id),poster:post_path,title:title)
                            self.videos.append(tem)
                            self.changed=true
                        }
                    }
                }
               
            }
            break
        case .failure(let error):
            break
        }
    }
}}
struct causellist_Previews: PreviewProvider {
    static var previews: some View {
        causellist(keyurl: "popular_movie", type: "movie")
    }
}
