---
layout: page-with-side-nav
title: Configureren van de {{ site.apiname }} Proxy
---

# {{ site.apiname }} Proxy configuratie

De volgende settings van de {{ site.apiname }} Proxy kunnen worden aangepast:

- [Routering](#routering)
- [Logging](#logging)
- [mTLS](#mtls)

## Routering

Standaard is de {{ site.apiname }} Proxy geconfigureerd om bevragingen door te sturen naar de mock van de {{ site.apiname }} Web API GBA variant.

De __Downstream__ configuratie van de {{ site.apiname }} Proxy moet worden aangepast om bevragingen door te sturen naar een andere instantie van de {{ site.apiname }} Web API GBA variant.

### Wijzigen van de Downstream configuratie van de Proxy (Docker Compose variant)

De volgende environment variabelen moet worden opgenomen in de configuratie van de Proxy in het [docker compose bestand]({{ site.mainBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"}:

- Routes__0__DownstreamScheme. Het communicatieprotocol dat moet worden gebruikt voor het aanroepen van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Host. De host naam van de aan te roepen {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Port. Het port nummer van de aan te roepen {{ site.apiname }} Web API GBA variant

In het volgende voorbeeld is de Proxy geconfigureerd om bevragingen door te sturen naar de proef omgeving van de {{ site.apiname }} Web API GBA variant

```yaml

  reisdocumentproxy:
    container_name: reisdocumentproxy
    image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Routes__0__DownstreamScheme=https
      - Routes__0__DownstreamHostAndPorts__0__Host=proefomgeving-gba.haalcentraal.nl
      - Routes__0__DownstreamHostAndPorts__0__Port=443
    ports:
      - "5002:5000"
    networks:
      - reisdocumenten-api-network

```

Een andere mogelijkheid is om de routering configuratie te definieren in een json bestand en met behulp van een volume mount te monteren aan een container instantie.

In het volgende voorbeeld is de configuratie van de routering naar de proef omgeving van de {{ site.apiname }} Web API GBA variant gespecificeerd. Dit [configuratie bestand]({{ site.mainBranchUrl }}/src/config/ReisdocumentProxy/configuration/ocelot.json){:target="_blank" rel="noopener"} is ook te vinden in de {{ site.apiname }} GitHub repository.

```json

{
  "Routes": [
    {
      "UpstreamPathTemplate": "/haalcentraal/api/reisdocumenten/reisdocumenten",
      "DownstreamPathTemplate": "/haalcentraal/api/reisdocumenten/reisdocumenten",
      "DownstreamScheme": "https",
      "DownstreamHostAndPorts": [
        {
          "Host": "proefomgeving-gba.haalcentraal.nl",
          "Port": "443"
        }
      ]
    }
  ]
}

```

Het configuratie bestand wordt vervolgens met behulp van een volume mount gemonteerd aan een {{ site.apiname }} Proxy instantie. In onderstaand voorbeeld wordt het ocelot.json bestand in de src/config/ReisdocumentProxy/configuration map gemonteerd aan een {{ site.apiname }} Proxy instantie.

```yaml

  reisdocumentproxy:
    container_name: reisdocumentproxy
    image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
    ports:
      - "5002:5000"
    volumes:
      - ./src/config/ReisdocumentProxy/configuration/ocelot.json:/app/configuration/ocelot.json
    networks:
      - reisdocumenten-api-network

```

### Wijzigen van de Downstream configuratie van de Proxy (Kubernetes variant)

De volgende environment variabelen moet worden opgenomen in de configuratie van de Proxy in het [reisdocument proxy deployment bestand]({{ site.mainBranchUrl }}/.k8s/reisdocument-proxy-deployment.yml){:target="_blank" rel="noopener"}:

- Routes__0__DownstreamScheme. Het communicatieprotocol dat moet worden gebruikt voor het aanroepen van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Host. De host naam van de aan te roepen {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Port. Het port nummer van de aan te roepen  {{ site.apiname }} Web API GBA variant

In het volgende voorbeeld is de Proxy geconfigureerd om bevragingen door te sturen naar de proef omgeving van de {{ site.apiname }} Web API GBA variant

```yaml

      containers:
        - name: reisdocumentproxy
          image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: Release
            - name: ASPNETCORE_URLS
              value: http://+:5000
            - name: Routes__0__DownstreamScheme
              value: https
            - name: Routes__0__DownstreamHostAndPorts__0__Host
              value: proefomgeving-gba.haalcentraal.nl
            - name: Routes__0__DownstreamHostAndPorts__0__Port
              value: "443"
          ports:
            - name: http-reisdocumentproxy
              containerPort: 5000

```

Een andere mogelijkheid is om de routering configuratie te definieren in een json bestand en met behulp van een volume mount te monteren aan een container instantie.

In het volgende voorbeeld is de configuratie van de routering naar de proef omgeving van de {{ site.apiname }} Web API GBA variant gespecificeerd. Dit [configuratie bestand]({{ site.mainBranchUrl }}/src/config/ReisdocumentProxy/configuration/ocelot.json){:target="_blank" rel="noopener"} is ook te vinden in de {{ site.apiname }} GitHub repository.

```json

{
  "Routes": [
    {
      "UpstreamPathTemplate": "/haalcentraal/api/reisdocumenten/reisdocumenten",
      "DownstreamPathTemplate": "/haalcentraal/api/reisdocumenten/reisdocumenten",
      "DownstreamScheme": "https",
      "DownstreamHostAndPorts": [
        {
          "Host": "proefomgeving-gba.haalcentraal.nl",
          "Port": "443"
        }
      ]
    }
  ]
}

```

Het configuratie bestand wordt vervolgens met behulp van een volume mount gemonteerd aan een {{ site.apiname }} Proxy instantie. In onderstaand voorbeeld wordt het ocelot.json bestand in de src/config/ReisdocumentProxy/configuration map gemonteerd aan een {{ site.apiname }} Proxy instantie.

```yaml

      containers:
        - name: reisdocumentproxy
          image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: Release
            - name: ASPNETCORE_URLS
              value: http://+:5000
          ports:
            - name: http-reisdocumentproxy
              containerPort: 5000
          volumeMounts:
            - name: reisdocumentproxy-routing-configuration
              mountPath: /app/configuration
      volumes:
        - name: reisdocumentproxy-routing-configuration
          hostPath:
            path: <host-path>/Haal-Centraal-Reisdocumenten-bevragen/src/config/ReisdocumentProxy/configuration

```

waarbij **host-path** gelijk is aan

- */run/desktop/mnt/host/c* voor een Windows machine waarop Docker Desktop is geïnstalleerd en Kubernetes ondersteuning is aangezet en de {{ site.api }} repository is gecloned naar de c:/Haal-Centraal-Reisdocumenten-bevragen map.

## Logging

- [Log level](#log-level)
- [Log providers](#log-providers)

### Log level

Standaard is de {{ site.apiname }} Proxy geconfigureerd met Log level `Warning`. Bij deze Log level wordt alleen ongeldige bevragingen (bevragingen die resulteren in een 4XX en 5XX HTTP status response) gelogd.

Om alle bevragingen te loggen moet de Log level op `Information` worden gezet. De Log level wordt gezet met behulp van de *Serilog__MinimumLevel__Override__Serilog* environment variabele.

In de volgende voorbeelden wordt de Log level gezet op `Information`.

Docker Compose variant:

```yaml

  reisdocumentproxy:
    container_name: reisdocumentproxy
    image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Serilog__MinimumLevel__Override__Serilog=Information
    ports:
      - "5002:5000"
    networks:
      - reisdocumenten-api-network

```

Kubernetes variant:

```yaml

      containers:
        - name: reisdocumentproxy
          image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: Release
            - name: ASPNETCORE_URLS
              value: http://+:5000
            - name: Serilog__MinimumLevel__Override__Serilog
              value: Information
          ports:
            - name: http-reisdocumentproxy
              containerPort: 5000

```

### Log providers

De {{ site.apiname }} Proxy kan log regels wegschrijven naar de volgende log providers:

- Console
- Seq
- Bestand in Elasticsearch Common Schema (ECS) formaat

#### Console log provider

Standaard wordt in de console (in Docker Desktop de Logs tab van de container) gelogd naar welke log providers er wordt gelogd.

Ten behoeve van debugging is het mogelijk om de requests te laten loggen naar de console. Hiervoor moet de waarde van de *Serilog__MinimumLevel__Override__Serilog* environment worden gezet op **Debug**. Omdat loggen naar de console impact kan hebben op de performance, wordt het niet aangeraden om loggen naar de console in productie te gebruiken.

#### Seq

Om naar een Seq server te laten loggen moet de url naar de Seq server worden opgegeven met behulp van de *Seq__ServerUrl* environment variabele.

```yaml

  reisdocumentproxy:
    container_name: reisdocumentproxy
    image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Seq__ServerUrl=http://seq:5341
    ports:
      - "5002:5000"
    networks:
      - reisdocumenten-api-network

```

#### Bestand in Elasticsearch Common Schema (ECS) formaat

Om naar een bestand te laten loggen moet het volledig pad van het log bestand worden opgegeven met behulp van de *Ecs__Path* environment variabele. De log regels worden in Elasticsearch Common Schema (ECS) formaat naar het bestand geschreven.

```yaml

  reisdocumentproxy:
    container_name: reisdocumentproxy
    image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Ecs__Path=/var/log/api/reisdocumentproxy.txt
    ports:
      - "5002:5000"
    networks:
      - reisdocumenten-api-network

```

## mTLS

Om de communicatie tussen de {{ site.apiname }} Proxy tussen een API Gateway of de {{ site.apiname }} Web API GBA variant bij RvIG over mTLS te laten plaatsvinden, moet de {{ site.apiname }} Proxy moet de volgende environment variabelen worden gezet:

- ClientCertificate__Name met de naam van het client certificaat bestand
- ClientCertificate__Password met het wachtwoord horende bij de client certificaat

Ook moet de map waar de client certificaat staat met behulp van een volume mount worden gemonteerd met /app/certificates. In onderstaand voorbeeld zijn de client certificaat settings toegevoegd aan de Proxy configuratie.

```yaml

  reisdocumentproxy:
    container_name: reisdocumentproxy
    image: ghcr.io/brp-api/haal-centraal-reisdocument-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Serilog__MinimumLevel__Override__Serilog=Information
      - ClientCertificate__Name=xxx
      - ClientCertificate__Password=yyy
    ports:
      - "5002:5000"
    volumes:
      - <pad client certificaat map>:/app/certificates
    networks:
      - reisdocumenten-api-network

```
