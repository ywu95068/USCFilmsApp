//
//  Search.swift
//  hw91
//
//  Created by 吴月 on 4/28/21.
//

import SwiftUI
import UIKit
import Alamofire
import SwiftyJSON
struct result {
    var type:String
    var id:String
}
struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
struct Search: View {
    @State private var results:[result]=[]
    @State private var changed=false
    @State private var searchText : String = ""
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                if self.searchText.isEmpty {
         
                }
                else{
                    ScrollView(.vertical, showsIndicators: false){
                        if changed{
                            ForEach(0..<results.count){
                                
                                resultCard(type: results[$0].type, id: results[$0].id)
                            }
                        }
                    }.onAppear{self.getlist(keyword:searchText)}
                }
                Spacer()

            }
               }.navigationBarTitle(Text("Search"))
    }

    func getlist(keyword:String){
    let url="https://test1-310121.wl.r.appspot.com/search/"+keyword
    AF.request(url).responseJSON { (response) in
        switch response.result{
        case .success(let value):
            let json=JSON(value)
            for (key,subJson):(String, JSON) in json{
                if let type=subJson["media_type"].string{
                        if let id=subJson["id"].int{
                            let tem=result(type:type,id:String(id))
                            self.results.append(tem)
                            print(tem)
                            self.changed=true
                        }
                    
                }
               
            }
            break
        case .failure(let error):
            break
        }
    }
}}
struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
