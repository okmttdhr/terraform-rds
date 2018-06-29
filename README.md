
# terraform-rds

```bash
git clone https://github.com/okmttdhr/terraform-rds.git
make keygen F=tf-key # or as you like
make prof P=your-profile # your AWS credential
make rds_password P=your-rds-password
make init
```

## plan

```
$ make plan
```

## create

```
$ make apply
```

## destroy

```
$ make destroy
```
