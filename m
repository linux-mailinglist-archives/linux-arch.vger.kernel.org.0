Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0386254036
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgH0IFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:05:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727823AbgH0IFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:05:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R82EL2026701;
        Thu, 27 Aug 2020 04:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=893UJQi8hOsUkObBOmcaXi0QGZ1whNTeHCCSlXG9Ep0=;
 b=n+kOVFv6ly4U8+r/J6T1xNXylRM2v5/u1pliBjQEayr4rtHHXGkjTGIAlTSrfU+AezDF
 s/THgQZkDnGv9KaNV62795WuqI/sj/olL9erWCCiSGgjLzMC4WuJz4AAG0L+iTZ3ms1a
 aD83jTl4NqIAljjrmz8rxWQsQPTgdzb0F8PdZmhcwGvDa/HPWYJq6reinDY/5zLLjExV
 zt+ft4P6GgP48seXLm9td7dOzLba5Je6OPYXhe37TQWwbkGQ6+DWktV/+mFD2+n8GWZm
 MobUQa82b8nud50mJ7EpTGpjEQHM5pTR4Sf25p5FFFKPFe48t4KnAGwd2jWki9UbmLkE Sg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3367x0t2sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:05:16 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R82YFT016529;
        Thu, 27 Aug 2020 08:05:15 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 332ujqgcb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:05:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R85Dpv59834788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:05:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC5178067;
        Thu, 27 Aug 2020 08:05:11 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 335187805C;
        Thu, 27 Aug 2020 08:05:07 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:05:06 +0000 (GMT)
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
Subject: [PATCH v3 04/13] mm/debug_vm_pgtables/hugevmap: Use the arch helper to identify huge vmap support.
Date:   Thu, 27 Aug 2020 13:34:29 +0530
Message-Id: <20200827080438.315345-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ppc64 supports huge vmap only with radix translation. Hence use arch helper
to determine the huge vmap support.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bbf9df0e64c6..28f9d0558c20 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -28,6 +28,7 @@
 #include <linux/swapops.h>
 #include <linux/start_kernel.h>
 #include <linux/sched/mm.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
@@ -206,11 +207,12 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pmd_leaf(pmd));
 }
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd;
 
-	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+	if (!arch_ioremap_pmd_supported())
 		return;
 
 	pr_debug("Validating PMD huge\n");
@@ -224,6 +226,10 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 	pmd = READ_ONCE(*pmdp);
 	WARN_ON(!pmd_none(pmd));
 }
+#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
+static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
+#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
+
 
 static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
@@ -320,11 +326,12 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pud_leaf(pud));
 }
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 {
 	pud_t pud;
 
-	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+	if (!arch_ioremap_pud_supported())
 		return;
 
 	pr_debug("Validating PUD huge\n");
@@ -338,6 +345,10 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 	pud = READ_ONCE(*pudp);
 	WARN_ON(!pud_none(pud));
 }
+#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
+static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
+#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
+
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
-- 
2.26.2

