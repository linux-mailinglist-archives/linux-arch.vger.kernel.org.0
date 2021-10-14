Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB942DEB6
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 17:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhJNP4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 11:56:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44836 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhJNP4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 11:56:36 -0400
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id D7E6A20B9D12; Thu, 14 Oct 2021 08:54:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7E6A20B9D12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1634226871;
        bh=VeES2n43zqg/M6shWym9IB5n/Tk28//PzezsWxS1dNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeHLfpmeCwER2PdKqI0mba7491HHWg6EyFSck5lffrHuURFy8FeIfpfwmWTt/PK6x
         G49AUBPqIXPMCR1WnuIsndQKDkcuhV1JhVzr7XoTtA351e016OeDSW/4JvjgnvB2Y6
         6P1aZZA7xKQIym7qagVf9A7zknOGqqe7U363ZZko=
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
Subject: [PATCH v3 2/2] arm64: PCI: hv: Add support for Hyper-V vPCI
Date:   Thu, 14 Oct 2021 08:53:14 -0700
Message-Id: <1634226794-9540-3-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Add support for Hyper-V vPCI for ARM64 by implementing the arch specific
interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI that
is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ domain
for basic vector management.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
In v2 & v3:
 Changes are described in the cover letter.

 arch/arm64/include/asm/hyperv-tlfs.h        |   9 +
 drivers/pci/Kconfig                         |   2 +-
 drivers/pci/controller/Kconfig              |   2 +-
 drivers/pci/controller/pci-hyperv-irqchip.c | 210 ++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c         |   6 +
 5 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
index 4d964a7f02ee..bc6c7ac934a1 100644
--- a/arch/arm64/include/asm/hyperv-tlfs.h
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -64,6 +64,15 @@
 #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
 #define HV_REGISTER_STIMER0_COUNT	0x000B0001
 
+union hv_msi_entry {
+	u64 as_uint64[2];
+	struct {
+		u64 address;
+		u32 data;
+		u32 reserved;
+	} __packed;
+};
+
 #include <asm-generic/hyperv-tlfs.h>
 
 #endif
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..36dc94407510 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -184,7 +184,7 @@ config PCI_LABEL
 
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
-	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
+	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
 	select PCI_HYPERV_INTERFACE
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 326f7d13024f..15271f8a0dd1 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -280,7 +280,7 @@ config PCIE_BRCMSTB
 
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
diff --git a/drivers/pci/controller/pci-hyperv-irqchip.c b/drivers/pci/controller/pci-hyperv-irqchip.c
index 36fa862f8bc5..ccecd14b6601 100644
--- a/drivers/pci/controller/pci-hyperv-irqchip.c
+++ b/drivers/pci/controller/pci-hyperv-irqchip.c
@@ -52,6 +52,216 @@ int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL(hv_msi_prepare);
 
