//
//  cast.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher
struct cast: View {
    var pic="https://image.tmdb.org/t/p/w500"
    var picpath:String
    var name:String
    var body: some View {
        VStack{
            KFImage(URL(string: pic+picpath))
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width:100,height:100)
            Text(name)
                .font(.system(size: 12))
        }
    }
}

struct cast_Previews: PreviewProvider {
    static var previews: some View {
        cast(picpath: "/lbUQ7ilvBtWMU23reKsHg3jRmsf.jpg", name: "Anna")
    }
}
