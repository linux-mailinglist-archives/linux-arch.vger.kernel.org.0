Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4342E1618
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404037AbfJWJay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 05:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732648AbfJWJax (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 05:30:53 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87682222BD;
        Wed, 23 Oct 2019 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571823052;
        bh=j8OWFTRm/jHlBTDjcdKdk/Hn1N3SqSGQtNNHLFbgGCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdCbmXvKo9YD536Tke7o2JZC6PxoIl7gtgHVvqyCEa3awWQpZyiHwHw8qnvI5y6VE
         cY3gODSk7+vPq4o+kVSTuIrZYfv6eI5dBWp40owN3uvkoCHPgvVXHq0K26FeAOTWzj
         qywoF0G0SpjuS7eIvMUa8BxDaFsW8Gi1lXOriX9I=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 11/12] um: add support for folded p4d page tables
Date:   Wed, 23 Oct 2019 12:29:00 +0300
Message-Id: <1571822941-29776-12-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The UML port uses 4 and 5 level fixups to support higher level page table
directories in the generic VM code.

Implement primitives necessary for the 4th level folding and add walks of
p4d level where appropriate.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/um/include/asm/pgtable-2level.h |  1 -
 arch/um/include/asm/pgtable-3level.h |  1 -
 arch/um/include/asm/pgtable.h        |  3 ++
 arch/um/kernel/mem.c                 | 25 ++++++++++++++--
 arch/um/kernel/skas/mmu.c            | 12 ++++++--
 arch/um/kernel/skas/uaccess.c        |  7 ++++-
 arch/um/kernel/tlb.c                 | 56 ++++++++++++++++++++++++++++++++----
 arch/um/kernel/trap.c                |  4 ++-
 8 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 32b3d26..32106d3 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -8,7 +8,6 @@
 #ifndef __UM_PGTABLE_2LEVEL_H
 #define __UM_PGTABLE_2LEVEL_H
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 9812269..8a3b689 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -7,7 +7,6 @@
 #ifndef __UM_PGTABLE_3LEVEL_H
 #define __UM_PGTABLE_3LEVEL_H
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopud.h>
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 36a44d5..2daa58d 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -106,6 +106,9 @@ extern unsigned long end_iomem;
 #define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
 #define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
 
+#define p4d_newpage(x)  (p4d_val(x) & _PAGE_NEWPAGE)
+#define p4d_mkuptodate(x) (p4d_val(x) &= ~_PAGE_NEWPAGE)
+
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
 
 #define pte_page(x) pfn_to_page(pte_pfn(x))
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 417ff64..6fd17bc 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -92,10 +92,26 @@ static void __init one_md_table_init(pud_t *pud)
 #endif
 }
 
+static void __init one_pud_table_init(p4d_t *p4d)
+{
+#if CONFIG_PGTABLE_LEVELS > 3
+	pud_t *pud_table = (pud_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+
+	if (!pud_table)
+		panic("%s: Failed to allocate %lu bytes align=%lx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE);
+
+	set_p4d(p4d, __p4d(_KERNPG_TABLE + (unsigned long) __pa(pud_table)));
+	if (pud_table != pud_offset(p4d, 0))
+		BUG();
+#endif
+}
+
 static void __init fixrange_init(unsigned long start, unsigned long end,
 				 pgd_t *pgd_base)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	int i, j;
@@ -107,7 +123,10 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
 	pgd = pgd_base + i;
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
-		pud = pud_offset(pgd, vaddr);
+		p4d = p4d_offset(pgd, vaddr);
+		if (p4d_none(*p4d))
+			one_pud_table_init(p4d);
+		pud = pud_offset(p4d, vaddr);
 		if (pud_none(*pud))
 			one_md_table_init(pud);
 		pmd = pmd_offset(pud, vaddr);
@@ -124,6 +143,7 @@ static void __init fixaddr_user_init( void)
 #ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	long size = FIXADDR_USER_END - FIXADDR_USER_START;
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -144,7 +164,8 @@ static void __init fixaddr_user_init( void)
 	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
 		      p += PAGE_SIZE) {
 		pgd = swapper_pg_dir + pgd_index(vaddr);
-		pud = pud_offset(pgd, vaddr);
+		p4d = p4d_offset(pgd, vaddr);
+		pud = pud_offset(p4d, vaddr);
 		pmd = pmd_offset(pud, vaddr);
 		pte = pte_offset_kernel(pmd, vaddr);
 		pte_set_val(*pte, p, PAGE_READONLY);
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index b5e3d91..3f0d9a5 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -19,15 +19,21 @@ static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 			 unsigned long kernel)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
 	pgd = pgd_offset(mm, proc);
-	pud = pud_alloc(mm, pgd, proc);
-	if (!pud)
+
+	p4d = p4d_alloc(mm, pgd, proc);
+	if (!p4d)
 		goto out;
 
+	pud = pud_alloc(mm, p4d, proc);
+	if (!pud)
+		goto out_pud;
+
 	pmd = pmd_alloc(mm, pud, proc);
 	if (!pmd)
 		goto out_pmd;
@@ -44,6 +50,8 @@ static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 	pmd_free(mm, pmd);
  out_pmd:
 	pud_free(mm, pud);
+ out_pud:
+	p4d_free(mm, p4d);
  out:
 	return -ENOMEM;
 }
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 3236052..d617f8d 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -17,6 +17,7 @@
 pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 
