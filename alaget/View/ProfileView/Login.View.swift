//
//  Login.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 28/08/2020.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import Combine


struct SignUpWithAppleView: UIViewRepresentable {
    
    @Binding var name : String
    
    func makeCoordinator() -> AppleSignUpCoordinator {
        return AppleSignUpCoordinator(self)
    }
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        //Creating the apple sign in button
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
                                                  authorizationButtonStyle: .black)
        button.cornerRadius = 10
        
        
        //Adding the tap action on the apple sign in button
        button.addTarget(context.coordinator,
                         action: #selector(AppleSignUpCoordinator.didTapButton),
                         for: .touchUpInside)
            
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}


class AppleSignUpCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var parent: SignUpWithAppleView?
    
    init(_ parent: SignUpWithAppleView) {
        self.parent = parent
        super.init()

    }
    
    @objc func didTapButton() {
        //Create an object of the ASAuthorizationAppleIDProvider
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        //Create a request
        let request         = appleIDProvider.createRequest()
        //Define the scope of the request
        request.requestedScopes = [.fullName, .email]
        //Make the request
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        //Assingnig the delegates
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let vc = UIApplication.shared.windows.last?.rootViewController
        return (vc?.view.window!)!
    }
    
    //If authorization is successfull then this method will get triggered
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization)
    {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("credentials not found....")
            return
        }
        
        //Storing the credential in user default for demo purpose only deally we should have store the credential in Keychain
        let defaults = UserDefaults.standard
        defaults.set(credentials.user, forKey: "userId")
        parent?.name = "\(credentials.fullName?.givenName ?? "")"
        
        
        
        
        
    }
    
    //If authorization faced any issue then this method will get triggered
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        //If there is any error will get it here
        print("Error In Credential")
    }
}


class GoogleStuff: UIViewController, GIDSignInDelegate, ObservableObject {

    var googleSignIn = GIDSignIn.sharedInstance()
    @ObservedObject var auth = ProfileStore()
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard user != nil else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
    
        
        guard let authentication = user.authentication else { return }
        if error == nil {
            guard let _ = user.authentication else { return }

            let _ = user.authentication.accessToken
            if let _ = authentication.idToken {
                let url = URL(string:  "https://www.googleapis.com/oauth2/v3/userinfo?access_token=\(user.authentication.accessToken ?? "")")
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let request = URLRequest.init(url: url!)
                print("THIS LINE IS PRINTED")
                let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                    if error != nil {
                        print("dataTaskWithURL error \(error?.localizedDescription ?? "")")
                    }
                    else {
                        do {
                            let userData = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:AnyObject]
                            /*
                             Get the account information you want here from the dictionary
                             Possible values are
                             "id": "...",
                             "email": "...",
                             "verified_email": ...,
                             "name": "...",
                             "given_name": "...",
                             "family_name": "...",
                             "link": "https://plus.google.com/...",
                             "picture": "https://lh5.googleuserco...",
                             "gender": "...",
                             "locale": "..."

                             so in my case:
                             */

                            DispatchQueue.main.async {
                                
                            
//                            userStore.profile?.firstName = (userData!["name"] as! String?) ?? ""
                            userStore.profile?.firstName = (userData!["given_name"] as! String?) ?? ""
                            userStore.profile?.lastName = (userData!["family_name"] as! String?) ?? ""
                            userStore.profile?.phoneNumber = (userData!["phoneNumber"] as! String?) ?? "-"
                            userStore.profile?.photoURL = ((userData!["picture"] as! String?) ?? "") + "?type=large"
                            userStore.profile?.email = ((userData!["email"] as! String?) ?? "")
                            var _ = (userData!["email_verified"] as! Bool?) ?? false
                            var _ = (userData!["locale"] as! String?) ?? ""
                            let gender = (userData!["gender"] as! String?) ?? ""


                            if (gender == "") {
                                if (gender == "male") {
                                    userStore.profile?.gender = 1
                                } else if (gender == "female") {
                                    userStore.profile?.gender = 2
                                } else {
                                    userStore.profile?.gender = 3
                                }
                            }
                            
                            userStore.isLogin = true
                        }

                        } catch {
                            NSLog("Account Information could not be loaded")
                        }
                    }
                })
                task.resume()
            }
            
        } else {
            print("\(error.localizedDescription)")
//            if signInBlock != nil {
//                signInBlock!(false, nil, error)
//            }
        }
    
        print("TOKEN => \(user.authentication.idToken!)")

        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        guard user != nil else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
        
        print("TOKEN => \(user.authentication.idToken!)")
        
    }
}

