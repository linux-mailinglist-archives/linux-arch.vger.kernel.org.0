Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C927A3BC53E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFEWs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEWs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:22:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B9C561416;
        Tue,  6 Jul 2021 04:20:07 +0000 (UTC)
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
Subject: [PATCH 14/19] LoongArch: Add 64-bit Loongson platform
Date:   Tue,  6 Jul 2021 12:18:15 +0800
Message-Id: <20210706041820.1536502-15-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, LoongArch has two types of processors: 32-bit Loongson and
64-bit Loongson. This patch adds the 64-bit Loongson platform support,
including platform-specific init, setup, irq and reset code.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../include/asm/mach-loongson64/boot_param.h  |  91 ++++++++++
 .../include/asm/mach-loongson64/irq.h         |  77 ++++++++
 .../include/asm/mach-loongson64/loongson.h    | 167 +++++++++++++++++
 arch/loongarch/loongson64/boardinfo.c         |  36 ++++
 arch/loongarch/loongson64/env.c               | 170 ++++++++++++++++++
 arch/loongarch/loongson64/init.c              | 138 ++++++++++++++
 arch/loongarch/loongson64/irq.c               |  84 +++++++++
 arch/loongarch/loongson64/mem.c               |  87 +++++++++
 arch/loongarch/loongson64/msi.c               |  41 +++++
 arch/loongarch/loongson64/reset.c             |  54 ++++++
 arch/loongarch/loongson64/rtc.c               |  36 ++++
 arch/loongarch/loongson64/setup.c             |  37 ++++
 12 files changed, 1018 insertions(+)
 create mode 100644 arch/loongarch/include/asm/mach-loongson64/boot_param.h
 create mode 100644 arch/loongarch/include/asm/mach-loongson64/irq.h
 create mode 100644 arch/loongarch/include/asm/mach-loongson64/loongson.h
 create mode 100644 arch/loongarch/loongson64/boardinfo.c
 create mode 100644 arch/loongarch/loongson64/env.c
 create mode 100644 arch/loongarch/loongson64/init.c
 create mode 100644 arch/loongarch/loongson64/irq.c
 create mode 100644 arch/loongarch/loongson64/mem.c
 create mode 100644 arch/loongarch/loongson64/msi.c
 create mode 100644 arch/loongarch/loongson64/reset.c
 create mode 100644 arch/loongarch/loongson64/rtc.c
 create mode 100644 arch/loongarch/loongson64/setup.c

