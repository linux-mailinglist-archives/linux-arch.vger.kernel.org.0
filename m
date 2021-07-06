Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5437F3BC53F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFEXO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEXN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99D6D60238;
        Tue,  6 Jul 2021 04:20:32 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 15/19] LoongArch: Add PCI controller support
Date:   Tue,  6 Jul 2021 12:18:16 +0800
Message-Id: <20210706041820.1536502-16-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Loongson64 based systems are PC-like systems which use PCI/PCIe as its
I/O bus, This patch adds the PCI host controller support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/pci.h  | 124 ++++++++++++++++++
 arch/loongarch/pci/acpi.c         | 194 ++++++++++++++++++++++++++++
 arch/loongarch/pci/mmconfig.c     | 105 +++++++++++++++
 arch/loongarch/pci/pci-loongson.c | 130 +++++++++++++++++++
 arch/loongarch/pci/pci.c          | 207 ++++++++++++++++++++++++++++++
 5 files changed, 760 insertions(+)
 create mode 100644 arch/loongarch/include/asm/pci.h
 create mode 100644 arch/loongarch/pci/acpi.c
 create mode 100644 arch/loongarch/pci/mmconfig.c
 create mode 100644 arch/loongarch/pci/pci-loongson.c
 create mode 100644 arch/loongarch/pci/pci.c

