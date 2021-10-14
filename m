Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7A42DEB2
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJNP4f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 11:56:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44790 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhJNP4e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 11:56:34 -0400
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id A4EFF20B9D00; Thu, 14 Oct 2021 08:54:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4EFF20B9D00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1634226869;
        bh=kAnb/nXu9eL2z6OTTfJQxnRrbOyQw0uuBgbUPNab42A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my0xXpRJ+N37vpG9mvDB2X0tglLi+se7J3sfCLOmxHtvwizAk9Jg00fMXnIrE9ATO
         oPS8tAwl2Ou+LQzcyU22iyEzDgHfO8S/z8UmfgWRf/BjF/ZethTentk2nEclygdTrv
         +wkxEt8oF8XQh5o68sZMZ9pgpNZlBLEJ7vRGBLVE=
From:   Sunil Muthuswamy <sunilmut@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, maz@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, arnd@arndb.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v3 1/2] PCI: hv: Make the code arch neutral by adding arch specific interfaces
Date:   Thu, 14 Oct 2021 08:53:13 -0700
Message-Id: <1634226794-9540-2-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Encapsulate arch dependencies in Hyper-V vPCI through a set of interfaces,
listed below. Adding these arch specific interfaces will allow for an
implementation for other arch, such as ARM64.

Implement the interfaces for X64, which is essentially just moving over the
current implementation.

List of added interfaces:
 - hv_pci_irqchip_init()
 - hv_pci_irqchip_free()
 - hv_msi_get_int_vector()
 - hv_set_msi_entry_from_desc()
 - hv_msi_prepare()

There are no functional changes expected from this patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
In v2 & v3:
 Changes are described in the cover letter.

 MAINTAINERS                                 |  2 +
 arch/x86/include/asm/hyperv-tlfs.h          | 33 ++++++++++++
 arch/x86/include/asm/mshyperv.h             |  7 ---
 drivers/pci/controller/Makefile             |  2 +-
 drivers/pci/controller/pci-hyperv-irqchip.c | 57 +++++++++++++++++++++
 drivers/pci/controller/pci-hyperv-irqchip.h | 20 ++++++++
 drivers/pci/controller/pci-hyperv.c         | 52 ++++++++++++-------
 include/asm-generic/hyperv-tlfs.h           | 33 ------------
 8 files changed, 146 insertions(+), 60 deletions(-)
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..ba8c979c17b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8688,6 +8688,8 @@ F:	drivers/iommu/hyperv-iommu.c
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
+F:	drivers/pci/controller/pci-hyperv-irqchip.c
+F:	drivers/pci/controller/pci-hyperv-irqchip.h
 F:	drivers/pci/controller/pci-hyperv.c
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 2322d6bd5883..fdf3d28fbdd5 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -585,6 +585,39 @@ enum hv_interrupt_type {
 	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
 };
 
+union hv_msi_address_register {
+	u32 as_uint32;
+	struct {
+		u32 reserved1:2;
+		u32 destination_mode:1;
+		u32 redirection_hint:1;
+		u32 reserved2:8;
+		u32 destination_id:8;
+		u32 msi_base:12;
+	};
+} __packed;
+
+union hv_msi_data_register {
+	u32 as_uint32;
+	struct {
+		u32 vector:8;
+		u32 delivery_mode:3;
+		u32 reserved1:3;
+		u32 level_assert:1;
+		u32 trigger_mode:1;
+		u32 reserved2:16;
+	};
+} __packed;
+
+/* HvRetargetDeviceInterrupt hypercall */
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		union hv_msi_address_register address;
+		union hv_msi_data_register data;
+	} __packed;
+};
+
 #include <asm-generic/hyperv-tlfs.h>
 
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index adccbc209169..c2b9ab94408e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -176,13 +176,6 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
 
-static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
-					      struct msi_desc *msi_desc)
-{
-	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
-	msi_entry->data.as_uint32 = msi_desc->msg.data;
-}
-
 struct irq_domain *hv_create_pci_msi_domain(void);
 
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index aaf30b3dcc14..2c301d0fc23b 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_PCIE_CADENCE) += cadence/
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
 obj-$(CONFIG_PCI_IXP4XX) += pci-ixp4xx.o
-obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
+obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o pci-hyperv-irqchip.o
 obj-$(CONFIG_PCI_HYPERV_INTERFACE) += pci-hyperv-intf.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
diff --git a/drivers/pci/controller/pci-hyperv-irqchip.c b/drivers/pci/controller/pci-hyperv-irqchip.c
new file mode 100644
index 000000000000..36fa862f8bc5
--- /dev/null
+++ b/drivers/pci/controller/pci-hyperv-irqchip.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyper-V vPCI irqchip.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
+ */
+
+#include <asm/mshyperv.h>
+#include <linux/acpi.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+
+#ifdef CONFIG_X86_64
+int hv_pci_irqchip_init(struct irq_domain **parent_domain,
+			bool *fasteoi_handler,
+			u8 *delivery_mode)
+{
+	*parent_domain = x86_vector_domain;
+	*fasteoi_handler = false;
+	*delivery_mode = APIC_DELIVERY_MODE_FIXED;
+
+	return 0;
+}
+EXPORT_SYMBOL(hv_pci_irqchip_init);
+
+void hv_pci_irqchip_free(void) {}
+EXPORT_SYMBOL(hv_pci_irqchip_free);
+
+unsigned int hv_msi_get_int_vector(struct irq_data *data)
+{
+	struct irq_cfg *cfg = irqd_cfg(data);
+
+	return cfg->vector;
+}
+EXPORT_SYMBOL(hv_msi_get_int_vector);
+
+void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				struct msi_desc *msi_desc)
+{
+	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
+	msi_entry->data.as_uint32 = msi_desc->msg.data;
+}
+EXPORT_SYMBOL(hv_set_msi_entry_from_desc);
+
+int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+		   int nvec, msi_alloc_info_t *info)
+{
+	return pci_msi_prepare(domain, dev, nvec, info);
+}
+EXPORT_SYMBOL(hv_msi_prepare);
+
+#endif
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-hyperv-irqchip.h b/drivers/pci/controller/pci-hyperv-irqchip.h
new file mode 100644
index 000000000000..00549809e6c4
--- /dev/null
+++ b/drivers/pci/controller/pci-hyperv-irqchip.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Architecture specific vector management for the Hyper-V vPCI.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
+ */
+
+int hv_pci_irqchip_init(struct irq_domain **parent_domain,
+			bool *fasteoi_handler,
+			u8 *delivery_mode);
+
+void hv_pci_irqchip_free(void);
+unsigned int hv_msi_get_int_vector(struct irq_data *data);
+void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				struct msi_desc *msi_desc);
+
+int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+		   int nvec, msi_alloc_info_t *info);
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index eaec915ffe62..2d3916206986 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -43,14 +43,12 @@
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
 #include <linux/semaphore.h>
-#include <linux/irqdomain.h>
-#include <asm/irqdomain.h>
-#include <asm/apic.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
 #include <asm/mshyperv.h>
+#include "pci-hyperv-irqchip.h"
 
 /*
  * Protocol versions. The low word is the minor version, the high word the
@@ -81,6 +79,10 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
 	PCI_PROTOCOL_VERSION_1_1,
 };
 
+static struct irq_domain *parent_domain;
+static bool fasteoi;
+static u8 delivery_mode;
+
 #define PCI_CONFIG_MMIO_LENGTH	0x2000
 #define CFG_PAGE_OFFSET 0x1000
 #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
@@ -1217,7 +1219,6 @@ static void hv_irq_mask(struct irq_data *data)
 static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
-	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_retarget_device_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
@@ -1246,11 +1247,12 @@ static void hv_irq_unmask(struct irq_data *data)
 			   (hbus->hdev->dev_instance.b[7] << 8) |
 			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
 			   PCI_FUNC(pdev->devfn);
-	params->int_target.vector = cfg->vector;
+	params->int_target.vector = hv_msi_get_int_vector(data);
 
 	/*
-	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
-	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
+	 * For x64, honoring apic->delivery_mode set to
+	 * APIC_DELIVERY_MODE_FIXED by setting the
+	 * HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
 	 * spurious interrupt storm. Not doing so does not seem to have a
 	 * negative effect (yet?).
 	 */
