Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B032B254040
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgH0IGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:06:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgH0IGQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:06:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R82AJp089124;
        Thu, 27 Aug 2020 04:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8PtFzrUGi6Q4DWzM5i8bzCUhGhNKkttqYzeEDhiaZbM=;
 b=rdLw225bSS02s0d+HzqfxFftXBHZ+nVuFXErgUEy6pwZoKSSw53ZZ/j3ftfndHcjJ1mr
 lkh9NKbC4BObH3ho0lzAs0oU5SC1/8eQ4UKluWXQkVq2+heD9JcazRaezSWWNR7lPMc6
 Hvcdmp9XIWl/QfMPAd47oUwXLzddGVH0n0LQKYXujKQPjxzO7voMEp/GX7BrCK6icqAa
 10cBmInlKWxpxxgCzPSbIop/v2pFOrtdTt772nz60KMqGb4DKaNIYdmZKE14EAsTW5Yk
 d7xN0dr7FBd6yOwVaAwpt0XsGU0D+CsBLhFcphRoc1aFTW7afsOM0TFVhy93A79PSS+5 Tg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3368s38f8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:05:35 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R82Zfq016541;
        Thu, 27 Aug 2020 08:05:33 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 332ujqgcdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:05:33 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R85Wa624707410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:05:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713297805C;
        Thu, 27 Aug 2020 08:05:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08C5B7805F;
        Thu, 27 Aug 2020 08:05:28 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:05:27 +0000 (GMT)
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
Subject: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table depost/withdraw with THP
Date:   Thu, 27 Aug 2020 13:34:33 +0530
Message-Id: <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architectures like ppc64 use deposited page table while updating the huge pte
entries.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index f9f6358899a8..0ce5c6a24c5b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -154,7 +154,7 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pmd_t *pmdp,
 				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+				      pgprot_t prot, pgtable_t pgtable)
 {
 	pmd_t pmd;
 
@@ -165,6 +165,8 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 	/* Align the address wrt HPAGE_PMD_SIZE */
 	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
 
+	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
+
 	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
 	set_pmd_at(mm, vaddr, pmdp, pmd);
 	pmdp_set_wrprotect(mm, vaddr, pmdp);
@@ -193,6 +195,8 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 	pmdp_test_and_clear_young(vma, vaddr, pmdp);
 	pmd = READ_ONCE(*pmdp);
 	WARN_ON(pmd_young(pmd));
+
+	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
 }
 
 static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
@@ -373,7 +377,7 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
 static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pmd_t *pmdp,
 				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+				      pgprot_t prot, pgtable_t pgtable)
 {
 }
 static void __init pud_advanced_tests(struct mm_struct *mm,
@@ -1015,7 +1019,7 @@ static int __init debug_vm_pgtable(void)
 	pgd_clear_tests(mm, pgdp);
 
 	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
-	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot);
+	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
 	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
 	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
 
-- 
2.26.2

