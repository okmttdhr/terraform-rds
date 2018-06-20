TERRAFORM	= terraform

init:
	$(TERRAFORM) init

prof:
	sed -i '' s/your-aws-profile/$(PROF)/ terraform.tfvars

plan:
	$(TERRAFORM) plan

show:
	$(TERRAFORM) show

apply:
	$(TERRAFORM) apply

destroy:
	$(TERRAFORM) destroy
