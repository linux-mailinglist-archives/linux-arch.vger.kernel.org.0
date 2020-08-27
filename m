Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A8254041
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH0IGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:06:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgH0IGS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:06:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R82xQI142173;
        Thu, 27 Aug 2020 04:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OvSP3qpJFR9OhAdIPzACmh0Xn36L9RSsnbZasnu6ewI=;
 b=nr6pJFzLMhxkIatfxVtR8ti4HGyKuLPKkplBfvTQiOupIxkvk6WnYNz4qeKKzE3LcqVn
 pkp0B3+kf7eUxOyQ5rBoESTkNSvtQeL2A6Ufgs2RPW92lbV6whumwx9xbq0ua5Ul+ObY
 mwSi6QcO/HMRvgqoCk8TCLdDqgz50L+GYLSHrXS27KKWoPF/LtifYXh8itHkvAmT0k2I
 OtWRJMAYq7TGYCFnxSsXZrkbanCgqlAkaG8z4yshVhuLCGSxtpWFKk97Yy4DZQNrs6Zu
 6dFcTro1orHZNOYbcwfiI0QeYoEz0yaN73sn2yusIYWKwTJwq3RAs2A6Z1eIlVZpuTIb aw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3366a0mhv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:05:45 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R82YVS020644;
        Thu, 27 Aug 2020 08:05:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 332utr89as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:05:43 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R85ga759703708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:05:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 903897806A;
        Thu, 27 Aug 2020 08:05:42 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0805278060;
        Thu, 27 Aug 2020 08:05:38 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:05:37 +0000 (GMT)
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
Subject: [PATCH v3 10/13] mm/debug_vm_pgtable/locks: Take correct page table lock
Date:   Thu, 27 Aug 2020 13:34:35 +0530
Message-Id: <20200827080438.315345-11-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=2 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make sure we call pte accessors with correct lock held.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 78c8af3445ac..0a6e771ebd13 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1039,33 +1039,39 @@ static int __init debug_vm_pgtable(void)
 	pmd_thp_tests(pmd_aligned, prot);
 	pud_thp_tests(pud_aligned, prot);
 
+	hugetlb_basic_tests(pte_aligned, prot);
+
 	/*
 	 * Page table modifying tests
 	 */
-	pte_clear_tests(mm, ptep, vaddr);
-	pmd_clear_tests(mm, pmdp);
-	pud_clear_tests(mm, pudp);
-	p4d_clear_tests(mm, p4dp);
-	pgd_clear_tests(mm, pgdp);
 
 	ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
+	pte_clear_tests(mm, ptep, vaddr);
 	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
-	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
-	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
-	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
-
+	pte_unmap_unlock(ptep, ptl);
 
+	ptl = pmd_lock(mm, pmdp);
+	pmd_clear_tests(mm, pmdp);
+	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
 	pmd_huge_tests(pmdp, pmd_aligned, prot);
+	pmd_populate_tests(mm, pmdp, saved_ptep);
+	spin_unlock(ptl);
+
+	ptl = pud_lock(mm, pudp);
+	pud_clear_tests(mm, pudp);
+	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
 	pud_huge_tests(pudp, pud_aligned, prot);
+	pud_populate_tests(mm, pudp, saved_pmdp);
+	spin_unlock(ptl);
 
-	pte_unmap_unlock(ptep, ptl);
+	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
 
-	pmd_populate_tests(mm, pmdp, saved_ptep);
-	pud_populate_tests(mm, pudp, saved_pmdp);
+	spin_lock(&mm->page_table_lock);
+	p4d_clear_tests(mm, p4dp);
+	pgd_clear_tests(mm, pgdp);
 	p4d_populate_tests(mm, p4dp, saved_pudp);
 	pgd_populate_tests(mm, pgdp, saved_p4dp);
-
-	hugetlb_basic_tests(pte_aligned, prot);
+	spin_unlock(&mm->page_table_lock);
 
 	p4d_free(mm, saved_p4dp);
 	pud_free(mm, saved_pudp);
-- 
2.26.2

