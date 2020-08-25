Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6470E250FED
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgHYDW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 23:22:59 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34530 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728039AbgHYDW7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 23:22:59 -0400
Received: from localhost.localdomain (unknown [222.209.10.89])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxauT3g0RfXqUNAA--.17408S3;
        Tue, 25 Aug 2020 11:22:39 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     tsbogend@alpha.franken.de
Cc:     akpm@linux-foundation.org, jiaxun.yang@flygoat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        maobibo@loongson.cn, paulburton@kernel.org
Subject: [PATCH] MIPS: make userspace mapping young by default
Date:   Tue, 25 Aug 2020 11:20:39 +0800
Message-Id: <20200825032039.21413-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825032039.21413-1-huangpei@loongson.cn>
References: <20200726083206.GE5032@alpha.franken.de>
 <20200825032039.21413-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9AxauT3g0RfXqUNAA--.17408S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWUGr1fKw45Jr4xCF4fGrg_yoWxtF4kpa
        s7Cry8A3y3Xr13ZryfZwnrAw1rAwsIqFyjqwnrCa15X343Z34ktrsIkrZ2vrykWa92kw4U
        Z3WUXr4rW3ya9rUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU5QYFtUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds support for non-rixi, based on [1].

MIPS page fault path take 3 exception (1 tlb miss + 2 tlb invalid), but
the second tlb invalid exception is just caused by __update_tlb from
do_page_fault writing tlb without _PAGE_VALID set. With this patch, it
only take 1 tlb miss + 1 tlb invalid exceptions

[1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email-maobibo@loongson.cn/

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

