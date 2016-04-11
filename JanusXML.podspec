Pod::Spec.new do |s|
  s.name             = "JanusXML"
  s.version          = "0.1.0"
  s.summary          = "A simple XML parser, written in Swift."
  s.description      = <<-DESC
  "A simple XML parser, written in Swift."
                       DESC

  s.homepage         = "https://github.com/nkirby/JanusXML"
  s.license          = 'MIT'
  s.author           = { "Nathaniel Kirby" => "nkirby.ps@gmail.com" }
  s.source           = { :git => "https://github.com/nkirby/JanusXML.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thenatekirby'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*.swift'
  # s.resource_bundles = {
  #   'JanusXML' => ['Pod/Assets/*.png']
  # }
end
