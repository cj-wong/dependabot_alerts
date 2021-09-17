"""This file is not to be used directly.

It's used to keep track of direct packages used, not their dependencies.

Some packages do not have 1:1 matching names on PyPI; for those, their actual
packages are listed as in-line comments. (e.g. bs4 comes from beautifulsoup4.)
"""

import bs4  # Package: beautifulsoup4
import flask
import flask_restful
import lxml
import more_itertools
import pendulum
import requests
import yaml  # Package: pyyaml
