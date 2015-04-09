# Run You Fools!

The basic idea behind RunYouFools is that system tests should be simple
scripts, whose exit code determines their success (or failure).

Most testing framework are more suitable for unit tests. System tests require a broader perspective,
and a simpler format. I believe that system tests should be readable, self-explanatory scripts that just
run from top to bottom, e.g. this little bit of Python:

```python
    # test_basic_client_server_chat.py
    # these are the real thing, not Moch objects of any kind
    server = Server()
    clinet = client()
    client.sendMessage( "what's up, server?" )
    assert server.response() == "I'm OK, how are you?"
```

Different tests should reside in different files, again unlike unit tests.

The purpose of runyoufools is to supply the user with a runner to run his/her tests,
no matter if these tests are Ruby, Python, C++, Perl - whatever - with appropriate hooks for test setup.

# Installation

RunYouFools is a ruby gem:

    $ gem install runyoufools

Once it is installed, you run it:

    $ runyoufools --help

To get an explanation. Basically, you specify a filename pattern with `--pattern`,
which RunYouFools uses to determine which files are tests (all relative the
current directory). The pattern is a *regular expression*, *NOT* a "glob".
Google regular expressions if you don't know what they are.

So, to run all tests in the `test/system` directory:

    $ runyoufools --pattern test/system/

Note that if you do not include the final `/`, RunYouFools might try to run a file called `test/system.log`.

The pattern is *MANDATORY*.


# What if I don't want my test files to be executable?

No problem, just specify how to run them with the `--command`. If, for example, your system tests are python scripts in the `test/system` directory:

    $ runyoufools --pattern test/system/ --command python

# My tests sometimes fail for no good reason - what to do?

In my experience, some system tests can fail without indicating an actual error. Some Selenium tests for example, may fail for some weird selenium bug that happens now and then, and has nothing to do with your code. To circumvent this, you can use retries. The rational is that if a test fails many times, it's probably an actual failure.

    $ runyoufools --retries 3           # retry test 3 times before declaring a failue

By default, there is only one trial per test.

# TODO

* setup and tear-down configuration
* Support different runners for different test types, e.g. `python` for Python, `perl` for perl. I'm not sure this is needed, but I may add it in the future.
* Integration with some reporting systems
