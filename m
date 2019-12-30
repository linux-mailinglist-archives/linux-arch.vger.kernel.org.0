Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF012CD98
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2019 09:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfL3IYG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Dec 2019 03:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3IYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:24:06 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B604520748;
        Mon, 30 Dec 2019 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694245;
        bh=U755GW1H8DWG9F8Orv9KhsgMsPEAnR8YAiD0+wGHrN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDlq3nDLBmu24T+fYxYi4ABvePYeAMIBp2fzLWRa8FDOzxnpIeJ8HMXitBWb/RO+9
         on6tcfIHGUbGl75mcZ/cnf6skNyMue+aXUZ21dEAflH53Bb2xeCVX8Lsf8mDhG1dCb
         trXdp2scv87R1xlPb4FSFDjQRUqIY/gr3FRBC/+E=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 3/5] csky: Tightly-Coupled Memory or Sram support
Date:   Mon, 30 Dec 2019 16:23:29 +0800
Message-Id: <20191230082331.30976-3-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191230082331.30976-1-guoren@kernel.org>
References: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The implementation are not only used by TCM but also used by sram on
SOC bus. It follow existed linux tcm software interface, so that old
tcm application codes could be re-used directly.

Software interface list in asm/tcm.h:
 - Variables/Const: 	__tcmdata, __tcmconst
 - Functions:		__tcmfunc, __tcmlocalfunc
 - Malloc/Free:		tcm_alloc, tcm_free

In linux menuconfig:
 - Choose a TCM contain instrctions + data or separated in ITCM/DTCM.
 - Determine TCM_BASE (DTCM_BASE) in phyiscal address.
 - Determine size of TCM or ITCM(DTCM) in page counts.

Here is hello tcm example from Documentation/arm/tcm.rst which could
be directly used:

/* Uninitialized data */
static u32 __tcmdata tcmvar;
/* Initialized data */
static u32 __tcmdata tcmassigned = 0x2BADBABEU;
/* Constant */
static const u32 __tcmconst tcmconst = 0xCAFEBABEU;

static void __tcmlocalfunc tcm_to_tcm(void)
{
	int i;
	for (i = 0; i < 100; i++)
		tcmvar ++;
}

static void __tcmfunc hello_tcm(void)
{
	/* Some abstract code that runs in ITCM */
	int i;
	for (i = 0; i < 100; i++) {
		tcmvar ++;
	}
	tcm_to_tcm();
}

