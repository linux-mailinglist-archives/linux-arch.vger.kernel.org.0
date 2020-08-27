Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A54254034
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH0IFg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:05:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbgH0IFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:05:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R82NaX095461;
        Thu, 27 Aug 2020 04:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lRtd7ye0+CNHfnxvkGBpHOyntXvdI5t4XHx4fH21RiQ=;
 b=k6NeVAWEFW1l5NOYyuMOpkRmCIKcQc4pfqN1pEkt9w23ZhJjR+2KxNrk6kaajPbymxec
 iyFoZIw+HGDcYyfnLl2KwOCp+ZSozCIUTzs4aYKqxdty7ceky6g9ffFg6ODTJOTIhUYg
 Zgfcyj5X9yAf40ubbzxA46kgvrC5wtj2TPG1nFpW/0hnRY/mkunQrXcSOvbFlhesj8yk
 In4QOzl6pcjOrKOs+dcI8/c7gXKRqb151HtSBUZ8z9priODiLoPH3Kbxl/4F8gIJSAXf
 0aILG+TFG7ebn11Hem19ZLIWFx0VSxLcQTnimTchZq+O8XJjtV2WhTrHN6awmcRtR/p8 jQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3366qjc1r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:05:09 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R838h3019621;
        Thu, 27 Aug 2020 08:05:08 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 332utttcpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:05:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R856EF53805342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:05:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9126978074;
        Thu, 27 Aug 2020 08:05:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D31227805E;
        Thu, 27 Aug 2020 08:05:01 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:05:01 +0000 (GMT)
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
Subject: [PATCH v3 03/13] mm/debug_vm_pgtable/ppc64: Avoid setting top bits in radom value
Date:   Thu, 27 Aug 2020 13:34:28 +0530
Message-Id: <20200827080438.315345-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=891 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in
random value.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 086309fb9b6f..bbf9df0e64c6 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -44,10 +44,17 @@
  * entry type. But these bits might affect the ability to clear entries with
  * pxx_clear() because of how dynamic page table folding works on s390. So
  * while loading up the entries do not change the lower 4 bits. It does not
- * have affect any other platform.
+ * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
+ * used to mark a pte entry.
  */
-#define S390_MASK_BITS	4
-#define RANDOM_ORVALUE	GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
+#define S390_SKIP_MASK		GENMASK(3, 0)
+#ifdef CONFIG_PPC_BOOK3S_64
+#define PPC64_SKIP_MASK		GENMASK(62, 62)
+#else
+#define PPC64_SKIP_MASK		0x0
+#endif
+#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
+#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
 #define RANDOM_NZVALUE	GENMASK(7, 0)
 
 static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
-- 
2.26.2

