Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8E129484
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2019 12:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLWLAT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Dec 2019 06:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfLWLAT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Dec 2019 06:00:19 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FE5206D3;
        Mon, 23 Dec 2019 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577098818;
        bh=VIlsTkstIcKhiUFDWlgqyQoytZZodl7K5fScLQQY9Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K46DkcG40lXUuO3yFpXyxBuTrDEG3ld/jfmHA4kYzgzqo8YxXZ4ie/AffE3QgxkWa
         4/uDUsnZ1xxl3+J9y6IQctwwmJ4muBrJp1Uz386edd6Mc7ITLCV2AyQTjC2M/bzO6k
         32sXab1Ma6JHPI5RDhALOEzcb143OWFt4CTNA22g=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 2/2] nds32: fix build failure caused by page table folding updates
Date:   Mon, 23 Dec 2019 13:00:04 +0200
Message-Id: <20191223110004.2157-3-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223110004.2157-1-rppt@kernel.org>
References: <20191223110004.2157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The commit 7c2763c42326 ("nds32: use pgtable-nopmd instead of
4level-fixup") missed the pmd_off_k() macro which caused the following
build error:

  CC      arch/nds32/mm/highmem.o
In file included from arch/nds32/include/asm/page.h:57,
                 from include/linux/mm_types_task.h:16,
                 from include/linux/mm_types.h:5,
                 from include/linux/mmzone.h:21,
                 from include/linux/gfp.h:6,
                 from include/linux/xarray.h:14,
                 from include/linux/radix-tree.h:18,
                 from include/linux/fs.h:15,
                 from include/linux/highmem.h:5,
                 from arch/nds32/mm/highmem.c:5:
arch/nds32/mm/highmem.c: In function 'kmap_atomic':
arch/nds32/include/asm/pgtable.h:360:44: error: passing argument 1 of 'pmd_offset' from incompatible pointer type [-Werror=incompatible-pointer-types]
 #define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
                                 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
arch/nds32/include/asm/memory.h:33:29: note: in definition of macro '__phys_to_virt'
 #define __phys_to_virt(x) ((x) - PHYS_OFFSET + PAGE_OFFSET)
                             ^
arch/nds32/include/asm/pgtable.h:193:55: note: in expansion of macro '__va'
 #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
                                                       ^~~~
include/asm-generic/pgtable-nop4d.h:41:24: note: in expansion of macro 'pgd_val'
 #define p4d_val(x)    (pgd_val((x).pgd))
                        ^~~~~~~
include/asm-generic/pgtable-nopud.h:50:24: note: in expansion of macro 'p4d_val'
 #define pud_val(x)    (p4d_val((x).p4d))
                        ^~~~~~~
include/asm-generic/pgtable-nopmd.h:49:24: note: in expansion of macro 'pud_val'
 #define pmd_val(x)    (pud_val((x).pud))
                        ^~~~~~~
arch/nds32/include/asm/pgtable.h:193:60: note: in expansion of macro 'pmd_val'
 #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
                                                            ^~~~~~~
arch/nds32/include/asm/pgtable.h:190:56: note: in expansion of macro 'pmd_page_kernel'
 #define pte_offset_kernel(dir, address)      ((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))
                                                        ^~~~~~~~~~~~~~~
arch/nds32/mm/highmem.c:52:9: note: in expansion of macro 'pte_offset_kernel'
  ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
         ^~~~~~~~~~~~~~~~~
arch/nds32/include/asm/pgtable.h:362:33: note: in expansion of macro 'pgd_offset'
 #define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
                                 ^~~~~~~~~~
arch/nds32/include/asm/pgtable.h:198:39: note: in expansion of macro 'pgd_offset_k'
 #define pmd_off_k(address) pmd_offset(pgd_offset_k(address), address)
                                       ^~~~~~~~~~~~
arch/nds32/mm/highmem.c:52:27: note: in expansion of macro 'pmd_off_k'
  ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
                           ^~~~~~~~~
In file included from arch/nds32/include/asm/pgtable.h:7,
                 from include/linux/mm.h:99,
                 from include/linux/highmem.h:8,
                 from arch/nds32/mm/highmem.c:5:
include/asm-generic/pgtable-nopmd.h:44:42: note: expected 'pud_t *' {aka 'struct <anonymous> *'} but argument is of type 'pgd_t *' {aka 'long unsigned int *'}
 static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
                                  ~~~~~~~~^~~
In file included from arch/nds32/include/asm/page.h:57,
                 from include/linux/mm_types_task.h:16,
                 from include/linux/mm_types.h:5,
                 from include/linux/mmzone.h:21,
                 from include/linux/gfp.h:6,
                 from include/linux/xarray.h:14,
                 from include/linux/radix-tree.h:18,
                 from include/linux/fs.h:15,
                 from include/linux/highmem.h:5,
                 from arch/nds32/mm/highmem.c:5:

Updating the pmd_off_k() macro to use the correct page table unfolding
fixes the issue.

Fixes: 7c2763c42326 ("nds32: use pgtable-nopmd instead of 4level-fixup")
Link: https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nds32/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 0214e4150539..6abc58ac406d 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -195,7 +195,7 @@ extern void paging_init(void);
 #define pte_unmap(pte)		do { } while (0)
 #define pte_unmap_nested(pte)	do { } while (0)
 
-#define pmd_off_k(address)	pmd_offset(pgd_offset_k(address), address)
+#define pmd_off_k(address)	pmd_offset(pud_offset(p4d_offset(pgd_offset_k(address), (address)), (address)), (address))
 
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 /*
-- 
2.24.0

