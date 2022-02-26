Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9A4C5595
	for <lists+linux-arch@lfdr.de>; Sat, 26 Feb 2022 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiBZLPy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiBZLPx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 06:15:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A01A94A1;
        Sat, 26 Feb 2022 03:15:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50426113B;
        Sat, 26 Feb 2022 11:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA3C340F1;
        Sat, 26 Feb 2022 11:15:13 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH V6 18/22] LoongArch: Add PCI controller support
Date:   Sat, 26 Feb 2022 19:03:34 +0800
Message-Id: <20220226110338.77547-19-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220226110338.77547-1-chenhuacai@loongson.cn>
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Loongson64 based systems are PC-like systems which use PCI/PCIe as its
I/O bus, This patch adds the PCI host controller support for LoongArch.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/dma.h |  13 +++
 arch/loongarch/include/asm/pci.h |  40 +++++++
 arch/loongarch/pci/acpi.c        | 172 +++++++++++++++++++++++++++++++
 arch/loongarch/pci/pci.c         |  98 ++++++++++++++++++
 4 files changed, 323 insertions(+)
 create mode 100644 arch/loongarch/include/asm/dma.h
 create mode 100644 arch/loongarch/include/asm/pci.h
 create mode 100644 arch/loongarch/pci/acpi.c
 create mode 100644 arch/loongarch/pci/pci.c

