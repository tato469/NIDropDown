Pod::Spec.new do |s|
  s.name             = "NIDropDown"
  s.version          = "0.1.2"
  s.summary          = "NiDropDown gives a proper animated drop down menu like effect."
  s.description      = <<-DESC
                       NiDropDown gives a proper animated drop down menu like effect.
                       Just do it! So easy!
                       DESC
  s.homepage         = "https://github.com/tato469/NIDropDown"
  s.screenshots      = "https://raw.githubusercontent.com/shjborage/NIDropDown/master/Screen%20Shot.png"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "tato469" => "fernandovalle.developer@gmail.com" }
  s.source           = { :git => "https://github.com/tato469/NIDropDown.git", :tag => 'v0.1.2'}

  s.platform              = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  
  s.dependency 'SQCommonUtils'
end
