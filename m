Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7B85C1B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfHHHwi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 03:52:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731706AbfHHHwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Aug 2019 03:52:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x787qXP3022426
        for <linux-arch@vger.kernel.org>; Thu, 8 Aug 2019 03:52:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8dvfvf2g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2019 03:52:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 8 Aug 2019 08:52:20 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 08:52:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x787qGeM33947662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 07:52:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 317B1AE053;
        Thu,  8 Aug 2019 07:52:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 668F9AE051;
        Thu,  8 Aug 2019 07:52:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Aug 2019 07:52:14 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 08 Aug 2019 10:52:13 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/3] ia64: switch to generic version of pte allocation
Date:   Thu,  8 Aug 2019 10:52:07 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
References: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080807-4275-0000-0000-000003568A20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080807-4276-0000-0000-000038688E6D
Message-Id: <1565250728-21721-3-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=824 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The ia64 implementation pte_alloc_one(), pte_alloc_one_kernel(),
pte_free_kernel() and pte_free() is identical to the generic except of lack
of __GFP_ACCOUNT for the user PTEs allocation.

Switch ia64 to use generic version of these functions.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/include/asm/pgalloc.h | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
index b03d993..f4c4910 100644
--- a/arch/ia64/include/asm/pgalloc.h
+++ b/arch/ia64/include/asm/pgalloc.h
@@ -20,6 +20,8 @@
 #include <linux/page-flags.h>
 #include <linux/threads.h>
 
+#include <asm-generic/pgalloc.h>
+
 #include <asm/mmu_context.h>
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
@@ -82,36 +84,6 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmd_entry, pte_t * pte)
 	pmd_val(*pmd_entry) = __pa(pte);
 }
 
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *page;
-
-	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
-		return NULL;
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
-}
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
 #define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
 
 #endif				/* _ASM_IA64_PGALLOC_H */
-- 
2.7.4

