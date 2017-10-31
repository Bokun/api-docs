# api-docs
Documentation for the Bokun API in Open API format (previously swagger).

## Developer workflow

After making changes in the API, edit bokun.yaml to reflect the change then convert it to json by
running ./generate.sh {prod|test} to generate the production and test swagger files respectively. 

Revert the change to the host location before committing the change to swagger-prod.json and 
swagger-test.json
