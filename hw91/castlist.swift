//
//  castlist.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//


import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher
struct Cast:Codable {
    var name:String
    var poster:String
}
struct castlist: View {
    var type:String
    var id:String
    @State private var casts:[Cast]=[]
    @State private var changed=false

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: true){
            HStack(spacing: 0) {
                if changed{
                    
                    ForEach(0..<casts.count){
                       
                        cast(picpath: casts[$0].poster, name: casts[$0].name)
                        .padding(1)
                            .frame(height: 120)
                        }
                }
                   
                }
            }
        }
        .frame(height: 140)
        .onAppear{self.getcastlist()}
                    .padding(10)
    }
    func getcastlist(){

        let url="https://test1-310121.wl.r.appspot.com/castlist/"+self.type+"/"+self.id
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                for (key,subJson):(String, JSON) in json["cast"] {
                    if let poster=subJson["profile_path"].string{
                            if let name=subJson["name"].string{
                                print(poster)
                                let tem=Cast(name:name,poster:poster)
                                self.casts.append(tem)
                                self.changed=true
                                
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

struct castlist_Previews: PreviewProvider {
    static var previews: some View {
        castlist(type: "movie", id: "724089")
    }
}
