Return-Path: <linux-arch+bounces-15885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9492D3BFC0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14D2A4F3172
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536613A1D1D;
	Tue, 20 Jan 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WUo4duFo"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8E3904D1;
	Tue, 20 Jan 2026 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891439; cv=none; b=fIRyP/lqd6OOGZ92EouxBhJusctg8zEndotvLBrqZxVs318NaEz3K3ZEYpTjDOjQ+Zx4Ak2LbshVryDMK+u9PKtpe80Dx8j59Lvt/nbbDwn4eTJYZQ6JkbGeDdTCKcHrh/dxCuzcMOvPYYR91jPsxlXZJsZVZQ6rKzZyiL9ezAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891439; c=relaxed/simple;
	bh=tdSEMC7gqv6tHPycbN0VEeX7mwVJnRgh+dC2FHoxyF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlcKXkxwPNHW9gLVVNVKWjhVzF3gs8KSBY0yn1xOBnVa3WsFy/0GZiJQg9t9QFlH0DoHjEbqKTYu481AoFIRkc8/TW9wiheI4Eh7J9WjkYAPJ2mvHSw9gOYI0bMRi7O5zd8EJFrKFVVvt2i6JDI5C9w0qq/p2Xu/N6FnJom6A+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WUo4duFo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id C34CF20B716A;
	Mon, 19 Jan 2026 22:43:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C34CF20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891428;
	bh=lrCNvS0KTmv8uGW/3D9TXCk8n/kSy8BeNKs2VH+PdxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUo4duFom3CBzDyCu19ZnRecBUYp8n0SeTqWk9J+CY0/pdnqPS79j+NLppPdZJHRH
	 AgkHKXVNd8Pos+JSoPunRIWjLiVBK8ZjDR3Xnzl72PCd0aZd3RD7TjhUxCD6EdDM0R
	 RmI6/gSwPyF2Doi2co/U/mf/wzj6eRWLF83CoH7A=
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
Subject: [PATCH v0 13/15] x86/hyperv: Basic interrupt support for direct attached devices
Date: Mon, 19 Jan 2026 22:42:28 -0800
Message-ID: <20260120064230.3602565-14-mrathor@linux.microsoft.com>
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

As mentioned previously, a direct attached device must be referenced
via logical device id which is formed in the initial attach hypercall.
Interrupt mapping paths for direct attached devices are almost same,
except we must use logical device ids instead of the PCI device ids.

L1VH only supports direct attaches for passing thru devices to its guests,
and devices on L1VH are VMBus based. However, the interrupts are mapped
via the map interrupt hypercall and not the traditional method of VMBus
messages.

Partition id for the relevant hypercalls is tricky. This because a device
could be moving from root to guest and then back to the root. In case
of L1VH, it could be moving from system host to L1VH root to a guest,
then back to the L1VH root. So, it is carefully crafted by keeping
track of whether the call is on behalf of a VMM process, whether the
device is attached device (as opposed to mapped), and whether we are in
an L1VH root/parent. If VMM process, we assume it is on behalf of a
guest. Otherwise, the device is being attached or detached during boot
or shutdown of the privileged partition.

Lastly, a dummy cpu and vector is used to map interrupt for a direct
attached device. This because, once a device is marked for direct attach,
hypervisor will not let any interrupts be mapped to host. So it is mapped
to guest dummy cpu and dummy vector. This is then correctly mapped during
guest boot via the retarget paths.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h   | 15 +++++
 arch/x86/hyperv/irqdomain.c         | 57 +++++++++++++-----
 arch/x86/include/asm/mshyperv.h     |  4 ++
 drivers/pci/controller/pci-hyperv.c | 91 +++++++++++++++++++++++++----
 4 files changed, 142 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b721d3134ab6..27da480f94f6 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -53,6 +53,21 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 	return hv_get_msr(reg);
 }
 
+struct irq_data;
+struct msi_msg;
+struct pci_dev;
+static inline void hv_irq_compose_msi_msg(struct irq_data *data,
+					  struct msi_msg *msg) {};
+static inline int hv_unmap_msi_interrupt(struct pci_dev *pdev,
+					struct hv_interrupt_entry *hvirqe)
+{
+	return -EOPNOTSUPP;
+}
+static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
+{
+	return false;
+}
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 33017aa0caa4..e6eb457f791e 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -13,6 +13,16 @@
 #include <linux/irqchip/irq-msi-lib.h>
 #include <asm/mshyperv.h>
 
