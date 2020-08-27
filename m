Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327EA25402F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgH0IF0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:05:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25170 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbgH0IFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:05:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R83dnZ020480;
        Thu, 27 Aug 2020 04:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QW1+HHhW/j4HGov2uFp7zP87T7YB1xtvslyOymICYdA=;
 b=G3ttW55vj4Siwp8bGOJCFSAe+1RMwygT07c6E/QOJXwlY9bSCo14Omcv+H+YW3Qv1AeY
 eBamsBr24dagLcftHlLx2hZY87R4YJqYNCKYdrx1WsVFcexFpzxP6S7QqVzEcPB11CXQ
 RbwFrvM3wTm3/2DRvHd6azfJuMXVxsEC5kIWuZF7Pv/Xy1Z1QCZsM7xiVVKFOA+Y6iKs
 HXVupzGZT+r2uxBxRrsTZ/KXPlTPza935CtqdQQ1ATagp4y1BOYv+OQnBrGLs1Y13HJq
 CxG5Fq28fUYjNKEW9gWoCkxfMvco2CD/hBqmO3wTRioTf7RH+yPf5WjKwl4WWLV6jJEI uQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3368t9rdur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:05:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R838h0019621;
        Thu, 27 Aug 2020 08:05:03 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 332utttcnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:05:02 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R84wZX56492380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:04:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 425137805C;
        Thu, 27 Aug 2020 08:05:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E4F97805F;
        Thu, 27 Aug 2020 08:04:56 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:04:56 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 02/13] powerpc/mm: Move setting pte specific flags to pfn_pte
Date:   Thu, 27 Aug 2020 13:34:27 +0530
Message-Id: <20200827080438.315345-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=597 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270060
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc used to set the pte specific flags in set_pte_at(). This is different
from other architectures. To be consistent with other architecture update
pfn_pte to set _PAGE_PTE on ppc64. Also, drop now unused pte_mkpte.

We add a VM_WARN_ON() to catch the usage of calling set_pte_at() without setting
_PAGE_PTE bit. We will remove that after a few releases.

With respect to huge pmd entries, pmd_mkhuge() takes care of adding the
_PAGE_PTE bit.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 15 +++++++++------
 arch/powerpc/include/asm/nohash/pgtable.h    |  5 -----
 arch/powerpc/mm/pgtable.c                    |  5 -----
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 079211968987..2382fd516f6b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -619,7 +619,7 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 	VM_BUG_ON(pfn >> (64 - PAGE_SHIFT));
 	VM_BUG_ON((pfn << PAGE_SHIFT) & ~PTE_RPN_MASK);
 
-	return __pte(((pte_basic_t)pfn << PAGE_SHIFT) | pgprot_val(pgprot));
+	return __pte(((pte_basic_t)pfn << PAGE_SHIFT) | pgprot_val(pgprot) | _PAGE_PTE);
 }
 
 static inline unsigned long pte_pfn(pte_t pte)
@@ -655,11 +655,6 @@ static inline pte_t pte_mkexec(pte_t pte)
 	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_EXEC));
 }
 
-static inline pte_t pte_mkpte(pte_t pte)
-{
-	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_PTE));
-}
-
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	/*
@@ -823,6 +818,14 @@ static inline int pte_none(pte_t pte)
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
+
+	VM_WARN_ON(!(pte_raw(pte) & cpu_to_be64(_PAGE_PTE)));
+	/*
+	 * Keep the _PAGE_PTE added till we are sure we handle _PAGE_PTE
+	 * in all the callers.
+	 */
+	 pte = __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_PTE));
+
 	if (radix_enabled())
 		return radix__set_pte_at(mm, addr, ptep, pte, percpu);
 	return hash__set_pte_at(mm, addr, ptep, pte, percpu);
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 4b7c3472eab1..6277e7596ae5 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -140,11 +140,6 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
-static inline pte_t pte_mkpte(pte_t pte)
-{
-	return pte;
-}
-
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9c0547d77af3..ab57b07ef39a 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -184,9 +184,6 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 */
 	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
 
-	/* Add the pte bit when trying to set a pte */
-	pte = pte_mkpte(pte);
-
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
 	 * is called.
@@ -275,8 +272,6 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_
 	 */
 	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
 
-	pte = pte_mkpte(pte);
-
 	pte = set_pte_filter(pte);
 
 	val = pte_val(pte);
-- 
2.26.2

