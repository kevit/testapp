
#app and deploy
make help
vagrant up
curl -i -H "Content-Type: application/json" -X POST -d '{"lenght": 10}' http://vagrant.kevit.info/

#infrastructure
cd terraform
make plan
terraform apply
make create name=aws


Known limitation:
error handling in app does not work correctly

