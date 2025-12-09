Return-Path: <linux-arch+bounces-15314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874BCAEEDA
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 06:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE58530B621E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 05:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5DB2D7DFF;
	Tue,  9 Dec 2025 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b69JYPQz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B127935F;
	Tue,  9 Dec 2025 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257124; cv=none; b=KIGcxYQUnd4VgbHhxByv8r+C8PM1GJt8xZ8tnZaSZiF/HQebSZsRZKEfoJAryke96Lhbi6Ox5hyUAeU9sP0leBOKgtZTbPd916MzoUG+oDsz/m/SRiWqthm3ag7iMW1XAJH6AzexN3LSZlAltX27roy/mfh3wFqKmK1S25loLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257124; c=relaxed/simple;
	bh=L82HXe73SVx67NNaZXv8amAvz07p+NaULya+Vyvg4bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWP1BeNIlmvpT/O8GOPoSctUo8RFV4UQibc44iqIhWMzoRdmHvX4fEkstJcEo7ZgPhXHp5RziI58uHRazeO4weFGBxg2IXMrsbTpgZcBrRon4ikJiygwyz4uzDZqJ4gtORVrXSy/spjRd4qfTYo1Y2qwoAenA5kYgHbIo/XwQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b69JYPQz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id E63C4201568D;
	Mon,  8 Dec 2025 21:11:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E63C4201568D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765257120;
	bh=21lCcfM5o1iG7jk9CsmQjcy+0iwTDq8Q7ftlfWHO2ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b69JYPQzv5EY8vInUrxi7ujYELxgc23q2zxOeEWw+nNGU3GLa8YXVT9qVJm9gIW7B
	 Q0jqIsAQtaCKWIay1yKV1wrJ7nSVpLch8GeiclmlQJIkg8cdnIgxX13b/IS9I7aVOQ
	 cpD3uDgSA5xyPbhe+rfKgEuyyTCM0HB8/4C238J4=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
Date: Tue,  9 Dec 2025 13:11:28 +0800
Message-ID: <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
This driver implements stage-1 IO translation within the guest OS.
It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
for:
 - Capability discovery
 - Domain allocation, configuration, and deallocation
 - Device attachment and detachment
 - IOTLB invalidation

The driver constructs x86-compatible stage-1 IO page tables in the
guest memory using consolidated IO page table helpers. This allows
the guest to manage stage-1 translations independently of vendor-
specific drivers (like Intel VT-d or AMD IOMMU).

Hyper-v consumes this stage-1 IO page table, when a device domain is
created and configured, and nests it with the host's stage-2 IO page
tables, therefore elemenating the VM exits for guest IOMMU mapping
operations.

For guest IOMMU unmapping operations, VM exits to perform the IOTLB
flush(and possibly the device TLB flush) is still unavoidable. For
now, HVCALL_FLUSH_DEVICE_DOMAIN	is used to implement a domain-selective
IOTLB flush. New hypercalls for finer-grained hypercall will be provided
in future patches.

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/iommu/hyperv/Kconfig  |  14 +
 drivers/iommu/hyperv/Makefile |   1 +
 drivers/iommu/hyperv/iommu.c  | 608 ++++++++++++++++++++++++++++++++++
 drivers/iommu/hyperv/iommu.h  |  53 +++
 4 files changed, 676 insertions(+)
 create mode 100644 drivers/iommu/hyperv/iommu.c
 create mode 100644 drivers/iommu/hyperv/iommu.h

diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
index 30f40d867036..fa3c77752d7b 100644
--- a/drivers/iommu/hyperv/Kconfig
+++ b/drivers/iommu/hyperv/Kconfig
@@ -8,3 +8,17 @@ config HYPERV_IOMMU
 	help
 	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
 	  guest and root partitions.
