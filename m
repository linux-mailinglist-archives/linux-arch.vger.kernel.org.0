Return-Path: <linux-arch+bounces-15877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC116D3BF94
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0647A3A589C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16E38B986;
	Tue, 20 Jan 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CtOkBlKD"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFC038B7AB;
	Tue, 20 Jan 2026 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891424; cv=none; b=eA4LjKFfqKMXO2B7y2TEYNyIwfPOE67xf6DuwszWZFfR9B/5zhiRUSg03rAA4z0E7bxfxbAQpYnnzgP7IXSnygZbnHGc07b5MIKI5pFJi5ezvvxCMuugZoPIHlbNLwZlDVJlZDltHdOThIJBGz67i39wiFGiqudAq8+hLkFDWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891424; c=relaxed/simple;
	bh=c6JvVOx8H/VsONhvif1DwT/sjYWxXqar3Z23TKRFpvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYeoYva0nicARcHWe8jNdxbinACMhDlAOD5L0jpYvptQsj3EFDa558xAU7wN6xF2XewBEl1Cyg51MwEUf9+3gPjlWOFatvx+FFDXwv+zSwlOWAvALa3gyGikR9K95LW4PlutY9mPiIbR3Q8Qkwm+RI+bgSv8MzXgSUi5Y+n+Yj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CtOkBlKD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 61BB720B716B;
	Mon, 19 Jan 2026 22:43:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61BB720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891409;
	bh=OW5YDvS1bnMpcoEg7TkbfyRItoXlmLCY/FzGfytcf20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtOkBlKD1snMCZLTU1RVXK4B70q0j/qdQdNToYjpfbrUk5q1CMAueGuNXVUUUNYGV
	 vyMLMpKqhA268xEuKMPv3jQvKewk211zA7VcqqqSDtn3PgISO8wPVMmPgV+GMAEjlu
	 0irIps+DTXZb3EICOgazglMYdg3TZSs3+MuikP7M=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joro@8bytes.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	nunodasneves@linux.microsoft.com,
	mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: [PATCH v0 02/15] x86/hyperv: cosmetic changes in irqdomain.c for readability
Date: Mon, 19 Jan 2026 22:42:17 -0800
Message-ID: <20260120064230.3602565-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Rathor <mrathor@linux.microsoft.com>

Make cosmetic changes:
 o Rename struct pci_dev *dev to *pdev since there are cases of
   struct device *dev in the file and all over the kernel
 o Rename hv_build_pci_dev_id to hv_build_devid_type_pci in anticipation
   of building different types of device ids
 o Fix checkpatch.pl issues with return and extraneous printk
 o Replace spaces with tabs
 o Rename struct hv_devid *xxx to struct hv_devid *hv_devid given code
   paths involve many types of device ids
 o Fix indentation in a large if block by using goto.

