//
//  reviewlist.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
struct Review {
    
    var name:String
    var time:String
    var vote:String
    var content:String
}
struct reviewlist: View {
    var type:String
    var id:String
    var title:String
    @State private var reviews:[Review]=[]
    @State private var changed=false
    var body: some View {
        VStack{
        if changed{
        
            ForEach(0..<self.reviews.count){
                review(type: type, id: id, title: title, name: reviews[$0].name, time: reviews[$0].time, vote: reviews[$0].vote, content: reviews[$0].content)
            }
        }
        }.onAppear{self.getreview()}
        
    }
    func getreview(){

        let url="https://test1-310121.wl.r.appspot.com/"+self.type+"/reviews/"+self.id
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                for (key,subJson):(String, JSON) in json["reviews"] {
                    if let content=subJson["content"].string{
                        if let time=subJson["created_at"].string{
                            if let vote=subJson["rating"].double{
                                if let name=subJson["author"].string{
                                    let timeR=time.components(separatedBy: ".")[0]
                                    let str=String(vote/2)
                                    let startIndex=str.index(str.startIndex, offsetBy: 0)
                                    let endIndex=str.index(str.startIndex, offsetBy: 3)

                                    let voteR=String(str[startIndex..<endIndex])
                                let tem=Review(name:name,time:timeR,vote: voteR,content: content)
                        
                                self.reviews.append(tem)
                                self.changed=true
                                }
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

struct reviewlist_Previews: PreviewProvider {
    static var previews: some View {
        reviewlist(type: "movie", id: "460465",title: "this")
    }
}
