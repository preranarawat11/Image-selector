//
//  ContentView.swift
//  Image-selector
//
//  Created by Prerana on 19/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Saving.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Saving.name, ascending: true),
        NSSortDescriptor(keyPath: \Saving.detail, ascending: false),
        NSSortDescriptor(keyPath: \Saving.imageD, ascending: false),
        NSSortDescriptor(keyPath: \Saving.favourite, ascending: true),
        NSSortDescriptor(keyPath: \Saving.date, ascending: true)])
    var saving : FetchedResults<Saving>
                         
    @State public var image : Data = .init(count: 0)
    @State public var show : Bool = false
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    var date = Date()
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                ForEach(saving, id: \.name){ savi in
                    VStack(alignment: .leading, spacing: 15){
                        Image(uiImage: UIImage(data: savi.imageD ?? self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 32, height: 220)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        
                         HStack{
                          /*  ForEach(0..<5, id: \.self) { star in
                                Button(action: {
                                    savi.favourite = Int64(star)
                                    try! self.moc.save()
                                }) {
                                    Image(systemName: savi.favourite >= star ? "star.fill": "star")
                                        .foregroundColor(savi.favourite >= star ? .yellow : .gray)
                                }
                                
                            }*/
                        Text("\(savi.name ?? "")")
                                .bold()
                       /* }
                       
                        Text("\(savi.date ?? self.date, formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.gray)*/
                    }
                  }
                }
            }.navigationTitle("Images")
                .navigationBarItems(trailing: Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "plus")
                })
        }.sheet(isPresented: self.$show, content: {
            CreaterNewView().environment(\.managedObjectContext, self.moc)
        })
    }
}
   

   



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