There are no functional changes.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c | 197 +++++++++++++++++++-----------------
 1 file changed, 103 insertions(+), 94 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index c3ba12b1bc07..f6b61483b3b8 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
 /*
  * Irqdomain for Linux to run as the root partition on Microsoft Hypervisor.
  *
@@ -14,8 +13,8 @@
 #include <linux/irqchip/irq-msi-lib.h>
 #include <asm/mshyperv.h>
 
-static int hv_map_interrupt(union hv_device_id device_id, bool level,
-		int cpu, int vector, struct hv_interrupt_entry *entry)
+static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
+		int cpu, int vector, struct hv_interrupt_entry *ret_entry)
 {
 	struct hv_input_map_device_interrupt *input;
 	struct hv_output_map_device_interrupt *output;
@@ -32,7 +31,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	intr_desc = &input->interrupt_descriptor;
 	memset(input, 0, sizeof(*input));
 	input->partition_id = hv_current_partition_id;
-	input->device_id = device_id.as_uint64;
+	input->device_id = hv_devid.as_uint64;
 	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
 	intr_desc->vector_count = 1;
 	intr_desc->target.vector = vector;
@@ -44,7 +43,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 
 	intr_desc->target.vp_set.valid_bank_mask = 0;
 	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));
+	nr_bank = cpumask_to_vpset(&intr_desc->target.vp_set, cpumask_of(cpu));
 	if (nr_bank < 0) {
 		local_irq_restore(flags);
 		pr_err("%s: unable to generate VP set\n", __func__);
@@ -61,7 +60,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 
 	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, var_size,
 			input, output);
-	*entry = output->interrupt_entry;
+	*ret_entry = output->interrupt_entry;
 
 	local_irq_restore(flags);
 
@@ -71,21 +70,19 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	return hv_result_to_errno(status);
 }
 
-static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
+static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *irq_entry)
 {
 	unsigned long flags;
 	struct hv_input_unmap_device_interrupt *input;
-	struct hv_interrupt_entry *intr_entry;
 	u64 status;
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	memset(input, 0, sizeof(*input));
-	intr_entry = &input->interrupt_entry;
 	input->partition_id = hv_current_partition_id;
 	input->device_id = id;
-	*intr_entry = *old_entry;
+	input->interrupt_entry = *irq_entry;
 
 	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
 	local_irq_restore(flags);
@@ -115,67 +112,71 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
+static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
 {
-	union hv_device_id dev_id;
+	int pos;
+	union hv_device_id hv_devid;
 	struct rid_data data = {
 		.bridge = NULL,
-		.rid = PCI_DEVID(dev->bus->number, dev->devfn)
+		.rid = PCI_DEVID(pdev->bus->number, pdev->devfn)
 	};
 
-	pci_for_each_dma_alias(dev, get_rid_cb, &data);
+	pci_for_each_dma_alias(pdev, get_rid_cb, &data);
 
-	dev_id.as_uint64 = 0;
-	dev_id.device_type = HV_DEVICE_TYPE_PCI;
-	dev_id.pci.segment = pci_domain_nr(dev->bus);
+	hv_devid.as_uint64 = 0;
+	hv_devid.device_type = HV_DEVICE_TYPE_PCI;
+	hv_devid.pci.segment = pci_domain_nr(pdev->bus);
 
-	dev_id.pci.bdf.bus = PCI_BUS_NUM(data.rid);
-	dev_id.pci.bdf.device = PCI_SLOT(data.rid);
-	dev_id.pci.bdf.function = PCI_FUNC(data.rid);
-	dev_id.pci.source_shadow = HV_SOURCE_SHADOW_NONE;
+	hv_devid.pci.bdf.bus = PCI_BUS_NUM(data.rid);
+	hv_devid.pci.bdf.device = PCI_SLOT(data.rid);
+	hv_devid.pci.bdf.function = PCI_FUNC(data.rid);
+	hv_devid.pci.source_shadow = HV_SOURCE_SHADOW_NONE;
 
-	if (data.bridge) {
-		int pos;
+	if (data.bridge == NULL)
+		goto out;
 
-		/*
-		 * Microsoft Hypervisor requires a bus range when the bridge is
-		 * running in PCI-X mode.
-		 *
-		 * To distinguish conventional vs PCI-X bridge, we can check
-		 * the bridge's PCI-X Secondary Status Register, Secondary Bus
-		 * Mode and Frequency bits. See PCI Express to PCI/PCI-X Bridge
-		 * Specification Revision 1.0 5.2.2.1.3.
-		 *
-		 * Value zero means it is in conventional mode, otherwise it is
-		 * in PCI-X mode.
-		 */
+	/*
+	 * Microsoft Hypervisor requires a bus range when the bridge is
+	 * running in PCI-X mode.
+	 *
+	 * To distinguish conventional vs PCI-X bridge, we can check
+	 * the bridge's PCI-X Secondary Status Register, Secondary Bus
+	 * Mode and Frequency bits. See PCI Express to PCI/PCI-X Bridge
+	 * Specification Revision 1.0 5.2.2.1.3.
+	 *
+	 * Value zero means it is in conventional mode, otherwise it is
+	 * in PCI-X mode.
+	 */
 
