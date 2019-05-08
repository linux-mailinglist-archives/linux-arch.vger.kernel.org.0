Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8637E170EC
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2019 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfEHGRk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 May 2019 02:17:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfEHGRk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2019 02:17:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x486GbEu017839
        for <linux-arch@vger.kernel.org>; Wed, 8 May 2019 02:17:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbryuj1un-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 08 May 2019 02:17:38 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 8 May 2019 07:17:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 07:17:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x486HO2w43909196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 06:17:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89B4F52051;
        Wed,  8 May 2019 06:17:24 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4F91C52050;
        Wed,  8 May 2019 06:17:21 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 08 May 2019 09:17:20 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 02/14] alpha: switch to generic version of pte allocation
Date:   Wed,  8 May 2019 09:16:59 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
References: <1557296232-15361-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050806-0028-0000-0000-0000036B6E51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050806-0029-0000-0000-0000242AEA19
Message-Id: <1557296232-15361-3-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=755 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080040
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

alpha allocates PTE pages with __get_free_page() and uses
GFP_KERNEL | __GFP_ZERO for the allocations.

Switch it to the generic version that does exactly the same thing for the
kernel page tables and adds __GFP_ACCOUNT for the user PTEs.

The alpha pte_free() and pte_free_kernel() versions are identical to the
generic ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/pgalloc.h | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 02f9f91..71ded3b 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -5,6 +5,8 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 /*      
  * Allocate and free page tables. The xxx_kernel() versions are
  * used to allocate a kernel page table - this turns on ASN bits
@@ -41,7 +43,7 @@ pgd_free(struct mm_struct *mm, pgd_t *pgd)
 static inline pmd_t *
 pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
+	pmd_t *ret = (pmd_t *)__get_free_page(GFP_PGTABLE_USER);
 	return ret;
 }
 
@@ -51,42 +53,6 @@ pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	free_page((unsigned long)pmd);
 }
 
-static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	return pte;
-}
-
-static inline void
-pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline pgtable_t
-pte_alloc_one(struct mm_struct *mm)
-{
-	pte_t *pte = pte_alloc_one_kernel(mm);
-	struct page *page;
-
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
-}
-
-static inline void
-pte_free(struct mm_struct *mm, pgtable_t page)
-{
-	pgtable_page_dtor(page);
-	__free_page(page);
-}
-
 #define check_pgt_cache()	do { } while (0)
 
 #endif /* _ALPHA_PGALLOC_H */
-- 
2.7.4

