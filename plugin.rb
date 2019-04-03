# name: New Relic RPM
# about: Report performance data to http://www.newrelic.com/
# version: 5.4.0.347
# authors: Sam Saffron, David Celis

ENV['NRCONFIG'] = File.expand_path('../newrelic.yml', __FILE__)
gem 'newrelic_rpm', ENV['NEW_RELIC_AGENT_VERSION'] || '5.4.0.347'

NewRelic::Control.instance.init_plugin config: Rails.configuration

after_initialize do
  ForumsController.newrelic_ignore only: [:status]
end