-		pos = pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
-		if (pos) {
-			u16 status;
+	pos = pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
+	if (pos) {
+		u16 status;
 
-			pci_read_config_word(data.bridge, pos +
-					PCI_X_BRIDGE_SSTATUS, &status);
+		pci_read_config_word(data.bridge, pos + PCI_X_BRIDGE_SSTATUS,
+				     &status);
 
-			if (status & PCI_X_SSTATUS_FREQ) {
-				/* Non-zero, PCI-X mode */
-				u8 sec_bus, sub_bus;
+		if (status & PCI_X_SSTATUS_FREQ) {
+			/* Non-zero, PCI-X mode */
+			u8 sec_bus, sub_bus;
 
-				dev_id.pci.source_shadow = HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE;
+			hv_devid.pci.source_shadow =
+					     HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE;
 
-				pci_read_config_byte(data.bridge, PCI_SECONDARY_BUS, &sec_bus);
-				dev_id.pci.shadow_bus_range.secondary_bus = sec_bus;
-				pci_read_config_byte(data.bridge, PCI_SUBORDINATE_BUS, &sub_bus);
-				dev_id.pci.shadow_bus_range.subordinate_bus = sub_bus;
-			}
+			pci_read_config_byte(data.bridge, PCI_SECONDARY_BUS,
+					     &sec_bus);
+			hv_devid.pci.shadow_bus_range.secondary_bus = sec_bus;
+			pci_read_config_byte(data.bridge, PCI_SUBORDINATE_BUS,
+					     &sub_bus);
+			hv_devid.pci.shadow_bus_range.subordinate_bus = sub_bus;
 		}
 	}
 
-	return dev_id;
+out:
+	return hv_devid;
 }
 
-/**
- * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
+/*
+ * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
  * @data:      Describes the IRQ
  * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
  *
@@ -188,22 +189,23 @@ int hv_map_msi_interrupt(struct irq_data *data,
 {
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_interrupt_entry dummy;
-	union hv_device_id device_id;
+	union hv_device_id hv_devid;
 	struct msi_desc *msidesc;
-	struct pci_dev *dev;
+	struct pci_dev *pdev;
 	int cpu;
 
 	msidesc = irq_data_get_msi_desc(data);
-	dev = msi_desc_to_pci_dev(msidesc);
-	device_id = hv_build_pci_dev_id(dev);
+	pdev = msi_desc_to_pci_dev(msidesc);
+	hv_devid = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
-	return hv_map_interrupt(device_id, false, cpu, cfg->vector,
+	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
 				out_entry ? out_entry : &dummy);
 }
 EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
-static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
+static void entry_to_msi_msg(struct hv_interrupt_entry *entry,
+			     struct msi_msg *msg)
 {
 	/* High address is always 0 */
 	msg->address_hi = 0;
@@ -211,17 +213,19 @@ static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi
 	msg->data = entry->msi_entry.data.as_uint32;
 }
 
-static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry);
+static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
+				  struct hv_interrupt_entry *irq_entry);
+
 static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct hv_interrupt_entry *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct msi_desc *msidesc;
-	struct pci_dev *dev;
+	struct pci_dev *pdev;
 	int ret;
 
 	msidesc = irq_data_get_msi_desc(data);
-	dev = msi_desc_to_pci_dev(msidesc);
+	pdev = msi_desc_to_pci_dev(msidesc);
 
 	if (!cfg) {
 		pr_debug("%s: cfg is NULL", __func__);
@@ -240,7 +244,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		stored_entry = data->chip_data;
 		data->chip_data = NULL;
 
-		ret = hv_unmap_msi_interrupt(dev, stored_entry);
+		ret = hv_unmap_msi_interrupt(pdev, stored_entry);
 
 		kfree(stored_entry);
 
@@ -249,10 +253,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	}
 
 	stored_entry = kzalloc(sizeof(*stored_entry), GFP_ATOMIC);
-	if (!stored_entry) {
-		pr_debug("%s: failed to allocate chip data\n", __func__);
+	if (!stored_entry)
 		return;
-	}
 
 	ret = hv_map_msi_interrupt(data, stored_entry);
 	if (ret) {
@@ -262,18 +264,21 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	data->chip_data = stored_entry;
 	entry_to_msi_msg(data->chip_data, msg);
-
-	return;
 }
 
-static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry)
+static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
+				  struct hv_interrupt_entry *irq_entry)
 {
-	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry);
+	union hv_device_id hv_devid;
+
+	hv_devid = hv_build_devid_type_pci(pdev);
+	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
 
