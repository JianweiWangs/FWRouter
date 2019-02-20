build: install open
open: 
	open ./Example/FWRouter.xcworkspace
install:
	pod install --project-directory=Example
clean:
	pod cache clean --all
quit:
	osascript -e 'quit app "Xcode"'
test:

	- xcodebuild -scheme FWRouter-Example -workspace Example/FWRouter.xcworkspace -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone XR,OS=12.0' build test
	