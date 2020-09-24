Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBE276A5A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgIXHPI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:15:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B925C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r19so1213801pls.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9Vu5NCJNPF2O2RM9kWkruAVRja6D8FxeGaKm3ixWZA=;
        b=DFArfsPFj3BIIeVrqGnBkw5T+DqIanUQbbs2ql9tRRKVZUTATXdhbTNd9uYDV6qH+Y
         ggvyO7aZONngEzbQbWS5imltSlH6SpDb+AXsLMIygq/wIaiD6Zr8F732QvFR5be5htDU
         MaQYs+GLa+Fcc0FfN3qWKVfFwKcg9jqTMgMUvVywPzmnX0tqwmGNEnTxWe51Qlzy+T5s
         escTcovtJR6HAUeBQAH5J76Sq5bpCcnMARwVyUBoFhuC+NZSJ9p387Ac9MssXI5mOU6m
         d6IOEMj0SwnRK1T109VME9wxDGM0z1vKrF3IKY68MyXtYblsr9+mzmDVv3YEWj2xQX/6
         OgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9Vu5NCJNPF2O2RM9kWkruAVRja6D8FxeGaKm3ixWZA=;
        b=Tng6lAFs5tU3ds2c9ssJrhTee3SkYmCfZKMkcd3QRn7Fbm2KxV4WeERtCMUMcQUNZr
         NqBzXcT7jwHs0ev+gKFvG5yFiiLKW7lWbYGDnYzQaWedG81IABzutYEGgn792aTP+11p
         9+WYFatF6ew7SNy3PieO90jaRUHo3Q1GJqJTsrZVbrmbVPvJ5l2fIBqDWXlWxNEONQ1q
         7eT+fe6fEHXEMWKwngIApxCy7KyUaPNVaoSYC7yXUptGaR+4AIVNAlxAJd7dgLlqSjYW
         dITaLFoTQp5Io/rB42+jjPRzzsFEmCR6LQ1HvDb3Mb9HpbAzF57Y9U2W4+aQ6F/f4Wz/
         vvmQ==
X-Gm-Message-State: AOAM5321mMHyXPiKcjtyFtV3vORey65NdMIEeHKGa6CBgbYUdhyzZHBm
        4R0tG//PU9wqOxtM2aodeJQ=
X-Google-Smtp-Source: ABdhPJyelWoKvjgxpRkDjh6jugO1oBlNHdNcabq6LpmcFIStM/OuLhEjx77H826+WD2xbRDn7zIDvg==
X-Received: by 2002:a17:902:d711:b029:d1:c6b5:ae5f with SMTP id w17-20020a170902d711b02900d1c6b5ae5fmr3371753ply.38.1600931707414;
        Thu, 24 Sep 2020 00:15:07 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 16sm1365403pjl.27.2020.09.24.00.15.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:15:06 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id AFC5E2037C2090; Thu, 24 Sep 2020 16:15:04 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 10/21] um: nommu: memory handling
Date:   Thu, 24 Sep 2020 16:12:50 +0900
Message-Id: <ad65a74ddbae13b87d87cb8927ddfdbaa906fec6.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

nommu mode follows the way !CONFIG_MMU architecture of other linux
archs.  Ther is not much work left to do other than initializing the
boot allocator and providing the page and page table definitions.

The backstore memory is allocated via a host operation and the memory
size to be used is specified when the kernel is started, in the
lkl_start_kernel call.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/include/asm/mmu.h                 |  3 +
 arch/um/include/asm/mmu_context.h         |  8 +++
 arch/um/include/asm/page.h                | 15 ++++
 arch/um/include/asm/pgtable.h             | 27 +++++++
 arch/um/include/asm/uaccess.h             |  6 ++
 arch/um/nommu/include/uapi/asm/host_ops.h |  5 ++
 arch/um/nommu/um/bootmem.c                | 86 +++++++++++++++++++++++
 7 files changed, 150 insertions(+)
 create mode 100644 arch/um/nommu/um/bootmem.c

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 5b072aba5b65..c06d6cb67dd7 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -13,6 +13,9 @@ typedef struct mm_context {
 	struct mm_id id;
 	struct uml_arch_mm_context arch;
 	struct page *stub_pages[2];
+#ifndef CONFIG_MMU
+	unsigned long		end_brk;
+#endif
 } mm_context_t;
 
 extern void __switch_mm(struct mm_id * mm_idp);
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..4b06c29ae830 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -6,6 +6,7 @@
 #ifndef __UM_MMU_CONTEXT_H
 #define __UM_MMU_CONTEXT_H
 
+#ifdef CONFIG_MMU
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
@@ -75,4 +76,11 @@ extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
 extern void destroy_context(struct mm_struct *mm);
 
+#else
+#include <asm-generic/mmu_context.h>
+
+extern void force_flush_all(void);
+
+#endif /* CONFIG_MMU */
+
 #endif
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 95af12e82a32..c9d5e487ac6b 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -7,6 +7,8 @@
 #ifndef __UM_PAGE_H
 #define __UM_PAGE_H
 
+#ifdef CONFIG_MMU
+
 #include <linux/const.h>
 
 /* PAGE_SHIFT determines the page size */
