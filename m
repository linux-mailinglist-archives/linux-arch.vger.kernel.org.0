Return-Path: <linux-arch+bounces-5653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442F93DB04
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 01:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D902836DC
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8C155A21;
	Fri, 26 Jul 2024 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CTdOB9Bt"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCAF15350B;
	Fri, 26 Jul 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034772; cv=none; b=Nre5m5MGZuCfWVr9NLzPf8+C2NE0DK4lsjJg3Qj3WVq8+ErhJt+3i9P4E9TJNkGFbgDmNxbER+2f5vqNfUCZ/pq7UXUEqy0LH8LSp0PebeY+uRDFRJl9jv17qvHNgfaa5ZaWVXiMXbNrFPc+C/yK0yPywBQpS/pBdJ+iZgCzbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034772; c=relaxed/simple;
	bh=DLUnroqMGGTesiv/VYVlyBGgrYzR5oprmLBsFYEDDqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGQ3tX4Ys899SEoFap3P14IHctNKxCdXbVubzplalkwuSFMgWm5xRPtVehbbHEtIIdtWRpRX1HCQXv2q34K8xDBNZ2CM/chKhXuEpXgAl9vJXGheF7brfazNxw/LC7mNj49yjJDYLkVoBu1Gs70hl2TBwHJKxiK3nmIOK7aARIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CTdOB9Bt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 262EB20B7139;
	Fri, 26 Jul 2024 15:59:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 262EB20B7139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722034770;
	bh=HO3yRXjuxdLjBhwnppBtgMAHdHUWQFnMBR0lzUnYMd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTdOB9BtLQmksCAEH7nr1aJW0bLAE0rIU2bYhoG+rAer6pFBGUyYbWzRaJPvLHOQg
	 hMNfTiuq7Q5Rkp5jRz875m5oA9Y7q4xceyViPsWreqV4KQPX14TOp15njTYyTtUBcq
	 0zEwjKEOQOaO/ndF5oPyEX4dc6FmkQM0vPTR838w=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	mingo@redhat.com,
	rafael@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 7/7] PCI: hv: Get vPCI MSI IRQ domain from DT
Date: Fri, 26 Jul 2024 15:59:10 -0700
Message-Id: <20240726225910.1912537-8-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726225910.1912537-1-romank@linux.microsoft.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
arm64. It won't be able to do that in the VTL mode where only DeviceTree
can be used.

Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
case, too.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c              | 23 +++++++-----
 drivers/pci/controller/pci-hyperv.c | 55 +++++++++++++++++++++++++++--
 include/linux/hyperv.h              |  2 ++
 3 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7eee7caff5f6..038bd9be64b7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -45,7 +45,8 @@ struct vmbus_dynid {
 	struct hv_vmbus_device_id id;
 };
 
-static struct device  *hv_dev;
+/* VMBus Root Device */
+static struct device  *vmbus_root_device;
 
 static int hyperv_cpuhp_online;
 
@@ -80,9 +81,15 @@ static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
 static DEFINE_MUTEX(hyperv_mmio_lock);
 
+struct device *get_vmbus_root_device(void)
+{
+	return vmbus_root_device;
+}
+EXPORT_SYMBOL_GPL(get_vmbus_root_device);
+
 static int vmbus_exists(void)
 {
-	if (hv_dev == NULL)
+	if (vmbus_root_device == NULL)
 		return -ENODEV;
 
 	return 0;
@@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_device)
 	 * On x86/x64 coherence is assumed and these calls have no effect.
 	 */
 	hv_setup_dma_ops(child_device,
-		device_get_dma_attr(hv_dev) == DEV_DMA_COHERENT);
+		device_get_dma_attr(vmbus_root_device) == DEV_DMA_COHERENT);
 	return 0;
 }
 
@@ -1892,7 +1899,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		     &child_device_obj->channel->offermsg.offer.if_instance);
 
 	child_device_obj->device.bus = &hv_bus;
