# faviconfinder

Simple command line tool to find favicons of a website, written in Dart.

Usage: `faviconfinder  <url>`

To compile the source code, run:
`dart compile exe bin/faviconfinder.dart`

-------

#### Example:

``` console
foo@bar:~$ faviconfinder github.com
fetching favicons...
Found 2 favicons for https://github.com:
[0x0] https://github.githubassets.com/favicons/favicon.svg
[16x16] https://github.com/favicon.ico

```

-------

#### Dependencies:

- [favicon](https://pub.dev/packages/favicon)
- [internet_connection_checker](https://pub.dev/packages/internet_connection_checker)
