<p align="center">
<img src="FixCode.jpg" alt="FixCode Logo" width="230" />
</p>

<h3 align="center">
FixCode
</h3>

<p align="center">
Fixing the <code>Fix Issue</code> button
</p>

This Xcode plugin disables the `Fix Issue` functionality in Xcode. This way, none of your team members can click this button by mistake and might end up revoking all existing certificates and provisioning profiles.


|  | Fix Issue
----------------------|----------------------------------
:sparkles: | Get the most out of the built-in `Fix Issue` button
:thought_balloon: | You've never seen something this amazing!
:email: | Support for Xcode
:page_with_curl: | Streamlines your signing process
:rocket: | Saves you **hours** of dealing with code signing
:mountain_cableway: | Fully automatic, nothing you need (or can) do
:ghost: | No more bad surprises
:computer: | Support for iOS, OS X, watchOS and AppleTV Projects

<img src="FixIssueButton.jpg" alt="Fix Issue" width="500" />

# Installation

### Using fastlane

Add the `install_xcode_plugin` to your `Fastfile`. This way, the plugin gets installed for the whole team, so that no one can revoke your certificate by mistake.

```ruby
lane :xcode do
  install_xcode_plugin(
    url: "https://github.com/fastlane/FixCode/releases/download/0.1.0/FixCode.xcplugin.zip"
  )
end
```

```
fastlane xcode
```

### Alcatraz
You can install `FixCode` using [Alcatraz](http://alcatraz.io/). 

First, install [Alcatraz](http://alcatraz.io/) using

```
curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh
```

- Restart Xcode
- Click on `Window`
- Select `Package Manager`
- Search and Install `FixCode`
- Restart Xcode

# Thanks

Special thanks to Apple Inc for providing the initial "Fix Issue" functionality. Without it, this project wouldn't be possible.

- The code was implemented by [@neonacho](https://twitter.com/neonacho)
- [@KrauseFx](https://twitter.com/KrauseFx) was also there, providing drinks while [@neonacho](https://twitter.com/neonacho) did the actual work.

# Need help?
Please submit an issue on GitHub and provide information about your setup

# License
This project is licensed under the terms of the MIT license. See the LICENSE file.

> This project are in no way affiliated with Apple Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs. This tool run on your own computer or server, so your credentials or other sensitive information will never leave your own computer. You are responsible for how you use this tool.

