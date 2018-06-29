TERRAFORM	= terraform

init:
	$(TERRAFORM) init

keygen:
	ssh-keygen -t rsa -f $(F)
	chmod 400 $F*
	mv $(F)* ~/.ssh/

prof:
	sed -i '' s/your-aws-profile/$(P)/ terraform.tfvars

rds_password:
	sed -i '' s/your-rds-password/$(P)/ terraform.tfvars

plan:
	$(TERRAFORM) plan

show:
	$(TERRAFORM) show

apply:
	$(TERRAFORM) apply

destroy:
	$(TERRAFORM) destroy
