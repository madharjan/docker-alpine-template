
@test "checking file: setuser exists" {
  run docker run --rm madharjan/docker-tools [ -f /usr/bin/htop ]
  [ "$status" -eq 0 ]
}
