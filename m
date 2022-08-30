Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD35A5DBB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH3IHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH3IHG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 04:07:06 -0400
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 01:07:04 PDT
Received: from forward101o.mail.yandex.net (forward101o.mail.yandex.net [37.140.190.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4AF564E2
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 01:07:04 -0700 (PDT)
Received: from myt6-654ec0a0ab93.qloud-c.yandex.net (myt6-654ec0a0ab93.qloud-c.yandex.net [IPv6:2a02:6b8:c12:1d80:0:640:654e:c0a0])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 8888B369F1C7;
        Tue, 30 Aug 2022 10:59:21 +0300 (MSK)
Received: by myt6-654ec0a0ab93.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ZnRIFBzOVH-xKierR5b;
        Tue, 30 Aug 2022 10:59:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=mail; t=1661846361;
        bh=suwIPIwhwykLHy7PBaeGZiwsLDJTUE38xFBbycEQO0o=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=rrkvYlci/OnWJftjNnSM38I21699Qk7tiDzftZtVciCHsMBo3e0TORgL7GwLfNFvA
         d+k5Euhh5s3gZYY6sfKqAf6voA3ckCZSsck0SsQZMBVyE920mKFw0D3LH+4aKTGJgh
         cISSC8KLAVWvVjv+IMRtC1VkoJzfpx5Q1Ul9gkL8=
Authentication-Results: myt6-654ec0a0ab93.qloud-c.yandex.net; dkim=pass header.i=@syntacore.com
From:   Vladimir Isaev <vladimir.isaev@syntacore.com>
To:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PATCH] riscv: Fix permissions for all mm's during mm init
Date:   Tue, 30 Aug 2022 10:59:00 +0300
Message-Id: <20220830075900.510105-1-vladimir.isaev@syntacore.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is possible to have more than one mm (init_mm) during memory
permission fixes. In my case it was caused by request_module
from drivers/net/phy/phy_device.c and leads to following Oops
during free_initmem() on RV32 platform:
     Unable to handle kernel paging request at virtual address c0800000
     Oops [#1]
     Modules linked in:
     CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.45
     Hardware name: Syntacore SCR5 SDK board (DT)
     epc : __memset+0x58/0xf4
      ra : free_reserved_area+0xfa/0x15a
     epc : c02b26ac ra : c00eb588 sp : c1c1fed0
      gp : c1898690 tp : c1c98000 t0 : c0800000
      t1 : ffffffff t2 : 00000000 s0 : c1c1ff20
      s1 : c189a000 a0 : c0800000 a1 : cccccccc
      a2 : 00001000 a3 : c0801000 a4 : 00000000
      a5 : 00800000 a6 : fef09000 a7 : 00000000
      s2 : c0e57000 s3 : c10edcf8 s4 : 000000cc
      s5 : ffffefff s6 : c188a9f4 s7 : 00000001
      s8 : c0800000 s9 : fef1b000 s10: c10ee000
      s11: c189a000 t3 : 00000000 t4 : 00000000
      t5 : 00000000 t6 : 00000001
     status: 00000120 badaddr: c0800000 cause: 0000000f
     [<c0488658>] free_initmem+0x204/0x222
     [<c048d05a>] kernel_init+0x32/0xfc
     [<c0002f76>] ret_from_exception+0x0/0xc
     ---[ end trace 7a5e2b002350b528 ]---

This is because request_module attempted to modprobe module, so it created
new mm with the copy of kernel's page table. And this copy won't be updated
in case of 4M pages and RV32 (pgd is the leaf).

To fix this we can update protection bits for all of existing mm-s, the same as
ARM does, see 08925c2f124f1 ('ARM: 8464/1: Update all mm structures with section adjustments').

Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 arch/riscv/include/asm/set_memory.h | 20 +++--------
 arch/riscv/kernel/setup.c           | 11 ------
 arch/riscv/mm/init.c                | 29 ++++++++++++---
 arch/riscv/mm/pageattr.c            | 55 ++++++++++++++++++++++++-----
 4 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index a2c14d4b3993..bb0f6b4ed86b 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -16,28 +16,16 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_rw_nx(unsigned long addr, int numpages);
-static __always_inline int set_kernel_memory(char *startp, char *endp,
-					     int (*set_memory)(unsigned long start,
-							       int num_pages))
-{
-	unsigned long start = (unsigned long)startp;
-	unsigned long end = (unsigned long)endp;
-	int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
-
-	return set_memory(start, num_pages);
-}
+void fix_kernel_mem_early(char *startp, char *endp, pgprot_t set_mask,
+			  pgprot_t clear_mask);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
-static inline int set_kernel_memory(char *startp, char *endp,
-				    int (*set_memory)(unsigned long start,
-						      int num_pages))
-{
-	return 0;
-}
+static inline void fix_kernel_mem_early(char *startp, char *endp,
+					pgprot_t set_mask, pgprot_t clear_mask) { }
 #endif
 
 int set_direct_map_invalid_noflush(struct page *page);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 95ef6e2bf45c..17eae1406092 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -27,7 +27,6 @@
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
-#include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
@@ -318,13 +317,3 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
-
-void free_initmem(void)
-{
-	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
-		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
-				  IS_ENABLED(CONFIG_64BIT) ?
-					set_memory_rw : set_memory_rw_nx);
-
-	free_initmem_default(POISON_FREE_INITMEM);
-}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b56a0a75533f..978202712535 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -16,7 +16,6 @@
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/libfdt.h>
-#include <linux/set_memory.h>
 #include <linux/dma-map-ops.h>
 #include <linux/crash_dump.h>
 #include <linux/hugetlb.h>
@@ -28,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/ptdump.h>
 #include <asm/numa.h>
+#include <asm/set_memory.h>
 
 #include "../kernel/head.h"
 
@@ -714,10 +714,14 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 
 void mark_rodata_ro(void)
 {
-	set_kernel_memory(__start_rodata, _data, set_memory_ro);
-	if (IS_ENABLED(CONFIG_64BIT))
-		set_kernel_memory(lm_alias(__start_rodata), lm_alias(_data),
-				  set_memory_ro);
+	pgprot_t set_mask = __pgprot(_PAGE_READ);
+	pgprot_t clear_mask = __pgprot(_PAGE_WRITE);
+
+	fix_kernel_mem_early(__start_rodata, _data, set_mask, clear_mask);
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		fix_kernel_mem_early(lm_alias(__start_rodata), lm_alias(_data),
+				     set_mask, clear_mask);
+	}
 
 	debug_checkwx();
 }
