Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44421526D9
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgBEHa4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:30:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35804 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEHa4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:30:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so536676pgk.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7r3Fmz9uH6eUoLXG/+dpk0ne5HgRyoo2jAEaQ9QR82s=;
        b=jgCJFaY4U9EmLa+9t/khJcxe1WsF58rwBREVQg6a1hJESIBgc66V/+G+lbiJhPMoPi
         zkFf0cAT4gCgzuITf2Y+F0v7b2Fb+Ljvfm8Q5/P+sALOA4bVaVr7FP3FvdnsKV8Th22c
         0tp9g8NKoxmeSS2nQ8FkPCD3HKNvO5MvPJZkv3ruAXKWod3OWyRsMPaRuZisa3ZnGto+
         2wJ2l8mMSQjdxv8ffGsALWqqdJ3Ltb0A+1BzL8P48jdIFVLMj1VImC5HFggbxVd4C765
         Rv6ssYlQVpz6ubNCYSyoGYjeG+4C3gU7kpfNtQ2EMMJPTnRNlv/lOr6ZItvrz4enWpVj
         6byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7r3Fmz9uH6eUoLXG/+dpk0ne5HgRyoo2jAEaQ9QR82s=;
        b=AEQAOYgbysbSRNgiJn/TsXkhN57+QoiSYETke2RgzzB0CRw+77aM4k4K/DQYVGdAS4
         zQOcKxMuH3h34r1i9955cV7YIvNFCK3PDDim6HGnabABz0ce7GGaAHhqyQNn18JjhdxK
         A6S1fTAmdWsm7Oi4jLfY3N76mbJkZ3sysHWS5FU+D2g0o9CFXxQ2vOaOwCx5JeeDRAZ2
         5nTWznD8hsLEQMKF2zvnUtO8HQQI+g/htu6IeX9qH6ei14Dcx3Af9vY5uhCe2hDkSPIy
         b7OgppUIcesIjQaXnUqKqkxkC5fCj92Ak3bUo/RpiFRH7QDlGOZh2mYukcJgBY1oIium
         l2BQ==
X-Gm-Message-State: APjAAAXKPL1vMh4TXyghHp4YF7SLonXgSOKDc7ys+DYoDfqoQARvadhZ
        BOEEcIIZx2UsgmQbtoINOmI=
X-Google-Smtp-Source: APXvYqyQnQv2lE7sKrPlpt90J8DoG+ELNam6IruuXRm8+xqKcjU++B7MXJ7xM7jg7EcC6KsAbRZo+w==
X-Received: by 2002:aa7:9546:: with SMTP id w6mr34700921pfq.66.1580887855374;
        Tue, 04 Feb 2020 23:30:55 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id fh24sm6035924pjb.24.2020.02.04.23.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:30:54 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 659BA202572FCD; Wed,  5 Feb 2020 16:30:53 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Levente Kurusa <levex@linux.com>,
        Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 05/26] um lkl: memory handling
Date:   Wed,  5 Feb 2020 16:30:14 +0900
Message-Id: <8b4b2ed333ba55c7e20c680d7daff27fed2192fd.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

LKL is a non MMU architecture and hence there is not much work left to
do other than initializing the boot allocator and providing the page
and page table definitions.

The backstore memory is allocated via a host operation and the memory
size to be used is specified when the kernel is started, in the
lkl_start_kernel call.

Cc: H.K. Jerry Chu <hkchu@google.com>
Cc: Levente Kurusa <levex@linux.com>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/page.h          | 14 ++++++
 arch/um/lkl/include/asm/pgtable.h       | 57 +++++++++++++++++++++
 arch/um/lkl/include/uapi/asm/host_ops.h |  5 ++
 arch/um/lkl/mm/bootmem.c                | 66 +++++++++++++++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/page.h
 create mode 100644 arch/um/lkl/include/asm/pgtable.h
 create mode 100644 arch/um/lkl/mm/bootmem.c

diff --git a/arch/um/lkl/include/asm/page.h b/arch/um/lkl/include/asm/page.h
new file mode 100644
index 000000000000..e77f3da22031
--- /dev/null
+++ b/arch/um/lkl/include/asm/page.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_PAGE_H
+#define _ASM_LKL_PAGE_H
+
+#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
+
+#ifndef __ASSEMBLY__
+void free_mem(void);
+void bootmem_init(unsigned long mem_size);
+#endif
+
+#include <asm-generic/page.h>
+
+#endif /* _ASM_LKL_PAGE_H */
diff --git a/arch/um/lkl/include/asm/pgtable.h b/arch/um/lkl/include/asm/pgtable.h
new file mode 100644
index 000000000000..733beb6d53f6
--- /dev/null
+++ b/arch/um/lkl/include/asm/pgtable.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_PGTABLE_H
+#define _LKL_PGTABLE_H
+
+#include <asm-generic/pgtable-nopud.h>
+
+/*
+ * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>
+ */
+
+#include <linux/slab.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+
+#define pgd_present(pgd)	(1)
+#define pgd_none(pgd)		(0)
+#define pgd_bad(pgd)		(0)
+#define pgd_clear(pgdp)
+#define kern_addr_valid(addr)	(1)
+#define	pmd_offset(a, b)	((void *)0)
+
+#define PAGE_NONE		__pgprot(0)
+#define PAGE_SHARED		__pgprot(0)
+#define PAGE_COPY		__pgprot(0)
+#define PAGE_READONLY		__pgprot(0)
+#define PAGE_KERNEL		__pgprot(0)
+
+void paging_init(void);
+#define swapper_pg_dir		((pgd_t *)0)
+
+#define __swp_type(x)		(0)
+#define __swp_offset(x)		(0)
+#define __swp_entry(typ, off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern void *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
+
+/*
+ * All 32bit addresses are effectively valid for vmalloc...
+ * Sort of meaningless for non-VM targets.
+ */
+#define	VMALLOC_START		0
+#define	VMALLOC_END		0xffffffff
+#define	KMAP_START		0
+#define	KMAP_END		0xffffffff
+
+#include <asm-generic/pgtable.h>
+
+#define check_pgt_cache()	do { } while (0)
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 7cfb0a93e6a6..6bbc94c120be 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -17,8 +17,13 @@ struct lkl_jmp_buf {
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
diff --git a/arch/um/lkl/mm/bootmem.c b/arch/um/lkl/mm/bootmem.c
new file mode 100644
index 000000000000..39dd0d22b44e
--- /dev/null
+++ b/arch/um/lkl/mm/bootmem.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+
+unsigned long memory_start, memory_end;
+static unsigned long _memory_start, mem_size;
+
+void *empty_zero_page;
+
+void __init bootmem_init(unsigned long mem_sz)
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
+		memory_start + mem_size);
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
+		zones_size[ZONE_NORMAL] = (mem_size) >> PAGE_SHIFT;
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
-- 
2.21.0 (Apple Git-122.2)

