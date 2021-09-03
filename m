Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBAC3FFDA9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhICJ6m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 05:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234974AbhICJ6m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 05:58:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C37B6056B;
        Fri,  3 Sep 2021 09:57:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 09/22] LoongArch: Add boot and setup routines
Date:   Fri,  3 Sep 2021 17:52:00 +0800
Message-Id: <20210903095213.797973-10-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds basic boot, setup and reset routines for LoongArch.
LoongArch uses UEFI-based firmware and uses ACPI as the boot protocol.

Now the boot information passed to kernel is like this:
1, kernel get a0, a1 and a2 from bootloader.
2, a0 is "argc", a1 is "argc", so "cmdline" comes from a0/a1.
3, a2 is "envrion", which is a pointer to a "struct bootparamsinterface"
4, "struct bootparamsinterface" include a "systemtable" pointer, whose
   type is "efi_system_table_t". Most information, include ACPI tables,
   come from here.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/acenv.h      |  17 +
 arch/loongarch/include/asm/acpi.h       |  39 ++
 arch/loongarch/include/asm/boot_param.h |  91 +++++
 arch/loongarch/include/asm/bootinfo.h   |  33 ++
 arch/loongarch/include/asm/dmi.h        |  24 ++
 arch/loongarch/include/asm/efi.h        |  32 ++
 arch/loongarch/include/asm/fw.h         |  18 +
 arch/loongarch/include/asm/reboot.h     |  10 +
 arch/loongarch/include/asm/setup.h      |  21 ++
 arch/loongarch/kernel/acpi.c            | 329 +++++++++++++++++
 arch/loongarch/kernel/cacheinfo.c       | 126 +++++++
 arch/loongarch/kernel/cmdline.c         |  28 ++
 arch/loongarch/kernel/cpu-probe.c       | 301 +++++++++++++++
 arch/loongarch/kernel/efi.c             |  95 +++++
 arch/loongarch/kernel/env.c             | 170 +++++++++
 arch/loongarch/kernel/head.S            |  72 ++++
 arch/loongarch/kernel/mem.c             |  85 +++++
 arch/loongarch/kernel/reset.c           |  90 +++++
 arch/loongarch/kernel/setup.c           | 469 ++++++++++++++++++++++++
 arch/loongarch/kernel/time.c            | 237 ++++++++++++
 arch/loongarch/kernel/topology.c        |  13 +
 21 files changed, 2300 insertions(+)
 create mode 100644 arch/loongarch/include/asm/acenv.h
 create mode 100644 arch/loongarch/include/asm/acpi.h
 create mode 100644 arch/loongarch/include/asm/boot_param.h
 create mode 100644 arch/loongarch/include/asm/bootinfo.h
 create mode 100644 arch/loongarch/include/asm/dmi.h
 create mode 100644 arch/loongarch/include/asm/efi.h
 create mode 100644 arch/loongarch/include/asm/fw.h
 create mode 100644 arch/loongarch/include/asm/reboot.h
 create mode 100644 arch/loongarch/include/asm/setup.h
 create mode 100644 arch/loongarch/kernel/acpi.c
 create mode 100644 arch/loongarch/kernel/cacheinfo.c
 create mode 100644 arch/loongarch/kernel/cmdline.c
 create mode 100644 arch/loongarch/kernel/cpu-probe.c
 create mode 100644 arch/loongarch/kernel/efi.c
 create mode 100644 arch/loongarch/kernel/env.c
 create mode 100644 arch/loongarch/kernel/head.S
 create mode 100644 arch/loongarch/kernel/mem.c
 create mode 100644 arch/loongarch/kernel/reset.c
 create mode 100644 arch/loongarch/kernel/setup.c
 create mode 100644 arch/loongarch/kernel/time.c
 create mode 100644 arch/loongarch/kernel/topology.c

diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/include/asm/acenv.h
new file mode 100644
index 000000000000..d1f41fbc9070
--- /dev/null
+++ b/arch/loongarch/include/asm/acenv.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch specific ACPICA environments and implementation
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_ACENV_H
+#define _ASM_LOONGARCH_ACENV_H
+
+/* The head file is required by ACPI core, but we have nothing to fill
+ * it now, update it later when needed.
+ */
+
+#endif /* _ASM_LOONGARCH_ACENV_H */
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
new file mode 100644
index 000000000000..aab9223e1f4a
--- /dev/null
+++ b/arch/loongarch/include/asm/acpi.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_LOONGARCH_ACPI_H
+#define _ASM_LOONGARCH_ACPI_H
+
+#ifdef CONFIG_ACPI
+extern int acpi_strict;
+extern int acpi_disabled;
+extern int acpi_pci_disabled;
+extern int acpi_noirq;
+
+static inline void disable_acpi(void)
+{
+	acpi_disabled = 1;
+	acpi_pci_disabled = 1;
+	acpi_noirq = 1;
+}
+
+static inline bool acpi_has_cpu_in_madt(void)
+{
+	return true;
+}
+
+extern struct list_head acpi_wakeup_device_list;
+
+#endif /* !CONFIG_ACPI */
+
+#define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn << PAGE_SHIFT)
+
+#endif /* _ASM_LOONGARCH_ACPI_H */
diff --git a/arch/loongarch/include/asm/boot_param.h b/arch/loongarch/include/asm/boot_param.h
new file mode 100644
index 000000000000..f515431d838b
--- /dev/null
+++ b/arch/loongarch/include/asm/boot_param.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BOOT_PARAM_H_
+#define __ASM_BOOT_PARAM_H_
+
+#ifdef CONFIG_VT
+#include <linux/screen_info.h>
+#endif
+
+#define ADDRESS_TYPE_SYSRAM	1
+#define ADDRESS_TYPE_RESERVED	2
+#define ADDRESS_TYPE_ACPI	3
+#define ADDRESS_TYPE_NVS	4
+#define ADDRESS_TYPE_PMEM	5
+
+#define LOONGSON3_BOOT_MEM_MAP_MAX 128
+
+#define LOONGSON_EFIBOOT_SIGNATURE	"BPI"
+#define LOONGSON_MEM_LINKLIST		"MEM"
+#define LOONGSON_VBIOS_LINKLIST		"VBIOS"
+#define LOONGSON_SCREENINFO_LINKLIST	"SINFO"
+
+/* Values for Version BPI */
+enum bpi_version {
+	BPI_VERSION_V1 = 1000, /* Signature="BPI01000" */
+	BPI_VERSION_V2 = 1001, /* Signature="BPI01001" */
+};
+
+/* Flags in bootparamsinterface */
+#define BPI_FLAGS_UEFI_SUPPORTED BIT(0)
+
+struct _extention_list_hdr {
+	u64	signature;
+	u32	length;
+	u8	revision;
+	u8	checksum;
+	struct	_extention_list_hdr *next;
+} __packed;
+
+struct bootparamsinterface {
+	u64	signature;	/* {"B", "P", "I", "0", "1", ... } */
+	void	*systemtable;
+	struct	_extention_list_hdr *extlist;
+	u64	flags;
+} __packed;
+
+struct loongsonlist_mem_map {
+	struct	_extention_list_hdr header;	/* {"M", "E", "M"} */
+	u8	map_count;
+	struct	loongson_mem_map {
+		u32 mem_type;
+		u64 mem_start;
+		u64 mem_size;
+	} __packed map[LOONGSON3_BOOT_MEM_MAP_MAX];
+} __packed;
+
+struct loongsonlist_vbios {
+	struct	_extention_list_hdr header;	/* {"V", "B", "I", "O", "S"} */
+	u64	vbios_addr;
+} __packed;
+
+struct loongsonlist_screeninfo {
+	struct	_extention_list_hdr header;	/* {"S", "I", "N", "F", "O"} */
+	struct	screen_info si;
+} __packed;
+
+struct loongson_board_info {
+	int bios_size;
+	char *bios_vendor;
+	char *bios_version;
+	char *bios_release_date;
+	char *board_name;
+	char *board_vendor;
+};
+
+struct loongson_system_configuration {
+	int bpi_ver;
+	int nr_cpus;
+	int nr_nodes;
+	int nr_io_pics;
+	int boot_cpu_id;
+	int cores_per_node;
+	int cores_per_package;
+	char *cpuname;
+	u64 vgabios_addr;
+};
+
+extern struct loongson_board_info b_info;
+extern struct bootparamsinterface *efi_bp;
+extern struct loongsonlist_mem_map *loongson_mem_map;
+extern struct loongson_system_configuration loongson_sysconf;
+#endif
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
new file mode 100644
index 000000000000..41838633d1aa
--- /dev/null
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_BOOTINFO_H
+#define _ASM_BOOTINFO_H
+
+#include <linux/types.h>
+#include <asm/setup.h>
+
+const char *get_system_type(void);
+
+extern void early_memblock_init(void);
+extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,  phys_addr_t sz_max);
+
+extern void early_init(void);
+extern void platform_init(void);
+
+extern void free_init_pages(const char *what, unsigned long begin, unsigned long end);
+
+/*
+ * Initial kernel command line, usually setup by fw_init_cmdline()
+ */
+extern char arcs_cmdline[COMMAND_LINE_SIZE];
+
+/*
+ * Registers a0, a1, a3 and a4 as passed to the kernel entry by firmware
+ */
+extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+
+extern unsigned long initrd_start, initrd_end;
+
+#endif /* _ASM_BOOTINFO_H */
diff --git a/arch/loongarch/include/asm/dmi.h b/arch/loongarch/include/asm/dmi.h
new file mode 100644
index 000000000000..fbe98f0e56e0
--- /dev/null
+++ b/arch/loongarch/include/asm/dmi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_DMI_H
+#define _ASM_DMI_H
+
+#include <linux/io.h>
+#include <linux/memblock.h>
+
+#define dmi_early_remap(x, l)	dmi_remap(x, l)
+#define dmi_early_unmap(x, l)	dmi_unmap(x)
+#define dmi_alloc(l)		memblock_alloc_low(l, PAGE_SIZE)
+
+static inline void *dmi_remap(u64 phys_addr, unsigned long size)
+{
+	return ((void *)TO_CAC(phys_addr));
+}
+
+static inline void dmi_unmap(void *addr)
+{
+}
+
+#endif /* _ASM_DMI_H */
diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
new file mode 100644
index 000000000000..90e8e35d7f4b
--- /dev/null
+++ b/arch/loongarch/include/asm/efi.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_LOONGARCH_EFI_H
+#define _ASM_LOONGARCH_EFI_H
+
+#include <linux/efi.h>
+
+extern void __init efi_init(void);
+extern void __init efi_runtime_init(void);
+extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
+
+#define ARCH_EFI_IRQ_FLAGS_MASK  0x00000001  /*bit0: CP0 Status.IE*/
+
+#define arch_efi_call_virt_setup()               \
+({                                               \
+})
+
+#define arch_efi_call_virt(p, f, args...)        \
+({                                               \
+	efi_##f##_t * __f;                       \
+	__f = p->f;                              \
+	__f(args);                               \
+})
+
+#define arch_efi_call_virt_teardown()            \
+({                                               \
+})
+
+
+#endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/arch/loongarch/include/asm/fw.h b/arch/loongarch/include/asm/fw.h
new file mode 100644
index 000000000000..8a0e8e7c625f
--- /dev/null
+++ b/arch/loongarch/include/asm/fw.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_FW_H_
+#define __ASM_FW_H_
+
+#include <asm/bootinfo.h>
+
+extern int fw_argc;
+extern long *_fw_argv, *_fw_envp;
+
+#define fw_argv(index)		((char *)(long)_fw_argv[(index)])
+#define fw_envp(index)		((char *)(long)_fw_envp[(index)])
+
+extern void fw_init_cmdline(void);
+
+#endif /* __ASM_FW_H_ */
diff --git a/arch/loongarch/include/asm/reboot.h b/arch/loongarch/include/asm/reboot.h
new file mode 100644
index 000000000000..0e96b0f42993
--- /dev/null
+++ b/arch/loongarch/include/asm/reboot.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_REBOOT_H
+#define _ASM_REBOOT_H
+
+extern void (*pm_restart)(void);
+
+#endif /* _ASM_REBOOT_H */
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
new file mode 100644
index 000000000000..fc1fb741b4da
--- /dev/null
+++ b/arch/loongarch/include/asm/setup.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef _LOONGARCH_SETUP_H
+#define _LOONGARCH_SETUP_H
+
+#include <linux/types.h>
+#include <uapi/asm/setup.h>
+
+#define VECSIZE 0x200
+
+extern unsigned long eentry;
+extern unsigned long tlbrentry;
+extern void cpu_cache_init(void);
+extern void per_cpu_trap_init(int cpu);
+extern void set_handler(unsigned long offset, void *addr, unsigned long len);
+extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len);
+
+#endif /* __SETUP_H */
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
new file mode 100644
index 000000000000..dcd683352d61
--- /dev/null
+++ b/arch/loongarch/kernel/acpi.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * acpi.c - Architecture-Specific Low-Level ACPI Boot Support
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/memblock.h>
+#include <linux/serial_core.h>
+#include <asm/io.h>
+#include <asm/loongson.h>
+
+int acpi_disabled;
+EXPORT_SYMBOL(acpi_disabled);
+int acpi_noirq;
+int acpi_pci_disabled;
+EXPORT_SYMBOL(acpi_pci_disabled);
+int acpi_strict = 1; /* We have no workarounds on LoongArch */
+int num_processors;
+int disabled_cpus;
+enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
+
+u64 acpi_saved_sp;
+
+#define MAX_CORE_PIC 256
+
+#define PREFIX			"ACPI: "
+
+/*
+ * Following __acpi_xx functions should be implemented for sepecific cpu.
+ */
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
+{
+	if (irqp != NULL)
+		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
+
+int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
+{
+	if (gsi)
+		*gsi = isa_irq;
+	return 0;
+}
+
+/*
+ * success: return IRQ number (>=0)
+ * failure: return < 0
+ */
+int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
+{
+	int id, hwirq;
+	struct irq_domain *domain;
+	struct irq_fwspec fwspec;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		hwirq = gsi - GSI_MIN_CPU_IRQ;
+		return irq_create_mapping(liointc_domain, hwirq);
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id < 0)
+			return -1;
+
+		domain = pch_pic_domain[id];
+		if (!domain)
+			return gsi;
+
+		hwirq = gsi - acpi_pchpic[id]->gsi_base;
+		fwspec.param_count = 2;
+		fwspec.param[0] = hwirq;
+		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+
+		return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &fwspec);
+	}
+
+	return -1;
+}
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
+
+void acpi_unregister_gsi(u32 gsi)
+{
+
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
+void __iomem *__init __acpi_map_table(unsigned long phys, unsigned long size)
+{
+
+	if (!phys || !size)
+		return NULL;
+
+	return early_memremap(phys, size);
+}
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
+{
+	if (!map || !size)
+		return;
+
+	early_memunmap(map, size);
+}
+
+void __init acpi_boot_table_init(void)
+{
+	/*
+	 * If acpi_disabled, bail out
+	 */
+	if (acpi_disabled)
+		return;
+
+	/*
+	 * Initialize the ACPI boot-time table parser.
+	 */
+	if (acpi_table_init()) {
+		disable_acpi();
+		return;
+	}
+}
+
+static int __init
+acpi_parse_cpuintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_core_pic *processor = NULL;
+
+	processor = (struct acpi_madt_core_pic *)header;
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	return 0;
+}
+
+static int __init
+acpi_parse_liointc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_lio_pic *liointc = NULL;
+
+	liointc = (struct acpi_madt_lio_pic *)header;
+
+	if (BAD_MADT_ENTRY(liointc, end))
+		return -EINVAL;
+
+	acpi_liointc = liointc;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_eiointc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	static int id = 0;
+	struct acpi_madt_eio_pic *eiointc = NULL;
+
+	eiointc = (struct acpi_madt_eio_pic *)header;
+
+	if (BAD_MADT_ENTRY(eiointc, end))
+		return -EINVAL;
+
+	acpi_eiointc[id++] = eiointc;
+	loongson_sysconf.nr_io_pics = id;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_htintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_ht_pic *htintc = NULL;
+
+	htintc = (struct acpi_madt_ht_pic *)header;
+
+	if (BAD_MADT_ENTRY(htintc, end))
+		return -EINVAL;
+
+	acpi_htintc = htintc;
+	loongson_sysconf.nr_io_pics = 1;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_pch_pic(union acpi_subtable_headers *header, const unsigned long end)
+{
+	static int id = 0;
+	struct acpi_madt_bio_pic *pchpic = NULL;
+
+	pchpic = (struct acpi_madt_bio_pic *)header;
+
+	if (BAD_MADT_ENTRY(pchpic, end))
+		return -EINVAL;
+
+	acpi_pchpic[id++] = pchpic;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_pch_msi(union acpi_subtable_headers *header, const unsigned long end)
+{
+	static int id = 0;
+	struct acpi_madt_msi_pic *pchmsi = NULL;
+
+	pchmsi = (struct acpi_madt_msi_pic *)header;
+
+	if (BAD_MADT_ENTRY(pchmsi, end))
+		return -EINVAL;
+
+	acpi_pchmsi[id++] = pchmsi;
+
+	return 0;
+}
+
+static int __init
+acpi_parse_pch_lpc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_lpc_pic *pchlpc = NULL;
+
+	pchlpc = (struct acpi_madt_lpc_pic *)header;
+
+	if (BAD_MADT_ENTRY(pchlpc, end))
+		return -EINVAL;
+
+	acpi_pchlpc = pchlpc;
+
+	return 0;
+}
+
+static void __init acpi_process_madt(void)
+{
+	int error;
+
+	/* Parse MADT CPUINTC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_CORE_PIC, acpi_parse_cpuintc, MAX_CORE_PIC);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (CPUINTC entries), ACPI disabled\n");
+		return;
+	}
+
+	loongson_sysconf.nr_cpus = num_processors;
+
+	/* Parse MADT LIOINTC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, acpi_parse_liointc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (LIOINTC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT EIOINTC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, acpi_parse_eiointc, MAX_IO_PICS);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (EIOINTC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT HTVEC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC, acpi_parse_htintc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (HTVEC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT PCHPIC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, acpi_parse_pch_pic, MAX_IO_PICS);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (PCHPIC entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT PCHMSI entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, acpi_parse_pch_msi, MAX_IO_PICS);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (PCHMSI entries), ACPI disabled\n");
+		return;
+	}
+
+	/* Parse MADT PCHLPC entries */
+	error = acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, acpi_parse_pch_lpc, 1);
+	if (error < 0) {
+		disable_acpi();
+		pr_err(PREFIX "Invalid BIOS MADT (PCHLPC entries), ACPI disabled\n");
+		return;
+	}
+}
+
+int __init acpi_boot_init(void)
+{
+	/*
+	 * If acpi_disabled, bail out
+	 */
+	if (acpi_disabled)
+		return -1;
+
+	loongson_sysconf.boot_cpu_id = read_csr_cpuid();
+
+	/*
+	 * Process the Multiple APIC Description Table (MADT), if present
+	 */
+	acpi_process_madt();
+
+	/* Do not enable ACPI SPCR console by default */
+	acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
+
+	return 0;
+}
+
+void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
+{
+	u8 map_count = loongson_mem_map->map_count;
+
+	loongson_mem_map->map[map_count].mem_start = addr;
+	loongson_mem_map->map[map_count].mem_size = size;
+	loongson_mem_map->map[map_count].mem_type = ADDRESS_TYPE_ACPI;
+	loongson_mem_map->map_count++;
+}
diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/cacheinfo.c
new file mode 100644
index 000000000000..399e2f5fa6fc
--- /dev/null
+++ b/arch/loongarch/kernel/cacheinfo.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LoongArch cacheinfo support
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/cacheinfo.h>
+#include <linux/of.h>
+
+/* Populates leaf and increments to next leaf */
+#define populate_cache(cache, leaf, c_level, c_type)		\
+do {								\
+	leaf->type = c_type;					\
+	leaf->level = c_level;					\
+	leaf->coherency_line_size = c->cache.linesz;		\
+	leaf->number_of_sets = c->cache.sets;			\
+	leaf->ways_of_associativity = c->cache.ways;		\
+	leaf->size = c->cache.linesz * c->cache.sets *		\
+		c->cache.ways;					\
+	leaf++;							\
+} while (0)
+
+static int __init_cache_level(unsigned int cpu)
+{
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	int levels = 0, leaves = 0;
+
+	/*
+	 * If Dcache is not set, we assume the cache structures
+	 * are not properly initialized.
+	 */
+	if (c->dcache.waysize)
+		levels += 1;
+	else
+		return -ENOENT;
+
+
+	leaves += (c->icache.waysize) ? 2 : 1;
+
+	if (c->vcache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	if (c->scache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	if (c->tcache.waysize) {
+		levels++;
+		leaves++;
+	}
+
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+	return 0;
+}
+
+static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
+					   struct cacheinfo *sib_leaf)
+{
+	return !((this_leaf->level == 1) || (this_leaf->level == 2));
+}
+
+static void __cache_cpumap_setup(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf, *sib_leaf;
+	unsigned int index;
+
+	for (index = 0; index < this_cpu_ci->num_leaves; index++) {
+		unsigned int i;
+
+		this_leaf = this_cpu_ci->info_list + index;
+		/* skip if shared_cpu_map is already populated */
+		if (!cpumask_empty(&this_leaf->shared_cpu_map))
+			continue;
+
+		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
+		for_each_online_cpu(i) {
+			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
+
+			if (i == cpu || !sib_cpu_ci->info_list)
+				continue;/* skip if itself or no cacheinfo */
+			sib_leaf = sib_cpu_ci->info_list + index;
+			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
+				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
+				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
+			}
+		}
+	}
+}
+
+static int __populate_cache_leaves(unsigned int cpu)
+{
+	int level = 1;
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+
+	if (c->icache.waysize) {
+		populate_cache(dcache, this_leaf, level, CACHE_TYPE_DATA);
+		populate_cache(icache, this_leaf, level++, CACHE_TYPE_INST);
+	} else {
+		populate_cache(dcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+	}
+
+	if (c->vcache.waysize)
+		populate_cache(vcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+
+	if (c->scache.waysize)
+		populate_cache(scache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+
+	if (c->tcache.waysize)
+		populate_cache(tcache, this_leaf, level++, CACHE_TYPE_UNIFIED);
+
+	__cache_cpumap_setup(cpu);
+	this_cpu_ci->cpu_map_populated = true;
+
+	return 0;
+}
+
+DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
+DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/loongarch/kernel/cmdline.c b/arch/loongarch/kernel/cmdline.c
new file mode 100644
index 000000000000..46bf4486b54c
--- /dev/null
+++ b/arch/loongarch/kernel/cmdline.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/fw.h>
+
+int fw_argc;
+long *_fw_argv, *_fw_envp;
+
+void __init fw_init_cmdline(void)
+{
+	int i;
+
+	fw_argc = fw_arg0;
+	_fw_argv = (long *)fw_arg1;
+	_fw_envp = (long *)fw_arg2;
+
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < fw_argc; i++) {
+		strlcat(arcs_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
+		if (i < (fw_argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+	}
+}
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
new file mode 100644
index 000000000000..acf7eb19f75d
--- /dev/null
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Processor capabilities determination functions.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
+#include <linux/export.h>
+#include <linux/printk.h>
+#include <linux/uaccess.h>
+
+#include <asm/cpu-features.h>
+#include <asm/elf.h>
+#include <asm/fpu.h>
+#include <asm/loongarch.h>
+#include <asm/pgtable-bits.h>
+#include <asm/setup.h>
+
+/* Hardware capabilities */
+unsigned int elf_hwcap __read_mostly;
+EXPORT_SYMBOL_GPL(elf_hwcap);
+
+/*
+ * Determine the FCSR mask for FPU hardware.
+ */
+static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_loongarch *c)
+{
+	unsigned long sr, mask, fcsr, fcsr0, fcsr1;
+
+	fcsr = c->fpu_csr0;
+	mask = FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_RM;
+
+	sr = read_csr_euen();
+	enable_fpu();
+
+	fcsr0 = fcsr & mask;
+	write_fcsr(LOONGARCH_FCSR0, fcsr0);
+	fcsr0 = read_fcsr(LOONGARCH_FCSR0);
+
+	fcsr1 = fcsr | ~mask;
+	write_fcsr(LOONGARCH_FCSR0, fcsr1);
+	fcsr1 = read_fcsr(LOONGARCH_FCSR0);
+
+	write_fcsr(LOONGARCH_FCSR0, fcsr);
+
+	write_csr_euen(sr);
+
+	c->fpu_mask = ~(fcsr0 ^ fcsr1) & ~mask;
+}
+
+static inline void set_elf_platform(int cpu, const char *plat)
+{
+	if (cpu == 0)
+		__elf_platform = plat;
+}
+
+/* MAP BASE */
+unsigned long vm_map_base;
+EXPORT_SYMBOL_GPL(vm_map_base);
+
+static void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
+{
+#ifdef __NEED_ADDRBITS_PROBE
+	c->pabits = (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_PABITS) >> 4;
+	c->vabits = (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_VABITS) >> 12;
+	vm_map_base = 0UL - (1UL << c->vabits);
+#endif
+}
+
+static void set_isa(struct cpuinfo_loongarch *c, unsigned int isa)
+{
+	switch (isa) {
+	case LOONGARCH_CPU_ISA_LA64:
+		c->isa_level |= LOONGARCH_CPU_ISA_LA64;
+		fallthrough;
+	case LOONGARCH_CPU_ISA_LA32S:
+		c->isa_level |= LOONGARCH_CPU_ISA_LA32S;
+		fallthrough;
+	case LOONGARCH_CPU_ISA_LA32R:
+		c->isa_level |= LOONGARCH_CPU_ISA_LA32R;
+		break;
+	}
+}
+
+static void cpu_probe_common(struct cpuinfo_loongarch *c)
+{
+	unsigned int config;
+	unsigned long asid_mask;
+
+	c->options = LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR |
+		     LOONGARCH_CPU_TLB | LOONGARCH_CPU_VINT | LOONGARCH_CPU_WATCH;
+
+	elf_hwcap |= HWCAP_LOONGARCH_CRC32;
+
+	config = read_cpucfg(LOONGARCH_CPUCFG1);
+	if (config & CPUCFG1_UAL) {
+		c->options |= LOONGARCH_CPU_UAL;
+		elf_hwcap |= HWCAP_LOONGARCH_UAL;
+	}
+
+	config = read_cpucfg(LOONGARCH_CPUCFG2);
+	if (config & CPUCFG2_LAM) {
+		c->options |= LOONGARCH_CPU_LAM;
+		elf_hwcap |= HWCAP_LOONGARCH_LAM;
+	}
+	if (config & CPUCFG2_FP) {
+		c->options |= LOONGARCH_CPU_FPU;
+		elf_hwcap |= HWCAP_LOONGARCH_FPU;
+	}
+	if (config & CPUCFG2_COMPLEX) {
+		c->options |= LOONGARCH_CPU_COMPLEX;
+		elf_hwcap |= HWCAP_LOONGARCH_COMPLEX;
+	}
+	if (config & CPUCFG2_CRYPTO) {
+		c->options |= LOONGARCH_CPU_CRYPTO;
+		elf_hwcap |= HWCAP_LOONGARCH_CRYPTO;
+	}
+	if (config & CPUCFG2_LVZP) {
+		c->options |= LOONGARCH_CPU_LVZ;
+		elf_hwcap |= HWCAP_LOONGARCH_LVZ;
+	}
+
+	config = read_cpucfg(LOONGARCH_CPUCFG6);
+	if (config & CPUCFG6_PMP)
+		c->options |= LOONGARCH_CPU_PMP;
+
+	config = iocsr_readl(LOONGARCH_IOCSR_FEATURES);
+	if (config & IOCSRF_CSRIPI)
+		c->options |= LOONGARCH_CPU_CSRIPI;
+	if (config & IOCSRF_EXTIOI)
+		c->options |= LOONGARCH_CPU_EXTIOI;
+	if (config & IOCSRF_FREQSCALE)
+		c->options |= LOONGARCH_CPU_SCALEFREQ;
+	if (config & IOCSRF_VM)
+		c->options |= LOONGARCH_CPU_HYPERVISOR;
+
+	config = csr_readl(LOONGARCH_CSR_ASID);
+	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
+	asid_mask = GENMASK(config - 1, 0);
+	set_cpu_asid_mask(c, asid_mask);
+
+	config = read_csr_prcfg1();
+	c->kscratch_mask = GENMASK((config & CSR_CONF1_KSNUM) - 1, 0);
+	c->kscratch_mask &= ~(EXC_KSCRATCH_MASK | PERCPU_KSCRATCH_MASK | KVM_KSCRATCH_MASK);
+
+	config = read_csr_prcfg3();
+	switch (config & CSR_CONF3_TLBTYPE) {
+	case 0:
+		c->tlbsizemtlb = 0;
+		c->tlbsizestlbsets = 0;
+		c->tlbsizestlbways = 0;
+		c->tlbsize = 0;
+		break;
+	case 1:
+		c->tlbsizemtlb = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
+		c->tlbsizestlbsets = 0;
+		c->tlbsizestlbways = 0;
+		c->tlbsize = c->tlbsizemtlb + c->tlbsizestlbsets * c->tlbsizestlbways;
+		break;
+	case 2:
+		c->tlbsizemtlb = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
+		c->tlbsizestlbsets = 1 << ((config & CSR_CONF3_STLBIDX) >> CSR_CONF3_STLBIDX_SHIFT);
+		c->tlbsizestlbways = ((config & CSR_CONF3_STLBWAYS) >> CSR_CONF3_STLBWAYS_SHIFT) + 1;
+		c->tlbsize = c->tlbsizemtlb + c->tlbsizestlbsets * c->tlbsizestlbways;
+		break;
+	default:
+		pr_warn("Warning: unimplemented tlb type\n");
+	}
+}
+
+#define MAX_NAME_LEN	32
+#define VENDOR_OFFSET	0
+#define CPUNAME_OFFSET	9
+
+static char cpu_full_name[MAX_NAME_LEN] = "        -        ";
+
+static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int cpu)
+{
+	uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
+	uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
+
+	__cpu_full_name[cpu] = cpu_full_name;
+	*vendor = iocsr_readq(LOONGARCH_IOCSR_VENDOR);
+	*cpuname = iocsr_readq(LOONGARCH_IOCSR_CPUNAME);
+
+	switch (c->processor_id & PRID_IMP_MASK) {
+	case PRID_IMP_LOONGSON_32:
+		c->cputype = CPU_LOONGSON32;
+		set_isa(c, LOONGARCH_CPU_ISA_LA32S);
+		__cpu_family[cpu] = "Loongson-32bit";
+		pr_info("Standard 32-bit Loongson Processor probed\n");
+		break;
+	case PRID_IMP_LOONGSON_64R:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Reduced 64-bit Loongson Processor probed\n");
+		break;
+	case PRID_IMP_LOONGSON_64C:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Classic 64-bit Loongson Processor probed\n");
+		break;
+	case PRID_IMP_LOONGSON_64G:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Generic 64-bit Loongson Processor probed\n");
+		break;
+	default: /* Default to 64 bit */
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("Unknown 64-bit Loongson Processor probed\n");
+	}
+}
+
+#ifdef CONFIG_64BIT
+/* For use by uaccess.h */
+u64 __ua_limit;
+EXPORT_SYMBOL(__ua_limit);
+#endif
+
+const char *__cpu_family[NR_CPUS];
+const char *__cpu_full_name[NR_CPUS];
+const char *__elf_platform;
+
+static void cpu_report(void)
+{
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+
+	pr_info("CPU%d revision is: %08x (%s)\n",
+		smp_processor_id(), c->processor_id, cpu_family_string());
+	if (c->options & LOONGARCH_CPU_FPU)
+		pr_info("FPU%d revision is: %08x\n", smp_processor_id(), c->fpu_vers);
+}
+
+void cpu_probe(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo_loongarch *c = &current_cpu_data;
+
+	/*
+	 * Set a default elf platform, cpu probe may later
+	 * overwrite it with a more precise value
+	 */
+	set_elf_platform(cpu, "loongarch");
+
+	c->cputype	= CPU_UNKNOWN;
+	c->processor_id = read_cpucfg(LOONGARCH_CPUCFG0);
+	c->fpu_vers	= (read_cpucfg(LOONGARCH_CPUCFG2) >> 3) & 0x3;
+
+	c->fpu_csr0	= FPU_CSR_RN;
+	c->fpu_mask	= FPU_CSR_RSVD;
+
+	cpu_probe_common(c);
+
+	per_cpu_trap_init(cpu);
+
+	switch (c->processor_id & PRID_COMP_MASK) {
+	case PRID_COMP_LOONGSON:
+		cpu_probe_loongson(c, cpu);
+		break;
+	}
+
+	BUG_ON(!__cpu_family[cpu]);
+	BUG_ON(c->cputype == CPU_UNKNOWN);
+
+	cpu_probe_addrbits(c);
+
+#ifdef CONFIG_64BIT
+	if (cpu == 0)
+		__ua_limit = ~((1ull << cpu_vabits) - 1);
+#endif
+
+	cpu_report();
+}
+
+void cpu_set_cluster(struct cpuinfo_loongarch *cpuinfo, unsigned int cluster)
+{
+	/* Ensure the core number fits in the field */
+	WARN_ON(cluster > (LOONGARCH_GLOBALNUMBER_CLUSTER >>
+			   LOONGARCH_GLOBALNUMBER_CLUSTER_SHF));
+
+	cpuinfo->globalnumber &= ~LOONGARCH_GLOBALNUMBER_CLUSTER;
+	cpuinfo->globalnumber |= cluster << LOONGARCH_GLOBALNUMBER_CLUSTER_SHF;
+}
+
+void cpu_set_core(struct cpuinfo_loongarch *cpuinfo, unsigned int core)
+{
+	/* Ensure the core number fits in the field */
+	WARN_ON(core > (LOONGARCH_GLOBALNUMBER_CORE >> LOONGARCH_GLOBALNUMBER_CORE_SHF));
+
+	cpuinfo->globalnumber &= ~LOONGARCH_GLOBALNUMBER_CORE;
+	cpuinfo->globalnumber |= core << LOONGARCH_GLOBALNUMBER_CORE_SHF;
+}
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
new file mode 100644
index 000000000000..c05abd143e44
--- /dev/null
+++ b/arch/loongarch/kernel/efi.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * EFI initialization
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <linux/efi-bgrt.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/kobject.h>
+#include <linux/memblock.h>
+#include <linux/reboot.h>
+#include <linux/uaccess.h>
+
+#include <asm/efi.h>
+#include <asm/boot_param.h>
+
+static efi_config_table_type_t arch_tables[] __initdata = {{},};
+
+void __init efi_runtime_init(void)
+{
+	if (!efi_enabled(EFI_BOOT))
+		return;
+
+	if (!efi.runtime)
+		return;
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return;
+	}
+
+	efi_native_runtime_setup();
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+}
+
+void __init efi_init(void)
+{
+	unsigned long efi_config_table;
+	efi_system_table_t *efi_systab;
+
+	if (!efi_bp)
+		return;
+
+	efi_systab = (efi_system_table_t *)efi_bp->systemtable;
+	if (!efi_systab) {
+		pr_err("Can't find EFI system table.\n");
+		return;
+	}
+
+	set_bit(EFI_64BIT, &efi.flags);
+	efi_config_table = (unsigned long)efi_systab->tables;
+	efi.runtime	 = (efi_runtime_services_t *)efi_systab->runtime;
+	efi.runtime_version = efi.runtime ? (unsigned int)efi.runtime->hdr.revision : 0;
+
+	efi_config_parse_tables((void *)efi_systab->tables, efi_systab->nr_tables, arch_tables);
+}
+
+static ssize_t boardinfo_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf,
+		"BIOS Information\n"
+		"Vendor\t\t\t: %s\n"
+		"Version\t\t\t: %s\n"
+		"ROM Size\t\t: %d KB\n"
+		"Release Date\t\t: %s\n\n"
+		"Board Information\n"
+		"Manufacturer\t\t: %s\n"
+		"Board Name\t\t: %s\n"
+		"Family\t\t\t: LOONGSON64\n\n",
+		b_info.bios_vendor, b_info.bios_version,
+		b_info.bios_size, b_info.bios_release_date,
+		b_info.board_vendor, b_info.board_name);
+}
+
+static struct kobj_attribute boardinfo_attr = __ATTR(boardinfo, 0444,
+						     boardinfo_show, NULL);
+
+static int __init boardinfo_init(void)
+{
+	if (!efi_kobj)
+		return -EINVAL;
+
+	return sysfs_create_file(efi_kobj, &boardinfo_attr.attr);
+}
+late_initcall(boardinfo_init);
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
new file mode 100644
index 000000000000..234fe282a98c
--- /dev/null
+++ b/arch/loongarch/kernel/env.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/export.h>
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <asm/fw.h>
+#include <asm/time.h>
+#include <asm/bootinfo.h>
+#include <asm/loongson.h>
+
+struct bootparamsinterface *efi_bp;
+struct loongsonlist_mem_map *loongson_mem_map;
+struct loongsonlist_vbios *pvbios;
+struct loongson_system_configuration loongson_sysconf;
+EXPORT_SYMBOL(loongson_sysconf);
+
+u64 loongson_chipcfg[MAX_PACKAGES];
+u64 loongson_chiptemp[MAX_PACKAGES];
+u64 loongson_freqctrl[MAX_PACKAGES];
+unsigned long long smp_group[MAX_PACKAGES];
+
+static void __init register_addrs_set(u64 *registers, const u64 addr, int num)
+{
+	u64 i;
+
+	for (i = 0; i < num; i++) {
+		*registers = (i << 44) | addr;
+		registers++;
+	}
+}
+
+static u8 ext_listhdr_checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end) {
+		sum = (u8)(sum + *(buffer++));
+	}
+
+	return (sum);
+}
+
+static int parse_mem(struct _extention_list_hdr *head)
+{
+	loongson_mem_map = (struct loongsonlist_mem_map *)head;
+	if (ext_listhdr_checksum((u8 *)loongson_mem_map, head->length)) {
+		pr_warn("mem checksum error\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static int parse_vbios(struct _extention_list_hdr *head)
+{
+	pvbios = (struct loongsonlist_vbios *)head;
+
+	if (ext_listhdr_checksum((u8 *)pvbios, head->length)) {
+		pr_warn("vbios_addr checksum error\n");
+		return -EPERM;
+	}
+
+	loongson_sysconf.vgabios_addr = pvbios->vbios_addr;
+
+	return 0;
+}
+
+static int parse_screeninfo(struct _extention_list_hdr *head)
+{
+	struct loongsonlist_screeninfo *pscreeninfo;
+
+	pscreeninfo = (struct loongsonlist_screeninfo *)head;
+	if (ext_listhdr_checksum((u8 *)pscreeninfo, head->length)) {
+		pr_warn("screeninfo_addr checksum error\n");
+		return -EPERM;
+	}
+
+	memcpy(&screen_info, &pscreeninfo->si, sizeof(screen_info));
+
+	return 0;
+}
+
+static int list_find(struct _extention_list_hdr *head)
+{
+	struct _extention_list_hdr *fhead = head;
+
+	if (fhead == NULL) {
+		pr_warn("the link is empty!\n");
+		return -1;
+	}
+
+	while (fhead != NULL) {
+		if (memcmp(&(fhead->signature), LOONGSON_MEM_LINKLIST, 3) == 0) {
+			if (parse_mem(fhead) != 0) {
+				pr_warn("parse mem failed\n");
+				return -EPERM;
+			}
+		} else if (memcmp(&(fhead->signature), LOONGSON_VBIOS_LINKLIST, 5) == 0) {
+			if (parse_vbios(fhead) != 0) {
+				pr_warn("parse vbios failed\n");
+				return -EPERM;
+			}
+		} else if (memcmp(&(fhead->signature), LOONGSON_SCREENINFO_LINKLIST, 5) == 0) {
+			if (parse_screeninfo(fhead) != 0) {
+				pr_warn("parse screeninfo failed\n");
+				return -EPERM;
+			}
+		}
+		fhead = fhead->next;
+	}
+
+	return 0;
+}
+
+static void __init parse_bpi_flags(void)
+{
+	if (efi_bp->flags & BPI_FLAGS_UEFI_SUPPORTED)
+		set_bit(EFI_BOOT, &efi.flags);
+	else
+		clear_bit(EFI_BOOT, &efi.flags);
+}
+
+static int get_bpi_version(void *signature)
+{
+	char data[8];
+	int r, version = 0;
+
+	memset(data, 0, 8);
+	memcpy(data, signature + 4, 4);
+	r = kstrtoint(data, 10, &version);
+
+	if (r < 0 || version < BPI_VERSION_V1)
+		panic("Fatal error, invalid BPI version: %d\n", version);
+
+	if (version >= BPI_VERSION_V2)
+		parse_bpi_flags();
+
+	return version;
+}
+
+void __init fw_init_environ(void)
+{
+	efi_bp = (struct bootparamsinterface *)_fw_envp;
+	loongson_sysconf.bpi_ver = get_bpi_version(&efi_bp->signature);
+
+	register_addrs_set(smp_group, TO_UNCAC(0x1fe01000), 16);
+	register_addrs_set(loongson_chipcfg, TO_UNCAC(0x1fe00180), 16);
+	register_addrs_set(loongson_chiptemp, TO_UNCAC(0x1fe0019c), 16);
+	register_addrs_set(loongson_freqctrl, TO_UNCAC(0x1fe001d0), 16);
+
+	if (list_find(efi_bp->extlist))
+		pr_warn("Scan bootparam failed\n");
+}
+
+static int __init init_cpu_fullname(void)
+{
+	int cpu;
+
+	if (loongson_sysconf.cpuname && !strncmp(loongson_sysconf.cpuname, "Loongson", 8)) {
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
+			__cpu_full_name[cpu] = loongson_sysconf.cpuname;
+	}
+	return 0;
+}
+arch_initcall(init_cpu_fullname);
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
new file mode 100644
index 000000000000..53e02fb0559d
--- /dev/null
+++ b/arch/loongarch/kernel/head.S
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/threads.h>
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+#include <asm/loongarch.h>
+#include <asm/stackframe.h>
+
+SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
+
+	__REF
+
+SYM_CODE_START(kernel_entry)			# kernel entry point
+
+	/* We might not get launched at the address the kernel is linked to,
+	   so we jump there.  */
+	la.abs		t0, 0f
+	jirl		zero, t0, 0
+0:
+	la		t0, __bss_start		# clear .bss
+	st.d		zero, t0, 0
+	la		t1, __bss_stop - LONGSIZE
+1:
+	addi.d		t0, t0, LONGSIZE
+	st.d		zero, t0, 0
+	bne		t0, t1, 1b
+
+	la		t0, fw_arg0
+	st.d		a0, t0, 0		# firmware arguments
+	la		t0, fw_arg1
+	st.d		a1, t0, 0
+	la		t0, fw_arg2
+	st.d		a2, t0, 0
+	la		t0, fw_arg3
+	st.d		a3, t0, 0
+
+	/* Config direct window and set PG */
+	li.d		t0, CSR_DMW0_INIT	# UC, PLV0, 0x8000 xxxx xxxx xxxx
+	csrwr		t0, LOONGARCH_CSR_DMWIN0
+	li.d		t0, CSR_DMW1_INIT	# CA, PLV0, 0x9000 xxxx xxxx xxxx
+	csrwr		t0, LOONGARCH_CSR_DMWIN1
+	/* Enable PG */
+	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
+	csrwr		t0, LOONGARCH_CSR_CRMD
+	li.w		t0, 0x04		# PLV=0, PIE=1, PWE=0
+	csrwr		t0, LOONGARCH_CSR_PRMD
+	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
+	csrwr		t0, LOONGARCH_CSR_EUEN
+
+	/* KScratch3 used for percpu base, initialized as 0 */
+	csrwr		zero, PERCPU_BASE_KS
+	/* GPR21 used for percpu base (runtime), initialized as 0 */
+	or		x0, zero, zero
+
+	la		tp, init_thread_union
+	/* Set the SP after an empty pt_regs.  */
+	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_ADDU	sp, sp, tp
+	set_saved_sp	sp, t0, t1
+	PTR_ADDIU	sp, sp, -4 * SZREG	# init stack pointer
+
+	bl		start_kernel
+
+SYM_CODE_END(kernel_entry)
+
+SYM_ENTRY(kernel_entry_end, SYM_L_GLOBAL, SYM_A_NONE)
diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
new file mode 100644
index 000000000000..0e548b36af6a
--- /dev/null
+++ b/arch/loongarch/kernel/mem.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+
+#include <asm/bootinfo.h>
+#include <asm/loongson.h>
+#include <asm/sections.h>
+
+void __init early_memblock_init(void)
+{
+	int i;
+	u32 mem_type;
+	u64 mem_start, mem_end, mem_size;
+
+	/* parse memory information */
+	for (i = 0; i < loongson_mem_map->map_count; i++) {
+		mem_type = loongson_mem_map->map[i].mem_type;
+		mem_start = loongson_mem_map->map[i].mem_start;
+		mem_size = loongson_mem_map->map[i].mem_size;
+		mem_end = mem_start + mem_size;
+
+		switch (mem_type) {
+		case ADDRESS_TYPE_SYSRAM:
+			memblock_add(mem_start, mem_size);
+			if (max_low_pfn < (mem_end >> PAGE_SHIFT))
+				max_low_pfn = mem_end >> PAGE_SHIFT;
+			break;
+		}
+	}
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+}
+
+void __init fw_init_memory(void)
+{
+	int i;
+	u32 mem_type;
+	u64 mem_start, mem_end, mem_size;
+	unsigned long start_pfn, end_pfn;
+	static unsigned long num_physpages;
+
+	/* parse memory information */
+	for (i = 0; i < loongson_mem_map->map_count; i++) {
+		mem_type = loongson_mem_map->map[i].mem_type;
+		mem_start = loongson_mem_map->map[i].mem_start;
+		mem_size = loongson_mem_map->map[i].mem_size;
+		mem_end = mem_start + mem_size;
+
+		switch (mem_type) {
+		case ADDRESS_TYPE_SYSRAM:
+			mem_start = PFN_ALIGN(mem_start);
+			mem_end = PFN_ALIGN(mem_end - PAGE_SIZE + 1);
+			num_physpages += (mem_size >> PAGE_SHIFT);
+			memblock_add(loongson_mem_map->map[i].mem_start,
+				     loongson_mem_map->map[i].mem_size);
+			memblock_set_node(mem_start, mem_size, &memblock.memory, 0);
+			break;
+		case ADDRESS_TYPE_ACPI:
+		case ADDRESS_TYPE_RESERVED:
+			memblock_reserve(loongson_mem_map->map[i].mem_start,
+					 loongson_mem_map->map[i].mem_size);
+			break;
+		}
+	}
+
+	get_pfn_range_for_nid(0, &start_pfn, &end_pfn);
+	pr_info("start_pfn=0x%lx, end_pfn=0x%lx, num_physpages:0x%lx\n",
+				start_pfn, end_pfn, num_physpages);
+
+	NODE_DATA(0)->node_start_pfn = start_pfn;
+	NODE_DATA(0)->node_spanned_pages = end_pfn - start_pfn;
+
+	/* used by finalize_initrd() */
+	max_low_pfn = end_pfn;
+
+	/* Reserve the first 2MB */
+	memblock_reserve(PHYS_OFFSET, 0x200000);
+
+	/* Reserve the kernel text/data/bss */
+	memblock_reserve(__pa_symbol(&_text),
+			 __pa_symbol(&_end) - __pa_symbol(&_text));
+}
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
new file mode 100644
index 000000000000..b140c2aa2c5a
--- /dev/null
+++ b/arch/loongarch/kernel/reset.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <linux/export.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+#include <linux/reboot.h>
+#include <linux/delay.h>
+#include <linux/console.h>
+
+#include <acpi/reboot.h>
+#include <asm/compiler.h>
+#include <asm/idle.h>
+#include <asm/loongarch.h>
+#include <asm/reboot.h>
+
+static void default_halt(void)
+{
+	local_irq_disable();
+	clear_csr_ecfg(ECFG0_IM);
+
+	pr_notice("\n\n** You can safely turn off the power now **\n\n");
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
+	while (true) {
+		__arch_cpu_idle();
+	}
+}
+
+static void default_poweroff(void)
+{
+#ifdef CONFIG_EFI
+	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
+#endif
+	while (true) {
+		__arch_cpu_idle();
+	}
+}
+
+static void default_restart(void)
+{
+#ifdef CONFIG_EFI
+	if (efi_capsule_pending(NULL))
+		efi_reboot(REBOOT_WARM, NULL);
+	else
+		efi_reboot(REBOOT_COLD, NULL);
+#endif
+	if (!acpi_disabled)
+		acpi_reboot();
+
+	while (true) {
+		__arch_cpu_idle();
+	}
+}
+
+void (*pm_restart)(void);
+EXPORT_SYMBOL(pm_restart);
+
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_halt(void)
+{
+	default_halt();
+}
+
+void machine_power_off(void)
+{
+	pm_power_off();
+}
+
+void machine_restart(char *command)
+{
+	do_kernel_restart(command);
+	pm_restart();
+}
+
+static int __init loongarch_reboot_setup(void)
+{
+	pm_restart = default_restart;
+	pm_power_off = default_poweroff;
+
+	return 0;
+}
+
+arch_initcall(loongarch_reboot_setup);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
new file mode 100644
index 000000000000..7ec32959b36c
--- /dev/null
+++ b/arch/loongarch/kernel/setup.c
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 1995 Linus Torvalds
+ * Copyright (C) 1995 Waldorf Electronics
+ * Copyright (C) 1994, 95, 96, 97, 98, 99, 2000, 01, 02, 03  Ralf Baechle
+ * Copyright (C) 1996 Stoned Elipot
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2000, 2001, 2002, 2007	 Maciej W. Rozycki
+ */
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/efi.h>
+#include <linux/export.h>
+#include <linux/screen_info.h>
+#include <linux/memblock.h>
+#include <linux/initrd.h>
+#include <linux/ioport.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+#include <linux/pfn.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/device.h>
+#include <linux/dma-map-ops.h>
+#include <linux/swiotlb.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/cache.h>
+#include <asm/cpu.h>
+#include <asm/dma.h>
+#include <asm/efi.h>
+#include <asm/fw.h>
+#include <asm/loongson.h>
+#include <asm/pgalloc.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/time.h>
+
+#define SMBIOS_BIOSSIZE_OFFSET		0x09
+#define SMBIOS_BIOSEXTERN_OFFSET	0x13
+#define SMBIOS_FREQLOW_OFFSET		0x16
+#define SMBIOS_FREQHIGH_OFFSET		0x17
+#define SMBIOS_FREQLOW_MASK		0xFF
+#define SMBIOS_CORE_PACKAGE_OFFSET	0x23
+#define LOONGSON_EFI_ENABLE		(1 << 3)
+
+#ifdef CONFIG_VT
+struct screen_info screen_info;
+#endif
+
+DEFINE_PER_CPU(unsigned long, kernelsp);
+unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
+
+EXPORT_SYMBOL(cpu_data);
+
+struct loongson_board_info b_info;
+static const char dmi_empty_string[] = "        ";
+
+/*
+ * Setup information
+ *
+ * These are initialized so they are in the .data section
+ */
+
+char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
+
+static struct resource code_resource = { .name = "Kernel code", };
+static struct resource data_resource = { .name = "Kernel data", };
+static struct resource bss_resource = { .name = "Kernel bss", };
+
+const char *get_system_type(void)
+{
+	return "generic-loongson-machine";
+}
+
+static const char *dmi_string_parse(const struct dmi_header *dm, u8 s)
+{
+	const u8 *bp = ((u8 *) dm) + dm->length;
+
+	if (s) {
+		s--;
+		while (s > 0 && *bp) {
+			bp += strlen(bp) + 1;
+			s--;
+		}
+
+		if (*bp != 0) {
+			size_t len = strlen(bp)+1;
+			size_t cmp_len = len > 8 ? 8 : len;
+
+			if (!memcmp(bp, dmi_empty_string, cmp_len))
+				return dmi_empty_string;
+
+			return bp;
+		}
+	}
+
+	return "";
+}
+
+static void __init parse_cpu_table(const struct dmi_header *dm)
+{
+	long freq_temp = 0;
+	char *dmi_data = (char *)dm;
+
+	freq_temp = ((*(dmi_data + SMBIOS_FREQHIGH_OFFSET) << 8) +
+			((*(dmi_data + SMBIOS_FREQLOW_OFFSET)) & SMBIOS_FREQLOW_MASK));
+	cpu_clock_freq = freq_temp * 1000000;
+
+	loongson_sysconf.cpuname = (void *)dmi_string_parse(dm, dmi_data[16]);
+	loongson_sysconf.cores_per_package = *(dmi_data + SMBIOS_CORE_PACKAGE_OFFSET);
+
+	pr_info("CpuClock = %llu\n", cpu_clock_freq);
+}
+
+static void __init parse_bios_table(const struct dmi_header *dm)
+{
+	int bios_extern;
+	char *dmi_data = (char *)dm;
+
+	bios_extern = *(dmi_data + SMBIOS_BIOSEXTERN_OFFSET);
+	b_info.bios_size = *(dmi_data + SMBIOS_BIOSSIZE_OFFSET);
+
+	if (bios_extern & LOONGSON_EFI_ENABLE)
+		set_bit(EFI_BOOT, &efi.flags);
+	else
+		clear_bit(EFI_BOOT, &efi.flags);
+}
+
+static void __init find_tokens(const struct dmi_header *dm, void *dummy)
+{
+	switch (dm->type) {
+	case 0x0: /* Extern BIOS */
+		parse_bios_table(dm);
+		break;
+	case 0x4: /* Calling interface */
+		parse_cpu_table(dm);
+		break;
+	}
+}
+static void __init smbios_parse(void)
+{
+	b_info.bios_vendor = (void *)dmi_get_system_info(DMI_BIOS_VENDOR);
+	b_info.bios_version = (void *)dmi_get_system_info(DMI_BIOS_VERSION);
+	b_info.bios_release_date = (void *)dmi_get_system_info(DMI_BIOS_DATE);
+	b_info.board_vendor = (void *)dmi_get_system_info(DMI_BOARD_VENDOR);
+	b_info.board_name = (void *)dmi_get_system_info(DMI_BOARD_NAME);
+	dmi_walk(find_tokens, NULL);
+}
+
+/*
+ * Manage initrd
+ */
+#ifdef CONFIG_BLK_DEV_INITRD
+
+static unsigned long __init init_initrd(void)
+{
+	if (!phys_initrd_start || !phys_initrd_size)
+		goto disable;
+
+	initrd_start = (unsigned long)phys_to_virt(phys_initrd_start);
+	initrd_end   = (unsigned long)phys_to_virt(phys_initrd_start + phys_initrd_size);
+
+	if (!initrd_start || initrd_end <= initrd_start)
+		goto disable;
+
+	if (initrd_start & ~PAGE_MASK) {
+		pr_err("initrd start must be page aligned\n");
+		goto disable;
+	}
+	if (initrd_start < PAGE_OFFSET) {
+		pr_err("initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
+	ROOT_DEV = Root_RAM0;
+
+	return 0;
+disable:
+	initrd_start = 0;
+	initrd_end = 0;
+	return 0;
+}
+
+static void __init finalize_initrd(void)
+{
+	unsigned long size = initrd_end - initrd_start;
+
+	if (size == 0) {
+		pr_info("Initrd not found or empty");
+		goto disable;
+	}
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		pr_err("Initrd extends beyond end of memory");
+		goto disable;
+	}
+
+
+	memblock_reserve(__pa(initrd_start), size);
+	initrd_below_start_ok = 1;
+
+	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
+		initrd_start, size);
+	return;
+disable:
+	pr_cont(" - disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
+#else  /* !CONFIG_BLK_DEV_INITRD */
+
+static unsigned long __init init_initrd(void)
+{
+	return 0;
+}
+
+#define finalize_initrd()	do {} while (0)
+
+#endif
+
+static int usermem __initdata;
+
+static int __init early_parse_mem(char *p)
+{
+	phys_addr_t start, size;
+
+	/*
+	 * If a user specifies memory size, we
+	 * blow away any automatically generated
+	 * size.
+	 */
+	if (usermem == 0) {
+		usermem = 1;
+		memblock_remove(memblock_start_of_DRAM(),
+			memblock_end_of_DRAM() - memblock_start_of_DRAM());
+	}
+	start = 0;
+	size = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
+
+	memblock_add(start, size);
+
+	return 0;
+}
+early_param("mem", early_parse_mem);
+
+static int __init early_parse_memmap(char *p)
+{
+	char *oldp;
+	u64 start_at, mem_size;
+
+	if (!p)
+		return -EINVAL;
+
+	if (!strncmp(p, "exactmap", 8)) {
+		pr_err("\"memmap=exactmap\" invalid on LoongArch\n");
+		return 0;
+	}
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
+
+	if (*p == '@') {
+		start_at = memparse(p+1, &p);
+		memblock_add(start_at, mem_size);
+	} else if (*p == '#') {
+		pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on LoongArch\n");
+		return -EINVAL;
+	} else if (*p == '$') {
+		start_at = memparse(p+1, &p);
+		memblock_add(start_at, mem_size);
+		memblock_reserve(start_at, mem_size);
+	} else {
+		pr_err("\"memmap\" invalid format!\n");
+		return -EINVAL;
+	}
+
+	if (*p == '\0') {
+		usermem = 1;
+		return 0;
+	} else
+		return -EINVAL;
+}
+early_param("memmap", early_parse_memmap);
+
+static void __init check_kernel_sections_mem(void)
+{
+	phys_addr_t start = __pa_symbol(&_text);
+	phys_addr_t size = __pa_symbol(&_end) - start;
+
+	if (!memblock_is_region_memory(start, size)) {
+		pr_info("Kernel sections are not in the memory maps\n");
+		memblock_add(start, size);
+	}
+}
+
+static void __init bootcmdline_append(const char *s, size_t max)
+{
+	if (!s[0] || !max)
+		return;
+
+	if (boot_command_line[0])
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+
+	strlcat(boot_command_line, s, max);
+}
+
+static void __init bootcmdline_init(char **cmdline_p)
+{
+	boot_command_line[0] = 0;
+
+	/*
+	 * Take arguments from the bootloader at first. Early code should have
+	 * filled arcs_cmdline with arguments from the bootloader.
+	 */
+	bootcmdline_append(arcs_cmdline, COMMAND_LINE_SIZE);
+
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+
+	parse_early_param();
+}
+
+/*
+ * arch_mem_init - initialize memory management subsystem
+ */
+static void __init arch_mem_init(char **cmdline_p)
+{
+	if (usermem)
+		pr_info("User-defined physical RAM map overwrite\n");
+
+	check_kernel_sections_mem();
+
+	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
+	pagetable_init();
+
+	/*
+	 * Prevent memblock from allocating high memory.
+	 * This cannot be done before max_low_pfn is detected, so up
+	 * to this point is possible to only reserve physical memory
+	 * with memblock_reserve; memblock_alloc* can be used
+	 * only after this point
+	 */
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+
+	/*
+	 * In order to reduce the possibility of kernel panic when failed to
+	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
+	 * low memory as small as possible before plat_swiotlb_setup(), so
+	 * make sparse_init() using top-down allocation.
+	 */
+	memblock_set_bottom_up(false);
+	sparse_init();
+	memblock_set_bottom_up(true);
+
+	swiotlb_init(1);
+
+	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+
+	memblock_dump_all();
+
+	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
+}
+
+static void __init resource_init(void)
+{
+	u64 i;
+	phys_addr_t start, end;
+
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext) - 1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata) - 1;
+	bss_resource.start = __pa_symbol(&__bss_start);
+	bss_resource.end = __pa_symbol(&__bss_stop) - 1;
+
+	for_each_mem_range(i, &start, &end) {
+		struct resource *res;
+
+		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
+		if (!res)
+			panic("%s: Failed to allocate %zu bytes\n", __func__,
+			      sizeof(struct resource));
+
+		res->start = start;
+		/*
+		 * In memblock, end points to the first byte after the
+		 * range while in resourses, end points to the last byte in
+		 * the range.
+		 */
+		res->end = end - 1;
+		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+		res->name = "System RAM";
+
+		request_resource(&iomem_resource, res);
+
+		/*
+		 *  We don't know which RAM region contains kernel data,
+		 *  so we try it repeatedly and let the resource manager
+		 *  test it.
+		 */
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+		request_resource(res, &bss_resource);
+	}
+}
+
+void __init platform_init(void)
+{
+	efi_init();
+#ifdef CONFIG_ACPI_TABLE_UPGRADE
+	acpi_table_upgrade();
+#endif
+#ifdef CONFIG_ACPI
+	acpi_gbl_use_default_register_widths = false;
+	acpi_boot_table_init();
+	acpi_boot_init();
+#endif
+
+	fw_init_memory();
+	dmi_setup();
+	smbios_parse();
+	pr_info("The BIOS Version: %s\n", b_info.bios_version);
+
+	efi_runtime_init();
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	cpu_probe();
+
+	fw_init_cmdline();
+	fw_init_environ();
+	early_memblock_init();
+	bootcmdline_init(cmdline_p);
+
+	init_initrd();
+	platform_init();
+	finalize_initrd();
+
+	arch_mem_init(cmdline_p);
+
+	resource_init();
+
+	paging_init();
+}
+
+static int __init register_gop_device(void)
+{
+	void *pd;
+
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return 0;
+	pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
+			&screen_info, sizeof(screen_info));
+	return PTR_ERR_OR_ZERO(pd);
+}
+subsys_initcall(register_gop_device);
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
new file mode 100644
index 000000000000..2e00802a3742
--- /dev/null
+++ b/arch/loongarch/kernel/time.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common time service routines for LoongArch machines.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/sched_clock.h>
+#include <linux/spinlock.h>
+
+#include <asm/cpu-features.h>
+#include <asm/loongarch.h>
+#include <asm/time.h>
+
+u64 cpu_clock_freq;
+EXPORT_SYMBOL(cpu_clock_freq);
+u64 const_clock_freq;
+EXPORT_SYMBOL(const_clock_freq);
+
+static DEFINE_RAW_SPINLOCK(state_lock);
+static DEFINE_PER_CPU(struct clock_event_device, constant_clockevent_device);
+
+static void constant_event_handler(struct clock_event_device *dev)
+{
+}
+
+irqreturn_t constant_timer_interrupt(int irq, void *data)
+{
+	int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+
+	/* Clear Timer Interrupt */
+	write_csr_tintclear(CSR_TINTCLR_TI);
+	cd = &per_cpu(constant_clockevent_device, cpu);
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static int constant_set_state_oneshot(struct clock_event_device *evt)
+{
+	unsigned long timer_config;
+
+	raw_spin_lock(&state_lock);
+
+	timer_config = csr_readq(LOONGARCH_CSR_TCFG);
+	timer_config |= CSR_TCFG_EN;
+	timer_config &= ~CSR_TCFG_PERIOD;
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	raw_spin_unlock(&state_lock);
+
+	return 0;
+}
+
+static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
+{
+	unsigned long timer_config;
+
+	raw_spin_lock(&state_lock);
+
+	timer_config = csr_readq(LOONGARCH_CSR_TCFG);
+	timer_config &= ~CSR_TCFG_EN;
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	raw_spin_unlock(&state_lock);
+
+	return 0;
+}
+
+static int constant_set_state_periodic(struct clock_event_device *evt)
+{
+	unsigned long period;
+	unsigned long timer_config;
+
+	raw_spin_lock(&state_lock);
+
+	period = const_clock_freq / HZ;
+	timer_config = period & CSR_TCFG_VAL;
+	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	raw_spin_unlock(&state_lock);
+
+	return 0;
+}
+
+static int constant_set_state_shutdown(struct clock_event_device *evt)
+{
+	return 0;
+}
+
+static int constant_timer_next_event(unsigned long delta, struct clock_event_device *evt)
+{
+	unsigned long timer_config;
+
+	delta &= CSR_TCFG_VAL;
+	timer_config = delta | CSR_TCFG_EN;
+	csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
+
+	return 0;
+}
+
+static unsigned long __init get_loops_per_jiffy(void)
+{
+	unsigned long lpj = (unsigned long)const_clock_freq;
+
+	do_div(lpj, HZ);
+
+	return lpj;
+}
+
+static long init_timeval;
+
+void sync_counter(void)
+{
+	/* Ensure counter begin at 0 */
+	csr_writeq(-init_timeval, LOONGARCH_CSR_CNTC);
+}
+
+int constant_clockevent_init(void)
+{
+	unsigned int irq;
+	unsigned int cpu = smp_processor_id();
+	unsigned long min_delta = 0x600;
+	unsigned long max_delta = (1UL << 48) - 1;
+	struct clock_event_device *cd;
+	static int timer_irq_installed = 0;
+
+	irq = get_timer_irq();
+
+	cd = &per_cpu(constant_clockevent_device, cpu);
+
+	cd->name = "Constant";
+	cd->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_PERCPU;
+
+	cd->irq = irq;
+	cd->rating = 320;
+	cd->cpumask = cpumask_of(cpu);
+	cd->set_state_oneshot = constant_set_state_oneshot;
+	cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
+	cd->set_state_periodic = constant_set_state_periodic;
+	cd->set_state_shutdown = constant_set_state_shutdown;
+	cd->set_next_event = constant_timer_next_event;
+	cd->event_handler = constant_event_handler;
+
+	clockevents_config_and_register(cd, const_clock_freq, min_delta, max_delta);
+
+	if (timer_irq_installed)
+		return 0;
+
+	timer_irq_installed = 1;
+
+	sync_counter();
+
+	if (request_irq(irq, constant_timer_interrupt, IRQF_PERCPU | IRQF_TIMER, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", irq);
+
+	lpj_fine = get_loops_per_jiffy();
+	pr_info("Constant clock event device register\n");
+
+	return 0;
+}
+
+static u64 read_const_counter(struct clocksource *clk)
+{
+	return drdtime();
+}
+
+static struct clocksource clocksource_const = {
+	.name = "Constant",
+	.rating = 400,
+	.read = read_const_counter,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.mult = 0,
+	.shift = 10,
+};
+
+unsigned long long notrace sched_clock(void)
+{
+	/* 64-bit arithmetic can overflow, so use 128-bit. */
+	u64 t1, t2, t3;
+	unsigned long long rv;
+	u64 mult = clocksource_const.mult;
+	u64 shift = clocksource_const.shift;
+	u64 cnt = read_const_counter(NULL);
+
+	__asm__ (
+		"nor		%[t1], $r0, %[shift]	\n\t"
+		"mulh.du	%[t2], %[cnt], %[mult]	\n\t"
+		"mul.d		%[t3], %[cnt], %[mult]	\n\t"
+		"slli.d		%[t2], %[t2], 1		\n\t"
+		"srl.d		%[rv], %[t3], %[shift]	\n\t"
+		"sll.d		%[t1], %[t2], %[t1]	\n\t"
+		"or		%[rv], %[t1], %[rv]	\n\t"
+		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
+		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
+		: );
+
+	return rv;
+}
+
+int __init constant_clocksource_init(void)
+{
+	int res;
+	unsigned long freq;
+
+	freq = const_clock_freq;
+
+	clocksource_const.mult =
+		clocksource_hz2mult(freq, clocksource_const.shift);
+
+	res = clocksource_register_hz(&clocksource_const, freq);
+
+	pr_info("Constant clock source device register\n");
+
+	return res;
+}
+
+void __init time_init(void)
+{
+	if (!cpu_has_cpucfg)
+		const_clock_freq = cpu_clock_freq;
+	else
+		const_clock_freq = calc_const_freq();
+
+	init_timeval = drdtime() - csr_readq(LOONGARCH_CSR_CNTC);
+
+	constant_clockevent_init();
+	constant_clocksource_init();
+}
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
new file mode 100644
index 000000000000..3b2cbb95875b
--- /dev/null
+++ b/arch/loongarch/kernel/topology.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+
+static struct cpu cpu_device;
+
+static int __init topology_init(void)
+{
+	return register_cpu(&cpu_device, 0);
+}
+
+subsys_initcall(topology_init);
-- 
2.27.0