diff --git a/arch/loongarch/include/asm/mach-loongson64/boot_param.h b/arch/loongarch/include/asm/mach-loongson64/boot_param.h
new file mode 100644
index 000000000000..0598cc7c8203
--- /dev/null
+++ b/arch/loongarch/include/asm/mach-loongson64/boot_param.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MACH_LOONGSON64_BOOT_PARAM_H_
+#define __ASM_MACH_LOONGSON64_BOOT_PARAM_H_
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
+	int nr_pch_pics;
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
diff --git a/arch/loongarch/include/asm/mach-loongson64/irq.h b/arch/loongarch/include/asm/mach-loongson64/irq.h
new file mode 100644
index 000000000000..9e03a960e7b6
--- /dev/null
+++ b/arch/loongarch/include/asm/mach-loongson64/irq.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MACH_LOONGSON64_IRQ_H_
+#define __ASM_MACH_LOONGSON64_IRQ_H_
+
+#define NR_IRQS	(64 + 256)
+
+#define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
+#define LOONGSON_CPU_THSENS_VEC		14 /* CPU Thsens */
+#define LOONGSON_CPU_HT0_VEC		16 /* CPU HT0 irq vector base number */
+#define LOONGSON_CPU_HT1_VEC		24 /* CPU HT1 irq vector base number */
+
+/* IRQ number definitions */
+#define LOONGSON_LPC_IRQ_BASE		0
+#define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
+
+#define LOONGSON_CPU_IRQ_BASE		16
+#define LOONGSON_LINTC_IRQ		(LOONGSON_CPU_IRQ_BASE + 2) /* IP2 for CPU local interrupt controller */
+#define LOONGSON_BRIDGE_IRQ		(LOONGSON_CPU_IRQ_BASE + 3) /* IP3 for bridge */
+#define LOONGSON_TIMER_IRQ		(LOONGSON_CPU_IRQ_BASE + 11) /* IP11 CPU Timer */
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
+
+#define LOONGSON_PCH_IRQ_BASE		64
+#define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
+#define LOONGSON_PCH_LAST_IRQ		(LOONGSON_PCH_IRQ_BASE + 64 - 1)
+
+#define LOONGSON_MSI_IRQ_BASE		(LOONGSON_PCH_IRQ_BASE + 64)
+#define LOONGSON_MSI_LAST_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
+
+#define GSI_MIN_CPU_IRQ		LOONGSON_CPU_IRQ_BASE
+#define GSI_MAX_CPU_IRQ		(LOONGSON_CPU_IRQ_BASE + 48 - 1)
+#define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
+#define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
+
+#define MAX_PCH_PICS 4
+
+extern int find_pch_pic(u32 gsi);
+
+static inline void eiointc_enable(void)
+{
+	uint64_t misc;
+
+	misc = iocsr_readq(LOONGARCH_IOCSR_MISC_FUNC);
+	misc |= IOCSR_MISC_FUNC_EXT_IOI_EN;
+	iocsr_writeq(misc, LOONGARCH_IOCSR_MISC_FUNC);
+}
+
+struct acpi_madt_lio_pic;
+struct acpi_madt_eio_pic;
+struct acpi_madt_ht_pic;
+struct acpi_madt_bio_pic;
+struct acpi_madt_msi_pic;
+struct acpi_madt_lpc_pic;
+
+struct fwnode_handle *liointc_acpi_init(struct acpi_madt_lio_pic *acpi_liointc);
+struct fwnode_handle *eiointc_acpi_init(struct acpi_madt_eio_pic *acpi_eiointc);
+
+struct fwnode_handle *htvec_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_ht_pic *acpi_htvec);
+struct fwnode_handle *pch_lpc_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc);
+struct fwnode_handle *pch_msi_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+struct fwnode_handle *pch_pic_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic);
+
+extern struct acpi_madt_lio_pic *acpi_liointc;
+extern struct acpi_madt_eio_pic *acpi_eiointc;
+extern struct acpi_madt_ht_pic *acpi_htintc;
+extern struct acpi_madt_lpc_pic *acpi_pchlpc;
+extern struct acpi_madt_msi_pic *acpi_pchmsi;
+extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_PCH_PICS];
+
+extern struct fwnode_handle *acpi_liointc_handle;
+extern struct fwnode_handle *acpi_msidomain_handle;
+extern struct fwnode_handle *acpi_picdomain_handle[MAX_PCH_PICS];
+
+#endif /* __ASM_MACH_LOONGSON64_IRQ_H_ */
diff --git a/arch/loongarch/include/asm/mach-loongson64/loongson.h b/arch/loongarch/include/asm/mach-loongson64/loongson.h
new file mode 100644
index 000000000000..f003fa204185
--- /dev/null
+++ b/arch/loongarch/include/asm/mach-loongson64/loongson.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_MACH_LOONGSON64_LOONGSON_H
+#define __ASM_MACH_LOONGSON64_LOONGSON_H
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <asm/addrspace.h>
+
+#include <boot_param.h>
+
+extern const struct plat_smp_ops loongson3_smp_ops;
+
+/* loongson-specific command line, env and memory initialization */
+extern void __init fw_init_environ(void);
+extern void __init fw_init_memory(void);
+extern void __init fw_init_numa_memory(void);
+
+#define LOONGSON_REG(x) \
+	(*(volatile u32 *)((char *)TO_UNCAC(LOONGSON_REG_BASE) + (x)))
+
+#define LOONGSON_LIO_BASE	0x18000000
+#define LOONGSON_LIO_SIZE	0x00100000	/* 1M */
+#define LOONGSON_LIO_TOP	(LOONGSON_LIO_BASE+LOONGSON_LIO_SIZE-1)
+
+#define LOONGSON_BOOT_BASE	0x1c000000
+#define LOONGSON_BOOT_SIZE	0x02000000	/* 32M */
+#define LOONGSON_BOOT_TOP	(LOONGSON_BOOT_BASE+LOONGSON_BOOT_SIZE-1)
+
+#define LOONGSON_REG_BASE	0x1fe00000
+#define LOONGSON_REG_SIZE	0x00100000	/* 1M */
+#define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
+
+/* GPIO Regs - r/w */
+
+#define LOONGSON_GPIODATA		LOONGSON_REG(0x11c)
+#define LOONGSON_GPIOIE			LOONGSON_REG(0x120)
+#define LOONGSON_REG_GPIO_BASE          (LOONGSON_REG_BASE + 0x11c)
+
+#define MAX_PACKAGES 16
+
+/* Chip Config registor of each physical cpu package */
+extern u64 loongson_chipcfg[MAX_PACKAGES];
+#define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
+
+/* Chip Temperature registor of each physical cpu package */
+extern u64 loongson_chiptemp[MAX_PACKAGES];
+#define LOONGSON_CHIPTEMP(id) (*(volatile u32 *)(loongson_chiptemp[id]))
+
+/* Freq Control register of each physical cpu package */
+extern u64 loongson_freqctrl[MAX_PACKAGES];
+#define LOONGSON_FREQCTRL(id) (*(volatile u32 *)(loongson_freqctrl[id]))
+
+#define xconf_readl(addr) readl(addr)
+#define xconf_readq(addr) readq(addr)
+
+static inline void xconf_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile (
+	"	st.w	%[v], %[hw], 0	\n"
+	"	ld.b	$r0, %[hw], 0	\n"
+	:
+	: [hw] "r" (addr), [v] "r" (val)
+	);
+}
+
+static inline void xconf_writeq(u64 val64, volatile void __iomem *addr)
+{
+	asm volatile (
+	"	st.d	%[v], %[hw], 0	\n"
+	"	ld.b	$r0, %[hw], 0	\n"
+	:
+	: [hw] "r" (addr),  [v] "r" (val64)
+	);
+}
+
+/* ============== LS7A registers =============== */
+#define LS7A_PCH_REG_BASE		0x10000000UL
+/* LPC regs */
+#define LS7A_LPC_REG_BASE		(LS7A_PCH_REG_BASE + 0x00002000)
+/* CHIPCFG regs */
+#define LS7A_CHIPCFG_REG_BASE		(LS7A_PCH_REG_BASE + 0x00010000)
+/* MISC reg base */
+#define LS7A_MISC_REG_BASE		(LS7A_PCH_REG_BASE + 0x00080000)
+/* ACPI regs */
+#define LS7A_ACPI_REG_BASE		(LS7A_MISC_REG_BASE + 0x00050000)
+/* RTC regs */
+#define LS7A_RTC_REG_BASE		(LS7A_MISC_REG_BASE + 0x00050100)
+
+#define LS7A_DMA_CFG			(void *)TO_UNCAC(LS7A_CHIPCFG_REG_BASE + 0x041c)
+#define LS7A_DMA_NODE_SHF		8
+#define LS7A_DMA_NODE_MASK		0x1F00
+
+#define LS7A_INT_MASK_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x020)
+#define LS7A_INT_EDGE_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x060)
+#define LS7A_INT_CLEAR_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x080)
+#define LS7A_INT_HTMSI_EN_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x040)
+#define LS7A_INT_ROUTE_ENTRY_REG	(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x100)
+#define LS7A_INT_HTMSI_VEC_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x200)
+#define LS7A_INT_STATUS_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x3a0)
+#define LS7A_INT_POL_REG		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x3e0)
+#define LS7A_LPC_INT_CTL		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2000)
+#define LS7A_LPC_INT_ENA		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2004)
+#define LS7A_LPC_INT_STS		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2008)
+#define LS7A_LPC_INT_CLR		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x200c)
+#define LS7A_LPC_INT_POL		(void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2010)
+
+#define LS7A_PMCON_SOC_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x000)
+#define LS7A_PMCON_RESUME_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x004)
+#define LS7A_PMCON_RTC_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x008)
+#define LS7A_PM1_EVT_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x00c)
+#define LS7A_PM1_ENA_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x010)
+#define LS7A_PM1_CNT_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x014)
+#define LS7A_PM1_TMR_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x018)
+#define LS7A_P_CNT_REG			(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x01c)
+#define LS7A_GPE0_STS_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x028)
+#define LS7A_GPE0_ENA_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x02c)
+#define LS7A_RST_CNT_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x030)
+#define LS7A_WD_SET_REG			(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x034)
+#define LS7A_WD_TIMER_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x038)
+#define LS7A_THSENS_CNT_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x04c)
+#define LS7A_GEN_RTC_1_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x050)
+#define LS7A_GEN_RTC_2_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x054)
+#define LS7A_DPM_CFG_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x400)
+#define LS7A_DPM_STS_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x404)
+#define LS7A_DPM_CNT_REG		(void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x408)
+
+typedef enum {
+	ACPI_PCI_HOTPLUG_STATUS	= 1 << 1,
+	ACPI_CPU_HOTPLUG_STATUS	= 1 << 2,
+	ACPI_MEM_HOTPLUG_STATUS	= 1 << 3,
+	ACPI_POWERBUTTON_STATUS	= 1 << 8,
+	ACPI_RTC_WAKE_STATUS	= 1 << 10,
+	ACPI_PCI_WAKE_STATUS	= 1 << 14,
+	ACPI_ANY_WAKE_STATUS	= 1 << 15,
+} AcpiEventStatusBits;
+
+#define HT1LO_OFFSET		0xe0000000000UL
+
+/* PCI Configuration Space Base */
+#define HT1LO_PCICFG_BASE	0xefdfe000000UL
+#define HT1LO_PCICFG_BASE_TP1	0xefdff000000UL
+
+#define MCFG_EXT_PCICFG_BASE		0xefe00000000UL
+#define HT1LO_EXT_PCICFG_BASE		(((struct pci_controller *)(bus)->sysdata)->mcfg_addr)
+#define HT1LO_EXT_PCICFG_BASE_TP1	(HT1LO_EXT_PCICFG_BASE + 0x10000000)
+
+/* REG ACCESS*/
+#define ls7a_readb(addr)			  (*(volatile unsigned char  *)TO_UNCAC(addr))
+#define ls7a_readw(addr)			  (*(volatile unsigned short *)TO_UNCAC(addr))
+#define ls7a_readl(addr)			  (*(volatile unsigned int   *)TO_UNCAC(addr))
+#define ls7a_readq(addr)			  (*(volatile unsigned long  *)TO_UNCAC(addr))
+#define ls7a_writeb(val, addr)		*(volatile unsigned char  *)TO_UNCAC(addr) = (val)
+#define ls7a_writew(val, addr)		*(volatile unsigned short *)TO_UNCAC(addr) = (val)
+#define ls7a_writel(val, addr)		ls7a_write_type(val, addr, uint32_t)
+#define ls7a_writeq(val, addr)		ls7a_write_type(val, addr, uint64_t)
+#define ls7a_write(val, addr)		ls7a_write_type(val, addr, uint64_t)
+
+extern struct pci_ops ls7a_pci_ops;
+
+#endif /* __ASM_MACH_LOONGSON64_LOONGSON_H */
diff --git a/arch/loongarch/loongson64/boardinfo.c b/arch/loongarch/loongson64/boardinfo.c
new file mode 100644
index 000000000000..67ffba105ebd
--- /dev/null
+++ b/arch/loongarch/loongson64/boardinfo.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+
+#include <boot_param.h>
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
+		"Family\t\t\t: LOONGSON3\n\n",
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
+	return sysfs_create_file(efi_kobj, &boardinfo_attr.attr);
+}
+late_initcall(boardinfo_init);
diff --git a/arch/loongarch/loongson64/env.c b/arch/loongarch/loongson64/env.c
new file mode 100644
index 000000000000..e6752ddbefc2
--- /dev/null
+++ b/arch/loongarch/loongson64/env.c
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
+#include <loongson.h>
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
+u8 ext_listhdr_checksum(u8 *buffer, u32 length)
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
+int parse_mem(struct _extention_list_hdr *head)
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
+int parse_vbios(struct _extention_list_hdr *head)
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
+	r = kstrtoint(data, 0, &version);
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
diff --git a/arch/loongarch/loongson64/init.c b/arch/loongarch/loongson64/init.c
new file mode 100644
index 000000000000..3fedebbbf665
--- /dev/null
+++ b/arch/loongarch/loongson64/init.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/efi.h>
+#include <linux/memblock.h>
+#include <asm/acpi.h>
+#include <asm/bootinfo.h>
+#include <asm/cacheflush.h>
+#include <asm/efi.h>
+#include <asm/fw.h>
+#include <asm/time.h>
+
+#include <loongson.h>
+
+#define SMBIOS_BIOSSIZE_OFFSET		0x09
+#define SMBIOS_BIOSEXTERN_OFFSET	0x13
+#define SMBIOS_FREQLOW_OFFSET		0x16
+#define SMBIOS_FREQHIGH_OFFSET		0x17
+#define SMBIOS_FREQLOW_MASK		0xFF
+#define SMBIOS_CORE_PACKAGE_OFFSET	0x23
+#define LOONGSON_EFI_ENABLE		(1 << 3)
+
+struct loongson_board_info b_info;
+static const char dmi_empty_string[] = "        ";
+
+const char *dmi_string_parse(const struct dmi_header *dm, u8 s)
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
+
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
+
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
+void __init early_init(void)
+{
+	fw_init_cmdline();
+	fw_init_environ();
+	early_memblock_init();
+}
+
+void __init platform_init(void)
+{
+	/* init base address of io space */
+	set_io_port_base((unsigned long)
+		ioremap(LOONGSON_LIO_BASE, LOONGSON_LIO_SIZE));
+
+	efi_init();
+#ifdef CONFIG_ACPI_TABLE_UPGRADE
+	acpi_table_upgrade();
+#endif
+#ifdef CONFIG_ACPI
+	acpi_gbl_use_default_register_widths = false;
+	acpi_boot_table_init();
+	acpi_boot_init();
+#endif
+	loongarch_pci_ops = &ls7a_pci_ops;
+
+	fw_init_memory();
+	dmi_setup();
+	smbios_parse();
+	pr_info("The BIOS Version: %s\n", b_info.bios_version);
+
+	efi_runtime_init();
+}
diff --git a/arch/loongarch/loongson64/irq.c b/arch/loongarch/loongson64/irq.c
new file mode 100644
index 000000000000..aabe457570ce
--- /dev/null
+++ b/arch/loongarch/loongson64/irq.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <asm/irq.h>
+#include <asm/setup.h>
+#include <asm/loongarchregs.h>
+#include <loongson.h>
+
+struct acpi_madt_lio_pic *acpi_liointc;
+struct acpi_madt_eio_pic *acpi_eiointc;
+struct acpi_madt_ht_pic *acpi_htintc;
+struct acpi_madt_lpc_pic *acpi_pchlpc;
+struct acpi_madt_msi_pic *acpi_pchmsi;
+struct acpi_madt_bio_pic *acpi_pchpic[MAX_PCH_PICS];
+
+struct fwnode_handle *acpi_liointc_handle;
+struct fwnode_handle *acpi_msidomain_handle;
+struct fwnode_handle *acpi_picdomain_handle[MAX_PCH_PICS];
+
+int find_pch_pic(u32 gsi)
+{
+	int i, start, end;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i = 0; i < loongson_sysconf.nr_pch_pics; i++) {
+		struct acpi_madt_bio_pic *irq_cfg = acpi_pchpic[i];
+
+		start = irq_cfg->gsi_base;
+		end   = irq_cfg->gsi_base + irq_cfg->size;
+		if (gsi >= start && gsi < end)
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
+
+void __init setup_IRQ(void)
+{
+	int i;
+	struct fwnode_handle *pch_parent_handle;
+
+	if (!acpi_eiointc)
+		cpu_data[0].options &= ~LOONGARCH_CPU_EXTIOI;
+
+	loongarch_cpu_irq_init(NULL, NULL);
+	acpi_liointc_handle = liointc_acpi_init(acpi_liointc);
+
+	if (cpu_has_extioi) {
+		pr_info("Using EIOINTC interrupt mode\n");
+		pch_parent_handle = eiointc_acpi_init(acpi_eiointc);
+	} else {
+		pr_info("Using HTVECINTC interrupt mode\n");
+		pch_parent_handle = htvec_acpi_init(acpi_liointc_handle, acpi_htintc);
+	}
+
+	for (i = 0; i < loongson_sysconf.nr_pch_pics; i++)
+		acpi_picdomain_handle[i] = pch_pic_acpi_init(pch_parent_handle, acpi_pchpic[i]);
+
+	acpi_msidomain_handle = pch_msi_acpi_init(pch_parent_handle, acpi_pchmsi);
+	irq_set_default_host(irq_find_matching_fwnode(acpi_picdomain_handle[0], DOMAIN_BUS_ANY));
+
+	pch_lpc_acpi_init(acpi_picdomain_handle[0], acpi_pchlpc);
+}
+
+void __init arch_init_irq(void)
+{
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	setup_IRQ();
+
+	set_csr_ecfg(ECFGF_IP0 | ECFGF_IP1 | ECFGF_IPI | ECFGF_PC);
+}
diff --git a/arch/loongarch/loongson64/mem.c b/arch/loongarch/loongson64/mem.c
new file mode 100644
index 000000000000..2e0b60642326
--- /dev/null
+++ b/arch/loongarch/loongson64/mem.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+
+#include <asm/bootinfo.h>
+#include <asm/sections.h>
+
+#include <loongson.h>
+#include <boot_param.h>
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
diff --git a/arch/loongarch/loongson64/msi.c b/arch/loongarch/loongson64/msi.c
new file mode 100644
index 000000000000..26b7a59cba85
--- /dev/null
+++ b/arch/loongarch/loongson64/msi.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+
+static bool msix_enable = 1;
+core_param(msix, msix_enable, bool, 0664);
+
+int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct irq_domain *msi_domain;
+
+	if (!pci_msi_enabled())
+		return -ENOSPC;
+
+	if (type == PCI_CAP_ID_MSIX && !msix_enable)
+		return -ENOSPC;
+
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
+	msi_domain = irq_find_matching_fwnode(acpi_msidomain_handle, DOMAIN_BUS_PCI_MSI);
+	if (!msi_domain)
+		return -ENOSPC;
+
+	return msi_domain_alloc_irqs(msi_domain, &dev->dev, nvec);
+
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	struct irq_domain *msi_domain;
+
+	msi_domain = irq_find_matching_fwnode(acpi_msidomain_handle, DOMAIN_BUS_PCI_MSI);
+	if (msi_domain)
+		irq_domain_free_irqs(irq, 1);
+}
diff --git a/arch/loongarch/loongson64/reset.c b/arch/loongarch/loongson64/reset.c
new file mode 100644
index 000000000000..0ca20679a0a7
--- /dev/null
+++ b/arch/loongarch/loongson64/reset.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen, chenhuacai@loongson.cn
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <acpi/reboot.h>
+#include <asm/bootinfo.h>
+#include <asm/delay.h>
+#include <asm/idle.h>
+#include <asm/reboot.h>
+#include <boot_param.h>
+
+static void loongson_restart(void)
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
+	while (1) {
+		__arch_cpu_idle();
+	}
+}
+
+static void loongson_poweroff(void)
+{
+#ifdef CONFIG_EFI
+	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
+#endif
+	while (1) {
+		__arch_cpu_idle();
+	}
+}
+
+static int __init loongarch_reboot_setup(void)
+{
+	pm_restart = loongson_restart;
+	pm_power_off = loongson_poweroff;
+
+	return 0;
+}
+
+arch_initcall(loongarch_reboot_setup);
diff --git a/arch/loongarch/loongson64/rtc.c b/arch/loongarch/loongson64/rtc.c
new file mode 100644
index 000000000000..645a4b40dcc0
--- /dev/null
+++ b/arch/loongarch/loongson64/rtc.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <loongson.h>
+
+#define RTC_TOYREAD0    0x2C
+#define RTC_YEAR        0x30
+
+unsigned long loongson_get_rtc_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+	unsigned int value;
+
+	value = ls7a_readl(LS7A_RTC_REG_BASE + RTC_TOYREAD0);
+	sec = (value >> 4) & 0x3f;
+	min = (value >> 10) & 0x3f;
+	hour = (value >> 16) & 0x1f;
+	day = (value >> 21) & 0x1f;
+	mon = (value >> 26) & 0x3f;
+	year = ls7a_readl(LS7A_RTC_REG_BASE + RTC_YEAR);
+
+	year = 1900 + year;
+
+	return mktime64(year, mon, day, hour, min, sec);
+}
+
+void read_persistent_clock64(struct timespec64 *ts)
+{
+	ts->tv_sec = loongson_get_rtc_time();
+	ts->tv_nsec = 0;
+}
diff --git a/arch/loongarch/loongson64/setup.c b/arch/loongarch/loongson64/setup.c
new file mode 100644
index 000000000000..941089d40c43
--- /dev/null
+++ b/arch/loongarch/loongson64/setup.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/export.h>
+#include <linux/init.h>
+#include <asm/bootinfo.h>
+
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#include <linux/platform_device.h>
+#endif
+
+#include <loongson.h>
+
+const char *get_system_type(void)
+{
+	return "generic-loongson-machine";
+}
+
+void __init plat_mem_setup(void)
+{
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
-- 
2.27.0

