# New Relic for Discourse

This is a Discourse plugin to get your forums reporting performance data to [New Relic][new-relic]. It is meant to be used with the [Discourse Docker Image][discourse-docker], so installation instructions will follow that route. It was originally written by [Sam Saffron][original], but I've updated the version of the New Relic RPM gem and supplied a newrelic.yml file that will be parsed by ERB.

## Installation

Assuming you've followed the above instructions for the Discourse Docker image:

 1. SSH into your forum server as the user running docker (probably root)
 2. `cd /var/discourse`
 3. Open up `containers/app.yml`
 4. In the `env:` section, add `NEW_RELIC_LICENSE_KEY: <your_license_key>`
 5. In the `env:` section, add `NEW_RELIC_APP_NAME: <name_of_your_forums>`
 6. (optional) In the `env` sesion, add `NEW_RELIC_AGENT_VERSION: <version_of_new_relic_agent>`
 7. In the `hooks` section at the bottom, add the following to `cmd:`

```yaml
- git clone https://github.com/davidcelis/new_relic-discourse.git
```
 7. (optional) In the `run` section at the bottom, add the following to get notified about new 'deployments':

```yaml
- exec: curl -H "x-api-key:<your_api_key_not_license>" -d "deployment[app_name]=<name_of_your_forums>" -d "deployment[description]=This is an app id deployment" https://api.newrelic.com/deployments.xml
```

The next time you bootstrap and start a new container for your forums, it'll start reporting into New Relic! Yay! To restart Discourse so that it picks up the new plugin, just SSH into your server and do the following:

```sh
$ cd /var/discourse
$ ./launcher rebuild app
$ ./launcher start app
```

Or, you can visit the `/admin/upgrade` URL on your Discourse installation's frontend and upgrade as you would normally.

[new-relic]: http://www.newrelic.com/
[discourse-docker]: https://github.com/discourse/discourse/blob/master/docs/INSTALL-digital-ocean.md
[original]: https://meta.discourse.org/t/newrelic-plugin/12986

