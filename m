Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1347945E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 19:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhLQSwY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 13:52:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40968 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbhLQSwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 13:52:24 -0500
Received: by linux.microsoft.com (Postfix, from userid 1109)
        id 994DF20B717B; Fri, 17 Dec 2021 10:52:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 994DF20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639767143;
        bh=VeF+vrkRM5Dj0wZmHoDXs3GcGlcLX4JMZjv9nWqKqWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlfgtJWw43ouUq43rh52PTS0Wsh4NAnShkxaXsDCo3CopmJVxsJuB9MSoIsJ76OIQ
         aPW7GNy4H47zJuxJ3acmdFNVG54QByyusIH9CkwDRW4tiuWW6vuCRCllT2HV+PoKRu
         2eb0T6FKPTaiVDwW0lbxW0tfM+lKe0gipSecmMiU=
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
Subject: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Date:   Fri, 17 Dec 2021 10:52:01 -0800
Message-Id: <1639767121-22007-3-git-send-email-sunilmut@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639767121-22007-1-git-send-email-sunilmut@linux.microsoft.com>
References: <1639767121-22007-1-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Add arm64 Hyper-V vPCI support by implementing the arch specific
interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI that
is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ domain
for basic vector management.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
In v2, v3, v4, v5, v6 & v7:
 Changes are described in the cover letter.

 arch/arm64/include/asm/hyperv-tlfs.h |   9 +
 drivers/pci/Kconfig                  |   2 +-
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pci-hyperv.c  | 241 ++++++++++++++++++++++++++-
 4 files changed, 251 insertions(+), 3 deletions(-)

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
index 43e615aa12ff..d98fafdd0f99 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -184,7 +184,7 @@ config PCI_LABEL
 
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
-	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
 	select PCI_HYPERV_INTERFACE
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..2536abcc045a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -281,7 +281,7 @@ config PCIE_BRCMSTB
 
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ead7d6cb6bf1..02ba2e7e2618 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -47,6 +47,8 @@
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
+#include <linux/irqdomain.h>
+#include <linux/acpi.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -614,7 +616,236 @@ static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	return pci_msi_prepare(domain, dev, nvec, info);
 }
-#endif /* CONFIG_X86 */
+#elif defined(CONFIG_ARM64)
+/*
+ * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving a bit
+ * of room at the start to allow for SPIs to be specified through ACPI and
+ * starting with a power of two to satisfy power of 2 multi-MSI requirement.
+ */
+#define HV_PCI_MSI_SPI_START	64
+#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
+#define DELIVERY_MODE		0
+#define FLOW_HANDLER		NULL
+#define FLOW_NAME		NULL
+#define hv_msi_prepare		NULL
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
+static struct irq_chip hv_arm64_msi_irq_chip = {
+	.name = "MSI",
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.irq_eoi = irq_chip_eoi_parent,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent
+};
+
+static unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
+{
+	return irqd->parent_data->hwirq;
+}
+
+static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				       struct msi_desc *msi_desc)
+{
+	msi_entry->address = ((u64)msi_desc->msg.address_hi << 32) |
+			      msi_desc->msg.address_lo;
+	msi_entry->data = msi_desc->msg.data;
+}
+
+/*
+ * @nr_bm_irqs:		Indicates the number of IRQs that were allocated from
+ *			the bitmap.
+ * @nr_dom_irqs:	Indicates the number of IRQs that were allocated from
+ *			the parent domain.
+ */
+static void hv_pci_vec_irq_free(struct irq_domain *domain,
+				unsigned int virq,
+				unsigned int nr_bm_irqs,
+				unsigned int nr_dom_irqs)
+{
+	struct hv_pci_chip_data *chip_data = domain->host_data;
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	int first = d->hwirq - HV_PCI_MSI_SPI_START;
+	int i;
+
+	mutex_lock(&chip_data->map_lock);
+	bitmap_release_region(chip_data->spi_map,
+			      first,
+			      get_count_order(nr_bm_irqs));
+	mutex_unlock(&chip_data->map_lock);
+	for (i = 0; i < nr_dom_irqs; i++) {
+		if (i)
+			d = irq_domain_get_irq_data(domain, virq + i);
+		irq_domain_reset_irq_data(d);
+	}
+
+	irq_domain_free_irqs_parent(domain, virq, nr_dom_irqs);
+}
+
+static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
+				       unsigned int virq,
+				       unsigned int nr_irqs)
+{
+	hv_pci_vec_irq_free(domain, virq, nr_irqs, nr_irqs);
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
+	struct irq_data *d;
+	int ret;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the interrupt specifier is not coming from ACPI or DT, the
+	 * trigger type will need to be set explicitly. Otherwise, it will be
+	 * set to whatever is in the GIC configuration.
+	 */
+	d = irq_domain_get_irq_data(domain->parent, virq);
+
+	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
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
+						    hwirq + i,
+						    &hv_arm64_msi_irq_chip,
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
+	hv_pci_vec_irq_free(domain, virq, nr_irqs, i);
+
+	return ret;
+}
+
+/*
+ * Pick the first online cpu as the irq affinity that can be temporarily used
+ * for composing MSI from the hypervisor. GIC will eventually set the right
+ * affinity for the irq and the 'unmask' will retarget the interrupt to that
+ * cpu.
+ */
+static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
+					  struct irq_data *irqd, bool reserve)
+{
+	int cpu = cpumask_first(cpu_online_mask);
+
+	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
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
+static int hv_pci_irqchip_init(void)
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
+	fn = irq_domain_alloc_named_fwnode("hv_vpci_arm64");
+	if (!fn)
+		goto free_chip;
+
+	/*
+	 * IRQ domain once enabled, should not be removed since there is no
+	 * way to ensure that all the corresponding devices are also gone and
+	 * no interrupts will be generated.
+	 */
+	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+							  fn, &hv_pci_domain_ops,
+							  chip_data);
+
+	if (!hv_msi_gic_irq_domain) {
+		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
+		goto free_chip;
+	}
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
+
+static struct irq_domain *hv_pci_get_root_domain(void)
+{
+	return hv_msi_gic_irq_domain;
+}
+#endif /* CONFIG_ARM64 */
 
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
@@ -1227,6 +1458,8 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
 static void hv_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
+	if (data->parent_data->chip->irq_mask)
+		irq_chip_mask_parent(data);
 }
 
 /**
@@ -1343,6 +1576,8 @@ static void hv_irq_unmask(struct irq_data *data)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
 
+	if (data->parent_data->chip->irq_unmask)
+		irq_chip_unmask_parent(data);
 	pci_msi_unmask_irq(data);
 }
 
@@ -1618,7 +1853,11 @@ static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
 	.irq_compose_msi_msg	= hv_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#ifdef CONFIG_X86
 	.irq_ack		= irq_chip_ack_parent,
+#elif defined(CONFIG_ARM64)
+	.irq_eoi		= irq_chip_eoi_parent,
+#endif
 	.irq_mask		= hv_irq_mask,
 	.irq_unmask		= hv_irq_unmask,
 };
-- 
2.25.1


