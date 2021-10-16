//
//  DetailPage.swift
//  hw91
//
//  Created by 吴月 on 4/27/21.
//
import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI
import youtube_ios_player_helper

struct BasicInfo:Codable{
    var title:String
    var time:String
    var genres:String
    var vote_aver:String
    var overview:String
    
}
struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
}
struct DetailPage: View {
    var type:String
    var id:String
    @State private var youtubeid=""
    @State private var youtubegot=false
@State private var info=""
    @State private var binfo=BasicInfo(title:"",time:"",genres:"",vote_aver:"0.0",overview:"")
    @State private var binfoget=false
    @State private var haveRec=true
    @State private var havecast=true
    @State private var havereview=true
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
        VStack(alignment: .leading, spacing: 10){
            if youtubegot{
                YTWrapper(videoID: youtubeid)
                    .frame( height: 200)
            }
            if binfoget{
                
            Text(binfo.title)
                .font(.system(.title))
                .fontWeight(.bold)
                .frame( alignment: .topLeading)
            Text(binfo.time+" | "+binfo.genres)

            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(Color.red)
                Text(binfo.vote_aver+"/5.0")
            }
            Text(binfo.overview)
                .font(.system(size: 12))
                .lineLimit(3)
            }
            if havecast{
                Text("Cast&Crew")
                        .font(.system(.title))
                        .fontWeight(.bold)
                castlist(type:type,id:id)
            }
            if havereview{
                Text("Reviews")
                        .font(.system(.title))
                        .fontWeight(.bold)
                reviewlist(type:type,id:id,title:binfo.title)
            }
            if haveRec{
                VStack(alignment: .leading){
                if (type=="movie"){
                Text("Recommended Movies")
                        .font(.system(.title))
                        .fontWeight(.bold)
                }
                else {
                    Text("Recommended TV shows")
                            .font(.system(.title))
                            .fontWeight(.bold)
                }
            showlist(type: type, info:false, urlkey:"/recommend_"+type+"/"+id)
                .padding(EdgeInsets(top: -40, leading: 0, bottom: 0, trailing: 0))
                } .frame(height: 270)
                .padding(EdgeInsets(top: -90, leading: 0, bottom: 50, trailing: 0))
            }
        }
        }.onAppear{self.getRequest()}
        .padding()
    }
    func getRequest(){
        let url="https://test1-310121.wl.r.appspot.com/"+self.type+"/"+self.id
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                if let title=json["title"].string{
                    self.binfo.title=title
                }
                if let genres=json["genres"].string{
                    self.binfo.genres=genres
                }
                if let time=json["release_date"].string{
                    self.binfo.time=time
                }
                if let overview=json["overview"].string{
                    self.binfo.overview=overview
                }
                if let vote=json["vote_average"].double{
                    let str=String(vote/2)
                    let startIndex=str.index(str.startIndex, offsetBy: 0)
                    let endIndex=str.index(str.startIndex, offsetBy: 3)

                    self.binfo.vote_aver=String(str[startIndex..<endIndex])
                    self.binfoget=true
                }
                break
            case .failure(let error):
                self.info="error"
                break
            }
        }
        let yurl="https://test1-310121.wl.r.appspot.com/"+self.type+"/video/"+self.id
        AF.request(yurl).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                if let videoId=json["videoId"].string{
                    self.youtubeid=videoId
                    self.youtubegot=true
                }
                break
            case .failure(let error):
                self.info="error"
                break
            }
        }
        let rurl="https://test1-310121.wl.r.appspot.com/"+"recommend_"+type+"/"+id
        AF.request(yurl).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                break
            case .failure(let error):
                self.info="error"
                break
            }
        }
        
        
}
    func update(_ info:String){
            self.info=info
    }
    func setbinfo(){
        self.binfo.title="Mortal Kombat"
        self.binfo.genres="Fantasy,Action,Adventure,Science Fiction,Thriller,"
        self.binfo.time="2021"
        self.binfo.overview="Washed-up MMA fighter Cole Young, unaware of his heritage, and hunted by Emperor Shang Tsung's best warrior, Sub-Zero, seeks out and trains with Earth's greatest champions as he prepares to stand against the enemies of Outworld in a high stakes battle for the universe.Washed-up MMA fighter Cole Young, unaware of his heritage, and hunted by Emperor Shang Tsung's best warrior, Sub-Zero, seeks out and trains with Earth's greatest champions as he prepares to stand against the enemies of Outworld in a high stakes battle for the universe."
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(type: "movie", id: "460465")
    }
}
struct basicinfo: Codable {
    var overview: String
}

extension View{
 
}
