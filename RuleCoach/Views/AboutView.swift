//
//  AboutView.swift
//  RuleCoach
//
//  Created by Jeff Reinecke on 7/14/20.
//  Copyright © 2020 Jeff Reinecke. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let websiteUrl: URL = URL(string: "https://github.com/paploo/SlideRuleCoach")!
    
//    var image: Image {
//        guard
//            let url = Bundle.main.url(forResource: "FullSizeIcon", withExtension: "png"),
//            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
//            let cgimage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil),
//            let image = Image(cgimage, scale: 2, label: Text("RuleCoachIcon"))
//        else {
//            fatalError("Couldn't find image")
//        }
//        return image
//    }
    
    var body: some View {
        VStack {

            Image("FullSizeIcon")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text("RuleCoach")
                .font(.largeTitle)
            Text("©2020 Jeff Reinecke")
                .font(.subheadline)
            Text(websiteUrl.absoluteString)
                .font(.subheadline)
                .foregroundColor(.blue)
                .onTapGesture {
                    UIApplication.shared.open(self.websiteUrl)
            }
            
        }
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}


extension Image {
    static func fromBundle(_ baseName: String, ext: String = "png") -> Image {
        if
        let url = Bundle.main.url(forResource: baseName, withExtension: ext),
        let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
        let cgimage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) {
            return Image(cgimage, scale: 1, label: Text(baseName))
        } else {
            return Image(systemName: "exclamationmark.triangle")
        }
    }
}
