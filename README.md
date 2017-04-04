# Meteor Deploy Configuration

## 1) Setting Up an Nginx Web Server

```bash
apt-get install nginx
```

Create a virtual host configuration file in /etc/nginx/sites-available.

Below is an annotated config file which we can create as /etc/nginx/sites-available/test with the following contents. Explanations for all of the configuration settings are included in the comments in the file nginx/default.

And enable our Meteor vhost:

```bash
ln -s /etc/nginx/sites-available/test /etc/nginx/sites-enabled/test
```
Test that the vhost configuration is error free (you will see an error related to ssl_stapling if you have a self-signed certificate; this is okay):

```bash
nginx -t
```

If everything is looking good we can apply the changes to Nginx:

```bash
nginx -s reload
```


## 2) Setting Up a MongoDB Database

Install the MongoDB server package:

```bash
apt-get install mongodb-server;
```

This is everything we need to do to get MongoDB running. To be sure that access from external hosts is not possible, we execute the following to be sure that MongoDB is bound to 127.0.0.1. Check with this command:

```bash
netstat -ln | grep -E '27017|28017';
```


## 3) Installing the Meteor Application

```bash
curl https://install.meteor.com | /bin/sh
```

It's a good practice to run our Meteor application as a regular user. Therefore, we will create a new system user specifically for that purpose:

```bash
adduser test
```
We also need to install g++, python and make:

```bash
apt-get install g++ make python
```

### Configuring Upstart

Now we are ready to create the Upstart service to manage our Meteor app. Upstart will automatically start the app on boot and restart Meteor in case it dies. You can read more about creating Upstart service files in this tutorial.

Create the file /etc/init/test.conf. Copy everyting from upstart/test.conf.

### Deploying app

Use deploy.sh script from bin folder of the repository.