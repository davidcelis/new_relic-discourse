# name: New Relic RPM
# about: Report performance data to http://www.newrelic.com/
# version: 3.12.1.298
# authors: Sam Saffron, David Celis

ENV['NRCONFIG'] = File.expand_path('../newrelic.yml', __FILE__)
gem 'newrelic_rpm', '3.12.1.298'

NewRelic::Control.instance.init_plugin config: Rails.configuration

after_initialize do
  ForumsController.newrelic_ignore only: [:status]
end