-static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
+/* NB: during map, hv_interrupt_entry is saved via data->chip_data */
+static void hv_teardown_msi_irq(struct pci_dev *pdev, struct irq_data *irqd)
 {
-	struct hv_interrupt_entry old_entry;
+	struct hv_interrupt_entry irq_entry;
 	struct msi_msg msg;
 
 	if (!irqd->chip_data) {
@@ -281,13 +286,13 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
 		return;
 	}
 
-	old_entry = *(struct hv_interrupt_entry *)irqd->chip_data;
-	entry_to_msi_msg(&old_entry, &msg);
+	irq_entry = *(struct hv_interrupt_entry *)irqd->chip_data;
+	entry_to_msi_msg(&irq_entry, &msg);
 
 	kfree(irqd->chip_data);
 	irqd->chip_data = NULL;
 
-	(void)hv_unmap_msi_interrupt(dev, &old_entry);
+	(void)hv_unmap_msi_interrupt(pdev, &irq_entry);
 }
 
 /*
@@ -302,7 +307,8 @@ static struct irq_chip hv_pci_msi_controller = {
 };
 
 static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
-				 struct irq_domain *real_parent, struct msi_domain_info *info)
+				 struct irq_domain *real_parent,
+				 struct msi_domain_info *info)
 {
 	struct irq_chip *chip = info->chip;
 
@@ -317,7 +323,8 @@ static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 }
 
 #define HV_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
-#define HV_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
+#define HV_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
 
 static struct msi_parent_ops hv_msi_parent_ops = {
 	.supported_flags	= HV_MSI_FLAGS_SUPPORTED,
@@ -329,14 +336,13 @@ static struct msi_parent_ops hv_msi_parent_ops = {
 	.init_dev_msi_info	= hv_init_dev_msi_info,
 };
 
-static int hv_msi_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
-			       void *arg)
+static int hv_msi_domain_alloc(struct irq_domain *d, unsigned int virq,
+			       unsigned int nr_irqs, void *arg)
 {
 	/*
-	 * TODO: The allocation bits of hv_irq_compose_msi_msg(), i.e. everything except
-	 * entry_to_msi_msg() should be in here.
+	 * TODO: The allocation bits of hv_irq_compose_msi_msg(), i.e.
+	 *	 everything except entry_to_msi_msg() should be in here.
 	 */
-
 	int ret;
 
 	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
@@ -344,13 +350,15 @@ static int hv_msi_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned
 		return ret;
 
 	for (int i = 0; i < nr_irqs; ++i) {
-		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller, NULL,
-				    handle_edge_irq, NULL, "edge");
+		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller,
+				    NULL, handle_edge_irq, NULL, "edge");
 	}
+
 	return 0;
 }
 
-static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
+static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq,
+			       unsigned int nr_irqs)
 {
 	for (int i = 0; i < nr_irqs; ++i) {
 		struct irq_data *irqd = irq_domain_get_irq_data(d, virq);
@@ -362,6 +370,7 @@ static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, unsigned
 
 		hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
 	}
+
 	irq_domain_free_irqs_top(d, virq, nr_irqs);
 }
 
@@ -394,25 +403,25 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
 
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
 {
-	union hv_device_id device_id;
+	union hv_device_id hv_devid;
 
-	device_id.as_uint64 = 0;
-	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
-	device_id.ioapic.ioapic_id = (u8)ioapic_id;
+	hv_devid.as_uint64 = 0;
+	hv_devid.device_type = HV_DEVICE_TYPE_IOAPIC;
+	hv_devid.ioapic.ioapic_id = (u8)ioapic_id;
 
-	return hv_unmap_interrupt(device_id.as_uint64, entry);
+	return hv_unmap_interrupt(hv_devid.as_uint64, entry);
 }
 EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
 
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int cpu, int vector,
 		struct hv_interrupt_entry *entry)
 {
-	union hv_device_id device_id;
+	union hv_device_id hv_devid;
 
-	device_id.as_uint64 = 0;
-	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
-	device_id.ioapic.ioapic_id = (u8)ioapic_id;
+	hv_devid.as_uint64 = 0;
+	hv_devid.device_type = HV_DEVICE_TYPE_IOAPIC;
+	hv_devid.ioapic.ioapic_id = (u8)ioapic_id;
 
-	return hv_map_interrupt(device_id, level, cpu, vector, entry);
+	return hv_map_interrupt(hv_devid, level, cpu, vector, entry);
 }
 EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
-- 
2.51.2.vfs.0.1


