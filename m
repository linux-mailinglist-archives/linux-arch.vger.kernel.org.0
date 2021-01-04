Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8632E9EB5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbhADUNu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:13:50 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38518 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbhADUNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:13:50 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 43C443AF870;
        Mon,  4 Jan 2021 20:02:03 +0000 (UTC)
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 977CF40003;
        Mon,  4 Jan 2021 20:00:59 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 02/12] riscv: Protect the kernel linear mapping
Date:   Mon,  4 Jan 2021 14:58:30 -0500
Message-Id: <20210104195840.1593-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel is now mapped at the end of the address space and it should
be accessed through this mapping only: so map the whole kernel in the
linear mapping as read only.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h |  9 ++++++++-
 arch/riscv/mm/init.c          | 29 +++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 98188e315e8d..a93e35aaa717 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -102,8 +102,15 @@ extern unsigned long pfn_base;
 extern unsigned long max_low_pfn;
 extern unsigned long min_low_pfn;
 extern unsigned long kernel_virt_addr;
+extern uintptr_t load_pa, load_sz;
+
+#define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
+#define kernel_mapping_pa_to_va(x)	\
+	((void *)((unsigned long) (x) + va_kernel_pa_offset))
+#define __pa_to_va_nodebug(x)				\
+	((x >= load_pa && x < load_pa + load_sz) ?	\
+		kernel_mapping_pa_to_va(x): linear_mapping_pa_to_va(x))
 
-#define __pa_to_va_nodebug(x)	((void *)((unsigned long) (x) + va_pa_offset))
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
 #define kernel_mapping_va_to_pa(x)	\
 	((unsigned long)(x) - va_kernel_pa_offset)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9d06ff0e015a..7b87c14f1d24 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -159,8 +159,6 @@ void __init setup_bootmem(void)
 {
 	phys_addr_t mem_start = 0;
 	phys_addr_t start, end = 0;
-	phys_addr_t vmlinux_end = __pa_symbol(&_end);
-	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 	u64 i;
 
 	/* Find the memory region containing the kernel */
@@ -168,7 +166,7 @@ void __init setup_bootmem(void)
 		phys_addr_t size = end - start;
 		if (!mem_start)
 			mem_start = start;
-		if (start <= vmlinux_start && vmlinux_end <= end)
+		if (start <= load_pa && (load_pa + load_sz) <= end)
 			BUG_ON(size == 0);
 	}
 
@@ -179,8 +177,13 @@ void __init setup_bootmem(void)
 	 */
 	memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
 
-	/* Reserve from the start of the kernel to the end of the kernel */
-	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
+	/*
+	 * Reserve from the start of the kernel to the end of the kernel
+	 * and make sure we align the reservation on PMD_SIZE since we will
+	 * map the kernel in the linear mapping as read-only: we do not want
+	 * any allocation to happen between _end and the next pmd aligned page.
+	 */
+	memblock_reserve(load_pa, (load_sz + PMD_SIZE - 1) & ~(PMD_SIZE - 1));
 
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = max_pfn;
@@ -438,7 +441,9 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
 #endif
 
-static uintptr_t load_pa, load_sz;
+uintptr_t load_pa, load_sz;
+EXPORT_SYMBOL(load_pa);
+EXPORT_SYMBOL(load_sz);
 
 static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
 {
@@ -596,9 +601,17 @@ static void __init setup_vm_final(void)
 
 		map_size = best_map_size(start, end - start);
 		for (pa = start; pa < end; pa += map_size) {
-			va = (uintptr_t)__va(pa);
+			pgprot_t prot = PAGE_KERNEL;
+
+			/* Protect the kernel mapping that lies in the linear mapping */
+			if (pa >= __pa(_start) && pa < __pa(_end))
+				prot = PAGE_KERNEL_READ;
+
+			/* Make sure we get virtual addresses in the linear mapping */
+			va = (uintptr_t)linear_mapping_pa_to_va(pa);
+
 			create_pgd_mapping(swapper_pg_dir, va, pa,
-					   map_size, PAGE_KERNEL);
+					   map_size, prot);
 		}
 	}
 
-- 
2.20.1

