require 'open-uri'
require 'json'


title "ElasticSearch Local Node"

node_addr = ES::Diag::Config['es_local_node']

unless node_addr
  warn "Skipping (no node host provided)."
  return
end

begin
  cdata = JSON.parse open("http://#{node_addr}/_cluster/nodes/_local").read
  context "es_local_node", cdata
rescue
  error "Gathering local node data: #{$!}"
end



