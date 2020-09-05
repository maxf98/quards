//
//  Tagview.swift
//  Quards
//
//  Created by Max Fest on 18.08.20.
//

import SwiftUI

struct TagView: View {
	
	var name: String
	
	var removeTag: (String) -> Void
	
	var body: some View {
		HStack {
			Text(name)
				.foregroundColor(.white)
				.lineLimit(1)
				.minimumScaleFactor(0.7)
				.allowsTightening(true)
				.padding(10)
			
			Button(action: {
				self.removeTag(name)
			}) {
				Image(systemName: "xmark.circle.fill")
					.padding(5)
			}
		}
		.background(RoundedRectangle(cornerRadius: 5).foregroundColor(.gray))
	}
}

struct TagView_Previews: PreviewProvider {
	static var previews: some View {
		TagView(name: "hello", removeTag: {_ in})
			.frame(width: 30, height: 30)
	}
}
