set_unless[:sphinx][:version]      = '0.9.9'
set_unless[:sphinx][:url]          = "http://www.sphinxsearch.com/downloads/sphinx-#{sphinx[:version]}.tar.gz"
set_unless[:sphinx][:stemmer_url]  = "http://snowball.tartarus.org/dist/libstemmer_c.tgz"

# tunable options
set_unless[:sphinx][:use_stemmer]  = false

set_unless[:sphinx][:configure_flags] = [
  "--with-mysql",
  "#{sphinx[:use_stemmer] ? '--with-stemmer' : '--without-stemmer'}"
]


