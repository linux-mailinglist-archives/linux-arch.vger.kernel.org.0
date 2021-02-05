Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5F311939
	for <lists+linux-arch@lfdr.de>; Sat,  6 Feb 2021 04:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhBFC7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 21:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhBFCrB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 21:47:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C4F264FFB;
        Fri,  5 Feb 2021 23:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612568467;
        bh=3sDRqog9DdOhZbI4zaNsJSd3/mxjGovx7LJZLTGAe4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AQBVoz5fAvrmQBvzS5Wpy2fjUdcUJeCirBjQ++FHQLMCSz9Dk5PkyS5fhSkyvf8gz
         am1nzOzy5qVGzpBArrXpKqWzpPL/KI6Cu/qupTNpLjv3IqwpDq7N0j8NPeHAo6LVoM
         a7tgJliixmZoi4fUVuNG+pXlsyDEScG8bw+t+yH4=
Date:   Fri, 5 Feb 2021 15:41:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huang Pei <huangpei@loongson.cn>, ambrosehua@gmail.com,
        Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
Message-Id: <20210205154105.32bb13df439aa49b7fc167e7@linux-foundation.org>
In-Reply-To: <20210204152239.GA14292@alpha.franken.de>
References: <20210204013942.8398-1-huangpei@loongson.cn>
        <20210204152239.GA14292@alpha.franken.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 4 Feb 2021 16:22:39 +0100 Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:

> On Thu, Feb 04, 2021 at 09:39:42AM +0800, Huang Pei wrote:
> > MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
> > + 2 TLB Invalid), butthe second TLB Invalid exception is just
> > triggered by __update_tlb from do_page_fault writing tlb without
> > _PAGE_VALID set. With this patch, user space mapping prot is made
> > young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
> > and it only take 1 TLB Miss + 1 TLB Invalid exception
> > 
> > Remove pte_sw_mkyoung without polluting MM code and make page fault
> > delay of MIPS on par with other architecture
> > 
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > ---
> >  arch/mips/mm/cache.c    | 30 ++++++++++++++++--------------
> >  include/linux/pgtable.h |  8 --------
> >  mm/memory.c             |  3 ---
> >  3 files changed, 16 insertions(+), 25 deletions(-)
> 
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> Andrew, can you take this patch through your tree ?

Sure.  I'll drop Christophe's "mm/memory.c: remove pte_sw_mkyoung()"
(https://lkml.kernel.org/r/f302ef92c48d1f08a0459aaee1c568ca11213814.1612345700.git.christophe.leroy@csgroup.eu)
in favour of this one.

I changed this patch a bit due to other changes in -next.  Please check
do_set_pte().



From: Huang Pei <huangpei@loongson.cn>
Subject: MIPS: make userspace mapping young by default

MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss + 2
TLB Invalid), butthe second TLB Invalid exception is just triggered by
__update_tlb from do_page_fault writing tlb without _PAGE_VALID set.  With
this patch, user space mapping prot is made young by default (with both
_PAGE_VALID and _PAGE_YOUNG set), and it only take 1 TLB Miss + 1 TLB
Invalid exception

Remove pte_sw_mkyoung without polluting MM code and make page fault delay
of MIPS on par with other architecture

Link: https://lkml.kernel.org/r/20210204013942.8398-1-huangpei@loongson.cn
Signed-off-by: Huang Pei <huangpei@loongson.cn>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: <huangpei@loongson.cn>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <ambrosehua@gmail.com>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Li Xuefeng <lixuefeng@loongson.cn>
Cc: Yang Tiezhu <yangtiezhu@loongson.cn>
Cc: Gao Juxin <gaojuxin@loongson.cn>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/mips/mm/cache.c    |   30 ++++++++++++++++--------------
 include/linux/pgtable.h |    8 --------
 mm/memory.c             |    4 ----
 3 files changed, 16 insertions(+), 26 deletions(-)

--- a/arch/mips/mm/cache.c~mips-make-userspace-mapping-young-by-default
+++ a/arch/mips/mm/cache.c
@@ -157,29 +157,31 @@ unsigned long _page_cachable_default;
 EXPORT_SYMBOL(_page_cachable_default);
 
 #define PM(p)	__pgprot(_page_cachable_default | (p))
+#define PVA(p)	PM(_PAGE_VALID | _PAGE_ACCESSED | (p))
 
 static inline void setup_protection_map(void)
 {
 	protection_map[0]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[1]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[2]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[3]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[4]  = PM(_PAGE_PRESENT);
-	protection_map[5]  = PM(_PAGE_PRESENT);
-	protection_map[6]  = PM(_PAGE_PRESENT);
-	protection_map[7]  = PM(_PAGE_PRESENT);
+	protection_map[1]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	protection_map[2]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	protection_map[3]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	protection_map[4]  = PVA(_PAGE_PRESENT);
+	protection_map[5]  = PVA(_PAGE_PRESENT);
+	protection_map[6]  = PVA(_PAGE_PRESENT);
+	protection_map[7]  = PVA(_PAGE_PRESENT);
 
 	protection_map[8]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[9]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[10] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
+	protection_map[9]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	protection_map[10] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
 				_PAGE_NO_READ);
-	protection_map[11] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-	protection_map[12] = PM(_PAGE_PRESENT);
-	protection_map[13] = PM(_PAGE_PRESENT);
-	protection_map[14] = PM(_PAGE_PRESENT | _PAGE_WRITE);
-	protection_map[15] = PM(_PAGE_PRESENT | _PAGE_WRITE);
+	protection_map[11] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
+	protection_map[12] = PVA(_PAGE_PRESENT);
+	protection_map[13] = PVA(_PAGE_PRESENT);
+	protection_map[14] = PVA(_PAGE_PRESENT);
+	protection_map[15] = PVA(_PAGE_PRESENT);
 }
 
+#undef _PVA
 #undef PM
 
 void cpu_cache_init(void)
--- a/include/linux/pgtable.h~mips-make-userspace-mapping-young-by-default
+++ a/include/linux/pgtable.h
@@ -432,14 +432,6 @@ static inline void ptep_set_wrprotect(st
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
--- a/mm/memory.c~mips-make-userspace-mapping-young-by-default
+++ a/mm/memory.c
@@ -2902,7 +2902,6 @@ static vm_fault_t wp_page_copy(struct vm
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 
 		/*
@@ -3560,7 +3559,6 @@ static vm_fault_t do_anonymous_page(stru
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
@@ -3745,8 +3743,6 @@ void do_set_pte(struct vm_fault *vmf, st
 
 	if (prefault && arch_wants_old_prefaulted_pte())
 		entry = pte_mkold(entry);
-	else
-		entry = pte_sw_mkyoung(entry);
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
_

