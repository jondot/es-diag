title "Recommended JVM Heap Size"


how_to """
    Passing JVM level configuration (such as -X parameters) should be set 
    within the elasticsearch.conf file.

    Use the ES_MIN_MEM and ES_MAX_MEM environment variables to set the minimum 
    and maximum memory allocation for the JVM (set in mega bytes). It defaults
    to 256 and 1024 respectively.
"""


#
# for more detail about es_local_node data bag, see your own node
# http://localhost:9200/_cluster/nodes/_local
#
# for technical detail, see how fetching is implemented in
# /contexts/es_local_node.rb
# 
if data.es_local_node
  n =  data.es_local_node.nodes.first[1]
  totmem = n.os.mem.total_in_bytes
  hmin = n.jvm.mem.heap_init_in_bytes
  hmax = n.jvm.mem.heap_max_in_bytes

  hmin_r = hmin / totmem
  hmax_r = hmax / totmem

  if hmin_r < 0.3
    warn "Min heap size set to #{n.jvm.mem.heap_init}, which is less than 30% of system memory."
  end
  if hmax_r > 0.8
    warn "Max heap size set to #{n.jvm.mem.heap_max}, which is more than 80% of system memory."
  end
end
