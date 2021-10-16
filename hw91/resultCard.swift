//
//  resultCard.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//


import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher
struct resultc {
    var title:String
    var poster:String
    var time:String
    var vote:String
}
struct resultCard: View {

    var type:String
    var id:String
    @State private var binfo=resultc(title: "", poster: "", time: "", vote: "")
    @State private var binfoget=false
    var body: some View {
        NavigationLink(destination:DetailPage(type:type, id: id)){
        ZStack{
            if binfoget{
                KFImage(URL(string: self.binfo.poster))
                    .resizable()
                    .cornerRadius(10)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .frame(width:370,height:200)
                VStack{
                    HStack(alignment: .top){
                        Text(type.uppercased()+"("+self.binfo.time+")")
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.red)
                        Text(self.binfo.vote)
                            .fontWeight(.bold)
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                }.foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame( alignment: .topTrailing)
                    HStack{
                    Text(self.binfo.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 120, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    }
                }
                
            }
        }.onAppear{self.getcard()}
        }
    }
    func getcard(){
        let url="https://test1-310121.wl.r.appspot.com/"+self.type+"/"+self.id
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                if let title=json["title"].string{
                    self.binfo.title=title
                }
                if let poster=json["poster_path"].string{
                    self.binfo.poster="https://image.tmdb.org/t/p/w500"+poster
                }
                if let time=json["release_date"].string{
                    self.binfo.time=time
                }

                if let vote=json["vote_average"].double{
                    let str=String(vote/2)
                    let startIndex=str.index(str.startIndex, offsetBy: 0)
                    let endIndex=str.index(str.startIndex, offsetBy: 3)

                    self.binfo.vote=String(str[startIndex..<endIndex])
                    self.binfoget=true
                }
                break
            case .failure(let error):
                break
            }
        }
    }
}

struct resultCard_Previews: PreviewProvider {
    static var previews: some View {
        resultCard(type: "movie", id: "681019")
    }
}
