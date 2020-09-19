Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7011270B8D
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 09:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgISHsd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 03:48:33 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33128 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISHsa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Sep 2020 03:48:30 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 03:48:28 EDT
Received: from localhost.localdomain (unknown [212.102.50.216])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxqMWVt2VfUmsWAA--.30623S2;
        Sat, 19 Sep 2020 15:48:06 +0800 (CST)
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
Subject: [PATCH V3] MIPS: make userspace mapping young by default
Date:   Sat, 19 Sep 2020 15:47:31 +0800
Message-Id: <20200919074731.22372-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAf9DxqMWVt2VfUmsWAA--.30623S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryxWr1DXr43GF48uF17Jrb_yoWxtF4kpa
        4kC340y3yaqr13AryxZwnrAw1rAwsIqFy8Xw17C3W5X343Z34ktrsxGa9avrykuFZ2kw48
        Z3WUXr4ruaya9rUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vEe7yl42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnGQDUUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MIPS page fault path take 3 exceptions (1 TLB Miss + 2 TLB Invalid), but
the second TLB Invalid exception is just triggered by __update_tlb from
do_page_fault writing tlb without _PAGE_VALID set. With this patch, it
only take 1 TLB Miss + 1 TLB Invalid exceptions

This version removes pte_sw_mkyoung without polluting MM code and makes
page fault delay of MIPS on par with other architecture and covers both
no-RIXI and RIXI MIPS CPUS

[1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email
-maobibo@loongson.cn/
---
V3:
- reformat with whitespace cleaned up following Thomas's advice
V2:
- remove unused asm-generic definition of pte_sw_mkyoung following Mao's
advice
---
Co-developed-by: Huang Pei <huangpei@loongson.cn>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
Co-developed-by: Bibo Mao <maobibo@loonson.cn>
---
 arch/mips/include/asm/pgtable.h | 10 ++++------
 arch/mips/mm/cache.c            | 25 +++++++++++++------------
 include/linux/pgtable.h         |  8 --------
 mm/memory.c                     |  3 ---
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index dd7a0f552cac..931fb35730f0 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -27,11 +27,11 @@ struct vm_area_struct;
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
 				 _page_cachable_default)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
-				 _page_cachable_default)
+#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
+				 __READABLE | _page_cachable_default)
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
-				 _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
+				 __READABLE | _page_cachable_default)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT |  __READABLE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
@@ -414,8 +414,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-#define pte_sw_mkyoung	pte_mkyoung
-
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 3e81ba000096..ed75f2871aad 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -159,22 +159,23 @@ static inline void setup_protection_map(void)
 {
 	if (cpu_has_rixi) {
 		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
+		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
 		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
+		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
+		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
+		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
+		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
+		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
 
 		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
+		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
 		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
-		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
-		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
+		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | __READABLE);
+		protection_map[12]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
+		protection_map[13]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | __READABLE);
+		protection_map[14]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
+		protection_map[15]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | __READABLE);
+
 
 	} else {
 		protection_map[0] = PAGE_NONE;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..ef9c5fa8673e 100644
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
index 602f4283122f..5100ab5bcf77 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2705,7 +2705,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3386,7 +3385,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
@@ -3661,7 +3659,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
2.17.1

