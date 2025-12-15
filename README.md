# Ekperimen Mekanisme Distributed Systems Menggunakan Redis Replication, Redis Sentinel, dan Redis Cluster

Proyek ini merupakan bagian dari tugas mata kuliah **Distributed System Course (EF234508)**.

| Nama | NRP |
| --- | --- |
| Kinar Naila Fauziah | 5025231001|
| Anindya Diany Putri | 5025231007|
| Nathaniel Christine M.S | 5025231010 |

## Fitur Utama dan Highlight Eksperimen

Proyek ini adalah serangkaian eksperimen yang bertujuan untuk memahami implementasi dan mekanisme utama dari sistem terdistribusi menggunakan berbagai konfigurasi Redis.

* **Redis Replication (Master-Replica):** Menguji arsitektur replikasi dasar.
* **Redis Sentinel (Leader Election & Failover):** Mengeksplorasi kemampuan *monitoring*, *failure detection*, dan *leader election* otomatis.
* **Redis Cluster (Sharding & High Availability):** Memahami *sharding* (pembagian data berdasarkan *hash slot* 0-16383) dan *auto-failover* pada klaster.
* **Isu Konsistensi:** Mengamati perbedaan konsistensi (*read-after-write* vs *eventual consistency*) dan *replication delay*.
* **Toleransi Kesalahan (Fault Tolerance):** Menguji ketahanan sistem terhadap kegagalan *node* (crash node).
* **CAP Theorem:** Menganalisis *trade-off* ketersediaan, konsistensi, dan partisi pada Redis.

## Deskripsi Eksperimen

Eksperimen dibagi menjadi tiga skenario utama:

### Skenario 1: Replication Lag & Consistency

**Aspek:** *Eventual consistency*, *replication delay*.
**Tujuan:** Mengamati konsistensi data antara *master* dan *replica*.
**Langkah:**
1. Setup 1 master + 2 replica.
2. Kirim 1000 operasi `SET` (*write*) ke master.
3. Segera lakukan pembacaan (`GET`) dari replica.
4. Catat jumlah key yang belum tersinkron.

### Skenario 2: Failover pada Redis Sentinel

**Tujuan:** Menguji *leader election* otomatis dan ketersediaan data saat *failover*.
**Aspek:** *Leader election*, *availability*, *CAP trade-off*.
**Langkah:**
1. Setup Redis Sentinel (3 nodes) (Diasumsikan setup).
2. Matikan master (simulasi kegagalan).
3. Observasi waktu *failover* dan siapa *replica* yang menjadi *master* baru.
4. Uji penulisan data saat *failover* berlangsung dan validasi data setelah *failover* selesai.

### Skenario 3: Sharding pada Redis Cluster

**Aspek:** *Partitioning*, *consistent hashing*, *scaling out*.
**Tujuan:** Melihat distribusi key ke *hash slot* dan menguji ketahanan klaster.
**Langkah:**
1. Buat Redis Cluster dengan 3 node *primary* dan 3 node *replica* (total 6 node).
2. Simpan key dengan pola `key0`-`key10000`.
3. Amati pemetaan key per *node* (sharding).
4. Uji kegagalan *shard* dan cek ketersediaan data setelah *failover*.

## Teknologi yang Digunakan

* **Redis Server:** Basis data *in-memory* yang menjadi fokus eksperimen.
* **Bash Scripting:** Untuk otomatisasi setup dan pengujian.
* **`redis-cli`:** Utilitas utama untuk berinteraksi dengan Redis dan klaster.
* **`bc` (Basic Calculator):** Digunakan dalam skrip untuk perhitungan waktu eksekusi presisi tinggi.

## Prasyarat Instalasi

Pastikan Anda memiliki lingkungan Linux/Unix dan utilitas berikut terinstal:

1.  **Redis Server dan Redis Tools:**
    ```bash
    sudo apt update
    sudo apt install -y redis-server redis-tools
    ```
2.  **bc (Basic Calculator):** Diperlukan untuk pengukuran waktu dalam Skenario 1.
    ```bash
    sudo apt install -y bc
    ```
3.  **Lingkungan Jaringan:** Eksperimen ini dirancang untuk dijalankan pada lingkungan yang mendukung banyak node dengan IP statis (misalnya, VM atau GNS3), seperti yang terlihat dari IP yang dikonfigurasi dalam skrip (e.g., `192.168.122.x`).

## Susunan Project

