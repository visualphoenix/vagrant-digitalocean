# if ! bundle exec vagrant box list | grep digital_ocean 1>/dev/null; then
#     bundle exec vagrant box add digital_ocean box/digital_ocean.box
# fi
set -e ; set -u ; set -o pipefail

cd test
bundle exec vagrant up --provider=digital_ocean
bundle exec vagrant provision
bundle exec vagrant rebuild
bundle exec vagrant halt
bundle exec vagrant destroy -f

cd ..
