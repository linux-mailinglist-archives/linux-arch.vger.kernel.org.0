Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5325403A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgH0IFs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 04:05:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbgH0IFn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 04:05:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R82NKZ095462;
        Thu, 27 Aug 2020 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cZ8pu+MqxRLeKoX7WBnqgr5YHzhMwJVnQd2Dx1YAPM4=;
 b=ZTOF/LJRQN3O/qL653dAck0Gq3DaQBhJSmU1L9o++AZXFk6LU2f41mtrkBY5vWHuZb6s
 RWYsMkxfCTYVbx2HbmPDCUrElYATNKZl6wSyOJe0l0x4TxUP0UWDoR6lZ7b7IP3PT7Mb
 0i625NLPnDMae1Icj7+vPnLqpvfHf8dnclN4XZbbKSw+/f2pjujUpxDesXW9pM+7QhdP
 7xhzwhpp48Fzl0SuNwmc1SlMaR51FZsgvV1E40+8SSzquKrt1ZDzN3DJphSl8gnGLTAC
 k9CN8x4gl8KWXTdpn8twU8+WsSf5/gXkyvVbvGb6C+Wa2iHRfrv6WSfF+m8P5fTgmIYO Bw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3366qjc1wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 04:05:20 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R81sER000814;
        Thu, 27 Aug 2020 08:05:19 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 335kvcjb2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 08:05:19 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R85H9758851584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 08:05:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 211997806D;
        Thu, 27 Aug 2020 08:05:17 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 699CC7807F;
        Thu, 27 Aug 2020 08:05:12 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.17.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 08:05:12 +0000 (GMT)
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
Subject: [PATCH v3 05/13] mm/debug_vm_pgtable/savedwrite: Enable savedwrite test with CONFIG_NUMA_BALANCING
Date:   Thu, 27 Aug 2020 13:34:30 +0530
Message-Id: <20200827080438.315345-6-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=910 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Saved write support was added to track the write bit of a pte after marking the
pte protnone. This was done so that AUTONUMA can convert a write pte to protnone
and still track the old write bit. When converting it back we set the pte write
bit correctly thereby avoiding a write fault again. Hence enable the test only
when CONFIG_NUMA_BALANCING is enabled and use protnone protflags.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 28f9d0558c20..5c0680836fe9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -119,10 +119,14 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pte_t pte = pfn_pte(pfn, prot);
 
+	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+		return;
+
 	pr_debug("Validating PTE saved write\n");
 	WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
 	WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
 }
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 {
@@ -235,6 +239,9 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd = pfn_pmd(pfn, prot);
 
+	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+		return;
+
 	pr_debug("Validating PMD saved write\n");
 	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
 	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
@@ -1020,8 +1027,8 @@ static int __init debug_vm_pgtable(void)
 	pmd_huge_tests(pmdp, pmd_aligned, prot);
 	pud_huge_tests(pudp, pud_aligned, prot);
 
-	pte_savedwrite_tests(pte_aligned, prot);
-	pmd_savedwrite_tests(pmd_aligned, prot);
+	pte_savedwrite_tests(pte_aligned, protnone);
+	pmd_savedwrite_tests(pmd_aligned, protnone);
 
 	pte_unmap_unlock(ptep, ptl);
 
-- 
2.26.2

