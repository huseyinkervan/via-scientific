# Minikube ve ShinyProxy ile Kubernetes Ortamı

Bu repo, Docker container içinde Minikube tabanlı bir Kubernetes cluster'ı ve ShinyProxy entegrasyonunu kurulumunu otomatikleştirir.

## Özellikler
- ✅ Docker-in-Docker (DinD) ile izole Minikube kurulumu
- ✅ Host dizin mount desteği (`MOUNT_DIR`)
- ✅ ShinyProxy operatörü ile otomatik yönetim
- ✅ Kustomize manifest desteği
- ✅ Multi-arch desteği (ARM64/x86_64)

## Hızlı Başlangıç

1. Cluster'ı başlat:
```bash
docker compose up -d --build
```

2. Minikube containerı bul ve  bağlan
```bash
docker ps
docker exec <container-id> -it sh
```
3. /etc/hosts dosyasına record ekle
```bash
172.0.0.1 shinyproxy-demo.local
```

4. kubernetes service forward et
```bash
kubectl port-forward svc/sp-shinyproxy-svc -n shinyproxy 80:80
```
5. curl isteği ile kontrole et.
```bash
curl http://shinyproxy-demo.local/login
```
Eğer bu şekil bir output gördüysen başarılı bir şekilde deployment yapılmış demektir.

```html
<!--

    ContainerProxy

    Copyright (C) 2016-2024 Open Analytics

    ===========================================================================

    This program is free software: you can redistribute it and/or modify
    it under the terms of the Apache License as published by
    The Apache Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    Apache License for more details.

    You should have received a copy of the Apache License
    along with this program.  If not, see <http://www.apache.org/licenses/>

-->
<!DOCTYPE html>
<html
>

    <head lang="en">
        <title>ShinyProxy</title>
        <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
        <meta content="width=device-width, initial-scale=1" name="viewport"/>
        <link media="screen" rel="stylesheet" href="/webjars/bootstrap/3.4.1/css/bootstrap.min.css"/>
        <link media="screen" rel="stylesheet" href="/css/login.css"/>
        <link media="screen" rel="stylesheet" href="/webjars/fontawesome/4.7.0/css/font-awesome.min.css"/>
        <script src="/webjars/jquery/3.7.1/jquery.min.js"></script>
        <script src="/webjars/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>

    <body>
        <div class="container">
            <form class="form-signin" method="POST" action="/login"><input type="hidden" name="_csrf" value="HoWA3ewipWmGBqq-DiufnbI8wGBSEH57yuKGpMP9RZHCP9Rsfba55dkXklGrZJLfNgar-4dY7QIxKBtW_4CzxvufIKWmCOZd"/>
                <h2 class="form-signin-heading">Please sign in:</h2>
                
                <label class="sr-only" for="username">Email address</label>
                <input autofocus="autofocus" class="form-control" id="username" name="username" placeholder="User name"
                       required="required">
                <label class="sr-only" for="password">Password</label>
                <input class="form-control" id="password" name="password" placeholder="Password" required="required"
                       type="password">
                <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
            </form>
        </div>
    </body>

</html>
```

6. Yeni deployment yapmak istiyorsan /manifests/shinyproxy altına ekleyebilirsin