+#elif CONFIG_ARM64
+
+/*
+ * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving a bit
+ * of room at the start to allow for SPIs to be specified through ACPI and
+ * starting with a power of two to satisfy power of 2 multi-MSI requirement.
+ */
+#define HV_PCI_MSI_SPI_START	64
+#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
+
+struct hv_pci_chip_data {
+	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
+	struct mutex	map_lock;
+};
+
+/* Hyper-V vPCI MSI GIC IRQ domain */
+static struct irq_domain *hv_msi_gic_irq_domain;
+
+/* Hyper-V PCI MSI IRQ chip */
+static struct irq_chip hv_msi_irq_chip = {
+	.name = "MSI",
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.irq_eoi = irq_chip_eoi_parent,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent
+};
+
+unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
+{
+	irqd = irq_domain_get_irq_data(hv_msi_gic_irq_domain, irqd->irq);
+
+	return irqd->hwirq;
+}
+EXPORT_SYMBOL(hv_msi_get_int_vector);
+
+void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				struct msi_desc *msi_desc)
+{
+	msi_entry->address = ((u64)msi_desc->msg.address_hi << 32) |
+			      msi_desc->msg.address_lo;
+	msi_entry->data = msi_desc->msg.data;
+}
+EXPORT_SYMBOL(hv_set_msi_entry_from_desc);
+
+int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+		   int nvec, msi_alloc_info_t *info)
+{
+	return 0;
+}
+EXPORT_SYMBOL(hv_msi_prepare);
+
+static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct hv_pci_chip_data *chip_data = domain->host_data;
+	struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
+	int first = irqd->hwirq - HV_PCI_MSI_SPI_START;
+
+	mutex_lock(&chip_data->map_lock);
+	bitmap_release_region(chip_data->spi_map,
+			      first,
+			      get_count_order(nr_irqs));
+	mutex_unlock(&chip_data->map_lock);
+	irq_domain_reset_irq_data(irqd);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
+				       unsigned int nr_irqs,
+				       irq_hw_number_t *hwirq)
+{
+	struct hv_pci_chip_data *chip_data = domain->host_data;
+	unsigned int index;
+
+	/* Find and allocate region from the SPI bitmap */
+	mutex_lock(&chip_data->map_lock);
+	index = bitmap_find_free_region(chip_data->spi_map,
+					HV_PCI_MSI_SPI_NR,
+					get_count_order(nr_irqs));
+	mutex_unlock(&chip_data->map_lock);
+	if (index < 0)
+		return -ENOSPC;
+
+	*hwirq = index + HV_PCI_MSI_SPI_START;
+
+	return 0;
+}
+
+static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
+					   unsigned int virq,
+					   irq_hw_number_t hwirq)
+{
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+}
+
+static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs,
+				       void *args)
+{
+	irq_hw_number_t hwirq;
+	unsigned int i;
+	int ret;
+
+	ret = hv_pci_vec_alloc_device_irq(domain, nr_irqs, &hwirq);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = hv_pci_vec_irq_gic_domain_alloc(domain, virq + i,
+						      hwirq + i);
+		if (ret)
+			goto free_irq;
+
+		ret = irq_domain_set_hwirq_and_chip(domain, virq + i,
+						    hwirq + i, &hv_msi_irq_chip,
+						    domain->host_data);
+		if (ret)
+			goto free_irq;
+
+		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
+	}
+
+	return 0;
+
+free_irq:
+	hv_pci_vec_irq_domain_free(domain, virq, nr_irqs);
+
+	return ret;
+}
+
+static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
+					  struct irq_data *irqd, bool reserve)
+{
+	/* All available online CPUs are available for targeting */
+	irq_data_update_effective_affinity(irqd, cpu_online_mask);
+
+	return 0;
+}
+
+static const struct irq_domain_ops hv_pci_domain_ops = {
+	.alloc	= hv_pci_vec_irq_domain_alloc,
+	.free	= hv_pci_vec_irq_domain_free,
+	.activate = hv_pci_vec_irq_domain_activate,
+};
+
+int hv_pci_irqchip_init(struct irq_domain **parent_domain,
+			bool *fasteoi_handler,
+			u8 *delivery_mode)
+{
+	static struct hv_pci_chip_data *chip_data;
+	struct fwnode_handle *fn = NULL;
+	int ret = -ENOMEM;
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return ret;
+
+	mutex_init(&chip_data->map_lock);
+	fn = irq_domain_alloc_named_fwnode("Hyper-V ARM64 vPCI");
+	if (!fn)
+		goto free_chip;
+
+	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+							  fn, &hv_pci_domain_ops,
+							  chip_data);
+
+	if (!hv_msi_gic_irq_domain) {
+		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ domain\n");
+		goto free_chip;
+	}
+
+	*parent_domain = hv_msi_gic_irq_domain;
+	*fasteoi_handler = true;
+
+	/* Delivery mode: Fixed */
+	*delivery_mode = 0;
+
+	return 0;
+
+free_chip:
+	kfree(chip_data);
+	if (fn)
+		irq_domain_free_fwnode(fn);
+
+	return ret;
+}
+EXPORT_SYMBOL(hv_pci_irqchip_init);
+
+void hv_pci_irqchip_free(void)
+{
+	static struct hv_pci_chip_data *chip_data;
+
+	if (!hv_msi_gic_irq_domain)
+		return;
+
+	/* Host data cannot be null if the domain was created successfully */
+	chip_data = hv_msi_gic_irq_domain->host_data;
+	irq_domain_remove(hv_msi_gic_irq_domain);
+	hv_msi_gic_irq_domain = NULL;
+	kfree(chip_data);
+}
+EXPORT_SYMBOL(hv_pci_irqchip_free);
+
 #endif
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2d3916206986..a77d0eaedac3 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
@@ -1204,6 +1205,8 @@ static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
 static void hv_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
+	if (data->parent_data->chip->irq_mask)
+		irq_chip_mask_parent(data);
 }
 
 /**
@@ -1321,6 +1324,8 @@ static void hv_irq_unmask(struct irq_data *data)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
 
+	if (data->parent_data->chip->irq_unmask)
+		irq_chip_unmask_parent(data);
 	pci_msi_unmask_irq(data);
 }
 
@@ -1597,6 +1602,7 @@ static struct irq_chip hv_msi_irq_chip = {
 	.irq_compose_msi_msg	= hv_compose_msi_msg,
 	.irq_set_affinity	= hv_set_affinity,
 	.irq_ack		= irq_chip_ack_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= hv_irq_mask,
 	.irq_unmask		= hv_irq_unmask,
 };
-- 
2.25.1