@@ -1347,7 +1349,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode = delivery_mode;
 
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1377,7 +1379,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode = delivery_mode;
 	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
@@ -1397,7 +1399,7 @@ static u32 hv_compose_msi_req_v3(
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.reserved = 0;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode = delivery_mode;
 	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
@@ -1419,7 +1421,6 @@ static u32 hv_compose_msi_req_v3(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
@@ -1470,7 +1471,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_2:
@@ -1478,14 +1479,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_4:
 		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
 
 	default:
@@ -1601,7 +1602,7 @@ static struct irq_chip hv_msi_irq_chip = {
 };
 
 static struct msi_domain_ops hv_msi_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= hv_msi_prepare,
 	.msi_free	= hv_msi_free,
 };
 
@@ -1625,12 +1626,13 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
 		MSI_FLAG_PCI_MSIX);
-	hbus->msi_info.handler = handle_edge_irq;
-	hbus->msi_info.handler_name = "edge";
+	hbus->msi_info.handler =
+		fasteoi ? handle_fasteoi_irq : handle_edge_irq;
+	hbus->msi_info.handler_name = fasteoi ? "fasteoi" : "edge";
 	hbus->msi_info.data = hbus;
 	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
-						     x86_vector_domain);
+						     parent_domain);
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
@@ -3531,13 +3533,21 @@ static void __exit exit_hv_pci_drv(void)
 	hvpci_block_ops.read_block = NULL;
 	hvpci_block_ops.write_block = NULL;
 	hvpci_block_ops.reg_blk_invalidate = NULL;
+
+	hv_pci_irqchip_free();
 }
 
 static int __init init_hv_pci_drv(void)
 {
+	int ret;
+
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	ret = hv_pci_irqchip_init(&parent_domain, &fasteoi, &delivery_mode);
+	if (ret)
+		return ret;
+
 	/* Set the invalid domain number's bit, so it will not be used */
 	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
 
@@ -3546,7 +3556,11 @@ static int __init init_hv_pci_drv(void)
 	hvpci_block_ops.write_block = hv_write_config_block;
 	hvpci_block_ops.reg_blk_invalidate = hv_register_block_invalidate;
 
-	return vmbus_driver_register(&hv_pci_drv);
+	ret = vmbus_driver_register(&hv_pci_drv);
+	if (ret)
+		hv_pci_irqchip_free();
+
+	return ret;
 }
 
 module_init(init_hv_pci_drv);
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 56348a541c50..45cc0c3b8ed7 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -539,39 +539,6 @@ enum hv_interrupt_source {
 	HV_INTERRUPT_SOURCE_IOAPIC,
 };
 
-union hv_msi_address_register {
-	u32 as_uint32;
-	struct {
-		u32 reserved1:2;
-		u32 destination_mode:1;
-		u32 redirection_hint:1;
-		u32 reserved2:8;
-		u32 destination_id:8;
-		u32 msi_base:12;
-	};
-} __packed;
-
-union hv_msi_data_register {
-	u32 as_uint32;
-	struct {
-		u32 vector:8;
-		u32 delivery_mode:3;
-		u32 reserved1:3;
-		u32 level_assert:1;
-		u32 trigger_mode:1;
-		u32 reserved2:16;
-	};
-} __packed;
-
-/* HvRetargetDeviceInterrupt hypercall */
-union hv_msi_entry {
-	u64 as_uint64;
-	struct {
-		union hv_msi_address_register address;
-		union hv_msi_data_register data;
-	} __packed;
-};
-
 union hv_ioapic_rte {
 	u64 as_uint64;
 
-- 
2.25.1

