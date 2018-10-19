# api-docs
Documentation for the Bokun API in Open API format (previously swagger).

## Installing swagger command line interface

The swagger-cli can validate yaml files `swagger validate [file]`. And bundle them as a
self contained `json` file for use with the Swagger code generator, `swagger bundle [file]`.

```bash
npm install -g swagger-cli
```

## Developer workflow

After making changes in the API, edit bokun.yaml to reflect the change then convert it to json by
running ./generate.sh {prod|test} to generate the production and test swagger files respectively. 

Revert the change to the host location before committing the change to swagger-prod.json and 
swagger-test.json