+/*
+ * For direct attached devices (which use logical device ids), hypervisor will
+ * not allow mappings to host. But VFIO needs to bind the interrupt at the very
+ * start before the guest cpu/vector is known. So we use dummy cpu and vector
+ * to bind in such case, and later when the guest starts, retarget will move it
+ * to correct guest cpu and vector.
+ */
+#define HV_DDA_DUMMY_CPU      0
+#define HV_DDA_DUMMY_VECTOR  32
+
 static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
 				  bool level, int cpu, int vector,
 				  struct hv_interrupt_entry *ret_entry)
@@ -24,6 +34,11 @@ static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
 	u64 status;
 	int nr_bank, var_size;
 
+	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL) {
+		cpu = HV_DDA_DUMMY_CPU;
+		vector = HV_DDA_DUMMY_VECTOR;
+	}
+
 	local_irq_save(flags);
 
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -95,7 +110,8 @@ static int hv_map_interrupt(u64 ptid, union hv_device_id device_id, bool level,
 	return hv_result_to_errno(status);
 }
 
-static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *irq_entry)
+static int hv_unmap_interrupt(union hv_device_id hv_devid,
+			      struct hv_interrupt_entry *irq_entry)
 {
 	unsigned long flags;
 	struct hv_input_unmap_device_interrupt *input;
@@ -103,10 +119,14 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *irq_entry)
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
 	memset(input, 0, sizeof(*input));
-	input->partition_id = hv_current_partition_id;
-	input->device_id = id;
+
+	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL)
+		input->partition_id = hv_iommu_get_curr_partid();
+	else
+		input->partition_id = hv_current_partition_id;
+
+	input->device_id = hv_devid.as_uint64;
 	input->interrupt_entry = *irq_entry;
 
 	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
@@ -263,6 +283,7 @@ static u64 hv_build_irq_devid(struct pci_dev *pdev)
 int hv_map_msi_interrupt(struct irq_data *data,
 			 struct hv_interrupt_entry *out_entry)
 {
+	u64 ptid;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_interrupt_entry dummy;
 	union hv_device_id hv_devid;
@@ -275,8 +296,17 @@ int hv_map_msi_interrupt(struct irq_data *data,
 	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
-	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
-				cfg->vector, out_entry ? out_entry : &dummy);
+	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL)
+		if (hv_pcidev_is_attached_dev(pdev))
+			ptid = hv_iommu_get_curr_partid();
+		else
+			/* Device actually on l1vh root, not passthru'd to vm */
+			ptid = hv_current_partition_id;
+	else
+		ptid = hv_current_partition_id;
+
+	return hv_map_interrupt(ptid, hv_devid, false, cpu, cfg->vector,
+				out_entry ? out_entry : &dummy);
 }
 EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
@@ -289,10 +319,7 @@ static void entry_to_msi_msg(struct hv_interrupt_entry *entry,
 	msg->data = entry->msi_entry.data.as_uint32;
 }
 
-static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
-				  struct hv_interrupt_entry *irq_entry);
-
-static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct hv_interrupt_entry *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
@@ -341,16 +368,18 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	data->chip_data = stored_entry;
 	entry_to_msi_msg(data->chip_data, msg);
 }
+EXPORT_SYMBOL_GPL(hv_irq_compose_msi_msg);
 
-static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
-				  struct hv_interrupt_entry *irq_entry)
+int hv_unmap_msi_interrupt(struct pci_dev *pdev,
+			   struct hv_interrupt_entry *irq_entry)
 {
 	union hv_device_id hv_devid;
 
 	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
 
-	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
+	return hv_unmap_interrupt(hv_devid, irq_entry);
 }
+EXPORT_SYMBOL_GPL(hv_unmap_msi_interrupt);
 
 /* NB: during map, hv_interrupt_entry is saved via data->chip_data */
 static void hv_teardown_msi_irq(struct pci_dev *pdev, struct irq_data *irqd)
@@ -486,7 +515,7 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
 	hv_devid.device_type = HV_DEVICE_TYPE_IOAPIC;
 	hv_devid.ioapic.ioapic_id = (u8)ioapic_id;
 
-	return hv_unmap_interrupt(hv_devid.as_uint64, entry);
+	return hv_unmap_interrupt(hv_devid, entry);
 }
 EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index e4ccdbbf1d12..b6facd3a0f5e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -204,11 +204,15 @@ static inline u64 hv_iommu_get_curr_partid(void)
 #endif	/* CONFIG_HYPERV_IOMMU */
 
 u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
+void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
+extern bool hv_no_attdev;
 
 struct irq_domain *hv_create_pci_msi_domain(void);
 
 int hv_map_msi_interrupt(struct irq_data *data,
 			 struct hv_interrupt_entry *out_entry);
+int hv_unmap_msi_interrupt(struct pci_dev *dev,
+			   struct hv_interrupt_entry *hvirqe);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 40f0b06bb966..71d1599dc4a8 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -660,15 +660,17 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 
 	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	memset(params, 0, sizeof(*params));