diff --git a/arch/loongarch/include/asm/pci.h b/arch/loongarch/include/asm/pci.h
new file mode 100644
index 000000000000..0b73a1e76280
--- /dev/null
+++ b/arch/loongarch/include/asm/pci.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_PCI_H
+#define _ASM_PCI_H
+
+#include <linux/mm.h>
+
+#ifdef __KERNEL__
+
+/*
+ * This file essentially defines the interface between board specific
+ * PCI code and LoongArch common PCI code. Should potentially put into
+ * include/asm/pci.h file.
+ */
+
+#include <linux/ioport.h>
+#include <linux/list.h>
+
+extern const struct pci_ops *__read_mostly loongarch_pci_ops;
+
+/*
+ * Each pci channel is a top-level PCI bus seem by CPU.	 A machine  with
+ * multiple PCI channels may have multiple PCI host controllers or a
+ * single controller supporting multiple channels.
+ */
+struct pci_controller {
+	struct list_head list;
+	struct pci_bus *bus;
+	struct device_node *of_node;
+
+	struct pci_ops *pci_ops;
+	struct resource *mem_resource;
+	unsigned long mem_offset;
+	struct resource *io_resource;
+	unsigned long io_offset;
+	unsigned long io_map_base;
+	struct resource *busn_resource;
+
+	unsigned int node;
+	unsigned int index;
+	unsigned int need_domain_info;
+#ifdef CONFIG_ACPI
+	struct acpi_device *companion;
+#endif
+	phys_addr_t mcfg_addr;
+};
+
+extern void pcibios_add_root_resources(struct list_head *resources);
+
+extern phys_addr_t mcfg_addr_init(int domain);
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline void set_pci_need_domain_info(struct pci_controller *hose,
+					    int need_domain_info)
+{
+	hose->need_domain_info = need_domain_info;
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
+/*
+ * Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader
+ */
+static inline unsigned int pcibios_assign_all_busses(void)
+{
+	return 1;
+}
+
+#define PCIBIOS_MIN_IO		0
+#define PCIBIOS_MIN_MEM		0x20000000
+#define PCIBIOS_MIN_CARDBUS_IO	0x4000
+
+#define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+
+/*
+ * Dynamic DMA mapping stuff.
+ * LoongArch has everything mapped statically.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/string.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_PCI_DOMAINS
+#define pci_domain_nr(bus) (((struct pci_controller *)(bus)->sysdata)->index)
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	return hose->need_domain_info;
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
+/* mmconfig.c */
+
+#ifdef CONFIG_PCI_MMCONFIG
+struct pci_mmcfg_region {
+	struct list_head list;
+	phys_addr_t address;
+	u16 segment;
+	u8 start_bus;
+	u8 end_bus;
+};
+
+extern phys_addr_t pci_mmconfig_addr(u16 seg, u8 start);
+extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
+extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
+extern struct list_head pci_mmcfg_list;
+#endif /*CONFIG_PCI_MMCONFIG*/
+
+#endif /* __KERNEL__ */
+
+/* generic pci stuff */
+#include <asm-generic/pci.h>
+
+#endif /* _ASM_PCI_H */
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
new file mode 100644
index 000000000000..68e4c3f5e88f
--- /dev/null
+++ b/arch/loongarch/pci/acpi.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <linux/pci-acpi.h>
+
+#include <asm/pci.h>
+#include <loongson.h>
+
+struct pci_root_info {
+	struct acpi_pci_root_info common;
+	struct pci_controller pc;
+#ifdef CONFIG_PCI_MMCONFIG
+	bool mcfg_added;
+	u8 start_bus;
+	u8 end_bus;
+#endif
+};
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_controller *pc = bridge->bus->sysdata;
+
+	ACPI_COMPANION_SET(&bridge->dev, pc->companion);
+	return 0;
+}
+
+#ifdef CONFIG_PCI_MMCONFIG
+static void teardown_mcfg(struct acpi_pci_root_info *ci)
+{
+	struct pci_root_info *info;
+
+	info = container_of(ci, struct pci_root_info, common);
+	if (info->mcfg_added) {
+		pci_mmconfig_delete(info->pc.index,
+				    info->start_bus, info->end_bus);
+		info->mcfg_added = false;
+	}
+}
+#else
+static void teardown_mcfg(struct acpi_pci_root_info *ci)
+{
+}
+#endif
+
+static void acpi_release_root_info(struct acpi_pci_root_info *info)
+{
+	if (info) {
+		teardown_mcfg(info);
+		kfree(container_of(info, struct pci_root_info, common));
+	}
+}
+
+static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
+{
+	struct acpi_device *device = ci->bridge;
+	struct resource_entry *entry, *tmp;
+	int status;
+
+	status = acpi_pci_probe_root_resources(ci);
+	if (status > 0)
+		return status;
+
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		dev_dbg(&device->dev,
+			   "host bridge window %pR (ignored)\n", entry->res);
+		resource_list_destroy_entry(entry);
+	}
+
+	pcibios_add_root_resources(&ci->resources);
+
+	return 0;
+}
+
+static int pci_read(struct pci_bus *bus,
+		unsigned int devfn,
+		int where, int size, u32 *value)
+{
+	return loongarch_pci_ops->read(bus,
+				 devfn, where, size, value);
+}
+
+static int pci_write(struct pci_bus *bus,
+		unsigned int devfn,
+		int where, int size, u32 value)
+{
+	return loongarch_pci_ops->write(bus,
+				  devfn, where, size, value);
+}
+
+struct pci_ops pci_root_ops = {
+	.read = pci_read,
+	.write = pci_write,
+};
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.pci_ops = &pci_root_ops,
+	.release_info = acpi_release_root_info,
+	.prepare_resources = acpi_prepare_root_resources,
+};
+
+static void init_controller_resources(struct pci_controller *controller,
+		struct pci_bus *bus)
+{
+	struct resource_entry *entry, *tmp;
+	struct resource *res;
+
+	controller->io_map_base = loongarch_io_port_base;
+
+	resource_list_for_each_entry_safe(entry, tmp, &bus->resources) {
+		res = entry->res;
+		if (res->flags & IORESOURCE_MEM)
+			controller->mem_resource = res;
+		else if (res->flags & IORESOURCE_IO)
+			controller->io_resource = res;
+		else
+			continue;
+	}
+}
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct pci_bus *bus;
+	struct pci_root_info *info;
+	struct pci_controller *controller;
+	int domain = root->segment;
+	int busnum = root->secondary.start;
+	static int need_domain_info;
+	struct acpi_device *device = root->device;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		pr_warn("pci_bus %04x:%02x: ignored (out of memory)\n", domain, busnum);
+		return NULL;
+	}
+
+	controller = &info->pc;
+	controller->companion = device;
+	controller->index = domain;
+
+#ifdef CONFIG_PCI_MMCONFIG
+	root->mcfg_addr = pci_mmconfig_addr(domain, busnum);
+	controller->mcfg_addr = pci_mmconfig_addr(domain, busnum);
+#endif
+	if (!controller->mcfg_addr)
+		controller->mcfg_addr = mcfg_addr_init(controller->index);
+
+	controller->node = 0;
+
+	bus = pci_find_bus(domain, busnum);
+	if (bus) {
+		memcpy(bus->sysdata, controller, sizeof(struct pci_controller));
+		kfree(info);
+	} else {
+		bus = acpi_pci_root_create(root, &acpi_pci_root_ops,
+					   &info->common, controller);
+		if (bus) {
+			need_domain_info = need_domain_info || pci_domain_nr(bus);
+			set_pci_need_domain_info(controller, need_domain_info);
+			init_controller_resources(controller, bus);
+
+			/*
+			 * We insert PCI resources into the iomem_resource
+			 * and ioport_resource trees in either
+			 * pci_bus_claim_resources() or
+			 * pci_bus_assign_resources().
+			 */
+			if (pci_has_flag(PCI_PROBE_ONLY)) {
+				pci_bus_claim_resources(bus);
+			} else {
+				struct pci_bus *child;
+
+				pci_bus_size_bridges(bus);
+				pci_bus_assign_resources(bus);
+				list_for_each_entry(child, &bus->children, node)
+					pcie_bus_configure_settings(child);
+			}
+		} else {
+			kfree(info);
+		}
+	}
+
+	return bus;
+}
diff --git a/arch/loongarch/pci/mmconfig.c b/arch/loongarch/pci/mmconfig.c
new file mode 100644
index 000000000000..d65820e3068a
--- /dev/null
+++ b/arch/loongarch/pci/mmconfig.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <linux/pci-acpi.h>
+#include <asm/pci.h>
+#include <loongson.h>
+
+#define PREFIX "PCI: "
+
+static DEFINE_MUTEX(pci_mmcfg_lock);
+
+LIST_HEAD(pci_mmcfg_list);
+
+struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
+{
+	struct pci_mmcfg_region *cfg;
+
+	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+		if (cfg->segment == segment &&
+		    cfg->start_bus <= bus && bus <= cfg->end_bus)
+			return cfg;
+
+	return NULL;
+}
+
+static int __init pci_parse_mcfg(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *cfg_table, *cfg;
+	struct pci_mmcfg_region *new, *arr;
+	unsigned long i;
+	int entries;
+
+	if (header->length < sizeof(struct acpi_table_mcfg))
+		return -EINVAL;
+
+	/* how many config structures do we have */
+	entries = (header->length - sizeof(struct acpi_table_mcfg)) /
+				sizeof(struct acpi_mcfg_allocation);
+
+
+	mcfg = (struct acpi_table_mcfg *)header;
+	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
+
+	arr = kcalloc(entries, sizeof(*arr), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	for (i = 0, new = arr; i < entries; i++, new++) {
+		cfg = &cfg_table[i];
+		new->address = cfg->address;
+		new->segment = cfg->pci_segment;
+		new->start_bus = cfg->start_bus_number;
+		new->end_bus = cfg->end_bus_number;
+
+		list_add(&new->list, &pci_mmcfg_list);
+		pr_info(PREFIX
+		       "MMCONFIG for domain %04x [bus %02x-%02x](base %#lx)\n",
+		       new->segment, new->start_bus, new->end_bus, (unsigned long)(new->address));
+	}
+
+	return 0;
+}
+
+void __init pci_mmcfg_late_init(void)
+{
+	int err;
+
+	err = acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+	if (err)
+		pr_err("Failed to parse MCFG (%d)\n", err);
+}
+
+phys_addr_t pci_mmconfig_addr(u16 seg, u8 start)
+{
+	struct pci_mmcfg_region *cfg;
+
+	cfg = pci_mmconfig_lookup(seg, start);
+	if (!cfg)
+		return (phys_addr_t)NULL;
+
+	return cfg->address;
+}
+
+/* Delete MMCFG information for host bridges */
+int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
+{
+	struct pci_mmcfg_region *cfg;
+
+	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+		if (cfg->segment == seg && cfg->start_bus == start &&
+		    cfg->end_bus == end) {
+			list_del(&cfg->list);
+			kfree(cfg);
+			return 0;
+		}
+
+	return -ENOENT;
+}
diff --git a/arch/loongarch/pci/pci-loongson.c b/arch/loongarch/pci/pci-loongson.c
new file mode 100644
index 000000000000..e74f887a330e
--- /dev/null
+++ b/arch/loongarch/pci/pci-loongson.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/vgaarb.h>
+
+#include <loongson.h>
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+static int ls7a_pci_config_access(unsigned char access_type,
+		struct pci_bus *bus, unsigned int devfn,
+		int where, u32 *data)
+{
+	unsigned char busnum = bus->number;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+	u_int64_t addr;
+	void *addrp;
+
+	/*
+	 * Filter out non-supported devices.
+	 * device 2: misc, device 21: confbus
+	 */
+	if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		if (busnum == 0) {
+			if (device > 23 || (device >= 9 && device <= 20 && function == 1))
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | addr);
+		} else {
+			addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE_TP1 | addr);
+		}
+	} else if (where < PCI_CFG_SPACE_EXP_SIZE) {  /* extended config */
+		reg = (reg & 0xff) | ((reg & 0xf00) << 16);
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		if (busnum == 0) {
+			if (device > 23 || (device >= 9 && device <= 20 && function == 1))
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			addrp = (void *)TO_UNCAC(HT1LO_EXT_PCICFG_BASE | addr);
+		} else {
+			addrp = (void *)TO_UNCAC(HT1LO_EXT_PCICFG_BASE_TP1 | addr);
+		}
+	} else {
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (access_type == PCI_ACCESS_WRITE)
+		writel(*data, addrp);
+	else {
+		*data = readl(addrp);
+		if (*data == 0xffffffff) {
+			*data = -1;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ls7a_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 *val)
+{
+	u32 data = 0;
+	int ret = ls7a_pci_config_access(PCI_ACCESS_READ,
+			bus, devfn, where, &data);
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return ret;
+}
+
+static int ls7a_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
+{
+	int ret;
+	u32 data = 0;
+
+	if (size == 4)
+		data = val;
+	else {
+		ret = ls7a_pci_config_access(PCI_ACCESS_READ,
+				bus, devfn, where, &data);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return ret;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+			    (val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+			    (val << ((where & 3) << 3));
+	}
+
+	ret = ls7a_pci_config_access(PCI_ACCESS_WRITE,
+			bus, devfn, where, &data);
+
+	return ret;
+}
+
+struct pci_ops ls7a_pci_ops = {
+	.read = ls7a_pci_pcibios_read,
+	.write = ls7a_pci_pcibios_write
+};
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
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC, pci_fixup_vgadev);
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
new file mode 100644
index 000000000000..afdf70fc8770
--- /dev/null
+++ b/arch/loongarch/pci/pci.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/of_address.h>
+#include <loongson.h>
+
+const struct pci_ops *__read_mostly loongarch_pci_ops;
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
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc, resource_size_t *start,
+			  resource_size_t *end)
+{
+	phys_addr_t size = resource_size(rsrc);
+
+	*start = rsrc->start;
+	*end = rsrc->start + size - 1;
+}
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ *
+ * Why? Because some silly external IO cards only decode
+ * the low 10 bits of the IO address. The 0x00-0xff region
+ * is reserved for motherboard devices that decode all 16
+ * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
+ * but we want to try to avoid allocating at 0x2900-0x2bff
+ * which might have be mirrored at 0x0100-0x03ff..
+ */
+resource_size_t
+pcibios_align_resource(void *data, const struct resource *res,
+		       resource_size_t size, resource_size_t align)
+{
+	struct pci_dev *dev = data;
+	struct pci_controller *hose = dev->sysdata;
+	resource_size_t start = res->start;
+
+	if (res->flags & IORESOURCE_IO) {
+		/* Make sure we start at our min on all hoses */
+		if (start < PCIBIOS_MIN_IO + hose->io_resource->start)
+			start = PCIBIOS_MIN_IO + hose->io_resource->start;
+
+		/*
+		 * Put everything into 0x00-0xff region modulo 0x400
+		 */
+		if (start & 0x300)
+			start = (start + 0x3ff) & ~0x3ff;
+	} else if (res->flags & IORESOURCE_MEM) {
+		/* Make sure we start at our min on all hoses */
+		if (start < PCIBIOS_MIN_MEM)
+			start = PCIBIOS_MIN_MEM;
+	}
+
+	return start;
+}
+
+phys_addr_t mcfg_addr_init(int domain)
+{
+	return (((u64) domain << 44) | MCFG_EXT_PCICFG_BASE);
+}
+
+static struct resource pci_mem_resource = {
+	.name	= "pci memory space",
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct resource pci_io_resource = {
+	.name	= "pci io space",
+	.flags	= IORESOURCE_IO,
+};
+
+void pcibios_add_root_resources(struct list_head *resources)
+{
+	if (resources) {
+		pci_add_resource(resources, &pci_mem_resource);
+		pci_add_resource(resources, &pci_io_resource);
+	}
+}
+
+static int __init pcibios_set_cache_line_size(void)
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
+static int __init pcibios_init(void)
+{
+	return pcibios_set_cache_line_size();
+}
+
+subsys_initcall(pcibios_init);
+
+static int pcibios_enable_resources(struct pci_dev *dev, int mask)
+{
+	int idx;
+	u16 cmd, old_cmd;
+	struct resource *r;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
+	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+		/* Only set up the requested stuff */
+		if (!(mask & (1<<idx)))
+			continue;
+
+		r = &dev->resource[idx];
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
+		if (!r->start && r->end) {
+			pci_err(dev,
+				"can't enable device: resource collisions\n");
+			return -EINVAL;
+		}
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	if (cmd != old_cmd) {
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+
+	return 0;
+}
+
+int pcibios_dev_init(struct pci_dev *dev)
+{
+#ifdef CONFIG_ACPI
+	if (acpi_disabled)
+		return 0;
+	if (pci_dev_msi_enabled(dev))
+		return 0;
+	return acpi_pci_irq_enable(dev);
+#endif
+}
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	int err;
+
+	err = pcibios_enable_resources(dev, mask);
+	if (err < 0)
+		return err;
+
+	return pcibios_dev_init(dev);
+}
+
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+
+	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
+	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_read_bridge_bases(bus);
+	}
+}
-- 
2.27.0

