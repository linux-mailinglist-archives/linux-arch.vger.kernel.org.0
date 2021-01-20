Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF82FC924
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbhATDfj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbhATC30 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276FC061757
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w14so4525578pfi.2
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIN7Gxa/J+IIxjxPiZGjpCwa9+eGnguwvK3b7NUTsEQ=;
        b=f1/5X6Sf6OoRFxrJMO87IxrrQpo2f5DTwuHiiwDP+oC9+kbGaNfgQzamF8DP8q7fXh
         A/EtUdrZID9Hz2PkQV9IcAqgzO29CTSis/CITzZUEkf2NiU9pIQ1roZHDXbNaZ/pPNB7
         3v8ZqI0G+viRsw4uZTewkq0qu3Vnjrvb+IOHH5TJxoQpu+cB97MAdohnvY29D+USmBkx
         aUcyOqAqZTyKttrLpNn3tM1SDysOxfDBGL8hHJIw5iF8XjZRTe/Ue37R7NO4dWrhrGE9
         PAUWm4B0/JKxUF2sUcSgcxJ+WTav8IDUckwUKo0waWXMb43oW+ZwqDeGYKFPrhouFR0P
         MFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIN7Gxa/J+IIxjxPiZGjpCwa9+eGnguwvK3b7NUTsEQ=;
        b=fRs0t4mfHGvvV4xv0MdZOfVakfApnDHLY5lRFDivLSWdHM8i+i45mMh1OpQShZKnFQ
         QWUa+scuihSXcotOzfsk1YlRtRsf6waYW6kmBz6ZY5YmGlBw8rNecnM8q4p+vc4m4TBl
         0KjZigAzRmOK2f35FYxUTFKBTd5z5HXUTDSly7J2qp5szA8YpCb6m10Uizpqg49L8bEH
         cM5DShKJuogfhNxymflgIsqLKOd1WOOgmDmGpdO3Wqk06KKZKKbsSqGUEYEESVrxvINr
         nz/7sY+e3vH/N2hpWYecdvDFXudp2bQWN19Hle9VN8fY58wBl0WbMU027KE7eyRUpxjA
         kkUw==
X-Gm-Message-State: AOAM532DlFUbbAWhayPGvOz44cGN75lYbn0a2A+IhxnDn3TPwzhDfnDq
        C1oWebuPEvp6O3SWk+UziQU=
X-Google-Smtp-Source: ABdhPJwAlh8FYP+f5jCOpstCO3UF5icj8MY5DI7fl8k3x1NvU+XOGskupfI5z/WZniwN4stbJfuipQ==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr7091625pgl.72.1611109721012;
        Tue, 19 Jan 2021 18:28:41 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id s7sm331237pgi.69.2021.01.19.18.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:40 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 2CAEC20442D330; Wed, 20 Jan 2021 11:28:38 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 08/20] um: lkl: memory handling
Date:   Wed, 20 Jan 2021 11:27:13 +0900
Message-Id: <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

library mode follows the way !CONFIG_MMU architecture of other linux
archs.  There is not much work left to do other than initializing the
boot allocator and providing the page and page table definitions.

The backstore memory is allocated via host functions and the memory
size to be used is specified when the kernel is started, in the
lkl_start_kernel call.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/include/asm/mmu.h               |   3 +
 arch/um/include/asm/mmu_context.h       |  10 +++
 arch/um/include/asm/page.h              |  15 ++++
 arch/um/include/asm/pgtable.h           |  27 ++++++
 arch/um/include/asm/uaccess.h           |   6 ++
 arch/um/lkl/include/uapi/asm/host_ops.h |  16 ++++
 arch/um/lkl/um/bootmem.c                | 107 ++++++++++++++++++++++++
 7 files changed, 184 insertions(+)
 create mode 100644 arch/um/lkl/um/bootmem.c

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
index f8a100770691..4bf627feaa0c 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -6,6 +6,7 @@
 #ifndef __UM_MMU_CONTEXT_H
 #define __UM_MMU_CONTEXT_H
 
+#ifdef CONFIG_MMU
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
@@ -73,4 +74,13 @@ extern void destroy_context(struct mm_struct *mm);
 
 #include <asm-generic/mmu_context.h>
 
+#else
+
+#include <asm-generic/nommu_context.h>
+
+extern void force_flush_all(void);
+
+#endif /* CONFIG_MMU */
+
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
index 39376bb63abf..58638d888b95 100644
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
@@ -326,4 +328,29 @@ do {						\
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
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 5d141784541d..17219802fa1d 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -20,4 +20,20 @@ struct lkl_host_operations {
  */
 void lkl_bug(const char *fmt, ...);
 
+/**
+ * lkl_mem_alloc - allocate memory
+ *
+ * @mem: the size of memory requested
+ *
+ */
+void *lkl_mem_alloc(unsigned long mem);
+
+/**
+ * lkl_mem_free - free memory
+ *
+ * @mem: the address of memory to be freed
+ *
+ */
+void lkl_mem_free(void *mem);
+
 #endif
diff --git a/arch/um/lkl/um/bootmem.c b/arch/um/lkl/um/bootmem.c
new file mode 100644
index 000000000000..7250924a7d40
--- /dev/null
+++ b/arch/um/lkl/um/bootmem.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+
+unsigned long memory_end, memory_start;
+EXPORT_SYMBOL(memory_start);
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
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+	mem_size = mem_sz;
+
+	_memory_start = (unsigned long)lkl_mem_alloc(mem_size);
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
+	zones_size[ZONE_NORMAL] = max_low_pfn;
+	free_area_init(zones_size);
+
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
+	lkl_mem_free((void *)_memory_start);
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
+
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return -EOPNOTSUPP;
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return -EOPNOTSUPP;
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return -EOPNOTSUPP;
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return -EOPNOTSUPP;
+}
-- 
2.21.0 (Apple Git-122.2)

