//
//  ConfigurationView.swift
//  Time of Possession
//
//  Created by Jim Dabrowski on 11/11/21.
//

import SwiftUI

struct ConfigurationView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @ObservedObject var homeConfig: Configuration
    @ObservedObject var visitorConfig: Configuration
    
    @Binding var isPresented: Bool
    
    var heading: some View {
        HStack {
            LargeTitleText(title: "Settings")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading])
            Button {
                isPresented.toggle()
            } label: {
                Text("Done")
            }
            .padding([.top, .trailing])
            
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("background"))
            if verticalSizeClass == .compact {
                VStack {
                    heading
                    HStack {
                        Spacer()
                        TeamConfigurationView(configuration: homeConfig)
                        Spacer()
                        TeamConfigurationView(configuration: visitorConfig)
                        Spacer()
                    }
                }
            } else {
                VStack {
                    heading
                    Spacer()
                    TeamConfigurationView(configuration: homeConfig)
                    Spacer()
                    TeamConfigurationView(configuration: visitorConfig)
                    Spacer()
                }
            }
        }
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(homeConfig: Configuration(for: .home), visitorConfig: Configuration(for: .visitor), isPresented: .constant(true))
.previewInterfaceOrientation(.portrait)
        
        ConfigurationView(homeConfig: Configuration(for: .home), visitorConfig: Configuration(for: .visitor), isPresented: .constant(true))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