diff --git a/arch/loongarch/include/asm/dma.h b/arch/loongarch/include/asm/dma.h
new file mode 100644
index 000000000000..c61fc72483ff
--- /dev/null
+++ b/arch/loongarch/include/asm/dma.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_DMA_H
+#define __ASM_DMA_H
+
+#define MAX_DMA_ADDRESS	PAGE_OFFSET
+#define MAX_DMA32_PFN	(1UL << (32 - PAGE_SHIFT))
+
+extern int isa_dma_bridge_buggy;
+
+#endif
diff --git a/arch/loongarch/include/asm/pci.h b/arch/loongarch/include/asm/pci.h
new file mode 100644
index 000000000000..5616ad2678ba
--- /dev/null
+++ b/arch/loongarch/include/asm/pci.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_PCI_H
+#define _ASM_PCI_H
+
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <asm/io.h>
+
+#define PCIBIOS_MIN_IO		0x4000
+#define PCIBIOS_MIN_MEM		0x20000000
+#define PCIBIOS_MIN_CARDBUS_IO	0x4000
+
+#define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
+
+extern phys_addr_t mcfg_addr_init(int node);
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return 1; /* always show the domain in /proc */
+}
+
+/*
+ * Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader
+ */
+static inline unsigned int pcibios_assign_all_busses(void)
+{
+	return 0;
+}
+
+/* generic pci stuff */
+#include <asm-generic/pci.h>
+
+#endif /* _ASM_PCI_H */
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
new file mode 100644
index 000000000000..7cabb8f37218
--- /dev/null
+++ b/arch/loongarch/pci/acpi.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
+
+#include <asm/pci.h>
+#include <asm/loongson.h>
+
+struct pci_root_info {
+	struct acpi_pci_root_info common;
+	struct pci_config_window *cfg;
+};
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_config_window *cfg = bridge->bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+
+	return 0;
+}
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return root->segment;
+}
+
+static void acpi_release_root_info(struct acpi_pci_root_info *ci)
+{
+	struct pci_root_info *info;
+
+	info = container_of(ci, struct pci_root_info, common);
+	pci_ecam_free(info->cfg);
+	kfree(ci->ops);
+	kfree(info);
+}
+
+static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
+{
+	int status;
+	struct resource_entry *entry, *tmp;
+	struct acpi_device *device = ci->bridge;
+
+	status = acpi_pci_probe_root_resources(ci);
+	if (status > 0) {
+		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+			if (entry->res->flags & IORESOURCE_MEM) {
+				entry->offset = ci->root->mcfg_addr & GENMASK_ULL(63, 40);
+				entry->res->start |= entry->offset;
+				entry->res->end   |= entry->offset;
+			}
+		}
+		return status;
+	}
+
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		dev_dbg(&device->dev,
+			   "host bridge window %pR (ignored)\n", entry->res);
+		resource_list_destroy_entry(entry);
+	}
+
+	return 0;
+}
+
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
+{
+	int ret, bus_shift;
+	u16 seg = root->segment;
+	struct device *dev = &root->device->dev;
+	struct resource cfgres;
+	struct resource *bus_res = &root->secondary;
+	struct pci_config_window *cfg;
+	const struct pci_ecam_ops *ecam_ops;
+
+	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
+	if (ret < 0) {
+		dev_err(dev, "%04x:%pR ECAM region not found, use default value\n", seg, bus_res);
+		ecam_ops = &loongson_pci_ecam_ops;
+		root->mcfg_addr = mcfg_addr_init(0);
+	}
+
+	bus_shift = ecam_ops->bus_shift ? : 20;
+
+	cfgres.start = root->mcfg_addr + (bus_res->start << bus_shift);
+	cfgres.end = cfgres.start + (resource_size(bus_res) << bus_shift) - 1;
+	cfgres.flags = IORESOURCE_MEM;
+
+	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res, PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct pci_bus *bus;
+	struct pci_root_info *info;
+	struct acpi_pci_root_ops *root_ops;
+	int domain = root->segment;
+	int busnum = root->secondary.start;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		pr_warn("pci_bus %04x:%02x: ignored (out of memory)\n", domain, busnum);
+		return NULL;
+	}
+
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
+	if (!root_ops) {
+		kfree(info);
+		return NULL;
+	}
+
+	info->cfg = pci_acpi_setup_ecam_mapping(root);
+	if (!info->cfg) {
+		kfree(info);
+		kfree(root_ops);
+		return NULL;
+	}
+
+	root_ops->release_info = acpi_release_root_info;
+	root_ops->prepare_resources = acpi_prepare_root_resources;
+	root_ops->pci_ops = (struct pci_ops *)&info->cfg->ops->pci_ops;
+
+	bus = pci_find_bus(domain, busnum);
+	if (bus) {
+		memcpy(bus->sysdata, info->cfg, sizeof(struct pci_config_window));
+		kfree(info);
+	} else {
+		struct pci_bus *child;
+
+		bus = acpi_pci_root_create(root, root_ops,
+					   &info->common, info->cfg);
+		if (!bus) {
+			kfree(info);
+			kfree(root_ops);
+			return NULL;
+		}
+
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
+
+	return bus;
+}
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
new file mode 100644
index 000000000000..56dd7d982abf
--- /dev/null
+++ b/arch/loongarch/pci/pci.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/vgaarb.h>
+#include <asm/loongson.h>
+
+#define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
+#define PCI_DEVICE_ID_LOONGSON_DC1      0x7a06
+#define PCI_DEVICE_ID_LOONGSON_DC2      0x7a36
+
+int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
+						int reg, int len, u32 *val)
+{
+	struct pci_bus *bus_tmp = pci_find_bus(domain, bus);
+
+	if (bus_tmp)
+		return bus_tmp->ops->read(bus_tmp, devfn, reg, len, val);
+	return -EINVAL;
+}
+
+int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
+						int reg, int len, u32 val)
+{
+	struct pci_bus *bus_tmp = pci_find_bus(domain, bus);
+
+	if (bus_tmp)
+		return bus_tmp->ops->write(bus_tmp, devfn, reg, len, val);
+	return -EINVAL;
+}
+
+phys_addr_t mcfg_addr_init(int node)
+{
+	return (((u64)node << 44) | MCFG_EXT_PCICFG_BASE);
+}
+
+static int __init pcibios_init(void)
+{
+	unsigned int lsize;
+
+	/*
+	 * Set PCI cacheline size to that of the highest level in the
+	 * cache hierarchy.
+	 */
+	lsize = cpu_dcache_line_size();
+	lsize = cpu_vcache_line_size() ? : lsize;
+	lsize = cpu_scache_line_size() ? : lsize;
+
+	BUG_ON(!lsize);
+
+	pci_dfl_cache_line_size = lsize >> 2;
+
+	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+
+	return 0;
+}
+
+subsys_initcall(pcibios_init);
+
+int pcibios_device_add(struct pci_dev *dev)
+{
+	int id = pci_domain_nr(dev->bus);
+
+	dev_set_msi_domain(&dev->dev, pch_msi_domain[id]);
+
+	return 0;
+}
+
+int pcibios_alloc_irq(struct pci_dev *dev)
+{
+	if (acpi_disabled)
+		return 0;
+	if (pci_dev_msi_enabled(dev))
+		return 0;
+	return acpi_pci_irq_enable(dev);
+}
+
+static void pci_fixup_vgadev(struct pci_dev *pdev)
+{
+	struct pci_dev *devp = NULL;
+
+	while ((devp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, devp))) {
+		if (devp->vendor != PCI_VENDOR_ID_LOONGSON) {
+			vga_set_default_device(devp);
+			dev_info(&pdev->dev,
+				"Overriding boot device as %X:%X\n",
+				devp->vendor, devp->device);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC1, pci_fixup_vgadev);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC2, pci_fixup_vgadev);
-- 
2.27.0