-	params->partition_id = HV_PARTITION_ID_SELF;
+
+	if (hv_pcidev_is_attached_dev(pdev))
+		params->partition_id = hv_iommu_get_curr_partid();
+	else
+		params->partition_id = HV_PARTITION_ID_SELF;
+
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
-	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
+	params->int_entry.msi_entry.address.as_uint32 =
+						int_desc->address & 0xffffffff;
 	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
-	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
-			   (hbus->hdev->dev_instance.b[4] << 16) |
-			   (hbus->hdev->dev_instance.b[7] << 8) |
-			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
-			   PCI_FUNC(pdev->devfn);
+	params->device_id = hv_pci_vmbus_device_id(pdev);
 	params->int_target.vector = hv_msi_get_int_vector(data);
 
 	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
@@ -1263,6 +1265,15 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 			mb();
 		}
 		spin_unlock_irqrestore(&hbus->config_lock, flags);
+		/*
+		 * Make sure PCI_INTERRUPT_PIN is hard-wired to 0 since it may
+		 * be read using a 32bit read which is skipped by the above
+		 * emulation.
+		 */
+		if (PCI_INTERRUPT_PIN >= where &&
+		    PCI_INTERRUPT_PIN <= (where + size)) {
+			*((char *)val + PCI_INTERRUPT_PIN - where) = 0;
+		}
 	} else {
 		dev_err(dev, "Attempt to read beyond a function's config space.\n");
 	}
@@ -1731,14 +1742,22 @@ static void hv_msi_free(struct irq_domain *domain, unsigned int irq)
 	if (!int_desc)
 		return;
 
-	irq_data->chip_data = NULL;
 	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
 	if (!hpdev) {
+		irq_data->chip_data = NULL;
 		kfree(int_desc);
 		return;
 	}
 
-	hv_int_desc_free(hpdev, int_desc);
+	if (hv_pcidev_is_attached_dev(pdev)) {
+		hv_unmap_msi_interrupt(pdev, irq_data->chip_data);
+		kfree(irq_data->chip_data);
+		irq_data->chip_data = NULL;
+	} else {
+		irq_data->chip_data = NULL;
+		hv_int_desc_free(hpdev, int_desc);
+	}
+
 	put_pcichild(hpdev);
 }
 
@@ -2139,6 +2158,56 @@ static void hv_vmbus_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data = 0;
 }
 
+/* Compose an msi message for a directly attached device */
+static void hv_dda_compose_msi_msg(struct irq_data *irq_data,
+				   struct msi_desc *msi_desc,
+				   struct msi_msg *msg)
+{
+	bool multi_msi;
+	struct hv_pcibus_device *hbus;
+	struct hv_pci_dev *hpdev;
+	struct pci_dev *pdev = msi_desc_to_pci_dev(msi_desc);
+
+	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
+		    msi_desc->nvec_used > 1;
+
+	if (multi_msi) {
+		dev_err(&hbus->hdev->device,
+			"Passthru direct attach does not support multi msi\n");
+		goto outerr;
+	}
+
+	hbus = container_of(pdev->bus->sysdata, struct hv_pcibus_device,
+			    sysdata);
+
+	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
+	if (!hpdev)
+		goto outerr;
+
+	/* will unmap if needed and also update irq_data->chip_data */
+	hv_irq_compose_msi_msg(irq_data, msg);
+
+	put_pcichild(hpdev);
+	return;
+
+outerr:
+	memset(msg, 0, sizeof(*msg));
+}
+
+static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct pci_dev *pdev;
+	struct msi_desc *msi_desc;
+
+	msi_desc = irq_data_get_msi_desc(data);
+	pdev = msi_desc_to_pci_dev(msi_desc);
+
+	if (hv_pcidev_is_attached_dev(pdev))
+		hv_dda_compose_msi_msg(data, msi_desc, msg);
+	else
+		hv_vmbus_compose_msi_msg(data, msg);
+}
+
 static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				      struct irq_domain *real_parent, struct msi_domain_info *info)
 {
@@ -2177,7 +2246,7 @@ static const struct msi_parent_ops hv_pcie_msi_parent_ops = {
 /* HW Interrupt Chip Descriptor */
 static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
-	.irq_compose_msi_msg	= hv_vmbus_compose_msi_msg,
+	.irq_compose_msi_msg	= hv_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
@@ -4096,7 +4165,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 		irq_data = irq_get_irq_data(entry->irq);
 		if (WARN_ON_ONCE(!irq_data))
 			return -EINVAL;
-		hv_vmbus_compose_msi_msg(irq_data, &entry->msg);
+		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
 	return 0;
 }
-- 
2.51.2.vfs.0.1


