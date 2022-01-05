Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC71F485939
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiAETdR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 14:33:17 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59738 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243540AbiAETdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 14:33:14 -0500
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id D491320B717A; Wed,  5 Jan 2022 11:33:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D491320B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641411193;
        bh=8TYc9VdkH5Y1le0NbUGUbj06rSqcYull5fxvJwO4IXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q981Ob0l2PtjGzRVRL0BfJlwcHOsK76WMRp/4cifosXCDF/Q8Dc9k15Rpq6yJkqkx
         CXJtJePpnW72xEct+RKDZovj1yaTPeb3CcUxbc+AWtMMqpS++ADf7q5xX5l2b1WiYx
         gHU8H2AY5bBAK5UuMJXseJ1sZTmdxmUt9QfAODtc=
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
Subject: [PATCH v8 1/2] PCI: hv: Make the code arch neutral by adding arch specific interfaces
Date:   Wed,  5 Jan 2022 11:32:35 -0800
Message-Id: <1641411156-31705-2-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
References: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Encapsulate arch dependencies in Hyper-V vPCI through a set of
arch-dependent interfaces. Adding these arch specific interfaces will
allow for an implementation for other architectures, such as arm64.

There are no functional changes expected from this patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
---
In v2, v3, v4, v5, v6, v7 & v8:
 Changes are described in the cover letter. No changes from v4 -> v5,
 v6 -> v7 or v7 -> v8.

 arch/x86/include/asm/hyperv-tlfs.h  | 33 ++++++++++++
 arch/x86/include/asm/mshyperv.h     |  7 ---
 drivers/pci/controller/pci-hyperv.c | 79 ++++++++++++++++++++---------
 include/asm-generic/hyperv-tlfs.h   | 33 ------------
 4 files changed, 87 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 381e88122a5f..0a9407dc0859 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -602,6 +602,39 @@ enum hv_interrupt_type {
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
index da3972fe5a7a..a1c3dceff8eb 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -169,13 +169,6 @@ bool hv_vcpu_is_preempted(int vcpu);
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
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6733cb14e775..ead7d6cb6bf1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -43,9 +43,6 @@
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
 #include <linux/semaphore.h>
-#include <linux/irqdomain.h>
-#include <asm/irqdomain.h>
-#include <asm/apic.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
@@ -583,6 +580,42 @@ struct hv_pci_compl {
 
 static void hv_pci_onchannelcallback(void *context);
 
+#ifdef CONFIG_X86
+#define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
+#define FLOW_HANDLER	handle_edge_irq
+#define FLOW_NAME	"edge"
+
+static int hv_pci_irqchip_init(void)
+{
+	return 0;
+}
+
+static struct irq_domain *hv_pci_get_root_domain(void)
+{
+	return x86_vector_domain;
+}
+
+static unsigned int hv_msi_get_int_vector(struct irq_data *data)
+{
+	struct irq_cfg *cfg = irqd_cfg(data);
+
+	return cfg->vector;
+}
+
+static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				       struct msi_desc *msi_desc)
+{
+	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
+	msi_entry->data.as_uint32 = msi_desc->msg.data;
+}
+
+static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+			  int nvec, msi_alloc_info_t *info)
+{
+	return pci_msi_prepare(domain, dev, nvec, info);
+}
+#endif /* CONFIG_X86 */
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -1191,14 +1224,6 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
 	put_pcichild(hpdev);
 }
 
-static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
-			   bool force)
-{
-	struct irq_data *parent = data->parent_data;
-
-	return parent->chip->irq_set_affinity(parent, dest, force);
-}
-
 static void hv_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
@@ -1217,7 +1242,6 @@ static void hv_irq_mask(struct irq_data *data)
 static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
-	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_retarget_device_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
@@ -1246,7 +1270,7 @@ static void hv_irq_unmask(struct irq_data *data)
 			   (hbus->hdev->dev_instance.b[7] << 8) |
 			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
 			   PCI_FUNC(pdev->devfn);
-	params->int_target.vector = cfg->vector;
+	params->int_target.vector = hv_msi_get_int_vector(data);
 
 	/*
 	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
@@ -1347,7 +1371,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
 
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1377,7 +1401,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
 	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
@@ -1397,7 +1421,7 @@ static u32 hv_compose_msi_req_v3(
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.reserved = 0;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
 	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
@@ -1419,7 +1443,6 @@ static u32 hv_compose_msi_req_v3(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
@@ -1470,7 +1493,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_2:
@@ -1478,14 +1501,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
@@ -1594,14 +1617,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
 	.irq_compose_msi_msg	= hv_compose_msi_msg,
-	.irq_set_affinity	= hv_set_affinity,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= hv_irq_mask,
 	.irq_unmask		= hv_irq_unmask,
 };
 
 static struct msi_domain_ops hv_msi_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= hv_msi_prepare,
 	.msi_free	= hv_msi_free,
 };
 
@@ -1625,12 +1648,12 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
 		MSI_FLAG_PCI_MSIX);
-	hbus->msi_info.handler = handle_edge_irq;
-	hbus->msi_info.handler_name = "edge";
+	hbus->msi_info.handler = FLOW_HANDLER;
+	hbus->msi_info.handler_name = FLOW_NAME;
 	hbus->msi_info.data = hbus;
 	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
-						     x86_vector_domain);
+						     hv_pci_get_root_domain());
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
@@ -3542,9 +3565,15 @@ static void __exit exit_hv_pci_drv(void)
 
 static int __init init_hv_pci_drv(void)
 {
+	int ret;
+
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	ret = hv_pci_irqchip_init();
+	if (ret)
+		return ret;
+
 	/* Set the invalid domain number's bit, so it will not be used */
 	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 8ed6733d5146..8f97c2927bee 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -540,39 +540,6 @@ enum hv_interrupt_source {
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


