Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73525D3F3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgIDIuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 04:50:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49352 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgIDIuM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 04:50:12 -0400
Received: from localhost.localdomain (unknown [182.149.160.36])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxeuSg_1FfyLcQAA--.21470S2;
        Fri, 04 Sep 2020 16:49:42 +0800 (CST)
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
Subject: [PATCH] MIPS: make userspace mapping young by default
Date:   Fri,  4 Sep 2020 16:49:26 +0800
Message-Id: <20200904084926.20924-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAf9AxeuSg_1FfyLcQAA--.21470S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryxWr1fZr4fZrWUZrWUArb_yoW3Gry5pa
        s7Cry8A3y3Xr13ZryxZwnrAw1rAwsFqFyjqwnrCa15Xa43Z34ktrs0krZavrykWa92kw4U
        Z3WUXr4rW39F9rUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This version removes pte_sw_mkyoung without polluting MM code and covers
both no-RIXI and RIXI MIPS CPUs and makes page fault delay of MIPS on par
with other architecture 

MIPS page fault path take 3 exceptions (1 TLB Miss + 2 TLB Invalid), but
the second TLB Invalid exception is just triggered by __update_tlb from
do_page_fault writing tlb without _PAGE_VALID set. By making userspace
mapping young by default, aka _PAGE_VALID and _PAGE_ACCESSED both set in
prot, it only take 1 TLB Miss + 1 TLB Invalid exceptions

[1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email
-maobibo@loongson.cn/

Co-developed-by: Bibo Mao <maobibo@loonson.cn>
Co-developed-by: Huang Pei <huangpei@loongson.cn>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/pgtable.h | 32 +++++++++++++++-----------------
 arch/mips/mm/cache.c            | 25 +++++++++++++------------
 mm/memory.c                     |  3 ---
 3 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index dd7a0f552cac..aaafe3d6a0a1 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -25,22 +25,22 @@
 struct mm_struct;
 struct vm_area_struct;
 
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
-				 _page_cachable_default)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
-				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
-				 _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
-				 _page_cachable_default)
-#define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
-				 _PAGE_GLOBAL | _page_cachable_default)
-#define PAGE_KERNEL_NC	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
-				 _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
-				 _page_cachable_default)
+#define PAGE_NONE      __pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
+                                _page_cachable_default)
+#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
+                                __READABLE | _page_cachable_default)
+#define PAGE_COPY      __pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
+                                __READABLE | _page_cachable_default)
+#define PAGE_READONLY  __pgprot(_PAGE_PRESENT |  __READABLE | \
+                                _page_cachable_default)
+#define PAGE_KERNEL    __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
+                                _PAGE_GLOBAL | _page_cachable_default)
+#define PAGE_KERNEL_NC __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
+                                _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
+#define PAGE_USERIO    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
+                                _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
-			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
+                       __WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
 
 /*
  * If _PAGE_NO_EXEC is not defined, we can't do page protection for
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

