//
//  causel.swift
//  hw91
//
//  Created by 吴月 on 4/29/21.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher
struct causel: View {
    @State private var changed=false
    var thpic:String
    var id:String
    var type:String
    var body: some View {
        NavigationLink(destination:DetailPage(type:type, id: id)){
        ZStack{
            KFImage(URL(string: thpic))
                .resizable()
                .frame(width:370,height:300)
                .blur(radius: 6.0 ,opaque: true)
                
            KFImage(URL(string: thpic))
                .resizable()
                .frame(width:200,height:300)
            
        }
        
        }
    }

}
struct causel_Previews: PreviewProvider {
    static var previews: some View {
        causel(thpic:"https://image.tmdb.org/t/p/w500/pwDvkDyaHEU9V7cApQhbcSJMG1w.jpg", id: "460465",type: "movie")
    }
}
