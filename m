Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22C53A1C5
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351639AbiFAKDV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351690AbiFAKDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 06:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF43BBCA;
        Wed,  1 Jun 2022 03:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A1760F61;
        Wed,  1 Jun 2022 10:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C26C385B8;
        Wed,  1 Jun 2022 10:02:20 +0000 (UTC)
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>
Subject: [PATCH V12 11/24] LoongArch: Add boot and setup routines
Date:   Wed,  1 Jun 2022 17:59:52 +0800
Message-Id: <20220601100005.2989022-12-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220601100005.2989022-1-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
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

Add basic boot, setup and reset routines for LoongArch. Now, LoongArch
machines use UEFI-based firmware. The firmware passes configuration
information to the kernel via ACPI and DMI/SMBIOS.

Currently an existing interface between the kernel and the bootloader
is implemented. Kernel gets 2 values from the bootloader, passed in
registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
non-UEFI firmware, while a1 is a pointer to an FDT with systable,
memmap, cmdline and initrd information.

This interface is used by existing bootloaders for booting kernels in
raw ELF format. However, the standard UEFI boot protocol (EFISTUB) is
preferred.

ECR for adding LoongArch support in ACPI:
https://mantis.uefi.org/mantis/view.php?id=2203

ECR for adding LoongArch support in ACPI (version update):
https://mantis.uefi.org/mantis/view.php?id=2268

ECR for adding LoongArch support in UEFI:
https://mantis.uefi.org/mantis/view.php?id=2313

ACPI changes of LoongArch have been approved in the last year, but the
new version of ACPI SPEC hasn't been made public yet. And UEFI changes
of LoongArch are under review now.

Cc: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: WANG Xuerui <git@xen0n.name>
Co-developed-by: Yun Liu <liuyun@loongson.cn>
Signed-off-by: Yun Liu <liuyun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/acenv.h            |  18 +
 arch/loongarch/include/asm/acpi.h             |  38 ++
 arch/loongarch/include/asm/bootinfo.h         |  41 +++
 arch/loongarch/include/asm/dmi.h              |  24 ++
 arch/loongarch/include/asm/efi.h              |  41 +++
 arch/loongarch/include/asm/reboot.h           |  10 +
 arch/loongarch/include/asm/setup.h            |  21 ++
 arch/loongarch/kernel/acpi.c                  | 169 +++++++++
 arch/loongarch/kernel/cacheinfo.c             | 122 +++++++
 arch/loongarch/kernel/cpu-probe.c             | 292 +++++++++++++++
 arch/loongarch/kernel/efi-header.S            | 104 ++++++
 arch/loongarch/kernel/efi.c                   | 226 ++++++++++++
 arch/loongarch/kernel/env.c                   |  70 ++++
 arch/loongarch/kernel/head.S                  |  99 +++++
 arch/loongarch/kernel/image-vars.h            |  29 ++
 arch/loongarch/kernel/mem.c                   |  64 ++++
 arch/loongarch/kernel/reset.c                 |  90 +++++
 arch/loongarch/kernel/setup.c                 | 341 ++++++++++++++++++
 arch/loongarch/kernel/time.c                  | 213 +++++++++++
 arch/loongarch/kernel/topology.c              |  13 +
 drivers/firmware/efi/Kconfig                  |   2 +-
 drivers/firmware/efi/libstub/Makefile         |  10 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   2 +-
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +-
 drivers/firmware/efi/libstub/loongarch-stub.c |  88 +++++
 include/linux/efi.h                           |   1 +
 include/linux/pe.h                            |   2 +
 27 files changed, 2129 insertions(+), 3 deletions(-)
 create mode 100644 arch/loongarch/include/asm/acenv.h
 create mode 100644 arch/loongarch/include/asm/acpi.h
 create mode 100644 arch/loongarch/include/asm/bootinfo.h
 create mode 100644 arch/loongarch/include/asm/dmi.h
 create mode 100644 arch/loongarch/include/asm/efi.h
 create mode 100644 arch/loongarch/include/asm/reboot.h
 create mode 100644 arch/loongarch/include/asm/setup.h
 create mode 100644 arch/loongarch/kernel/acpi.c
 create mode 100644 arch/loongarch/kernel/cacheinfo.c
 create mode 100644 arch/loongarch/kernel/cpu-probe.c
 create mode 100644 arch/loongarch/kernel/efi-header.S
 create mode 100644 arch/loongarch/kernel/efi.c
 create mode 100644 arch/loongarch/kernel/env.c
 create mode 100644 arch/loongarch/kernel/head.S
 create mode 100644 arch/loongarch/kernel/image-vars.h
 create mode 100644 arch/loongarch/kernel/mem.c
 create mode 100644 arch/loongarch/kernel/reset.c
 create mode 100644 arch/loongarch/kernel/setup.c
 create mode 100644 arch/loongarch/kernel/time.c
 create mode 100644 arch/loongarch/kernel/topology.c
 create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c

diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/include/asm/acenv.h
new file mode 100644
index 000000000000..52f298f7293b
--- /dev/null
+++ b/arch/loongarch/include/asm/acenv.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch specific ACPICA environments and implementation
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_ACENV_H
+#define _ASM_LOONGARCH_ACENV_H
+
+/*
+ * This header is required by ACPI core, but we have nothing to fill in
+ * right now. Will be updated later when needed.
+ */
+
+#endif /* _ASM_LOONGARCH_ACENV_H */
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
new file mode 100644
index 000000000000..62044cd5b7bc
--- /dev/null
+++ b/arch/loongarch/include/asm/acpi.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+#define acpi_os_ioremap acpi_os_ioremap
+void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
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
+#define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
+
+#endif /* _ASM_LOONGARCH_ACPI_H */
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
new file mode 100644
index 000000000000..7b60f202faaf
--- /dev/null
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_BOOTINFO_H
+#define _ASM_BOOTINFO_H
+
+#include <linux/types.h>
+#include <asm/setup.h>
+
+const char *get_system_type(void);
+
+extern void init_environ(void);
+extern void memblock_init(void);
+extern void platform_init(void);
+
+struct loongson_board_info {
+	int bios_size;
+	const char *bios_vendor;
+	const char *bios_version;
+	const char *bios_release_date;
+	const char *board_name;
+	const char *board_vendor;
+};
+
+struct loongson_system_configuration {
+	int nr_cpus;
+	int nr_nodes;
+	int nr_io_pics;
+	int boot_cpu_id;
+	int cores_per_node;
+	int cores_per_package;
+	const char *cpuname;
+};
+
+extern u64 efi_system_table;
+extern unsigned long fw_arg0, fw_arg1;
+extern struct loongson_board_info b_info;
+extern struct loongson_system_configuration loongson_sysconf;
+
+#endif /* _ASM_BOOTINFO_H */
diff --git a/arch/loongarch/include/asm/dmi.h b/arch/loongarch/include/asm/dmi.h
new file mode 100644
index 000000000000..605493417753
--- /dev/null
+++ b/arch/loongarch/include/asm/dmi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_DMI_H
+#define _ASM_DMI_H
+
+#include <linux/io.h>
+#include <linux/memblock.h>
+
+#define dmi_early_remap(x, l)	dmi_remap(x, l)
+#define dmi_early_unmap(x, l)	dmi_unmap(x)
+#define dmi_alloc(l)		memblock_alloc(l, PAGE_SIZE)
+
+static inline void *dmi_remap(u64 phys_addr, unsigned long size)
+{
+	return ((void *)TO_CACHE(phys_addr));
+}
+
+static inline void dmi_unmap(void *addr)
+{
+}
+
+#endif /* _ASM_DMI_H */
diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
new file mode 100644
index 000000000000..0127d84d5e1d
--- /dev/null
+++ b/arch/loongarch/include/asm/efi.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_LOONGARCH_EFI_H
+#define _ASM_LOONGARCH_EFI_H
+
+#include <linux/efi.h>
+
+void __init efi_init(void);
+void __init efi_runtime_init(void);
+void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
+
+#define ARCH_EFI_IRQ_FLAGS_MASK  0x00000004  /* Bit 2: CSR.CRMD.IE */
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
+#define EFI_ALLOC_ALIGN		SZ_64K
+
+struct screen_info *alloc_screen_info(void);
+void free_screen_info(struct screen_info *si);
+
+static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
+{
+	return ULONG_MAX;
+}
+
+#endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/arch/loongarch/include/asm/reboot.h b/arch/loongarch/include/asm/reboot.h
new file mode 100644
index 000000000000..51151749d8f0
--- /dev/null
+++ b/arch/loongarch/include/asm/reboot.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_REBOOT_H
+#define _ASM_REBOOT_H
+
+extern void (*pm_restart)(void);
+
+#endif /* _ASM_REBOOT_H */
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
new file mode 100644
index 000000000000..6d7d2a3e23dd
--- /dev/null
+++ b/arch/loongarch/include/asm/setup.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..a644220bb426
--- /dev/null
+++ b/arch/loongarch/kernel/acpi.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * acpi.c - Architecture-Specific Low-Level ACPI Boot Support
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
+{
+	if (irqp != NULL)
+		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
+	return (*irqp >= 0) ? 0 : -EINVAL;
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
+	struct irq_fwspec fwspec;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		fwspec.fwnode = liointc_domain->fwnode;
+		fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
+		fwspec.param_count = 1;
+
+		return irq_create_fwspec_mapping(&fwspec);
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (!pch_lpc_domain)
+			return -EINVAL;
+
+		fwspec.fwnode = pch_lpc_domain->fwnode;
+		fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
+		fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
+		fwspec.param_count = 2;
+
+		return irq_create_fwspec_mapping(&fwspec);
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		if (!pch_pic_domain[0])
+			return -EINVAL;
+
+		fwspec.fwnode = pch_pic_domain[0]->fwnode;
+		fwspec.param[0] = gsi - GSI_MIN_PCH_IRQ;
+		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+		fwspec.param_count = 2;
+
+		return irq_create_fwspec_mapping(&fwspec);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
+
+void acpi_unregister_gsi(u32 gsi)
+{
+
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
+void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
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
+void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	if (!memblock_is_memory(phys))
+		return ioremap(phys, size);
+	else
+		return ioremap_cache(phys, size);
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
+static void __init acpi_process_madt(void)
+{
+	loongson_sysconf.nr_cpus = num_processors;
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
+	memblock_reserve(addr, size);
+}
diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/cacheinfo.c
new file mode 100644
index 000000000000..8c9fe29e98f0
--- /dev/null
+++ b/arch/loongarch/kernel/cacheinfo.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LoongArch cacheinfo support
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/cacheinfo.h>
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
+int init_cache_level(unsigned int cpu)
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
+static void cache_cpumap_setup(unsigned int cpu)
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
+int populate_cache_leaves(unsigned int cpu)
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
+	cache_cpumap_setup(cpu);
+	this_cpu_ci->cpu_map_populated = true;
+
+	return 0;
+}
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
new file mode 100644
index 000000000000..6c87ea36b257
--- /dev/null
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Processor capabilities determination functions.
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+	config = iocsr_read32(LOONGARCH_IOCSR_FEATURES);
+	if (config & IOCSRF_CSRIPI)
+		c->options |= LOONGARCH_CPU_CSRIPI;
+	if (config & IOCSRF_EXTIOI)
+		c->options |= LOONGARCH_CPU_EXTIOI;
+	if (config & IOCSRF_FREQSCALE)
+		c->options |= LOONGARCH_CPU_SCALEFREQ;
+	if (config & IOCSRF_FLATMODE)
+		c->options |= LOONGARCH_CPU_FLATMODE;
+	if (config & IOCSRF_EIODECODE)
+		c->options |= LOONGARCH_CPU_EIODECODE;
+	if (config & IOCSRF_VM)
+		c->options |= LOONGARCH_CPU_HYPERVISOR;
+
+	config = csr_read32(LOONGARCH_CSR_ASID);
+	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
+	asid_mask = GENMASK(config - 1, 0);
+	set_cpu_asid_mask(c, asid_mask);
+
+	config = read_csr_prcfg1();
+	c->ksave_mask = GENMASK((config & CSR_CONF1_KSNUM) - 1, 0);
+	c->ksave_mask &= ~(EXC_KSAVE_MASK | PERCPU_KSAVE_MASK | KVM_KSAVE_MASK);
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
+		pr_warn("Warning: unknown TLB type\n");
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
+	*vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
+	*cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
+
+	switch (c->processor_id & PRID_SERIES_MASK) {
+	case PRID_SERIES_LA132:
+		c->cputype = CPU_LOONGSON32;
+		set_isa(c, LOONGARCH_CPU_ISA_LA32S);
+		__cpu_family[cpu] = "Loongson-32bit";
+		pr_info("32-bit Loongson Processor probed (LA132 Core)\n");
+		break;
+	case PRID_SERIES_LA264:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("64-bit Loongson Processor probed (LA264 Core)\n");
+		break;
+	case PRID_SERIES_LA364:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("64-bit Loongson Processor probed (LA364 Core)\n");
+		break;
+	case PRID_SERIES_LA464:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("64-bit Loongson Processor probed (LA464 Core)\n");
+		break;
+	case PRID_SERIES_LA664:
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("64-bit Loongson Processor probed (LA664 Core)\n");
+		break;
+	default: /* Default to 64 bit */
+		c->cputype = CPU_LOONGSON64;
+		set_isa(c, LOONGARCH_CPU_ISA_LA64);
+		__cpu_family[cpu] = "Loongson-64bit";
+		pr_info("64-bit Loongson Processor probed (Unknown Core)\n");
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
+	 * Set a default ELF platform, cpu probe may later
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
diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
new file mode 100644
index 000000000000..1d9c735fe6d4
--- /dev/null
+++ b/arch/loongarch/kernel/efi-header.S
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/pe.h>
+#include <linux/sizes.h>
+
+	.macro	__EFI_PE_HEADER
+	.long	PE_MAGIC
+.Lcoff_header:
+#ifdef CONFIG_32BIT
+	.short	IMAGE_FILE_MACHINE_LOONGARCH32		/* Machine */
+#else
+	.short	IMAGE_FILE_MACHINE_LOONGARCH64		/* Machine */
+#endif
+	.short	.Lsection_count				/* NumberOfSections */
+	.long	0 					/* TimeDateStamp */
+	.long	0					/* PointerToSymbolTable */
+	.long	0					/* NumberOfSymbols */
+	.short	.Lsection_table - .Loptional_header	/* SizeOfOptionalHeader */
+	.short	IMAGE_FILE_DEBUG_STRIPPED | \
+		IMAGE_FILE_EXECUTABLE_IMAGE | \
+		IMAGE_FILE_LINE_NUMS_STRIPPED		/* Characteristics */
+
+.Loptional_header:
+	.short	PE_OPT_MAGIC_PE32PLUS			/* PE32+ format */
+	.byte	0x02					/* MajorLinkerVersion */
+	.byte	0x14					/* MinorLinkerVersion */
+	.long	__inittext_end - .Lefi_header_end	/* SizeOfCode */
+	.long	_end - __initdata_begin			/* SizeOfInitializedData */
+	.long	0					/* SizeOfUninitializedData */
+	.long	__efistub_efi_pe_entry - _head		/* AddressOfEntryPoint */
+	.long	.Lefi_header_end - _head		/* BaseOfCode */
+
+.Lextra_header_fields:
+	.quad	0					/* ImageBase */
+	.long	PECOFF_SEGMENT_ALIGN			/* SectionAlignment */
+	.long	PECOFF_FILE_ALIGN			/* FileAlignment */
+	.short	0					/* MajorOperatingSystemVersion */
+	.short	0					/* MinorOperatingSystemVersion */
+	.short	LINUX_EFISTUB_MAJOR_VERSION		/* MajorImageVersion */
+	.short	LINUX_EFISTUB_MINOR_VERSION		/* MinorImageVersion */
+	.short	0					/* MajorSubsystemVersion */
+	.short	0					/* MinorSubsystemVersion */
+	.long	0					/* Win32VersionValue */
+
+	.long	_end - _head				/* SizeOfImage */
+
+	/* Everything before the kernel image is considered part of the header */
+	.long	.Lefi_header_end - _head		/* SizeOfHeaders */
+	.long	0					/* CheckSum */
+	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		/* Subsystem */
+	.short	0					/* DllCharacteristics */
+	.quad	0					/* SizeOfStackReserve */
+	.quad	0					/* SizeOfStackCommit */
+	.quad	0					/* SizeOfHeapReserve */
+	.quad	0					/* SizeOfHeapCommit */
+	.long	0					/* LoaderFlags */
+	.long	(.Lsection_table - .) / 8		/* NumberOfRvaAndSizes */
+
+	.quad	0					/* ExportTable */
+	.quad	0					/* ImportTable */
+	.quad	0					/* ResourceTable */
+	.quad	0					/* ExceptionTable */
+	.quad	0					/* CertificationTable */
+	.quad	0					/* BaseRelocationTable */
+
+	/* Section table */
+.Lsection_table:
+	.ascii	".text\0\0\0"
+	.long	__inittext_end - .Lefi_header_end	/* VirtualSize */
+	.long	.Lefi_header_end - _head		/* VirtualAddress */
+	.long	__inittext_end - .Lefi_header_end	/* SizeOfRawData */
+	.long	.Lefi_header_end - _head		/* PointerToRawData */
+
+	.long	0					/* PointerToRelocations */
+	.long	0					/* PointerToLineNumbers */
+	.short	0					/* NumberOfRelocations */
+	.short	0					/* NumberOfLineNumbers */
+	.long	IMAGE_SCN_CNT_CODE | \
+		IMAGE_SCN_MEM_READ | \
+		IMAGE_SCN_MEM_EXECUTE			/* Characteristics */
+
+	.ascii	".data\0\0\0"
+	.long	_end - __initdata_begin			/* VirtualSize */
+	.long	__initdata_begin - _head		/* VirtualAddress */
+	.long	_edata - __initdata_begin		/* SizeOfRawData */
+	.long	__initdata_begin - _head		/* PointerToRawData */
+
+	.long	0					/* PointerToRelocations */
+	.long	0					/* PointerToLineNumbers */
+	.short	0					/* NumberOfRelocations */
+	.short	0					/* NumberOfLineNumbers */
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA | \
+		IMAGE_SCN_MEM_READ | \
+		IMAGE_SCN_MEM_WRITE			/* Characteristics */
+
+	.org 0x20e
+	.word kernel_version - 512 -  _head
+
+	.set	.Lsection_count, (. - .Lsection_table) / 40
+.Lefi_header_end:
+	.endm
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
new file mode 100644
index 000000000000..d36a325a990c
--- /dev/null
+++ b/arch/loongarch/kernel/efi.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * EFI initialization
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
+#include <asm/tlb.h>
+#include <asm/loongson.h>
+
+static unsigned long efi_nr_tables;
+static unsigned long efi_config_table;
+static unsigned long screen_info_table __initdata = EFI_INVALID_TABLE_ADDR;
+
+static efi_system_table_t *efi_systab;
+static efi_config_table_type_t arch_tables[] __initdata = {
+	{LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID, &screen_info_table, "SINFO"},
+	{},
+};
+
+static void __init init_screen_info(void)
+{
+	struct screen_info *si;
+
+	if (screen_info_table == EFI_INVALID_TABLE_ADDR)
+		return;
+
+	si = early_memremap_ro(screen_info_table, sizeof(*si));
+	if (!si) {
+		pr_err("Could not map screen_info config table\n");
+		return;
+	}
+	screen_info = *si;
+	early_memunmap(si, sizeof(*si));
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
+		memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+}
+
+static void __init create_tlb(u32 index, u64 vppn, u32 ps, u32 mat)
+{
+	unsigned long tlblo0, tlblo1;
+
+	write_csr_pagesize(ps);
+
+	tlblo0 = vppn | CSR_TLBLO0_V | CSR_TLBLO0_WE |
+		CSR_TLBLO0_GLOBAL | (mat << CSR_TLBLO0_CCA_SHIFT);
+	tlblo1 = tlblo0 + (1 << ps);
+
+	csr_write64(vppn, LOONGARCH_CSR_TLBEHI);
+	csr_write64(tlblo0, LOONGARCH_CSR_TLBELO0);
+	csr_write64(tlblo1, LOONGARCH_CSR_TLBELO1);
+	csr_xchg32(0, CSR_TLBIDX_EHINV, LOONGARCH_CSR_TLBIDX);
+	csr_xchg32(index, CSR_TLBIDX_IDX, LOONGARCH_CSR_TLBIDX);
+
+	tlb_write_indexed();
+}
+
+#define MTLB_ENTRY_INDEX	0x800
+
+/* Create VA == PA mapping as UEFI */
+static void __init fix_efi_mapping(void)
+{
+	unsigned int index = MTLB_ENTRY_INDEX;
+	unsigned int tlbnr = boot_cpu_data.tlbsizemtlb - 2;
+	unsigned long i, vppn;
+
+	/* Low Memory, Cached */
+	create_tlb(index++, 0x00000000, PS_128M, 1);
+	/* MMIO Registers, Uncached */
+	create_tlb(index++, 0x10000000, PS_128M, 0);
+
+	/* High Memory, Cached */
+	for (i = 0; i < tlbnr; i++) {
+		vppn = 0x80000000ULL + (i * SZ_2G);
+		create_tlb(index++, vppn, PS_1G, 1);
+	}
+}
+
+/*
+ * set_virtual_map() - create a virtual mapping for the EFI memory map and call
+ * efi_set_virtual_address_map enter virtual for runtime service
+ *
+ * This function populates the virt_addr fields of all memory region descriptors
+ * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
+ * are also copied to @runtime_map, and their total count is returned in @count.
+ */
+static int __init set_virtual_map(void)
+{
+	int count = 0;
+	unsigned int size;
+	unsigned long attr;
+	efi_status_t status;
+	efi_runtime_services_t *rt;
+	efi_set_virtual_address_map_t *svam;
+	efi_memory_desc_t *in, runtime_map[32];
+
+	size = sizeof(efi_memory_desc_t);
+
+	for_each_efi_memory_desc(in) {
+		attr = in->attribute;
+		if (!(attr & EFI_MEMORY_RUNTIME))
+			continue;
+
+		if (attr & (EFI_MEMORY_WB | EFI_MEMORY_WT))
+			in->virt_addr = TO_CACHE(in->phys_addr);
+		else
+			in->virt_addr = TO_UNCACHE(in->phys_addr);
+
+		memcpy(&runtime_map[count++], in, size);
+	}
+
+	rt = early_memremap_ro((unsigned long)efi_systab->runtime, sizeof(*rt));
+
+	/* Install the new virtual address map */
+	svam = rt->set_virtual_address_map;
+
+	fix_efi_mapping();
+
+	status = svam(size * count, size, efi.memmap.desc_version,
+			(efi_memory_desc_t *)TO_PHYS((unsigned long)runtime_map));
+
+	local_flush_tlb_all();
+	write_csr_pagesize(PS_DEFAULT_SIZE);
+
+	return 0;
+}
+
+void __init efi_runtime_init(void)
+{
+	efi_status_t status;
+
+	if (!efi_enabled(EFI_BOOT))
+		return;
+
+	if (!efi_systab->runtime)
+		return;
+
+	status = set_virtual_map();
+	if (status < 0)
+		return;
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return;
+	}
+
+	efi.runtime = (efi_runtime_services_t *)efi_systab->runtime;
+	efi.runtime_version = (unsigned int)efi.runtime->hdr.revision;
+
+	efi_native_runtime_setup();
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+}
+
+void __init efi_init(void)
+{
+	int size;
+	void *config_tables;
+
+	if (!efi_system_table)
+		return;
+
+	efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(*efi_systab));
+	if (!efi_systab) {
+		pr_err("Can't find EFI system table.\n");
+		return;
+	}
+
+	set_bit(EFI_64BIT, &efi.flags);
+	efi_nr_tables	 = efi_systab->nr_tables;
+	efi_config_table = (unsigned long)efi_systab->tables;
+
+	size = sizeof(efi_config_table_t);
+	config_tables = early_memremap(efi_config_table, efi_nr_tables * size);
+	efi_config_parse_tables(config_tables, efi_systab->nr_tables, arch_tables);
+	early_memunmap(config_tables, efi_nr_tables * size);
+
+	init_screen_info();
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
index 000000000000..bf2593f1e536
--- /dev/null
+++ b/arch/loongarch/kernel/env.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <linux/export.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+#include <asm/early_ioremap.h>
+#include <asm/bootinfo.h>
+#include <asm/loongson.h>
+
+u64 efi_system_table;
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
+void __init init_environ(void)
+{
+	int efi_boot = fw_arg0;
+	struct efi_memory_map_data data;
+	void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
+
+	if (efi_boot)
+		set_bit(EFI_BOOT, &efi.flags);
+	else
+		clear_bit(EFI_BOOT, &efi.flags);
+
+	early_init_dt_scan(fdt_ptr);
+	early_init_fdt_reserve_self();
+	efi_system_table = efi_get_fdt_params(&data);
+
+	efi_memmap_init_early(&data);
+	memblock_reserve(data.phys_map & PAGE_MASK,
+			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
+
+	register_addrs_set(smp_group, TO_UNCACHE(0x1fe01000), 16);
+	register_addrs_set(loongson_chipcfg, TO_UNCACHE(0x1fe00180), 16);
+	register_addrs_set(loongson_chiptemp, TO_UNCACHE(0x1fe0019c), 16);
+	register_addrs_set(loongson_freqctrl, TO_UNCACHE(0x1fe001d0), 16);
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
index 000000000000..4cb79e9c70f5
--- /dev/null
+++ b/arch/loongarch/kernel/head.S
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
+
+#ifdef CONFIG_EFI_STUB
+
+#include "efi-header.S"
+
+	__HEAD
+
+_head:
+	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
+	.org	0x38
+#ifdef CONFIG_32BIT
+	.ascii	"LA32"			/* Magic number for BootLoader */
+#else
+	.ascii	"LA64"			/* Magic number for BootLoader */
+#endif
+	.org	0x3c
+	.long	pe_header - _head	/* Offset to the PE header */
+
+pe_header:
+	__EFI_PE_HEADER
+
+SYM_DATA(kernel_asize, .long _end - _text);
+SYM_DATA(kernel_fsize, .long _edata - _text);
+SYM_DATA(kernel_offset, .long kernel_offset - _text);
+
+kernel_version:
+	.ascii  UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION "\0"
+
+#endif
+
+	__REF
+
+SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
+
+SYM_CODE_START(kernel_entry)			# kernel entry point
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
+
+	/* KSave3 used for percpu base, initialized as 0 */
+	csrwr		zero, PERCPU_BASE_KS
+	/* GPR21 used for percpu base (runtime), initialized as 0 */
+	or		u0, zero, zero
+
+	la		tp, init_thread_union
+	/* Set the SP after an empty pt_regs.  */
+	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_ADD		sp, sp, tp
+	set_saved_sp	sp, t0, t1
+	PTR_ADDI	sp, sp, -4 * SZREG	# init stack pointer
+
+	bl		start_kernel
+
+SYM_CODE_END(kernel_entry)
+
+SYM_ENTRY(kernel_entry_end, SYM_L_GLOBAL, SYM_A_NONE)
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
new file mode 100644
index 000000000000..104e9f0e97fe
--- /dev/null
+++ b/arch/loongarch/kernel/image-vars.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef __LOONGARCH_KERNEL_IMAGE_VARS_H
+#define __LOONGARCH_KERNEL_IMAGE_VARS_H
+
+#ifdef CONFIG_EFI_STUB
+
+__efistub_memcmp		= memcmp;
+__efistub_memchr		= memchr;
+__efistub_memcpy		= memcpy;
+__efistub_memmove		= memmove;
+__efistub_memset		= memset;
+__efistub_strcat		= strcat;
+__efistub_strcmp		= strcmp;
+__efistub_strlen		= strlen;
+__efistub_strncat		= strncat;
+__efistub_strnstr		= strnstr;
+__efistub_strnlen		= strnlen;
+__efistub_strrchr		= strrchr;
+__efistub_kernel_entry		= kernel_entry;
+__efistub_kernel_asize		= kernel_asize;
+__efistub_kernel_fsize		= kernel_fsize;
+__efistub_kernel_offset		= kernel_offset;
+
+#endif
+
+#endif /* __LOONGARCH_KERNEL_IMAGE_VARS_H */
diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
new file mode 100644
index 000000000000..7423361b0ebc
--- /dev/null
+++ b/arch/loongarch/kernel/mem.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/efi.h>
+#include <linux/initrd.h>
+#include <linux/memblock.h>
+
+#include <asm/bootinfo.h>
+#include <asm/loongson.h>
+#include <asm/sections.h>
+
+void __init memblock_init(void)
+{
+	u32 mem_type;
+	u64 mem_start, mem_end, mem_size;
+	efi_memory_desc_t *md;
+
+	/* Parse memory information */
+	for_each_efi_memory_desc(md) {
+		mem_type = md->type;
+		mem_start = md->phys_addr;
+		mem_size = md->num_pages << EFI_PAGE_SHIFT;
+		mem_end = mem_start + mem_size;
+
+		switch (mem_type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_PERSISTENT_MEMORY:
+		case EFI_CONVENTIONAL_MEMORY:
+			memblock_add(mem_start, mem_size);
+			if (max_low_pfn < (mem_end >> PAGE_SHIFT))
+				max_low_pfn = mem_end >> PAGE_SHIFT;
+			break;
+		case EFI_PAL_CODE:
+		case EFI_UNUSABLE_MEMORY:
+		case EFI_ACPI_RECLAIM_MEMORY:
+			memblock_add(mem_start, mem_size);
+			fallthrough;
+		case EFI_RESERVED_TYPE:
+		case EFI_RUNTIME_SERVICES_CODE:
+		case EFI_RUNTIME_SERVICES_DATA:
+		case EFI_MEMORY_MAPPED_IO:
+		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+			memblock_reserve(mem_start, mem_size);
+			break;
+		}
+	}
+
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
+
+	/* Reserve the first 2MB */
+	memblock_reserve(PHYS_OFFSET, 0x200000);
+
+	/* Reserve the kernel text/data/bss */
+	memblock_reserve(__pa_symbol(&_text),
+			 __pa_symbol(&_end) - __pa_symbol(&_text));
+
+	/* Reserve the initrd */
+	reserve_initrd_mem();
+}
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
new file mode 100644
index 000000000000..ef484ce43c5c
--- /dev/null
+++ b/arch/loongarch/kernel/reset.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..29f3b82cd0a5
--- /dev/null
+++ b/arch/loongarch/kernel/setup.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+unsigned long fw_arg0, fw_arg1;
+DEFINE_PER_CPU(unsigned long, kernelsp);
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
+static int num_standard_resources;
+static struct resource *standard_resources;
+
+static struct resource code_resource = { .name = "Kernel code", };
+static struct resource data_resource = { .name = "Kernel data", };
+static struct resource bss_resource  = { .name = "Kernel bss", };
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
+static int usermem __initdata;
+
+static int __init early_parse_mem(char *p)
+{
+	phys_addr_t start, size;
+
+	if (!p) {
+		pr_err("mem parameter is empty, do nothing\n");
+		return -EINVAL;
+	}
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
+	else {
+		pr_err("Invalid format!\n");
+		return -EINVAL;
+	}
+
+	memblock_add(start, size);
+
+	return 0;
+}
+early_param("mem", early_parse_mem);
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
+	dmi_setup();
+	smbios_parse();
+	pr_info("The BIOS Version: %s\n", b_info.bios_version);
+
+	efi_runtime_init();
+}
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
+	swiotlb_init(true, SWIOTLB_VERBOSE);
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
+	long i = 0;
+	size_t res_size;
+	struct resource *res;
+	struct memblock_region *region;
+
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext) - 1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata) - 1;
+	bss_resource.start = __pa_symbol(&__bss_start);
+	bss_resource.end = __pa_symbol(&__bss_stop) - 1;
+
+	num_standard_resources = memblock.memory.cnt;
+	res_size = num_standard_resources * sizeof(*standard_resources);
+	standard_resources = memblock_alloc(res_size, SMP_CACHE_BYTES);
+
+	for_each_mem_region(region) {
+		res = &standard_resources[i++];
+		if (!memblock_is_nomap(region)) {
+			res->name  = "System RAM";
+			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+			res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
+			res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
+		} else {
+			res->name  = "Reserved";
+			res->flags = IORESOURCE_MEM;
+			res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
+			res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
+		}
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
+static int __init reserve_memblock_reserved_regions(void)
+{
+	u64 i, j;
+
+	for (i = 0; i < num_standard_resources; ++i) {
+		struct resource *mem = &standard_resources[i];
+		phys_addr_t r_start, r_end, mem_size = resource_size(mem);
+
+		if (!memblock_is_region_reserved(mem->start, mem_size))
+			continue;
+
+		for_each_reserved_mem_range(j, &r_start, &r_end) {
+			resource_size_t start, end;
+
+			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
+			end = min(PFN_PHYS(PFN_UP(r_end)) - 1, mem->end);
+
+			if (start > mem->end || end < mem->start)
+				continue;
+
+			reserve_region_with_split(mem, start, end, "Reserved");
+		}
+	}
+
+	return 0;
+}
+arch_initcall(reserve_memblock_reserved_regions);
+
+void __init setup_arch(char **cmdline_p)
+{
+	cpu_probe();
+	*cmdline_p = boot_command_line;
+
+	init_environ();
+	memblock_init();
+	parse_early_param();
+
+	platform_init();
+	pagetable_init();
+	arch_mem_init(cmdline_p);
+
+	resource_init();
+
+	paging_init();
+}
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
new file mode 100644
index 000000000000..b2bb14844f01
--- /dev/null
+++ b/arch/loongarch/kernel/time.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common time service routines for LoongArch machines.
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config |= CSR_TCFG_EN;
+	timer_config &= ~CSR_TCFG_PERIOD;
+	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
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
+	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config &= ~CSR_TCFG_EN;
+	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
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
+	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
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
+	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
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
+	csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
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
+	irq = EXCCODE_TIMER - EXCCODE_INT_START;
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
+static u64 native_sched_clock(void)
+{
+	return read_const_counter(NULL);
+}
+
+static struct clocksource clocksource_const = {
+	.name = "Constant",
+	.rating = 400,
+	.read = read_const_counter,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+int __init constant_clocksource_init(void)
+{
+	int res;
+	unsigned long freq = const_clock_freq;
+
+	res = clocksource_register_hz(&clocksource_const, freq);
+
+	sched_clock_register(native_sched_clock, 64, freq);
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
+	init_timeval = drdtime() - csr_read64(LOONGARCH_CSR_CNTC);
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
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 4720ba98cec3..ba5d3d946f61 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -118,7 +118,7 @@ config EFI_GENERIC_STUB
 
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
-	depends on EFI_GENERIC_STUB && !RISCV
+	depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
 	default y
 	help
 	  Select this config option to add support for the dtb= command
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..1588c61939e7 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   $(call cc-option,-mno-single-pic-base)
 cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpic
+cflags-$(CONFIG_LOONGARCH)	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+				   -fpic
 
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
@@ -70,6 +72,8 @@ lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
 lib-$(CONFIG_RISCV)		+= riscv-stub.o
+lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
+
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 # Even when -mbranch-protection=none is set, Clang will generate a
@@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_RISCV)	:= R_RISCV_HI20
 
+# For LoongArch, keep all the symbols in .init section and make sure that no
+# absolute symbols references doesn't exist.
+STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)	+= --prefix-alloc-sections=.init \
+					   --prefix-symbols=__efistub_
+STUBCOPY_RELOC-$(CONFIG_LOONGARCH)	:= R_LARCH_MARK_LA
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3d972061c1b0..f612cfceda22 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -21,7 +21,7 @@
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
-bool efi_novamap;
+bool efi_novamap = IS_ENABLED(CONFIG_LOONGARCH); /* LoongArch call svam() in kernel */
 
 static bool efi_noinitrd;
 static bool efi_nosoftreserve;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f515394cce6e..f228fce398cc 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -40,7 +40,7 @@
 
 #ifdef CONFIG_ARM64
 # define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
-#elif defined(CONFIG_RISCV)
+#elif defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
 # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_MIN
 #else
 # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
new file mode 100644
index 000000000000..beee086d9950
--- /dev/null
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Yun Liu <liuyun@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include <asm/addrspace.h>
+#include "efistub.h"
+
+typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
+
+extern int kernel_asize;
+extern int kernel_fsize;
+extern int kernel_offset;
+extern kernel_entry_t kernel_entry;
+
+static efi_guid_t screen_info_guid = LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID;
+
+struct screen_info *alloc_screen_info(void)
+{
+	efi_status_t status;
+	struct screen_info *si;
+
+	status = efi_bs_call(allocate_pool,
+			EFI_RUNTIME_SERVICES_DATA, sizeof(*si), (void **)&si);
+	if (status != EFI_SUCCESS)
+		return NULL;
+
+	status = efi_bs_call(install_configuration_table, &screen_info_guid, si);
+	if (status == EFI_SUCCESS)
+		return si;
+
+	efi_bs_call(free_pool, si);
+
+	return NULL;
+}
+
+void free_screen_info(struct screen_info *si)
+{
+	if (!si)
+		return;
+
+	efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
+	efi_bs_call(free_pool, si);
+}
+
+efi_status_t check_platform_features(void)
+{
+	/* Config Direct Mapping */
+	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
+	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
+
+	return EFI_SUCCESS;
+}
+
+efi_status_t handle_kernel_image(unsigned long *image_addr,
+				 unsigned long *image_size,
+				 unsigned long *reserve_addr,
+				 unsigned long *reserve_size,
+				 efi_loaded_image_t *image,
+				 efi_handle_t image_handle)
+{
+	efi_status_t status;
+	unsigned long kernel_addr = 0;
+
+	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
+
+	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
+				     PHYSADDR(VMLINUX_LOAD_ADDRESS), SZ_2M, 0x0);
+
+	*image_addr = kernel_addr;
+	*image_size = kernel_asize;
+
+	return status;
+}
+
+void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt, unsigned long fdt_size)
+{
+	kernel_entry_t real_kernel_entry;
+
+	real_kernel_entry = (kernel_entry_t)
+		((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD_ADDRESS);
+
+	real_kernel_entry(true, fdt);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d9b0bb47eb3..adc43641ef8c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -401,6 +401,7 @@ void efi_native_runtime_setup(void);
  * associated with ConOut
  */
 #define LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+#define LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID	EFI_GUID(0x07fd51a6, 0x9532, 0x926f,  0x51, 0xdc, 0x6a, 0x63, 0x60, 0x2f, 0x84, 0xb4)
 #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
diff --git a/include/linux/pe.h b/include/linux/pe.h
index daf09ffffe38..1d3836ef9d92 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -65,6 +65,8 @@
 #define	IMAGE_FILE_MACHINE_SH5		0x01a8
 #define	IMAGE_FILE_MACHINE_THUMB	0x01c2
 #define	IMAGE_FILE_MACHINE_WCEMIPSV2	0x0169
+#define	IMAGE_FILE_MACHINE_LOONGARCH32	0x6232
+#define	IMAGE_FILE_MACHINE_LOONGARCH64	0x6264
 
 /* flags */
 #define IMAGE_FILE_RELOCS_STRIPPED           0x0001
-- 
2.27.0

