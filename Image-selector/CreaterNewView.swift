//
//  CreaterNewView.swift
//  Image-selector
//
//  Created by Prerana on 19/11/22.
//

import SwiftUI

struct CreaterNewView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    
    @State public var image : Data = .init(count: 0)
    @State public var sourceType : UIImagePickerController.SourceType = .photoLibrary
    @State public var show : Bool = false
    
    @State public var profileImg : Data = .init(count: 0)
    @State public var profile : Bool = false
    
    @State public var names = ""
    @State public var details = ""
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    if self.image.count != 0{
                        Button(action: {
                            self.show.toggle()
                        }) {
                            Image(uiImage: UIImage(data: self.image)!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        }
                    } else{
                        Button(action: {
                            self.show.toggle()
                        }){
                            Image(systemName: "photo.fill")
                                .font(.system(size: 120))
                                .foregroundColor(.gray)
                            
                        }
                    }
                    
                    Button(action: {
                        
                        let add = Saving(context: self.moc)
                        add.name = self.names
                        add.detail = self.details
                        add.imageD = self.image
                        add.profileImg = self.profileImg
                        add.date = Date()
                        
                        try! self.moc.save()
                        self.dismiss.wrappedValue.dismiss()
                        
                        self.names = ""
                        self.details = ""
                        self.image.count = 0
                        self.profileImg.count = 0
                    }) {
                        Text("Add")
                            .bold()
                            .padding()
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }.foregroundColor(.white)
                        .background(self.image.count != 0 ? Color.blue : Color.gray)
                    
                        .disabled(self.image.count != 0 ? false : true)
                    
                }.sheet(isPresented: self.$profile, content: {
                    ImagePicker(images: self.$profileImg, show: self.$profile, sourceType: self.sourceType)
                })

                
        }.navigationTitle("create new")
                .navigationBarItems(leading: HStack { if
                    self.profileImg.count != 0 { Button(action: {
                    self.profile.toggle()
                }) {
                    Image(uiImage: UIImage(data: self.profileImg)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }} else {
                    Button(action: {
                        self.profile.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                }
                   ,trailing: Button(action: {
                    self.dismiss.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                })
    }.sheet(isPresented: self.$show, content: {
            ImagePicker(images: self.$image, show: self.$show, sourceType: self.sourceType)
        })
    }
}
struct CreaterNewView_Previews: PreviewProvider {
    static var previews: some View {
        CreaterNewView()
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var images : Data
    @Binding var show : Bool
    var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(img1: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        let img0 : ImagePicker
        init(img1 : ImagePicker){
            img0 = img1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.img0.show.toggle()
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 0.50)
            self.img0.images = data!
            self.img0.show.toggle()
        }
    }
}

