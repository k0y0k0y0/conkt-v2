# server '54.199.149.44', user: 'app', roles: %w{app db web}
# set :ssh_options, keys: '/Users/uchiborieri/workspace/keys/id_rsa'

# TODO: app ユーザで対応する予定だが、一時的にec-user2 を利用している
server '54.199.149.44', user: 'ec2-user', roles: %w{app db web}
set :ssh_options, keys: '/Users/uchiborieri/workspace/keys/conkt.pem'