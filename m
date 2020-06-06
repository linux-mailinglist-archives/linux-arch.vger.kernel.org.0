Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAAF1F0485
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jun 2020 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgFFEDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Jun 2020 00:03:07 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53238 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbgFFEDH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jun 2020 00:03:07 -0400
Received: from kvm-dev1.localdomain (unknown [10.2.5.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxJuppFdtebUs+AA--.1078S2;
        Sat, 06 Jun 2020 12:02:50 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/2] MIPS: Set page access bit with pgprot on platforms with RIXI
Date:   Sat,  6 Jun 2020 12:02:48 +0800
Message-Id: <1591416169-26666-1-git-send-email-maobibo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9AxJuppFdtebUs+AA--.1078S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF43GF1UtFy3CryUJFW3trb_yoWxur1kpF
        97A34xArW2qry3AryxurnrAa1rCwsrtFWUJw17C3W8Z3y7XrykKrnrCa97ZrykuFWvva18
        Aa1UXr48WayIvFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU56c_DUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On MIPS system which has rixi hardware bit, page access bit is not
set in pgrot. For memory reading, there will be one page fault to
allocate physical page; however valid bit is not set, there will
be the second fast tlb-miss fault handling to set valid/access bit.

This patch set page access/valid bit with pgrot if there is reading
access privilege. It will reduce one tlb-miss handling for memory
reading access.

The valid/access bit will be cleared in order to track memory
accessing activity. If the page is accessed, tlb-miss fast handling
will set valid/access bit, pte_sw_mkyoung is not necessary in slow
page fault path. This patch removes pte_sw_mkyoung function which
is defined as empty function except MIPS system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
v2:
- refine commit log title
---
 arch/mips/include/asm/pgtable.h | 10 ++++++++--
 arch/mips/mm/cache.c            | 34 +++++++++++++++++-----------------
 include/asm-generic/pgtable.h   | 16 ----------------
 mm/memory.c                     |  3 ---
 4 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 85b39c9..d066469 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -25,6 +25,14 @@
 struct mm_struct;
 struct vm_area_struct;
 
+#define __PP	_PAGE_PRESENT
+#define __NX	_PAGE_NO_EXEC
+#define __NR	_PAGE_NO_READ
+#define ___W	_PAGE_WRITE
+#define ___A	_PAGE_ACCESSED
+#define ___R	(_PAGE_SILENT_READ | _PAGE_ACCESSED)
+#define __PC	_page_cachable_default
+
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
 				 _page_cachable_default)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
@@ -414,8 +422,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-#define pte_sw_mkyoung	pte_mkyoung
-
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index ad6df1c..f814e43 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -158,23 +158,23 @@ void __update_cache(unsigned long address, pte_t pte)
 static inline void setup_protection_map(void)
 {
 	if (cpu_has_rixi) {
-		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-
-		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
-		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
-		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
+		protection_map[0]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[1]  = __pgprot(__PC | __PP | __NX | ___R);
+		protection_map[2]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[3]  = __pgprot(__PC | __PP | __NX | ___R);
+		protection_map[4]  = __pgprot(__PC | __PP | ___R);
+		protection_map[5]  = __pgprot(__PC | __PP | ___R);
+		protection_map[6]  = __pgprot(__PC | __PP | ___R);
+		protection_map[7]  = __pgprot(__PC | __PP | ___R);
+
+		protection_map[8]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[9]  = __pgprot(__PC | __PP | __NX | ___R);
+		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | __NR);
+		protection_map[11] = __pgprot(__PC | __PP | __NX | ___W | ___R);
+		protection_map[12] = __pgprot(__PC | __PP | ___R);
+		protection_map[13] = __pgprot(__PC | __PP | ___R);
+		protection_map[14] = __pgprot(__PC | __PP | ___W | ___R);
+		protection_map[15] = __pgprot(__PC | __PP | ___W | ___R);
 
 	} else {
 		protection_map[0] = PAGE_NONE;
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index b5278ec..fa5c73f 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -244,22 +244,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
-/*
- * On some architectures hardware does not set page access bit when accessing
- * memory page, it is responsibilty of software setting this bit. It brings
- * out extra page fault penalty to track page access bit. For optimization page
- * access bit can be set during all page fault flow on these arches.
- * To be differentiate with macro pte_mkyoung, this macro is used on platforms
- * where software maintains page access bit.
- */
-#ifndef pte_sw_mkyoung
-static inline pte_t pte_sw_mkyoung(pte_t pte)
-{
-	return pte;
-}
-#define pte_sw_mkyoung	pte_sw_mkyoung
-#endif
-
 #ifndef pte_savedwrite
 #define pte_savedwrite pte_write
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index c7c8960..8bb31c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2704,7 +2704,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3379,7 +3378,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
@@ -3662,7 +3660,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
1.8.3.1