-	child_device_obj->device.parent = hv_dev;
+	child_device_obj->device.parent = vmbus_root_device;
 	child_device_obj->device.release = vmbus_device_release;
 
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
@@ -2253,7 +2260,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 	struct acpi_device *ancestor;
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
-	hv_dev = &device->dev;
+	vmbus_root_device = &device->dev;
 
 	/*
 	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
@@ -2342,7 +2349,7 @@ static int vmbus_device_add(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	hv_dev = &pdev->dev;
+	vmbus_root_device = &pdev->dev;
 
 	ret = of_range_parser_init(&parser, np);
 	if (ret)
@@ -2675,7 +2682,7 @@ static int __init hv_acpi_init(void)
 	if (ret)
 		return ret;
 
-	if (!hv_dev) {
+	if (!vmbus_root_device) {
 		ret = -ENODEV;
 		goto cleanup;
 	}
@@ -2706,7 +2713,7 @@ static int __init hv_acpi_init(void)
 
 cleanup:
 	platform_driver_unregister(&vmbus_platform_driver);
-	hv_dev = NULL;
+	vmbus_root_device = NULL;
 	return ret;
 }
 
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..cdecefd1f9bd 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -50,6 +50,7 @@
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
 #include <linux/sizes.h>
+#include <linux/of_irq.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -887,6 +888,35 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
 	.activate = hv_pci_vec_irq_domain_activate,
 };
 
+#ifdef CONFIG_OF
+
+static struct irq_domain *hv_pci_of_irq_domain_parent(void)
+{
+	struct device_node *parent;
+	struct irq_domain *domain;
+
+	parent = of_irq_find_parent(to_platform_device(get_vmbus_root_device())->dev.of_node);
+	domain = NULL;
+	if (parent) {
+		domain = irq_find_host(parent);
+		of_node_put(parent);
+	}
+
+	/*
+	 * `domain == NULL` shouldn't happen.
+	 *
+	 * If somehow the code does end up in that state, treat this as a configuration
+	 * issue rather than a hard error, emit a warning, and let the code proceed.
+	 * The NULL parent domain is an acceptable option for the `irq_domain_create_hierarchy`
+	 * function called later.
+	 */
+	if (!domain)
+		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n");
+	return domain;
+}
+
+#endif
+
 static int hv_pci_irqchip_init(void)
 {
 	static struct hv_pci_chip_data *chip_data;
@@ -906,10 +936,29 @@ static int hv_pci_irqchip_init(void)
 	 * IRQ domain once enabled, should not be removed since there is no
 	 * way to ensure that all the corresponding devices are also gone and
 	 * no interrupts will be generated.
+	 *
+	 * In the ACPI case, the parent IRQ domain is supplied by the ACPI
+	 * subsystem, and it is the default GSI domain pointing to the GIC.
+	 * Neither is available outside of the ACPI subsystem, cannot avoid
+	 * the messy ifdef below.
+	 * There is apparently no such default in the OF subsystem, and
+	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
+	 * points to the GIC as well.
+	 * None of these two cases reaches for the MSI parent domain.
 	 */
-	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
-							  fn, &hv_pci_domain_ops,
-							  chip_data);
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+			fn, &hv_pci_domain_ops,
+			chip_data);
+#endif
+#if defined(CONFIG_OF)
+	if (!hv_msi_gic_irq_domain)
+		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
+			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
+			fn, &hv_pci_domain_ops,
+			chip_data);
+#endif
 
 	if (!hv_msi_gic_irq_domain) {
 		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 5e39baa7f6cb..b4aa1f579a97 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1346,6 +1346,8 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
 	return dev_get_drvdata(&dev->device);
 }
 
+struct device *get_vmbus_root_device(void);
+
 struct hv_ring_buffer_debug_info {
 	u32 current_interrupt_mask;
 	u32 current_read_index;
-- 
2.34.1