@@ -120,4 +122,17 @@ extern unsigned long uml_physmem;
 #define __HAVE_ARCH_GATE_AREA 1
 #endif
 
+#else  /* CONFIG_MMU */
+#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
+#include <asm-generic/page.h>
+
+#define __va_space (8*1024*1024)
+
+#ifndef __ASSEMBLY__
+#include <mem.h>
+void free_mem(void);
+#endif
+
+#endif /* !CONFIG_MMU  */
+
 #endif	/* __UM_PAGE_H */
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index def376194dce..7e506d5406e3 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -21,6 +21,8 @@
 #define _PAGE_PROTNONE	0x010	/* if the user mapped it with PROT_NONE;
 				   pte_present gives true */
 
+#ifdef CONFIG_MMU
+
 #ifdef CONFIG_3_LEVEL_PGTABLES
 #include <asm/pgtable-3level.h>
 #else
@@ -323,4 +325,29 @@ do {						\
 	__flush_tlb_one((vaddr));		\
 } while (0)
 
+#else  /* CONFIG_MMU */
+
+#include <asm-generic/pgtable-nopud.h>
+
+#define swapper_pg_dir		((pgd_t *)0)
+#define PAGE_KERNEL             __pgprot(0)
+#define PGDIR_SHIFT		21
+#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+#define VMALLOC_START	0
+#define VMALLOC_END	0xffffffff
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern unsigned long *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
+
+extern unsigned long end_iomem;
+
+#endif /* !CONFIG_MMU */
+
+
 #endif
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index fe66d659acad..95db8f06d295 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -21,6 +21,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern long __strncpy_from_user(char *dst, const char __user *src, long count);
@@ -46,4 +47,9 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
 		uaccess_kernel());
 }
 
+#else
+#include <asm-generic/uaccess.h>
+#endif /* CONFIG_MMU */
+
+
 #endif
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index d3dad11b459e..5253c3f8de0e 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -16,8 +16,13 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  *
+ * @mem_alloc - allocate memory
+ * @mem_free - free memory
+ *
  */
 struct lkl_host_operations {
+	void *(*mem_alloc)(unsigned long mem);
+	void (*mem_free)(void *mem);
 };
 
 void lkl_bug(const char *fmt, ...);
diff --git a/arch/um/nommu/um/bootmem.c b/arch/um/nommu/um/bootmem.c
new file mode 100644
index 000000000000..6ae4c26e2b74
--- /dev/null
+++ b/arch/um/nommu/um/bootmem.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+
+unsigned long memory_start, memory_end;
+static unsigned long _memory_start, mem_size;
+
+unsigned long *empty_zero_page;
+
+/* XXX: unused */
+unsigned long long highmem;
+int iomem_size;
+int kmalloc_ok = 1;
+
+void __init setup_physmem(unsigned long start, unsigned long reserve_end,
+			  unsigned long mem_sz, unsigned long long _highmem)
+{
+	mem_size = mem_sz;
+
+	_memory_start = (unsigned long)lkl_ops->mem_alloc(mem_size);
+	memory_start = _memory_start;
+	WARN_ON(!memory_start);
+	memory_end = memory_start + mem_size;
+
+	if (PAGE_ALIGN(memory_start) != memory_start) {
+		mem_size -= PAGE_ALIGN(memory_start) - memory_start;
+		memory_start = PAGE_ALIGN(memory_start);
+		mem_size = (mem_size / PAGE_SIZE) * PAGE_SIZE;
+	}
+	pr_info("memblock address range: 0x%lx - 0x%lx\n", memory_start,
+		memory_start+mem_size);
+	/*
+	 * Give all the memory to the bootmap allocator, tell it to put the
+	 * boot mem_map at the start of memory.
+	 */
+	max_low_pfn = virt_to_pfn(memory_end);
+	min_low_pfn = virt_to_pfn(memory_start);
+	memblock_add(memory_start, mem_size);
+
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
+
+	{
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+		zones_size[ZONE_NORMAL] = max_low_pfn;
+		free_area_init(zones_size);
+	}
+}
+
+void __init mem_init(void)
+{
+	max_mapnr = (((unsigned long)high_memory) - PAGE_OFFSET) >> PAGE_SHIFT;
+	/* this will put all memory onto the freelists */
+	totalram_pages_add(memblock_free_all());
+	pr_info("Memory available: %luk/%luk RAM\n",
+		(nr_free_pages() << PAGE_SHIFT) >> 10, mem_size >> 10);
+}
+
+/*
+ * In our case __init memory is not part of the page allocator so there is
+ * nothing to free.
+ */
+void free_initmem(void)
+{
+}
+
+void free_mem(void)
+{
+	lkl_ops->mem_free((void *)_memory_start);
+}
+
+void *uml_kmalloc(int size, int flags)
+{
+	return kmalloc(size, flags);
+}
+
+void __init mem_total_pages(unsigned long physmem, unsigned long iomem,
+		     unsigned long _highmem)
+{
+}
+
+void __init paging_init(void)
+{
+}
-- 
2.21.0 (Apple Git-122.2)

