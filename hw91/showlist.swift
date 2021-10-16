//
//  showlist.swift
//  hw91
//
//  Created by 吴月 on 4/28/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher

struct Videolist:Codable {
    var id:String
    var poster:String
    var title:String
    
}
struct showlist: View {
    var type:String
    var info:Bool
    var urlkey:String
    @State private var videos:[Videolist]=[]
    @State private var changed=false
    var a=[1,2,3,4,5]
    var body: some View {

        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: true){
            HStack(spacing: 0) {
                if changed{
                    
                    ForEach(0..<videos.count){
                       
                        slide(url:videos[$0].poster,title:videos[$0].title,id:videos[$0].id,type: type,info: info)
                            
                            .cornerRadius(10)
                            .font(.system(size: 12))
                            
                            
                            .frame(width: geometry.size.width * 0.33)
                        .padding(10)
                        }
                    
                }
                   
                }
            }
        }
        .frame(height: 50)
        .onAppear{self.getlist()}
                    .padding(10)
    }

func getlist(){

    let url="https://test1-310121.wl.r.appspot.com/"+urlkey
    AF.request(url).responseJSON { (response) in
        switch response.result{
        case .success(let value):
            let json=JSON(value)
            for (key,subJson):(String, JSON) in json["resultsforphone"] {
                if let poster=subJson["poster_path"].string{
                    if let title=subJson["title"].string{
                        if let id=subJson["id"].int{
                        let post_path="https://image.tmdb.org/t/p/w500"+poster
                            let tem=Videolist(id:String(id),poster:post_path,title:title)
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
}
}
struct showlist_Previews: PreviewProvider {
    static var previews: some View {
        showlist(type: "movie", info: true,urlkey:"Toprated_movie")
    }
}
