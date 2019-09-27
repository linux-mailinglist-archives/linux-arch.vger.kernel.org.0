Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD51C0E7E
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2019 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfI0XlX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 19:41:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42378 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbfI0XlX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RNbROp140469;
        Fri, 27 Sep 2019 19:40:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w27era2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:44 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RNbV1S140605;
        Fri, 27 Sep 2019 19:40:43 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w27er99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:43 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RNePml007471;
        Fri, 27 Sep 2019 23:40:40 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2v5bg8k6ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 23:40:40 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RNeeg513566566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 23:40:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9861112062;
        Fri, 27 Sep 2019 23:40:39 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 473FC112065;
        Fri, 27 Sep 2019 23:40:36 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.58])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 23:40:36 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v4 04/11] powerpc/mce_power: Applies counting method to monitor lockless pgtbl walks
Date:   Fri, 27 Sep 2019 20:40:01 -0300
Message-Id: <20190927234008.11513-5-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=720 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270205
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Applies the counting-based method for monitoring lockless pgtable walks on
addr_to_pfn().

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kernel/mce_power.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index a814d2dfb5b0..0f2f87da4cd1 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -27,6 +27,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 {
 	pte_t *ptep;
 	unsigned long flags;
+	unsigned long pfn;
 	struct mm_struct *mm;
 
 	if (user_mode(regs))
@@ -34,15 +35,21 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 	else
 		mm = &init_mm;
 
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	if (mm == current->mm)
 		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
 	else
 		ptep = find_init_mm_pte(addr, NULL);
-	local_irq_restore(flags);
+
 	if (!ptep || pte_special(*ptep))
-		return ULONG_MAX;
-	return pte_pfn(*ptep);
+		pfn = ULONG_MAX;
+	else
+		pfn = pte_pfn(*ptep);
+
+	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
+	return pfn;
 }
 
 /* flush SLBs and reload */
-- 
2.20.1

