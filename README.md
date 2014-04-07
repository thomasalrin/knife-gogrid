Knife GoGrid
========

This is the official Opscode Knife plugin for GoGrid. This plugin gives knife the ability to create, bootstrap and manage instances in the GoGrid.

# Installation #

Be sure you are running the latest version Chef. Versions earlier than 0.10.0 don't support plugins:

    $ gem install chef

This plugin is distributed as a Ruby Gem. To install it, run:

    $ gem install knife-gogrid

Depending on your system's configuration, you may need to run this command with root privileges.

# Configuration #

In order to communicate with GoGrid API you will need to tell Knife the API Key, and Shared Secret value. The easiest way to accomplish this is to create these entries in your `knife.rb` file:

    knife[:go_grid_api_key]       = "Your GoGrid Api Key"
    knife[:go_grid_shared_secret] = "Your GoGrid shared secret"

If your knife.rb file will be checked into a SCM system (ie readable by others) you may want to read the values from environment variables:

    knife[:go_grid_api_key]        = "#{ENV['GOGRID_API_KEY']}"
    knife[:go_grid_shared_secret]  = "#{ENV['GOGRID_SHARED_SECRET']}"

You also have the option of passing your GoGrid API options from the command line:

    `-K` (or `--go-grid-api-key`) your GoGrid API Key
    `-A` (or `--go-grid-shared-secret`) your GoGrid Shared Secret

    knife gogrid server create -K 'MyAPIKey' -A 'Shared-Secret' -i 14767 -r 'role[webserver]' -N server-name -a public-ip-address -R 512MB


# Subcommands #

This plugin provides the following Knife subcommands. Specific command options can be found by invoking the subcommand with a `--help` flag

knife gogrid server create
----------------------

Provisions a new server in the GoGrid and then perform a Chef bootstrap (using the SSH protocol). The goal of the bootstrap is to get Chef installed on the target system so it can run Chef Client with a Chef Server. The main assumption is a baseline OS installation exists (provided by the provisioning). It is primarily intended for Chef Client systems that talk to a Chef Server. By default the server is bootstrapped using the [chef-full](https://github.com/opscode/chef/blob/master/chef/lib/chef/knife/bootstrap/chef-full.erb) template. This can be overridden using the `-d` or `--template-file` command options. If you do not pass a node name with `-N NAME` (or `--node-name NAME`) a name will be generated for the node.

    knife gogrid server create  -i 14767 -r 'role[webserver]' -N server-name -a public-ip-address -R 512MB

knife gogrid server delete
----------------------

Deletes an existing server in the currently configured GoGrid account. <b>PLEASE NOTE</b> - this does not delete the associated node and client objects from the Chef Server without using the `-P` or `--purge` option to purge the client.

knife gogrid server list
--------------------

Outputs a list of all servers in the currently configured GoGrid account. <b>PLEASE NOTE</b> - this shows all instances associated with the account, some of which may not be currently managed by the Chef Server.

knife gogrid image list
-------------------

Outputs a list of all images available to the currently configured GoGrid account. 


# License #

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Steve Lum (<steve.lum@gmail.com>)
|                      | Kishorekumar Neelamegam (<nkishore@megam.co.in>)
|                      | Rajthilak (<rajthilak@megam.co.in>)
| **Copyright:**       | Copyright (c) 2012-2013 Megam Systems.
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
