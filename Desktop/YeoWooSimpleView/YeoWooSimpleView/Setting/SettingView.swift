//
//  SettingView.swift
//  YeoWooSimpleView
//
//  Created by 정회승 on 2023/07/14.
//

import SwiftUI

struct SettingView: View {
    @State private var name = "시저"
    @State private var role = "먹방 여우"
    @State private var myImage = "Caesar"
    @State private var notiToggle = true
    
    var body: some View {
        NavigationStack {
            //스크롤 뷰
            ScrollView{
                //프로필 뷰
                VStack{
                    Text("프로필")
                        .modifier(SubTitleFont())

                    NavigationLink{
                        
                    }label: {
                        HStack{
                            
                            Image(myImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 71, height: 71)
                                .background(Color.mainColor)
                                .clipShape(Circle())
                                .padding(.horizontal, 10 )
                            HStack{
                                VStack(alignment: .leading){
                                    Text(name)
                                        .font(.headline)
                                    Text(role)
                                        .font(.footnote)
                                        .bold()
                                    
                                }
                                
                                Spacer()
                                
                                    Image(systemName: "chevron.right")
                                        .imageScale(.large)
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 20)
                            }
                            
                        }
                        .modifier(CardViewModifier(height: 95))
                    }
                    .accentColor(.black)
                }
                
                //알림 on/off
                VStack{
                    Text("알림")
                        .modifier(SubTitleFont())
                    
                    HStack{
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(width: 27, height: 30)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 20 )
                        HStack{
                            Text("notification")
                                .font(.headline)
                       
                            Spacer()
                            
                            Toggle("", isOn: $notiToggle)
                                .padding(.trailing, 20)
                    }
                    }
                    .modifier(CardViewModifier())
                }
                
                //로그아웃/탈퇴
                VStack{
                    Text("로그아웃/탈퇴")
                        .modifier(SubTitleFont())
                    
                    
                        VStack {
                            NavigationLink{
                                
                            } label: {
                            HStack{
                            Image(systemName: "person.fill.badge.minus")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 20 )
                                HStack{
                                    Text("log out")
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.large)
                                    .foregroundColor(.gray)
                                
                                    .padding(.trailing, 20)
                            }
                            
                        }
                            .padding(.bottom, 10)
                            
                            Divider()
                            
                            NavigationLink{
                                
                            } label: {
                                HStack{
                                    Image(systemName: "eraser.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.gray)
                                        .padding(.horizontal, 20 )
                                    HStack{
                                        Text("delete account")
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .imageScale(.large)
                                            .foregroundColor(.gray)
                                        
                                            .padding(.trailing, 20)
                                    }
                                    
                                }
                                .padding(.top, 10)}
                            
                        }
                        .modifier(CardViewModifier(height: 130))
                       
                
                    .accentColor(.black)
                }
                
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.backgroundGray)
            
            
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
