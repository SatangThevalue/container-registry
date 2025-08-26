# 📦 Azure Container Registry (ACR) ระดับ Basic  
**คู่มือสำหรับผู้เริ่มต้น** — เขียนสำหรับนักศึกษาและผู้สนใจใช้งานจริง  
*ใช้งานได้ฟรีใน Azure Free Account*

[![Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/media/container-registry-concepts/acr-diagram.png)](https://azure.microsoft.com/products/container-registry/)

---


## 📚 สารบัญ
- [เหตุผลที่ควรใช้ Azure Container Registry](#เหตุผลที่ควรใช้-azure-container-registry)
- [Azure Container Registry ระดับ Basic](#azure-container-registry-ระดับ-basic)
- [สิ่งที่ต้องเตรียมก่อนเริ่ม](#สิ่งที่ต้องเตรียมก่อนเริ่ม)
- [ขั้นตอนการใช้งาน](#ขั้นตอนการใช้งาน)
- [ข้อจำกัดของระดับ Basic](#ข้อจำกัดของระดับ-basic)
- [ตัวอย่างการใช้งานจริง](#ตัวอย่างการใช้งานจริง)
- [Container List](#container-list)
- [คำถามพบบ่อย (FAQ)](#คำถามพบบ่อย-faq)
- [แหล่งเรียนรู้เพิ่มเติม](#แหล่งเรียนรู้เพิ่มเติม)

---

## เหตุผลที่ควรใช้ Azure Container Registry
Azure Container Registry (ACR) คือ **รีจิสทรีส่วนตัว (Private Registry) สำหรับจัดเก็บ Docker Images** บน Azure  
จุดเด่น:
- ✅ จัดเก็บภาพคอนเทนเนอร์อย่างปลอดภัย
- ✅ ใช้งานร่วมกับเครื่องมือที่คุ้นเคย (Docker, Azure CLI)
- ✅ เชื่อมต่อกับ Azure DevOps และ GitHub Actions ได้ทันที
- ✅ Authentication และ RBAC ผ่าน Azure AD

> 💡 **นักศึกษาได้สิทธิพิเศษ**: ฟรี 12 เดือนใน Azure Free Account รวมพื้นที่เก็บข้อมูล **5–10 GB** โดยไม่เสียค่าใช้จ่าย

---

## Azure Container Registry ระดับ Basic
ACR มี 3 ระดับ (Basic, Standard, Premium) โดย **Basic** เหมาะกับ:
- 🎓 นักศึกษา, ผู้ที่เพิ่งเริ่มต้น
- 🧪 โปรเจกต์ทดลอง, POC
- 📘 งานวิชาการ/โปรเจกต์เรียน

### ✅ ข้อดี
| คุณสมบัติ | รายละเอียด |
|-----------|-------------|
| ราคา | ประมาณ $0.165/วัน (ฟรี 750 ชม./เดือนใน Free Account) |
| พื้นที่เก็บข้อมูล | 10 GB ฟรี (สูงสุด 40 TB) |
| ความปลอดภัย | Authentication ผ่าน Azure AD |
| การใช้งาน | รองรับ Push/Pull ภาพพื้นฐาน |
| เหมาะสำหรับ | โปรเจกต์เล็กและการเรียนรู้ |

### ⚠️ ข้อจำกัด
- ❌ ไม่รองรับ Geo-replication คือความสามารถในการ ซิงก์ registry ไปยังหลาย region ของ Azure
- ❌ ไม่รองรับ Content Trust  คือการ เซ็นดิจิทัล (signing) Docker Image เพื่อยืนยันว่า image นั้น ไม่ถูกแก้ไข/ปลอมแปลง ระหว่างการส่ง
- ❌ ไม่รองรับ Private Link คือการเชื่อมต่อ ผ่าน private network (VNet) ของ Azure โดยตรง โดยไม่ผ่าน public internet 

---

## สิ่งที่ต้องเตรียมก่อนเริ่ม
1. **Azure Free Account** → [สมัครฟรี](https://azure.microsoft.com/free/students/)  
2. **Azure CLI** → [ติดตั้งตามระบบปฏิบัติการ](https://learn.microsoft.com/cli/azure/install-azure-cli)  
3. **Docker Desktop** → [ดาวน์โหลด](https://www.docker.com/products/docker-desktop/)  
4. **Terminal** เช่น PowerShell, CMD, Bash  

---

## ขั้นตอนการใช้งาน

### 🛠️ 1. สร้าง ACR
```bash
az login
az group create --name myResourceGroup --location southeastasia
az acr create --resource-group myResourceGroup --name <ชื่อรีจิสทรี> --sku Basic
```
> 📌 `<ชื่อรีจิสทรี>` ต้องเป็นภาษาอังกฤษทั้งหมด ไม่มีช่องว่าง เช่น `myfirstacr`

### 🔑 2. ล็อกอินเข้า ACR
```bash
az acr login --name <ชื่อรีจิสทรี>
```

### 🐳 3. Push Docker Image ขึ้น ACR
```bash
docker pull mcr.microsoft.com/mcr/hello-world
docker tag mcr.microsoft.com/mcr/hello-world <ชื่อรีจิสทรี>.azurecr.io/samples/hello-world
docker push <ชื่อรีจิสทรี>.azurecr.io/samples/hello-world
```

### 🔍 4. ตรวจสอบ Images
```bash
az acr repository list --name <ชื่อรีจิสทรี> --output table
```
**ผลลัพธ์ที่ได้**:
```
Result
----------------
samples/hello-world
```

---

## ข้อจำกัดของระดับ Basic
| คุณสมบัติ | ระดับ Basic | หมายเหตุ |
|-----------|-------------|----------|
| พื้นที่เก็บข้อมูล | 10 GB | ฟรีใน Free Account |
| สูงสุด | 40 TB | มีค่าใช้จ่ายเพิ่ม |
| ความเร็วดาวน์โหลด | ~30 Mbps | |
| ความเร็วอัปโหลด | ~10 Mbps | |
| Webhooks | สูงสุด 2 | |
| Repository-scoped Permissions | ✅ รองรับ | |
| Geo-replication | ❌ ไม่รองรับ | |
| Private Link | ❌ ไม่รองรับ | |
| Content Trust | ❌ ไม่รองรับ | |

> ⚠️ **คำเตือน**: ชื่อรีจิสทรี **เปลี่ยนไม่ได้** หากลบแล้วสร้างใหม่อาจมี hash ต่อท้าย เช่น `myacr-abc123.azurecr.io`

---


## Container List

| ชื่อ (บริการ)         | docker Hub | เวอร์ชั่น | ความพร้อมในการใช้งาน | อ้างอิงจาก (Docker Hub) | หมายเหตุ |
|----------------------|--------------------------------------------|-----------|----------------------|-------------------------|----------|
| Postgres Database    | satangthevalue/postgres                    | 16    | ✅                   | [Docker Hub](https://hub.docker.com/_/postgres) | ใช้สำหรับฐานข้อมูลหลัก |
| pgAdmin              | satangthevalue/pgadmin                     | 9.7.0    | ✅                   | [Docker Hub](https://hub.docker.com/r/dpage/pgadmin4) | UI สำหรับจัดการ Postgres |

## ตัวอย่างการใช้งานจริง

### 🎓 โปรเจกต์นักศึกษา
```bash
docker build -t myapp:v1 .
docker tag myapp:v1 myfirstacr.azurecr.io/project1/myapp:v1
docker push myfirstacr.azurecr.io/project1/myapp:v1
```

### 🔄 ใช้ร่วมกับ GitHub Actions
```yaml
- name: Push to ACR
  run: |
    echo ${{ secrets.DOCKER_PASSWORD }} | docker login ${{ env.ACR_NAME }}.azurecr.io -u 00000000-0000-0000-0000-000000000000 --password-stdin
    docker tag myapp ${{ env.ACR_NAME }}.azurecr.io/${{ github.repository }}:latest
    docker push ${{ env.ACR_NAME }}.azurecr.io/${{ github.repository }}:latest
  env:
    ACR_NAME: myfirstacr
```

---

## คำถามพบบ่อย (FAQ)

### ❓ ทำไม Push ไม่ได้?
- ยังไม่ได้ล็อกอิน `az acr login`  
- หรือ tag ไม่ตรง `<ชื่อรีจิสทรี>.azurecr.io/...`

### ❓ ใช้ฟรีกี่เดือน?
- ฟรี **12 เดือน** + เครดิต $200 (30 วันแรก)

### ❓ ลบแล้วชื่อหาย ทำไง?
- ชื่อจะมี hash ต่อท้าย แก้ไขไม่ได้  
- ควรตั้งชื่อให้ชัดเจน เช่น `student-acr-ชื่อ-นามสกุล`

### ❓ ใช้กับ Kubernetes ได้หรือไม่?
- ได้ ใช้กับ AKS ได้ เช่น  
```bash
az aks update -n myAKSCluster -g myResourceGroup --attach-acr myfirstacr
```

---

## แหล่งเรียนรู้เพิ่มเติม
- [Azure Container Registry สำหรับนักศึกษา](https://learn.microsoft.com/th-th/azure/container-registry/container-registry-get-started-azure-cli)  
- [Docker เริ่มต้นใช้งาน](https://docs.docker.com/get-started/)  
- [สมัคร Azure Free Account](https://azure.microsoft.com/free/students/)  
- [ตัวอย่างโค้ด GitHub จาก Azure](https://github.com/Azure-Samples?query=container)  

---

[![Azure Student](https://arit.rmutt.ac.th/wp-content/uploads/2022/04/220465Microsoft-Azure-01-1200x675.jpg)](https://arit.rmutt.ac.th/)  
**นักศึกษาใช้ฟรี $100 + สิทธิพิเศษมากมาย!**
อ้างอิงจากหน้าเว็บ อย่างเป็นทางการของ RMUTT
```
Microsoft Azure คือ Platform เหนือเมฆ 
เทคโนโลยี Cloud เริ่มได้รับความสนใจจากองค์กรธุรกิจรุ่นใหม่มากขึ้นเรื่อย ๆ ในปัจจุบัน เพราะเป็นสิ่งหนึ่งที่ใช้งานง่าย บริหารจัดการง่าย ช่วยให้ธุรกิจทำงานได้คล่องตัวมากขึ้น หนึ่งในผู้ให้บริการด้านเทคโนโลยี Cloud สำหรับองค์กรอีกรายหนึ่งที่มีระบบที่ดีและมีความน่าสนใจก็คือ Microsoft ที่ได้สร้างบริการอย่าง Microsoft Azure ขึ้นมาเพื่อตอบสนองการทำงานในองค์กร

สำนักวิทยบริการและเทคโนโลยีสารสนเทศ มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี พร้อมให้บริการซอฟต์แวร์ลิขสิทธิ์ไม่มีค่าใช้จ่าย สำหรับอาจารย์ เจ้าหน้าที่ และนักศึกษา มทร.ธัญบุรี โดยท่านสามารถลงทะเบียนเข้าใช้งานด้วย E-Mail RMUTT
```