struct ImageCarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content

    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            // 1
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                    .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                    .animation(.spring())
                    .onReceive(self.timer) { _ in
                        self.currentIndex = (self.currentIndex + 1) % (self.numberOfImages == 0 ? 1 : self.numberOfImages)
                }
                
                // 2
                HStack(spacing: 3) {
                    // 3
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                         // 4
                        Circle()
                            .frame(width: index == self.currentIndex ? 10 : 8,
                                   height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.blue : .white)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 8)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 1
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct Login_View: View {
    @State var name = ""
    @State var isPresented: Bool = false
    let googleSignIn = GIDSignIn.sharedInstance()
    @ObservedObject var myGoogle = GoogleStuff()
    @EnvironmentObject var auth: ProfileStore
    @State var attempts: Int = 0
    @State var selection: Int = 0
//    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
//        NavigationView{
            VStack{
                VStack{
                    Spacer(minLength: 20)
                    
                    if (auth.isLogin) {
                        Text((Bundle.main.name.capitalized))
                            .font(.custom("TrebuchetMS-Bold", size: 35))
                            .foregroundColor(Color.red.opacity(0.6))
                            .shadow(color: Color.red.opacity(0.8), radius:  2)
                            .frame(height: UIScreen.main.bounds.height / 30, alignment: .center)
                            .modifier(Shake(animatableData: CGFloat(attempts)))
                    } else {
                        Spacer()
                        Text("")
                    }
                    Button(action: {
                        self.isPresented = (auth.isLogin)
                        if (!auth.isLogin) {
                            let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.error)
                            withAnimation(.default) {
                                self.attempts += 1
                            }
                        }
                    }) {
                        ZStack{
                            Spacer()
                            
                            Image("flight")
                                .resizable()
                                .frame(height: UIScreen.main.bounds.height / 1.6, alignment: .center)
                                .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(15)
                                .shadow(color: Color.shadowColor(for: self.colorScheme), radius:  20)
                                    
                            VStack(alignment: .center){
//                                Spacer()
                                if (!auth.isLogin) {
                                    Text((Bundle.main.name.capitalized))
                                        .font(.custom("TrebuchetMS-Bold", size: 35))
                                        .foregroundColor(Color.red.opacity(0.7))
                                        .shadow(color: Color.black.opacity(0.5), radius:  2)
                                        .frame(height: UIScreen.main.bounds.height / 30, alignment: .center)
                                        .padding([.top], 35)
                                }
                                VStack(spacing: 10){
                                    Text("People fly different direction today")
                                        .foregroundColor(Color.white)
                                        .font(.custom("ArialRoundedMTBold", size: 25))
                                        .lineLimit(5)
                                        .multilineTextAlignment(.center)
                                }
                                .padding([.top, .bottom], 35)
                                VStack(spacing: 10){
                                    Text("Send something to your family or friends. Find who is flying to your country")
                                        .foregroundColor(Color.white.opacity(0.9))
                                        .font(.custom("TrebuchetMS-Bold", size: 16))
                                        .lineLimit(5)
                                        .multilineTextAlignment(.center)
                                }
                                Spacer()
                                Button(action: {
                                    self.isPresented = true
                                }) {
                                    Text("Exlpoer")
                                        .padding([.top, .bottom], 10)
                                        .padding([.leading, .trailing], 20)
                                        .font(.custom("TrebuchetMS-Bold", size: 16))
                                        .background(Color.white)
                                        .cornerRadius(3)
                                    
                                }
                                .disabled(!(auth.isLogin))
                                .opacity((auth.isLogin) ? 1 : 0)
                                .padding(.bottom, 50)
                            }
                            .padding([.leading, .trailing], 20)
                            
                            
                        }
                    }
                    Spacer(minLength: 20)
                   
                    if (!auth.isLogin) {
                        VStack(spacing: 10) {
                            Button(action: {
                                self.googleSignIn?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                                self.googleSignIn?.clientID = "59239181686-8aeabons2tll000m8v9jtaf737lr56um.apps.googleusercontent.com" //It is just a playground for now
                                self.googleSignIn?.delegate = self.myGoogle
                                self.googleSignIn?.signIn()
                            }) {
                                HStack{
                                    Image("google")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(Color.white)
                                    Text("Sign in with Google")
                                        .foregroundColor(Color.blue.opacity(0.6))
                                        .fontWeight(.medium)
                                        .font(.system(size: 16))
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                // .background(Color(red: 0.257, green: 0.534, blue: 0.962))
                                .background(Color.white)
                            }
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.4), radius:  1)
                            
                            //                        FacebookLoginBtn()
                            Button(action: {
                                //                            let loginManager = LoginManager()
                                ////                            if AccessToken.current != nil{
                                //                                loginManager.logIn(permissions: [.email,.publicProfile,.userGender,.userBirthday], viewController: nil) { result in
                                //
                                //                                    switch result {
                                //                                    case .failed(let error):
                                //                                        print(error)
                                //                                    case .cancelled:
                                //                                        print("User cancelled login.")
                                //                                    case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                                //                                        print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                                //                                        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, birthday, gender, email"]).start(completionHandler: { (connection, result, error) -> Void in
                                //                                            if (error == nil){
                                //                                                let fbDetails = result as! NSDictionary
                                //                                                userStore.profile?.lastName = fbDetails["name"] as! String
                                //                                                userStore.profile?.firstName = fbDetails["first_name"] as! String
                                //                                                userStore.profile?.email = fbDetails["email"] as! String
                                //                                                let gender = fbDetails["gender"] as! String
                                //                                                userStore.profile?.dateOfBirth = fbDetails["birthday"] as! String
                                //
                                //                                                if (gender == "") {
                                //                                                    if (gender == "male") {
                                //                                                        userStore.profile?.gender = 1
                                //                                                    } else if (gender == "female") {
                                //                                                        userStore.profile?.gender = 2
                                //                                                    } else {
                                //                                                        userStore.profile?.gender = 3
                                //                                                    }
                                //                                                }
                                //                                                print(fbDetails)
                                //                                            }
                                //                                        })
                                //                                    }
                                //                                }
                                ////                            }
                            }) {
                                
                                HStack{
                                    Image("facebook")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(Color.white)
                                    Text("Sign in with Facebook")
                                        .foregroundColor(.white)
                                        .fontWeight(.medium)
                                        .font(.system(size: 16))
                                    //                                    .font(.custom("TrebuchetMS-Bold", size: 16))
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                .background(Color(red: 0.259, green: 0.41, blue: 0.706))
                                
                                
                            }
                            .cornerRadius(10)
                            .shadow(color: Color.blue, radius:  1)
                            
                            //                        SignUpWithAppleView(name: $name)
                            
                            SignInWithAppleButton(
                                .signIn,
                                onRequest: { request in
                                    let appleIDProvider = ASAuthorizationAppleIDProvider()
                                    let request = appleIDProvider.createRequest()
                                    request.requestedScopes = [.fullName, .email]
                                },
                                onCompletion: { result in
                                    switch result {
                                    case .success(let authResults):
                                        switch authResults.credential {
                                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                            let _ = appleIDCredential.user
                                            auth.isLogin = true
                                            //                                                let fullName = appleIDCredential.fullName
                                            //                                                let email = appleIDCredential.email
                                            //                                                let defaults = UserDefaults.standard
                                            //                                                defaults.set(userIdentifier, forKey: "userIdentifier1")
                                            
                                            //Save the UserIdentifier somewhere in your server/database
                                            //                                                let vc = UserViewController()
                                            //                                                vc.userID = userIdentifier
                                            //                                                self.present(UINavigationController(rootViewController: vc), animated: true)
                                            break
                                        default:
                                            break
                                        }
                                        
                                    case .failure(let error):
                                        print("Authorization failed: " + error.localizedDescription)
                                    }
                                }
                            )
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .cornerRadius(10)
                            .shadow(color: Color.blue, radius:  1)
                            
                        }
                        .frame(height: UIScreen.main.bounds.height / 5, alignment: .center)
                        .modifier(Shake(animatableData: CGFloat(attempts)))
                    } else {
                        VStack(spacing: 10){
                            Button(action: {

                            }) {
                                HStack{
                                    Image(systemName: "envelope.fill")
                                        .resizable()
                                        .frame(width: 25, height: 17)
                                        .foregroundColor(Color.orange.opacity(0.5))
                                    Text("New message from Jhon")
                                        .foregroundColor(Color.orange.opacity(0.5))
                                        .fontWeight(.medium)
                                        .font(.system(size: 16))
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                // .background(Color(red: 0.257, green: 0.534, blue: 0.962))
                                .background(Color.gray.opacity(0.1))
                            }
                            .cornerRadius(10)
                            .shadow(color: Color.red.opacity(0.4), radius:  5)
                        }
                        .frame(height: UIScreen.main.bounds.height / 10, alignment: .center)
                       
                    }
                    Spacer()
                    VStack(spacing: 5){
//                        Spacer()
                        Text("© 2020-2021 \(Bundle.main.name.capitalized) Inc. All Rights Reserved ")
                            .font(.custom("ArialRoundedMT", size: 11))
                            .foregroundColor(Color.gray)
                        
                        Text("Version: \(Bundle.main.version)")
                            .font(.custom("TrebuchetMS", size: 12))
                            .foregroundColor(Color.gray)
                    }
                    .padding(.bottom, 5)
                }
                .padding([.leading, .trailing], 30)
            }
            .buttonStyle(ScaleButtonStyle())
            .fullScreenCover(isPresented: $isPresented){
                ContentView()
            }
            
//            .navigationBarTitle("", displayMode: .inline)
//        }
    }
}


struct Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Login_View()
    }
}