@@ -1243,3 +1247,18 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return vmemmap_populate_basepages(start, end, node, NULL);
 }
 #endif
+
+void free_initmem(void)
+{
+	pgprot_t set_mask = __pgprot(_PAGE_READ | _PAGE_WRITE);
+	pgprot_t clear_mask = IS_ENABLED(CONFIG_64BIT) ?
+			      __pgprot(0) : __pgprot(_PAGE_EXEC);
+
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
+		fix_kernel_mem_early(lm_alias(__init_begin),
+				     lm_alias(__init_end),
+				     set_mask, clear_mask);
+	}
+
+	free_initmem_default(POISON_FREE_INITMEM);
+}
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 5e49e4b4a4cc..10a4ee313083 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -5,6 +5,7 @@
 
 #include <linux/pagewalk.h>
 #include <linux/pgtable.h>
+#include <linux/sched.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
 #include <asm/set_memory.h>
@@ -104,24 +105,62 @@ static const struct mm_walk_ops pageattr_ops = {
 	.pte_hole = pageattr_pte_hole,
 };
 
-static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
-			pgprot_t clear_mask)
+static int __set_memory_mm(struct mm_struct  *mm, unsigned long start,
+			   unsigned long end, pgprot_t set_mask,
+			   pgprot_t clear_mask)
 {
 	int ret;
-	unsigned long start = addr;
-	unsigned long end = start + PAGE_SIZE * numpages;
 	struct pageattr_masks masks = {
 		.set_mask = set_mask,
 		.clear_mask = clear_mask
 	};
 
+	mmap_read_lock(mm);
+	ret = walk_page_range_novma(mm, start, end, &pageattr_ops, NULL,
+				    &masks);
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
+void fix_kernel_mem_early(char *startp, char *endp, pgprot_t set_mask,
+			  pgprot_t clear_mask)
+{
+	struct task_struct *t, *s;
+
+	unsigned long start = (unsigned long)startp;
+	unsigned long end = PAGE_ALIGN((unsigned long)endp);
+
+	__set_memory_mm(current->active_mm, start, end, set_mask, clear_mask);
+	__set_memory_mm(&init_mm, start, end, set_mask, clear_mask);
+
+	rcu_read_lock();
+	for_each_process(t) {
+		if (t->flags & PF_KTHREAD)
+			continue;
+		for_each_thread(t, s) {
+			if (s->mm) {
+				__set_memory_mm(s->mm, start, end, set_mask,
+						clear_mask);
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	flush_tlb_kernel_range(start, end);
+}
+
+static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
+			pgprot_t clear_mask)
+{
+	int ret;
+	unsigned long start = addr;
+	unsigned long end = start + PAGE_SIZE * numpages;
+
 	if (!numpages)
 		return 0;
 
-	mmap_read_lock(&init_mm);
-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
-				     &masks);
-	mmap_read_unlock(&init_mm);
+	ret = __set_memory_mm(&init_mm, start, end, set_mask, clear_mask);
 
 	flush_tlb_kernel_range(start, end);
 
-- 
2.37.2

