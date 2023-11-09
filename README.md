# Dockerfile

A dockerfile with terraform and terragrunt included to working with the Codely Terraform course.

- Warning: You will need to copy the .env.template to .env and populate the AWS keys.

This repo includes a Makefile with next commands:

- Initialize the container:
```
make docker-up
```

- Enter into the container:
```
make docker-exec
```

- Stop the container:
```
make docker-down
``` 

