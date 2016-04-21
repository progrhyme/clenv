. lib/util.shrc
. lib/version.shrc

(
  t_substart "version_compare"

  version_compare 1 1 result
  t_is $result 0 "1 == 1"

  version_compare 2.0 1.0 result
  t_is $result 1 "2.0 > 1.0"

  version_compare 2.0 2 result
  t_is $result 1 "2.0 > 2"

  version_compare 2.0.0 2.0.1 result
  t_is $result -1 "2.0.0 < 2.0.1"

  version_compare 2.0.0 2.0.0-p321 result
  t_is $result -1 "2.0.0 < 2.0.0-p321"

  version_compare 2.0.0-p322 2.0.0-p321 result
  t_is $result 1 "2.0.0-p322 > 2.0.0-p321"

  t_subclose
)
t_subend "version_compare"
