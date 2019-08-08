Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B733885C15
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfHHHw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 03:52:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731673AbfHHHw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Aug 2019 03:52:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x787qDdV066761
        for <linux-arch@vger.kernel.org>; Thu, 8 Aug 2019 03:52:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8f7g8vew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2019 03:52:25 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 8 Aug 2019 08:52:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 08:52:19 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x787qIqi31785064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 07:52:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94EC7A404D;
        Thu,  8 Aug 2019 07:52:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1F9A4040;
        Thu,  8 Aug 2019 07:52:16 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Aug 2019 07:52:16 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 08 Aug 2019 10:52:16 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/3] sh: switch to generic version of pte allocation
Date:   Thu,  8 Aug 2019 10:52:08 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
References: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080807-0016-0000-0000-0000029C2B8E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080807-0017-0000-0000-000032FC2D77
Message-Id: <1565250728-21721-4-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The sh implementation pte_alloc_one(), pte_alloc_one_kernel(),
pte_free_kernel() and pte_free() is identical to the generic except of lack
of __GFP_ACCOUNT for the user PTEs allocation.

Switch sh to use generic version of these functions.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sh/include/asm/pgalloc.h | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 9e15054..8c6341a 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -3,6 +3,7 @@
 #define __ASM_SH_PGALLOC_H
 
 #include <asm/page.h>
+#include <asm-generic/pgalloc.h>
 
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
@@ -26,39 +27,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 }
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
-/*
- * Allocate and free page tables.
- */
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
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
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 #define __pte_free_tlb(tlb,pte,addr)			\
 do {							\
 	pgtable_page_dtor(pte);				\
-- 
2.7.4

