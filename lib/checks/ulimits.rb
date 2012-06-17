title "ulimit Settings ('Too many open files')"

how_to """
    To raise the limit add to /etc/security/limits.conf the lines:

      elasticsearch soft nofile 32000
      elasticsearch hard nofile 32000
    
    If you still see the previous limit, run:

      $ egrep -r pam_limits /etc/pam.d/
    
    and check that all pam_limits.so are not commented out.

    Now you can run to verify:

      $ bin/elasticsearch -f -Des.max-open-files=true
      [2011-04-05 04:12:02,687][INFO ][bootstrap] max_open_files [32000]
"""
if data.ulimit['soft']['nofiles'] < 32_000
  warn "Increment your soft file limit (#{data.ulimit['soft']['nofiles']}) to 32000"
end
if data.ulimit['hard']['nofiles'] < 32_000
  warn "Increment your hard file limit (#{data.ulimit['hard']['nofiles']}) to 32000"
end
