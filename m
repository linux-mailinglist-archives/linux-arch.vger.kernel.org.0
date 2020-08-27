Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E0254049
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgH0IGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:06:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgH0IGc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:06:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R81xRL120591;
        Thu, 27 Aug 2020 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hIlWSk6ofeiZwpYPzcLI119bUUppUCBMvwXOLDNsUJ8=;
 b=o8XOz+vMaiTZIbchkmCPYvakYhmlmEldbkUWKKXR5rbA/kmgPswLj0MAEW4pJkeQPRvK
 MgM6Bg8ONQHnnhGKBUFYJbTHOSNvz/BIkIDR9b/kewePzxX4pZnw5VyombDYzOt4j9bo
 OS5Du1kZXmbldof/olfuf+RG8Q1ZZMWG1OclELA4491bcGDt0CKS5CMRJrxG1BqAAHeQ
 SVNuJ+v/MoNtiPbW8YFn8bL+C/L9pvpNlXvvwZzSXwqSv1TSrYYWs6OcTwp1+/JCX95G
 3lRnFU29KxpuAHTXNpJc1sNIDQJO3GLxMQOxjRq0XRlsk8vzDEeLlELEHOjjK//+MnFN TA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3367syt981-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:06:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R81uq2000840;
        Thu, 27 Aug 2020 08:06:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 335kvcjb8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:06:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R85t8o8913514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:05:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C2C97805F;
        Thu, 27 Aug 2020 08:05:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43FB7805E;
        Thu, 27 Aug 2020 08:05:53 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:05:53 +0000 (GMT)
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
Subject: [PATCH v3 13/13] mm/debug_vm_pgtable: populate a pte entry before fetching it
Date:   Thu, 27 Aug 2020 13:34:38 +0530
Message-Id: <20200827080438.315345-14-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=946
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

pte_clear_tests operate on an existing pte entry. Make sure that is not a none
pte entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 21329c7d672f..8527ebb75f2c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -546,7 +546,7 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
 				   unsigned long vaddr)
 {
-	pte_t pte = ptep_get(ptep);
+	pte_t pte =  ptep_get_and_clear(mm, vaddr, ptep);
 
 	pr_debug("Validating PTE clear\n");
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
@@ -944,7 +944,7 @@ static int __init debug_vm_pgtable(void)
 	p4d_t *p4dp, *saved_p4dp;
 	pud_t *pudp, *saved_pudp;
 	pmd_t *pmdp, *saved_pmdp, pmd;
-	pte_t *ptep;
+	pte_t *ptep, pte;
 	pgtable_t saved_ptep;
 	pgprot_t prot, protnone;
 	phys_addr_t paddr;
@@ -1049,6 +1049,8 @@ static int __init debug_vm_pgtable(void)
 	 */
 
 	ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
+	pte = pfn_pte(pte_aligned, prot);
+	set_pte_at(mm, vaddr, ptep, pte);
 	pte_clear_tests(mm, ptep, vaddr);
 	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
 	pte_unmap_unlock(ptep, ptl);
-- 
2.26.2

