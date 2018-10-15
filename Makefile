ox: 
	open ./Example/FWRouter.xcworkspace
di:
	cd Example && pod install
clean:
	pod cache clean --all
rp:
	rm -rf Example/Pods
qx:
	osascript -e 'quit app "Xcode"'
	
	