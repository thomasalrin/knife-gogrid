#
# Author:: Steve Lum (<steve.lum@gmail.com>), Rajthilak (<rajthilak@megam.co.in>)
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/knife'
require 'json'
require 'chef/node'
require 'chef/api_client'
class Chef
  class Knife
    class GogridServerDelete < Knife

      banner "knife gogrid server delete SERVER (options)"
       
      option :go_grid_api_key,
        :short => "-K KEY",
        :long => "--go-grid-api-key KEY",
        :description => "Your GoGrid API key",
        :proc => Proc.new { |key| Chef::Config[:knife][:go_grid_api_key] = key } 

      option :go_grid_shared_secret,
        :short => "-A SHARED_SECRET",
        :long => "--go-grid-shared-secret SHARED_SECRET",
        :description => "Your GoGrid API Shared Secret",
        :proc => Proc.new { |shared_secret| Chef::Config[:knife][:go_grid_shared_secret] = shared_secret} 
 
     option :purge,
        :short => "-P",
        :long => "--purge",
        :boolean => true,
        :default => false,
        :description => "Destroy corresponding node and client on the Chef Server, in addition to destroying the GoGrid node itself. Assumes node and client have the same name as the server (if not, add the '--node-name' option)."

      option :chef_node_name,
        :short => "-N NAME",
        :long => "--node-name NAME",
        :description => "The name of the node and client to delete, if it differs from the server name. Only has meaning when used with the '--purge' option."

      def destroy_item(klass, name, type_name)
        begin
          object = klass.load(name)
          object.destroy
          ui.warn("Deleted #{type_name} #{name}")
        rescue Net::HTTPServerException
          ui.warn("Could not find a #{type_name} named #{name} to delete!")
        end
      end


      def h
        @highline ||= HighLine.new
      end

      def run 
        require 'fog'
        require 'highline'
        require 'net/ssh/multi'
        require 'readline'

        connection = Fog::Compute::GoGrid.new(
          :go_grid_api_key => Chef::Config[:knife][:go_grid_api_key],
          :go_grid_shared_secret => Chef::Config[:knife][:go_grid_shared_secret]
        )
        begin 
           server = connection.servers.get(@name_args[0])

           confirm("Do you really want to delete server ID #{server.id} named #{server.name}")

           server.destroy
            if config[:purge]
              thing_to_delete = config[:chef_node_name]
              destroy_item(Chef::Node, thing_to_delete, "node")
              destroy_item(Chef::ApiClient, thing_to_delete, "client")
            else
              ui.warn("Corresponding node and client for the #{server.name} server were not deleted and remain registered with the Chef Server")
            end
           Chef::Log.warn("Deleted server #{server.id} named #{server.name}")
          rescue NoMethodError
            ui.error("Could not locate server.")
          end
      end
    end
  end
end




