Pod::Spec.new do |s|
  s.name = 'StepColor'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'iOS/MacOS framework to pick any color in a gradient.'
  s.homepage = 'https://github.com/notbenoit/StepColor'
  s.social_media_url = 'http://twitter.com/notbenoit'
  s.authors = { 'Benoit Layer' => 'benoit.layer@gmail.com' }
  s.source = { :git => 'https://github.com/notbenoit/StepColor.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'Source/*.swift'

  s.requires_arc = true
end