@@ -27,7 +28,11 @@ pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
 	if (!pgd_present(*pgd))
 		return NULL;
 
-	pud = pud_offset(pgd, addr);
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
 	if (!pud_present(*pud))
 		return NULL;
 
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 8425a22..80a358c 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -277,7 +277,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 	return ret;
 }
 
-static inline int update_pud_range(pgd_t *pgd, unsigned long addr,
+static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 				   unsigned long end,
 				   struct host_vm_change *hvc)
 {
@@ -285,7 +285,7 @@ static inline int update_pud_range(pgd_t *pgd, unsigned long addr,
 	unsigned long next;
 	int ret = 0;
 
-	pud = pud_offset(pgd, addr);
+	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
@@ -299,6 +299,28 @@ static inline int update_pud_range(pgd_t *pgd, unsigned long addr,
 	return ret;
 }
 
+static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
+				   unsigned long end,
+				   struct host_vm_change *hvc)
+{
+	p4d_t *p4d;
+	unsigned long next;
+	int ret = 0;
+
+	p4d = p4d_offset(pgd, addr);
+	do {
+		next = p4d_addr_end(addr, end);
+		if (!p4d_present(*p4d)) {
+			if (hvc->force || p4d_newpage(*p4d)) {
+				ret = add_munmap(addr, next - addr, hvc);
+				p4d_mkuptodate(*p4d);
+			}
+		} else
+			ret = update_pud_range(p4d, addr, next, hvc);
+	} while (p4d++, addr = next, ((addr < end) && !ret));
+	return ret;
+}
+
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 		      unsigned long end_addr, int force)
 {
@@ -316,8 +338,8 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 				ret = add_munmap(addr, next - addr, &hvc);
 				pgd_mkuptodate(*pgd);
 			}
-		}
-		else ret = update_pud_range(pgd, addr, next, &hvc);
+		} else
+			ret = update_p4d_range(pgd, addr, next, &hvc);
 	} while (pgd++, addr = next, ((addr < end_addr) && !ret));
 
 	if (!ret)
@@ -338,6 +360,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm;
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -364,7 +387,23 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 			continue;
 		}
 
-		pud = pud_offset(pgd, addr);
+		p4d = p4d_offset(pgd, addr);
+		if (!p4d_present(*p4d)) {
+			last = ADD_ROUND(addr, P4D_SIZE);
+			if (last > end)
+				last = end;
+			if (p4d_newpage(*p4d)) {
+				updated = 1;
+				err = add_munmap(addr, last - addr, &hvc);
+				if (err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
+			}
+			addr = last;
+			continue;
+		}
+
+		pud = pud_offset(p4d, addr);
 		if (!pud_present(*pud)) {
 			last = ADD_ROUND(addr, PUD_SIZE);
 			if (last > end)
@@ -424,6 +463,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -437,7 +477,11 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	if (!pgd_present(*pgd))
 		goto kill;
 
-	pud = pud_offset(pgd, address);
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		goto kill;
+
+	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		goto kill;
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index e62296c..8185530 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -28,6 +28,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -104,7 +105,8 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 		}
 
 		pgd = pgd_offset(mm, address);
-		pud = pud_offset(pgd, address);
+		p4d = p4d_offset(pgd, address);
+		pud = pud_offset(p4d, address);
 		pmd = pmd_offset(pud, address);
 		pte = pte_offset_kernel(pmd, address);
 	} while (!pte_present(*pte));
-- 
2.7.4

