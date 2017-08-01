# Wallabag for OpenShift 3

```
Work In Progress!
```

This repository contains an OpenShift 3 template to easily deploy Wallabag on OpenShift.
With this template it's possible to run your own Piwik instance f.e. on [APPUiO](https://appuio.ch/).

## Installation

### 0 Create OpenShift project

Create an OpenShift project if not already provided by the service

```
PROJECT=wallabag
oc new-project $PROJECT
```

### 1 Deploy Database and Redis

```
oc -n openshift process mariadb-persistent -p MYSQL_DATABASE=piwik | oc -n $PROJECT create -f -
oc -n $PROJECT new-app redis
```

### 2 Deploy Wallabag

```
oc process -f https://raw.githubusercontent.com/tobru/wallabag-openshift/master/wallabag.yaml -p APP_URL=wallabag.example.com | oc -n $PROJECT create -f -
```

### 3 Configure Wallabag

* Navigate to http://wallabag.example.com
* Login with default credentials: wallabag / wallabag

**Hints**

* You might want to enable TLS for your instance

#### Template parameters

Execute the following command to get the available parameters:

```
oc process -f https://raw.githubusercontent.com/tobru/wallabag-openshift/master/wallabag.yaml --parameters
```

## Todo

* Support configuration of all parameters https://doc.wallabag.org/en/admin/parameters.html
* Better configuration system (get rid of sed)
* Backup

## Contributions

Very welcome!

1. Fork it (https://github.com/tobru/piwik-openshift/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