static void __init test_tcm(void)
{
	u32 *tcmem;
	int i;

	hello_tcm();
	printk("Hello TCM executed from ITCM RAM\n");

	printk("TCM variable from testrun: %u @ %p\n", tcmvar, &tcmvar);
	tcmvar = 0xDEADBEEFU;
	printk("TCM variable: 0x%x @ %p\n", tcmvar, &tcmvar);

	printk("TCM assigned variable: 0x%x @ %p\n", tcmassigned, &tcmassigned);

	printk("TCM constant: 0x%x @ %p\n", tcmconst, &tcmconst);

	/* Allocate some TCM memory from the pool */
	tcmem = tcm_alloc(20);
	if (tcmem) {
		printk("TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
		tcmem[0] = 0xDEADBEEFU;
		tcmem[1] = 0x2BADBABEU;
		tcmem[2] = 0xCAFEBABEU;
		tcmem[3] = 0xDEADBEEFU;
		tcmem[4] = 0x2BADBABEU;
		for (i = 0; i < 5; i++)
			printk("TCM tcmem[%d] = %08x\n", i, tcmem[i]);
		tcm_free(tcmem, 20);
	}
}

TODO:
 - Separate fixup mapping from highmem
 - Support abiv1

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig              |  35 ++++++++
 arch/csky/include/asm/fixmap.h |   5 +-
 arch/csky/include/asm/memory.h |  22 +++++
 arch/csky/include/asm/tcm.h    |  24 +++++
 arch/csky/kernel/vmlinux.lds.S |  49 +++++++++++
 arch/csky/mm/Makefile          |   1 +
 arch/csky/mm/tcm.c             | 156 +++++++++++++++++++++++++++++++++
 7 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 arch/csky/include/asm/memory.h
 create mode 100644 arch/csky/include/asm/tcm.h
 create mode 100644 arch/csky/mm/tcm.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 285234300740..77e8e077648a 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -188,6 +188,41 @@ config CPU_PM_STOP
 	bool "stop"
 endchoice
 
+menuconfig HAVE_TCM
+	bool "Tightly-Coupled/Sram Memory"
+	depends on HIGHMEM
+	select GENERIC_ALLOCATOR
+	help
+	  The implementation are not only used by TCM (Tightly-Coupled Meory)
+	  but also used by sram on SOC bus. It follow existed linux tcm
+	  software interface, so that old tcm application codes could be
+	  re-used directly.
+
+if HAVE_TCM
+config ITCM_RAM_BASE
+	hex "ITCM ram base"
+	default 0xffffffff
+
+config ITCM_NR_PAGES
+	int "Page count of ITCM size: NR*4KB"
+	range 1 256
+	default 32
+
+config HAVE_DTCM
+	bool "DTCM Support"
+
+config DTCM_RAM_BASE
+	hex "DTCM ram base"
+	depends on HAVE_DTCM
+	default 0xffffffff
+
+config DTCM_NR_PAGES
+	int "Page count of DTCM size: NR*4KB"
+	depends on HAVE_DTCM
+	range 1 256
+	default 32
+endif
+
 config CPU_HAS_VDSP
 	bool "CPU has VDSP coprocessor"
 	depends on CPU_HAS_FPU && CPU_HAS_FPUV2
diff --git a/arch/csky/include/asm/fixmap.h b/arch/csky/include/asm/fixmap.h
index 380ff0a307df..4350578faa1c 100644
--- a/arch/csky/include/asm/fixmap.h
+++ b/arch/csky/include/asm/fixmap.h
@@ -5,12 +5,16 @@
 #define __ASM_CSKY_FIXMAP_H
 
 #include <asm/page.h>
+#include <asm/memory.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
 #endif
 
 enum fixed_addresses {
+#ifdef CONFIG_HAVE_TCM
+	FIX_TCM = TCM_NR_PAGES,
+#endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
@@ -18,7 +22,6 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
-#define FIXADDR_TOP	0xffffc000
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/csky/include/asm/memory.h b/arch/csky/include/asm/memory.h
new file mode 100644
index 000000000000..cdffbd0a500b
--- /dev/null
+++ b/arch/csky/include/asm/memory.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_MEMORY_H
+#define __ASM_CSKY_MEMORY_H
+
+#include <linux/compiler.h>
+#include <linux/const.h>
+#include <linux/types.h>
+#include <linux/sizes.h>
+
+#define FIXADDR_TOP	_AC(0xffffc000, UL)
+
+#ifdef CONFIG_HAVE_TCM
+#ifdef CONFIG_HAVE_DTCM
+#define TCM_NR_PAGES	(CONFIG_ITCM_NR_PAGES + CONFIG_DTCM_NR_PAGES)
+#else
+#define TCM_NR_PAGES	(CONFIG_ITCM_NR_PAGES)
+#endif
+#define FIXADDR_TCM	_AC(FIXADDR_TOP - (TCM_NR_PAGES * PAGE_SIZE), UL)
+#endif
+
+#endif
diff --git a/arch/csky/include/asm/tcm.h b/arch/csky/include/asm/tcm.h
new file mode 100644
index 000000000000..2b135cefb73f
--- /dev/null
+++ b/arch/csky/include/asm/tcm.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_TCM_H
+#define __ASM_CSKY_TCM_H
+
+#ifndef CONFIG_HAVE_TCM
+#error "You should not be including tcm.h unless you have a TCM!"
+#endif
+
+#include <linux/compiler.h>
+
+/* Tag variables with this */
+#define __tcmdata __section(.tcm.data)
+/* Tag constants with this */
+#define __tcmconst __section(.tcm.rodata)
+/* Tag functions inside TCM called from outside TCM with this */
+#define __tcmfunc __section(.tcm.text) noinline
+/* Tag function inside TCM called from inside TCM  with this */
+#define __tcmlocalfunc __section(.tcm.text)
+
+void *tcm_alloc(size_t len);
+void tcm_free(void *addr, size_t len);
+
+#endif
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index ae7961b973f2..d8363577c644 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -2,6 +2,7 @@
 
 #include <asm/vmlinux.lds.h>
 #include <asm/page.h>
+#include <asm/memory.h>
 
 OUTPUT_ARCH(csky)
 ENTRY(_start)
@@ -53,6 +54,54 @@ SECTIONS
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
+#ifdef CONFIG_HAVE_TCM
+	.tcm_start : {
+		. = ALIGN(PAGE_SIZE);
+		__tcm_start = .;
+	}
+
+	.text_data_tcm FIXADDR_TCM : AT(__tcm_start)
+	{
+		. = ALIGN(4);
+		__stcm_text_data = .;
+		*(.tcm.text)
+		*(.tcm.rodata)
+#ifndef CONFIG_HAVE_DTCM
+		*(.tcm.data)
+#endif
+		. = ALIGN(4);
+		__etcm_text_data = .;
+	}
+
+	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_data_tcm);
+
+#ifdef CONFIG_HAVE_DTCM
+	#define ITCM_SIZE	CONFIG_ITCM_NR_PAGES * PAGE_SIZE
+
+	.dtcm_start : {
+		__dtcm_start = .;
+	}
+
+	.data_tcm FIXADDR_TCM + ITCM_SIZE : AT(__dtcm_start)
+	{
+		. = ALIGN(4);
+		__stcm_data = .;
+		*(.tcm.data)
+		. = ALIGN(4);
+		__etcm_data = .;
+	}
+
+	. = ADDR(.dtcm_start) + SIZEOF(.data_tcm);
+
+	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_tcm)) {
+#else
+	.tcm_end : AT(ADDR(.tcm_start) + SIZEOF(.text_data_tcm)) {
+#endif
+		. = ALIGN(PAGE_SIZE);
+		__tcm_end = .;
+	}
+#endif
+
 	NOTES
 	EXCEPTION_TABLE(L1_CACHE_BYTES)
 	BSS_SECTION(L1_CACHE_BYTES, PAGE_SIZE, L1_CACHE_BYTES)
diff --git a/arch/csky/mm/Makefile b/arch/csky/mm/Makefile
index c94ef6481098..2c51918eb4fc 100644
--- a/arch/csky/mm/Makefile
+++ b/arch/csky/mm/Makefile
@@ -14,3 +14,4 @@ obj-y +=			syscache.o
 obj-y +=			tlb.o
 obj-y +=			asid.o
 obj-y +=			context.o
+obj-$(CONFIG_HAVE_TCM) +=	tcm.o
diff --git a/arch/csky/mm/tcm.c b/arch/csky/mm/tcm.c
new file mode 100644
index 000000000000..01f40443ce1a
--- /dev/null
+++ b/arch/csky/mm/tcm.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/highmem.h>
+#include <linux/genalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/fixmap.h>
+
+#if (CONFIG_ITCM_RAM_BASE == 0xffffffff)
+#error "You should define ITCM_RAM_BASE"
+#endif
+
+#ifdef CONFIG_HAVE_DTCM
+#if (CONFIG_DTCM_RAM_BASE == 0xffffffff)
+#error "You should define DTCM_RAM_BASE"
+#endif
+#endif
+
+extern char __tcm_start, __tcm_end, __dtcm_start;
+
+static struct gen_pool *tcm_pool;
+
+static void __init tcm_mapping_init(void)
+{
+	pte_t *tcm_pte;
+	unsigned long vaddr, paddr;
+	int i;
+
+	paddr = CONFIG_ITCM_RAM_BASE;
+
+#ifndef CONFIG_HAVE_DTCM
+	for (i = 0; i < TCM_NR_PAGES; i++) {
+#else
+	for (i = 0; i < CONFIG_ITCM_NR_PAGES; i++) {
+#endif
+		vaddr = __fix_to_virt(FIX_TCM - i);
+
+		tcm_pte =
+			pte_offset_kernel((pmd_t *)pgd_offset_k(vaddr), vaddr);
+
+		set_pte(tcm_pte, pfn_pte(__phys_to_pfn(paddr), PAGE_KERNEL));
+
+		flush_tlb_one(vaddr);
+
+		paddr = paddr + PAGE_SIZE;
+	}
+
+#ifdef CONFIG_HAVE_DTCM
+	paddr = CONFIG_DTCM_RAM_BASE;
+
+	for (i = 0; i < CONFIG_DTCM_NR_PAGES; i++) {
+		vaddr = __fix_to_virt(FIX_TCM - CONFIG_ITCM_NR_PAGES - i);
+
+		tcm_pte =
+			pte_offset_kernel((pmd_t *) pgd_offset_k(vaddr), vaddr);
+
+		set_pte(tcm_pte, pfn_pte(__phys_to_pfn(paddr), PAGE_KERNEL));
+
+		flush_tlb_one(vaddr);
+
+		paddr = paddr + PAGE_SIZE;
+	}
+#endif
+
+#ifndef CONFIG_HAVE_DTCM
+	memcpy((void *)__fix_to_virt(FIX_TCM),
+				&__tcm_start, &__tcm_end - &__tcm_start);
+
+	pr_info("%s: mapping tcm va:0x%08lx to pa:0x%08x\n",
+			__func__, __fix_to_virt(FIX_TCM), CONFIG_ITCM_RAM_BASE);
+
+	pr_info("%s: __tcm_start va:0x%08lx size:%d\n",
+			__func__, (unsigned long)&__tcm_start, &__tcm_end - &__tcm_start);
+#else
+	memcpy((void *)__fix_to_virt(FIX_TCM),
+				&__tcm_start, &__dtcm_start - &__tcm_start);
+
+	pr_info("%s: mapping itcm va:0x%08lx to pa:0x%08x\n",
+			__func__, __fix_to_virt(FIX_TCM), CONFIG_ITCM_RAM_BASE);
+
+	pr_info("%s: __itcm_start va:0x%08lx size:%d\n",
+			__func__, (unsigned long)&__tcm_start, &__dtcm_start - &__tcm_start);
+
+	memcpy((void *)__fix_to_virt(FIX_TCM - CONFIG_ITCM_NR_PAGES),
+				&__dtcm_start, &__tcm_end - &__dtcm_start);
+
+	pr_info("%s: mapping dtcm va:0x%08lx to pa:0x%08x\n",
+			__func__, __fix_to_virt(FIX_TCM - CONFIG_ITCM_NR_PAGES),
+						CONFIG_DTCM_RAM_BASE);
+
+	pr_info("%s: __dtcm_start va:0x%08lx size:%d\n",
+			__func__, (unsigned long)&__dtcm_start, &__tcm_end - &__dtcm_start);
+
+#endif
+}
+
+void *tcm_alloc(size_t len)
+{
+	unsigned long vaddr;
+
+	if (!tcm_pool)
+		return NULL;
+
+	vaddr = gen_pool_alloc(tcm_pool, len);
+	if (!vaddr)
+		return NULL;
+
+	return (void *) vaddr;
+}
+EXPORT_SYMBOL(tcm_alloc);
+
+void tcm_free(void *addr, size_t len)
+{
+	gen_pool_free(tcm_pool, (unsigned long) addr, len);
+}
+EXPORT_SYMBOL(tcm_free);
+
+static int __init tcm_setup_pool(void)
+{
+#ifndef CONFIG_HAVE_DTCM
+	u32 pool_size = (u32) (TCM_NR_PAGES * PAGE_SIZE)
+				- (u32) (&__tcm_end - &__tcm_start);
+
+	u32 tcm_pool_start = __fix_to_virt(FIX_TCM)
+				+ (u32) (&__tcm_end - &__tcm_start);
+#else
+	u32 pool_size = (u32) (CONFIG_DTCM_NR_PAGES * PAGE_SIZE)
+				- (u32) (&__tcm_end - &__dtcm_start);
+
+	u32 tcm_pool_start = __fix_to_virt(FIX_TCM - CONFIG_ITCM_NR_PAGES)
+				+ (u32) (&__tcm_end - &__dtcm_start);
+#endif
+	int ret;
+
+	tcm_pool = gen_pool_create(2, -1);
+
+	ret = gen_pool_add(tcm_pool, tcm_pool_start, pool_size, -1);
+	if (ret) {
+		pr_err("%s: gen_pool add failed!\n", __func__);
+		return ret;
+	}
+
+	pr_info("%s: Added %d bytes @ 0x%08x to memory pool\n",
+		__func__, pool_size, tcm_pool_start);
+
+	return 0;
+}
+
+static int __init tcm_init(void)
+{
+	tcm_mapping_init();
+
+	tcm_setup_pool();
+
+	return 0;
+}
+arch_initcall(tcm_init);
-- 
2.17.0

