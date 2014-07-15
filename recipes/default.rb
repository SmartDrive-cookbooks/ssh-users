#
# Cookbook Name:: ssh-users
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node["ssh-users"]["setup"].each do |usr|
  users_manage usr["name"] do
    group_id usr["group_id"]
    action usr["action"]
  end
  if usr["sudo"].is_a?(Hash)
    sudo usr["name"] do
      %w{commands group nopasswd runas template user defaults variables}.each do |attr|
        send(attr, usr["sudo"][attr]) if usr["sudo"][attr]
      end
    end
  end
end
