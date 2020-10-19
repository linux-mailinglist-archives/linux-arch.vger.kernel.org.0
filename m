Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C55292376
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgJSINd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 04:13:33 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33750 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728618AbgJSINd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Oct 2020 04:13:33 -0400
Received: from localhost.localdomain (unknown [222.209.8.91])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxeuSTSo1f9uEeAA--.44413S2;
        Mon, 19 Oct 2020 16:13:15 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4] MIPS: make userspace mapping young by default
Date:   Mon, 19 Oct 2020 16:12:57 +0800
Message-Id: <20201019081257.32127-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAf9AxeuSTSo1f9uEeAA--.44413S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryxWr17Zr4fWr18JrWxCrg_yoW3CFyxpF
        97Ca4xA3yaqr13AryxJwnrZw1rAwsrtF1UJwnrC3WUZa4fZrykKrnIka93ZrykuFZayw1U
        Z3WUXr45ua9avFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUeHUDDUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MIPS page fault path takes 3 exceptions (1 TLB Miss + 2 TLB Invalid), but
the second TLB Invalid exception is just triggered by __update_tlb from
do_page_fault writing tlb without _PAGE_VALID set. With this patch, user
space mapping prot is made young by default (with both _PAGE_VALID and
_PAGE_YOUNG set), and it only take 1 TLB Miss + 1 TLB Invalid exception

+. remove pte_sw_mkyoung without polluting MM code and make page fault
delay of MIPS on par with other architecture and covers both no-rixi and
rixi MIPS CPUS

+. clean up cpu_has_rixi case in setup_protection_map with PAGE_*_XI,
since only _PAGE_NO_EXEC(eXecute Inhibit) provide additional control
while _PAGE_NO_READ equals _PAGE_READ for no-rixi MIPS CPUs;

[1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email
-maobibo@loongson.cn/
---
V4:
- clean up cpu_has_rixi case 
V3:
- reformat with whitespace cleaned up following Thomas's advice
V2:
- remove unused asm-generic definition of pte_sw_mkyoung following Mao's
advice
---
---
 arch/mips/include/asm/pgtable.h | 15 ++++++---
 arch/mips/mm/cache.c            | 55 +++++++++++++++++----------------
 include/linux/pgtable.h         |  8 -----
 mm/memory.c                     |  3 --
 4 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index e5ef0fdd4838..3712d9d683f1 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -27,11 +27,20 @@ struct vm_area_struct;
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
 				 _page_cachable_default)
+#define PAGE_NONE_XI	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
+				 _PAGE_NO_EXEC | _page_cachable_default)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
-				 _page_cachable_default)
+				 __READABLE | _page_cachable_default)
+#define PAGE_SHARED_XI	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | __READABLE | \
+				 _PAGE_NO_EXEC | _page_cachable_default)
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
+				 __READABLE | _page_cachable_default)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT |  __READABLE | \
 				 _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
+#define PAGE_READONLY_XI	__pgprot(_PAGE_PRESENT | __READABLE | \
+				 _PAGE_NO_EXEC | _page_cachable_default)
+#define PAGE_WRITEONLY_XI	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
+				 _PAGE_NO_EXEC | _PAGE_NO_READ | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
@@ -412,8 +421,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-#define pte_sw_mkyoung	pte_mkyoung
-
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 3e81ba000096..e0488030c76e 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -158,35 +158,36 @@ EXPORT_SYMBOL(_page_cachable_default);
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
+		protection_map[0]  = PAGE_NONE_XI;
+		protection_map[1]  = PAGE_COPY;
+		protection_map[2]  = PAGE_NONE_XI;
+		protection_map[3]  = PAGE_COPY;
+		protection_map[4]  = PAGE_READONLY;
+		protection_map[5]  = PAGE_READONLY;
+		protection_map[6]  = PAGE_READONLY;
+		protection_map[7]  = PAGE_READONLY;
+
+		protection_map[8]  = PAGE_NONE_XI;
+		protection_map[9]  = PAGE_COPY;
+		protection_map[10] = PAGE_WRITEONLY_XI;
+		protection_map[11] = PAGE_SHARED_XI;
+		protection_map[12] = PAGE_READONLY;
+		protection_map[13] = PAGE_READONLY;
+		protection_map[14] = PAGE_READONLY_XI;
+		protection_map[15] = PAGE_READONLY_XI;
+
 
 	} else {
-		protection_map[0] = PAGE_NONE;
-		protection_map[1] = PAGE_READONLY;
-		protection_map[2] = PAGE_COPY;
-		protection_map[3] = PAGE_COPY;
-		protection_map[4] = PAGE_READONLY;
-		protection_map[5] = PAGE_READONLY;
-		protection_map[6] = PAGE_COPY;
-		protection_map[7] = PAGE_COPY;
-		protection_map[8] = PAGE_NONE;
-		protection_map[9] = PAGE_READONLY;
+		protection_map[0]  = PAGE_NONE;
+		protection_map[1]  = PAGE_READONLY;
+		protection_map[2]  = PAGE_COPY;
+		protection_map[3]  = PAGE_COPY;
+		protection_map[4]  = PAGE_READONLY;
+		protection_map[5]  = PAGE_READONLY;
+		protection_map[6]  = PAGE_COPY;
+		protection_map[7]  = PAGE_COPY;
+		protection_map[8]  = PAGE_NONE;
+		protection_map[9]  = PAGE_READONLY;
 		protection_map[10] = PAGE_SHARED;
 		protection_map[11] = PAGE_SHARED;
 		protection_map[12] = PAGE_READONLY;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 38c33eabea89..c0326efbaa12 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -377,14 +377,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
  * To be differentiate with macro pte_mkyoung, this macro is used on platforms
  * where software maintains page access bit.
  */
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
index 589afe45d0b3..95d85d03b0a2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2877,7 +2877,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3533,7 +3532,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
@@ -3809,7 +3807,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
2.17.1

