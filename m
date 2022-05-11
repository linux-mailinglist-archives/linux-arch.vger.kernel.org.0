Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E121523289
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiEKMFH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbiEKMEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 08:04:55 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E9492D08;
        Wed, 11 May 2022 05:04:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0VCvyFME_1652270674;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCvyFME_1652270674)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 20:04:35 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when migration
Date:   Wed, 11 May 2022 20:04:18 +0800
Message-Id: <a4baca670aca637e7198d9ae4543b8873cb224dc.1652270205.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On some architectures (like ARM64), it can support CONT-PTE/PMD size
hugetlb, which means it can support not only PMD/PUD size hugetlb:
2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
size specified.

When migrating a hugetlb page, we will get the relevant page table
entry by huge_pte_offset() only once to nuke it and remap it with
a migration pte entry. This is correct for PMD or PUD size hugetlb,
since they always contain only one pmd entry or pud entry in the
page table.

However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
since they can contain several continuous pte or pmd entry with
same page table attributes. So we will nuke or remap only one pte
or pmd entry for this CONT-PTE/PMD size hugetlb page, which is
not expected for hugetlb migration. The problem is we can still
continue to modify the subpages' data of a hugetlb page during
migrating a hugetlb page, which can cause a serious data consistent
issue, since we did not nuke the page table entry and set a
migration pte for the subpages of a hugetlb page.

To fix this issue, we should change to use huge_ptep_clear_flush()
to nuke a hugetlb page table, and remap it with set_huge_pte_at()
and set_huge_swap_pte_at() when migrating a hugetlb page, which
already considered the CONT-PTE or CONT-PMD size hugetlb.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 11 +++++++++++
 mm/rmap.c               | 24 ++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 306d6ef..abde66e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1093,6 +1093,17 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
+
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
+{
+	return *ptep;
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/rmap.c b/mm/rmap.c
index 94d6b24..4e96daf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1926,13 +1926,15 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 					break;
 				}
 			}
+
+			/* Nuke the hugetlb page table entry */
+			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+			/* Nuke the page table entry. */
+			pteval = ptep_clear_flush(vma, address, pvmw.pte);
 		}
 
-		/* Nuke the page table entry. */
-		pteval = ptep_clear_flush(vma, address, pvmw.pte);
-
 		/* Set the dirty flag on the folio now the pte is gone. */
 		if (pte_dirty(pteval))
 			folio_mark_dirty(folio);
@@ -2017,7 +2019,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			pte_t swp_pte;
 
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-				set_pte_at(mm, address, pvmw.pte, pteval);
+				if (folio_test_hugetlb(folio))
+					set_huge_pte_at(mm, address, pvmw.pte, pteval);
+				else
+					set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
@@ -2026,7 +2031,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				       !anon_exclusive, subpage);
 			if (anon_exclusive &&
 			    page_try_share_anon_rmap(subpage)) {
-				set_pte_at(mm, address, pvmw.pte, pteval);
+				if (folio_test_hugetlb(folio))
+					set_huge_pte_at(mm, address, pvmw.pte, pteval);
+				else
+					set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
@@ -2052,7 +2060,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
 			if (pte_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			set_pte_at(mm, address, pvmw.pte, swp_pte);
+			if (folio_test_hugetlb(folio))
+				set_huge_swap_pte_at(mm, address, pvmw.pte,
+						     swp_pte, vma_mmu_pagesize(vma));
+			else
+				set_pte_at(mm, address, pvmw.pte, swp_pte);
 			trace_set_migration_pte(address, pte_val(swp_pte),
 						compound_order(&folio->page));
 			/*
-- 
1.8.3.1

