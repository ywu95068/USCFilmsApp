//
//  review.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//

import SwiftUI
import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI

struct review: View {
    var type:String
    var id:String
    var title:String
    var name:String
    var time:String
    var vote:String
    var content:String

    var body: some View {
        NavigationLink(destination:reviewpage(title: title, name: name, time: time, vote: vote, content: content)){
        VStack(alignment: .leading){
                Text("A review by "+name)
                    .font(.system(.headline))
                    .fontWeight(.bold)
                    .frame( alignment: .topLeading)
                    .foregroundColor(Color.black)
                
                Text("Written by "+name+" on "+time)
                    .font(.system(size:13))
                    .foregroundColor(.secondary)
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.red)
                    Text(vote+"/5.0")
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .font(.system(size:15)).padding(2)
                Text(content)
                    .font(.system(size:13))
                    .foregroundColor(Color.black)
                    .lineLimit(3)
           
                
        }.padding(10)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.lightGray), lineWidth: 1)
            )
        }
    }
}
    



struct review_Previews: PreviewProvider {
    static var previews: some View {
        review(type: "movie", id: "460465",title: "this",name: "name",time:"String",vote:"String",content:"String")
    }
}