+
+if HYPERV_IOMMU
+config HYPERV_PVIOMMU
+	bool "Microsoft Hypervisor para-virtualized IOMMU support"
+	depends on X86 && HYPERV && PCI_HYPERV
+	depends on IOMMU_PT
+	select IOMMU_API
+	select IOMMU_DMA
+	select DMA_OPS
+	select IOMMU_IOVA
+	default HYPERV
+	help
+	  A para-virtualized IOMMU for Microsoft Hypervisor guest.
+endif
diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
index 9f557bad94ff..8669741c0a51 100644
--- a/drivers/iommu/hyperv/Makefile
+++ b/drivers/iommu/hyperv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_HYPERV_IOMMU) += irq_remapping.o
+obj-$(CONFIG_HYPERV_PVIOMMU) += iommu.o
diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
new file mode 100644
index 000000000000..3d0aff868e16
--- /dev/null
+++ b/drivers/iommu/hyperv/iommu.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V IOMMU driver.
+ *
+ * Copyright (C) 2019, 2024-2025 Microsoft, Inc.
+ */
+
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/dma-map-ops.h>
+#include <linux/generic_pt/iommu.h>
+#include <linux/syscore_ops.h>
+#include <linux/pci-ats.h>
+
+#include <asm/iommu.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+
+#include "iommu.h"
+#include "../dma-iommu.h"
+#include "../iommu-pages.h"
+
+static void hv_iommu_detach_dev(struct iommu_domain *domain, struct device *dev);
+static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain);
+struct hv_iommu_dev *hv_iommu_device;
+static struct hv_iommu_domain hv_identity_domain;
+static struct hv_iommu_domain hv_blocking_domain;
+static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
+static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
+static struct iommu_ops hv_iommu_ops;
+
+#define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
+#define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1)
+#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_5LVL)
+#define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)
+
+static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_stage)
+{
+	int ret;
+	u64 status;
+	unsigned long flags;
+	struct hv_input_create_device_domain *input;
+
+	ret = ida_alloc_range(&hv_iommu_device->domain_ids,
+			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
+			GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	hv_domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	hv_domain->device_domain.domain_id.type = domain_stage;
+	hv_domain->device_domain.domain_id.id = ret;
+	hv_domain->hv_iommu = hv_iommu_device;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	input->create_device_domain_flags.forward_progress_required = 1;
+	input->create_device_domain_flags.inherit_owning_vtl = 0;
+	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+		ida_free(&hv_iommu_device->domain_ids, hv_domain->device_domain.domain_id.id);
+	}
+
+	return hv_result_to_errno(status);
+}
+
+static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_delete_device_domain *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	ida_free(&hv_domain->hv_iommu->domain_ids, hv_domain->device_domain.domain_id.id);
+}
+
+static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int hv_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	u64 status;
+	unsigned long flags;
+	struct pci_dev *pdev;
+	struct hv_input_attach_device_domain *input;
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
+
+	/* Only allow PCI devices for now */
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	if (vdev->hv_domain == hv_domain)
+		return 0;
+
+	if (vdev->hv_domain)
+		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
+
+	pdev = to_pci_dev(dev);
+	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : "",
+		hv_domain->device_domain.domain_id.id);
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	input->device_id.as_uint64 = hv_build_logical_dev_id(pdev);
+	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+	} else {
+		vdev->hv_domain = hv_domain;
+		spin_lock_irqsave(&hv_domain->lock, flags);
+		list_add(&vdev->list, &hv_domain->dev_list);
+		spin_unlock_irqrestore(&hv_domain->lock, flags);
+	}
+
+	return hv_result_to_errno(status);
+}
+
+static void hv_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_detach_device_domain *input;
+	struct pci_dev *pdev;
+	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	/* See the attach function, only PCI devices for now */
+	if (!dev_is_pci(dev) || vdev->hv_domain != hv_domain)
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	dev_dbg(dev, "Detaching from %d\n", hv_domain->device_domain.domain_id.id);
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->device_id.as_uint64 = hv_build_logical_dev_id(pdev);
+	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	spin_lock_irqsave(&hv_domain->lock, flags);
+	hv_flush_device_domain(hv_domain);
+	list_del(&vdev->list);
+	spin_unlock_irqrestore(&hv_domain->lock, flags);
+
+	vdev->hv_domain = NULL;
+}
+
+static int hv_iommu_get_logical_device_property(struct device *dev,
+					enum hv_logical_device_property_code code,
+					struct hv_output_get_logical_device_property *property)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_logical_device_property *input;
+	struct hv_output_get_logical_device_property *output;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->logical_device_id = hv_build_logical_dev_id(to_pci_dev(dev));
+	input->code = code;
+	status = hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, output);
+	*property = *output;
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	return hv_result_to_errno(status);
+}
+
+static struct iommu_device *hv_iommu_probe_device(struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct hv_iommu_endpoint *vdev;
+	struct hv_output_get_logical_device_property device_iommu_property = {0};
+
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	if (hv_iommu_get_logical_device_property(dev,
+						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
+						 &device_iommu_property) ||
+	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
+		return ERR_PTR(-ENODEV);
+
+	pdev = to_pci_dev(dev);
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return ERR_PTR(-ENOMEM);
+
+	vdev->dev = dev;
+	vdev->hv_iommu = hv_iommu_device;
+	dev_iommu_priv_set(dev, vdev);
+
+	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
+	    pci_ats_supported(pdev))
+		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
+
+	return &vdev->hv_iommu->iommu;
+}
+
+static void hv_iommu_release_device(struct device *dev)
+{
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	if (vdev->hv_domain)
+		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
+
+	dev_iommu_priv_set(dev, NULL);
+	set_dma_ops(dev, NULL);
+
+	kfree(vdev);
+}
+
+static struct iommu_group *hv_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	else
+		return generic_device_group(dev);
+}
+
+static int hv_configure_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_type)
+{
+	u64 status;
+	unsigned long flags;
+	struct pt_iommu_x86_64_hw_info pt_info;
+	struct hv_input_configure_device_domain *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	input->settings.flags.blocked = (domain_type == IOMMU_DOMAIN_BLOCKED);
+	input->settings.flags.translation_enabled = (domain_type != IOMMU_DOMAIN_IDENTITY);
+
+	if (domain_type & __IOMMU_DOMAIN_PAGING) {
+		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64, &pt_info);
+		input->settings.page_table_root = pt_info.gcr3_pt;
+		input->settings.flags.first_stage_paging_mode =
+			pt_info.levels == 5;
+	}
+	status = hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	return hv_result_to_errno(status);
+}
+
+static int __init hv_initialize_static_domains(void)
+{
+	int ret;
+	struct hv_iommu_domain *hv_domain;
+
+	/* Default stage-1 identity domain */
+	hv_domain = &hv_identity_domain;
+	memset(hv_domain, 0, sizeof(*hv_domain));
+
+	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
+	if (ret)
+		return ret;
+
+	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
+	if (ret)
+		goto delete_identity_domain;
+
+	hv_domain->domain.type = IOMMU_DOMAIN_IDENTITY;
+	hv_domain->domain.ops = &hv_iommu_identity_domain_ops;
+	hv_domain->domain.owner = &hv_iommu_ops;
+	hv_domain->domain.geometry = hv_iommu_device->geometry;
+	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
+	INIT_LIST_HEAD(&hv_domain->dev_list);
+
+	/* Default stage-1 blocked domain */
+	hv_domain = &hv_blocking_domain;
+	memset(hv_domain, 0, sizeof(*hv_domain));
+
+	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
+	if (ret)
+		goto delete_identity_domain;
+
+	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
+	if (ret)
+		goto delete_blocked_domain;
+
+	hv_domain->domain.type = IOMMU_DOMAIN_BLOCKED;
+	hv_domain->domain.ops = &hv_iommu_blocking_domain_ops;
+	hv_domain->domain.owner = &hv_iommu_ops;
+	hv_domain->domain.geometry = hv_iommu_device->geometry;
+	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
+	INIT_LIST_HEAD(&hv_domain->dev_list);
+
+	return 0;
+
+delete_blocked_domain:
+	hv_delete_device_domain(&hv_blocking_domain);
+delete_identity_domain:
+	hv_delete_device_domain(&hv_identity_domain);
+	return ret;
+}
+
+#define INTERRUPT_RANGE_START	(0xfee00000)
+#define INTERRUPT_RANGE_END	(0xfeefffff)
+static void hv_iommu_get_resv_regions(struct device *dev,
+		struct list_head *head)
+{
+	struct iommu_resv_region *region;
+
+	region = iommu_alloc_resv_region(INTERRUPT_RANGE_START,
+				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
+				      0, IOMMU_RESV_MSI, GFP_KERNEL);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, head);
+}
+
+static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_flush_device_domain *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain.partition_id = hv_domain->device_domain.partition_id;
+	input->device_domain.owner_vtl = hv_domain->device_domain.owner_vtl;
+	input->device_domain.domain_id.type = hv_domain->device_domain.domain_id.type;
+	input->device_domain.domain_id.id = hv_domain->device_domain.domain_id.id;
+	status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+}
+
+static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	hv_flush_device_domain(to_hv_iommu_domain(domain));
+}
+
+static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *iotlb_gather)
+{
+	hv_flush_device_domain(to_hv_iommu_domain(domain));
+
+	iommu_put_pages_list(&iotlb_gather->freelist);
+}
+
+static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
+{
+	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
+
+	/* Free all remaining mappings */
+	pt_iommu_deinit(&hv_domain->pt_iommu);
+
+	hv_delete_device_domain(hv_domain);
+
+	kfree(hv_domain);
+}
+
+static const struct iommu_domain_ops hv_iommu_identity_domain_ops = {
+	.attach_dev	= hv_iommu_attach_dev,
+};
+
+static const struct iommu_domain_ops hv_iommu_blocking_domain_ops = {
+	.attach_dev	= hv_iommu_attach_dev,
+};
+
+static const struct iommu_domain_ops hv_iommu_paging_domain_ops = {
+	.attach_dev	= hv_iommu_attach_dev,
+	IOMMU_PT_DOMAIN_OPS(x86_64),
+	.flush_iotlb_all = hv_iommu_flush_iotlb_all,
+	.iotlb_sync = hv_iommu_iotlb_sync,
+	.free = hv_iommu_paging_domain_free,
+};
+
+static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
+{
+	int ret;
+	struct hv_iommu_domain *hv_domain;
+	struct pt_iommu_x86_64_cfg cfg = {};
+
+	hv_domain = kzalloc(sizeof(*hv_domain), GFP_KERNEL);
+	if (!hv_domain)
+		return ERR_PTR(-ENOMEM);
+
+	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
+	if (ret) {
+		kfree(hv_domain);
+		return ERR_PTR(ret);
+	}
+
+	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
+	hv_domain->domain.geometry = hv_iommu_device->geometry;
+	hv_domain->pt_iommu.nid = dev_to_node(dev);
+	INIT_LIST_HEAD(&hv_domain->dev_list);
+	spin_lock_init(&hv_domain->lock);
+
+	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
+	cfg.common.hw_max_oasz_lg2 = 52;
+
+	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
+	if (ret) {
+		hv_delete_device_domain(hv_domain);
+		return ERR_PTR(ret);
+	}
+
+	hv_domain->domain.ops = &hv_iommu_paging_domain_ops;
+
+	ret = hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
+	if (ret) {
+		pt_iommu_deinit(&hv_domain->pt_iommu);
+		hv_delete_device_domain(hv_domain);
+		return ERR_PTR(ret);
+	}
+
+	return &hv_domain->domain;
+}
+
+static struct iommu_ops hv_iommu_ops = {
+	.capable		  = hv_iommu_capable,
+	.domain_alloc_paging	  = hv_iommu_domain_alloc_paging,
+	.probe_device		  = hv_iommu_probe_device,
+	.release_device		  = hv_iommu_release_device,
+	.device_group		  = hv_iommu_device_group,
+	.get_resv_regions	  = hv_iommu_get_resv_regions,
+	.owner			  = THIS_MODULE,
+	.identity_domain	  = &hv_identity_domain.domain,
+	.blocked_domain		  = &hv_blocking_domain.domain,
+	.release_domain		  = &hv_blocking_domain.domain,
+};
+
+static void hv_iommu_shutdown(void)
+{
+	iommu_device_sysfs_remove(&hv_iommu_device->iommu);
+
+	kfree(hv_iommu_device);
+}
+
+static struct syscore_ops hv_iommu_syscore_ops = {
+	.shutdown = hv_iommu_shutdown,
+};
+
+static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_iommu_cap)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_iommu_capabilities *input;
+	struct hv_output_get_iommu_capabilities *output;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	status = hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output);
+	*hv_iommu_cap = *output;
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	return hv_result_to_errno(status);
+}
+
+static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
+			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
+{
+	ida_init(&hv_iommu->domain_ids);
+
+	hv_iommu->cap = hv_iommu_cap->iommu_cap;
+	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
+	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
+	    hv_iommu->max_iova_width > 48) {
+		pr_err("5-level paging not supported, limiting iova width to 48.\n");
+		hv_iommu->max_iova_width = 48;
+	}
+
+	hv_iommu->geometry = (struct iommu_domain_geometry) {
+		.aperture_start = 0,
+		.aperture_end = (((u64)1) << hv_iommu_cap->max_iova_width) - 1,
+		.force_aperture = true,
+	};
+
+	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
+	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_NULL - 1;
+	hv_iommu->pgsize_bitmap = hv_iommu_cap->pgsize_bitmap;
+	hv_iommu_device = hv_iommu;
+}
+
+static int __init hv_iommu_init(void)
+{
+	int ret = 0;
+	struct hv_iommu_dev *hv_iommu = NULL;
+	struct hv_output_get_iommu_capabilities hv_iommu_cap = {0};
+
+	if (no_iommu || iommu_detected)
+		return -ENODEV;
+
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
+	if (hv_iommu_detect(&hv_iommu_cap) ||
+	    !hv_iommu_present(hv_iommu_cap.iommu_cap) ||
+	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap))
+		return -ENODEV;
+
+	iommu_detected = 1;
+	pci_request_acs();
+
+	hv_iommu = kzalloc(sizeof(*hv_iommu), GFP_KERNEL);
+	if (!hv_iommu)
+		return -ENOMEM;
+
+	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
+
+	ret = hv_initialize_static_domains();
+	if (ret) {
+		pr_err("hv_initialize_static_domains failed: %d\n", ret);
+		goto err_sysfs_remove;
+	}
+
+	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-iommu");
+	if (ret) {
+		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
+		goto err_free;
+	}
+
+
+	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
+	if (ret) {
+		pr_err("iommu_device_register failed: %d\n", ret);
+		goto err_sysfs_remove;
+	}
+
+	register_syscore_ops(&hv_iommu_syscore_ops);
+
+	pr_info("Microsoft Hypervisor IOMMU initialized\n");
+	return 0;
+
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&hv_iommu->iommu);
+err_free:
+	kfree(hv_iommu);
+	return ret;
+}
+
+device_initcall(hv_iommu_init);
diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
new file mode 100644
index 000000000000..c8657e791a6e
--- /dev/null
+++ b/drivers/iommu/hyperv/iommu.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Hyper-V IOMMU driver.
+ *
+ * Copyright (C) 2024-2025, Microsoft, Inc.
+ *
+ */
+
+#ifndef _HYPERV_IOMMU_H
+#define _HYPERV_IOMMU_H
+
+struct hv_iommu_dev {
+	struct iommu_device iommu;
+	struct ida domain_ids;
+
+	/* Device configuration */
+	u8  max_iova_width;
+	u8  max_pasid_width;
+	u64 cap;
+	u64 pgsize_bitmap;
+
+	struct iommu_domain_geometry geometry;
+	u64 first_domain;
+	u64 last_domain;
+};
+
+struct hv_iommu_domain {
+	union {
+		struct iommu_domain    domain;
+		struct pt_iommu        pt_iommu;
+		struct pt_iommu_x86_64 pt_iommu_x86_64;
+	};
+	struct hv_iommu_dev *hv_iommu;
+	struct hv_input_device_domain device_domain;
+	u64		pgsize_bitmap;
+
+	spinlock_t lock; /* protects dev_list and TLB flushes */
+	/* List of devices in this DMA domain */
+	struct list_head dev_list;
+};
+
+struct hv_iommu_endpoint {
+	struct device *dev;
+	struct hv_iommu_dev *hv_iommu;
+	struct hv_iommu_domain *hv_domain;
+	struct list_head list; /* For domain->dev_list */
+};
+
+#define to_hv_iommu_domain(d) \
+	container_of(d, struct hv_iommu_domain, domain)
+
+#endif /* _HYPERV_IOMMU_H */
-- 
2.49.0


