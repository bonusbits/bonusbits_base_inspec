def node_attributes
  json('/etc/chef/.chef-attributes.json').params
end

def dev?
  node_attributes['bonusbits_base']['deployment_environment'] == 'dev'
end

def kitchen?
  node_attributes['bonusbits_base']['deployment_method'] == 'kitchen'
end

def node_values
  node_attributes['bonusbits_base']
end

def prod?
  node_attributes['bonusbits_base']['deployment_environment'] == 'prod'
end

def proxy_settings
  node = node_attributes

  results = Hash.new
  results['http_proxy'] = node['bonusbits_base']['proxy']['host_port_url']
  results['https_proxy'] = node['bonusbits_base']['proxy']['host_port_url']
  results['no_proxy'] = node['bonusbits_base']['proxy']['no_proxy']
  results
end

def proxy_shell_script_content
  node = node_attributes
  %W[
    http_proxy=#{node['bonusbits_base']['proxy']['host_port_url']}
    https_proxy=#{node['bonusbits_base']['proxy']['host_port_url']}
    no_proxy=#{node['bonusbits_base']['proxy']['no_proxy']}
  ]
end

def server_role
  node_attributes['bonusbits_base']['role']
end

def qa?
  node_attributes['bonusbits_base']['deployment_environment'] == 'qa'
end
