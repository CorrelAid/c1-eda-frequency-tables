Track 2 Challenge 1
================

Frequency tables built with R and SQL.

# Setup

## Dependencies

install `renv`:

```
install.packages("renv")
```

### Install/update dependencies
```
renv::restore()
```

### Adding new dependencies
1. install package as usual (with `install.packages`)
2. run `renv::snapshot()`
3. commit and push the updated `renv.lock`

## Access data
To access the data for this challenge, you first need to get secrets/passwords.

uno 

To get them, proceed as follows:

1. Check the Slack channel for the "secret link" for your challenge
2. We'll share the password to decrypt the message on-site 
3. Click on the link and enter the password to decrypt the message
4. Follow the specific instructions for your data below.

### Supabase/Postgres

To connect to the Supabase Postgres database, you need to store your credentials in the `.Renviron` file:

```
# set up passwords in .Renviron
usethis::edit_r_environ()
```

Copy the content from the decrypted secret link. It should look something like this:

```
# logins for supabase
COOLIFY_HOST='pip9'
COOLIFY_PORT='9001'
COOLIFY_USER='user'
COOLIFY_PASSWORD='pw'
COOLIFY_DB='dbname'
```

Restart your R session (Session -> Restart R Session or `.rs.restartR()`)

Run `code/00-setup-supabase.R`

# Developer information
Just kept here for continuing after the hackathon :)

## Definition of Done

Default Definition of Done can be found
[here](https://github.com/CorrelAid/definition-of-done). Adapt if
needed.

