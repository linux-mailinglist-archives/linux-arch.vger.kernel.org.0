Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A21EF3C3
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFEJL1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 05:11:27 -0400
Received: from mail.loongson.cn ([114.242.206.163]:51162 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbgFEJLZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 05:11:25 -0400
Received: from kvm-dev1.localdomain (unknown [10.2.5.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxXesqDNpeHOw9AA--.611S2;
        Fri, 05 Jun 2020 17:11:06 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] MIPS: set page access bit with pgprot on some MIPS platform
Date:   Fri,  5 Jun 2020 17:11:05 +0800
Message-Id: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxXesqDNpeHOw9AA--.611S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF43GF1UtFyfKFy5tF48tFb_yoWxZrW3pF
        97A34xArW2qry3AryxurnrAa1rCwsrtFWUJw17C3W8Z3y7XrykKrnrCa97ZrykuFWvva18
        Aa1UXr4UWayIvFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUqEoXUUUUU
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
---
 arch/mips/include/asm/pgtable.h | 11 +++++++++--
 arch/mips/mm/cache.c            | 34 +++++++++++++++++-----------------
 include/asm-generic/pgtable.h   | 16 ----------------
 mm/memory.c                     |  3 ---
 4 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 85b39c9..e2452ab 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -25,6 +25,15 @@
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
+
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
 				 _page_cachable_default)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
@@ -414,8 +423,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
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

