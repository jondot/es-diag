# ES-Diag

`es-diag` is a command line tool that evaluates your machine and setup, points out typical machine misconfiguration for Elastic Search, sniffs out health parameters from a running Elastic Search instance (not impl. yet), and recommends ways to amend it.


<img src="https://raw.github.com/jondot/es-diag/master/resources/screen.png" /><br/>




## Getting Started

You need to have a recent Ruby on your system.

    $ gem install es-diag
    $ es-diag status
    # should output a lot of useful data if your system
    # isn't healthy. a list of things it checked otherwise.


## Adding checks

`es-diag` will run a series of predefined checks. My hope is that you can add checks and
submit pull requests very easily.  


Writing a check is designed to be VERY easy, using a simple DSL. Lets take a look at an
example:

```ruby
    # set the check title
    title "ulimit set appropriately - avoid 'Too many open files'"

    # specify actions to take to amend problems that can be detected
    # by this check.
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

    # Here, you have a property bag called 'data' that is 
    # exposed via Opscode/ohai [here is a sample](https://gist.github.com/2381589).
    # If you want to sample your own system:
    # 
    # $ gem install ohai
    # $ ohai
    # 
    # It is most probably that `data` will contain additional properties
    # not originating from ohai in the future.
    #
    if data.ulimit['soft']['nofiles'] < 32_000
      warn "Increment your soft file limit (#{data.ulimit['soft']['nofiles']}) to 32000"
    end
    if data.ulimit['hard']['nofiles'] < 32_000
      warn "Increment your hard file limit (#{data.ulimit['hard']['nofiles']}) to 32000"
    end
```

Next, put all of this in a file and drop it in the `lib/checks` folder.
It will be picked up automatically.


# Contributing

Fork, implement, add tests, pull request, get my everlasting thanks and a respectable place here :).


# Copyright


Copyright (c) 2012 [Dotan Nahum](http://gplus.to/dotan) [@jondot](http://twitter.com/jondot). See MIT-LICENSE for further details.


