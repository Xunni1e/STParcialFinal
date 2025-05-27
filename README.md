# STParcialFinal
# To Run application

## Start and SSH into Vagrant VM 

```
vagrant up
vagrant ssh servidorWeb
```

## Run the webApp

```
cd /home/vagrant/webapp
export FLASK_APP=run.py
/usr/local/bin/flask run --host=0.0.0.0
```
## Tercera Parte  
📡 **Monitoreo con Prometheus y Node Exporter**

Proyecto de monitoreo de sistema Linux utilizando Prometheus y Node Exporter en Ubuntu 22.04 (EC2). Incluye instalación, configuración y consulta de métricas.

---

## ✅ Fase 4: Instalación y Configuración de Prometheus

### 🔧 Pasos realizados

```bash
# Descargar Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-amd64.tar.gz

# Extraer el archivo
tar -xvf prometheus-2.51.2.linux-amd64.tar.gz
cd prometheus-2.51.2.linux-amd64
```

---

### 🛠️ Archivo de configuración `prometheus.yml`  
📂 Ruta: `prometheus-2.51.2.linux-amd64/prometheus.yml`

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
```

---

### 🚀 Ejecutar Prometheus

```bash
./prometheus --config.file=prometheus.yml
```

---

## ✅ Fase 4.2: Instalación y Configuración de Node Exporter

```bash
# Descargar Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz

# Extraer
tar -xvf node_exporter-1.8.0.linux-amd64.tar.gz
cd node_exporter-1.8.0.linux-amd64

# Ejecutar
./node_exporter
```

---

## ✅ Verificación de Targets

📍 Abrir en el navegador:

```
http://<IP_PUBLICA_EC2>:9090/targets
```

Se deben ver los targets `localhost:9090` y `localhost:9100` en estado **UP**.

---

## ✅ Exploración y Documentación de Métricas del Sistema

### 🔎 1. Uso de CPU

- **Consulta:**
  ```promql
  rate(node_cpu_seconds_total{mode!="idle"}[1m])
  ```

- **Descripción:**  
  Mide el tiempo en segundos que el CPU estuvo activo (sin contar el tiempo en `idle`) durante el último minuto. Útil para detectar carga alta de CPU.

---

### 🔎 2. Memoria disponible

- **Consulta:**
  ```promql
  node_memory_MemAvailable_bytes
  ```

- **Descripción:**  
  Muestra cuántos bytes de memoria están disponibles para nuevos procesos. Ayuda a prevenir falta de memoria RAM y swapping.

---

### 🔎 3. Espacio en disco

- **Consulta:**
  ```promql
  node_filesystem_avail_bytes{fstype!~"tmpfs|overlay"}
  ```

- **Descripción:**  
  Indica la cantidad de espacio disponible en los sistemas de archivos. Es clave para evitar fallos por disco lleno.

---


## 🗂️ Rutas de archivos relevantes

| Archivo / Directorio                    | Propósito                          |
|----------------------------------------|------------------------------------|
| `/tmp/prometheus-2.51.2.linux-amd64/`   | Carpeta de Prometheus              |
| `prometheus.yml`                        | Archivo de configuración principal |
| `/tmp/node_exporter-1.8.0.linux-amd64/` | Carpeta de Node Exporter           |
