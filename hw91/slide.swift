//
//  slide.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//

import SwiftUI
import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher
struct slide: View {
    @State private var time="()"
    @State private var timegot=false
    var url:String
    var title:String
    var id:String
    var type:String
    var info:Bool
    var body: some View {
        NavigationLink(destination:DetailPage(type:type, id: id)){
            VStack{
          
            KFImage(URL(string: url))
                .resizable()
                .cornerRadius(10)
                .frame(height:150)
                if info{
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    if timegot{
                        Text(time)
                            .foregroundColor(.secondary)
                    }
                }
            }.onAppear{self.getRequest()}
                      
       
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    func getRequest(){
        let url="https://test1-310121.wl.r.appspot.com/"+self.type+"/"+self.id
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                if let title=json["release_date"].string{
                    self.time="("+title+")"
                    self.timegot=true
                }
                break
            case .failure(let error):
                break
            }
        }
        
        
}
}

struct slide_Previews: PreviewProvider {
    static var previews: some View {
        slide(url:"https://image.tmdb.org/t/p/w500/oBgWY00bEFeZ9N25wWVyuQddbAo.jpg",title:"title",id:"615457",type: "movie",info: true)
    }
}
