//
//  reviewpage.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//

import SwiftUI

struct reviewpage: View {
    var title:String
    var name:String
    var time:String
    var vote:String
    var content:String
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(.title))
                    .fontWeight(.bold)
                    .frame( alignment: .topLeading)
                    .padding(2)
                Text("By "+name+" on "+time)
                    .foregroundColor(.secondary)
                    .padding(2)
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.red)
                    Text(vote+"/5.0")
                }.padding(2)
                Divider()
                Text(content)

            }.padding(10)
    }
}

struct reviewpage_Previews: PreviewProvider {
    static var previews: some View {
        reviewpage(title: "title", name: "name", time: "time", vote: "2", content: "As pure popcorn entertainment and the culmination of the Monsterverse saga, 'Godzilla vs")
    }
}
}
