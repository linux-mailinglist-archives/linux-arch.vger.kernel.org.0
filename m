Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5562153D54
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBFDKl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:10:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbgBFDKk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:10:40 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016380Jr187211;
        Wed, 5 Feb 2020 22:10:11 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmyc07g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:10:11 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 016399Gm189386;
        Wed, 5 Feb 2020 22:10:10 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmyc06y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:10:10 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01636LhN025844;
        Thu, 6 Feb 2020 03:10:09 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 2xykc9htgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 03:10:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0163A8eQ19136962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 03:10:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C118BE058;
        Thu,  6 Feb 2020 03:10:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5720FBE051;
        Thu,  6 Feb 2020 03:09:52 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.163.250])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 03:09:52 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl walks on gup_pgd_range
Date:   Thu,  6 Feb 2020 00:08:51 -0300
Message-Id: <20200206030900.147032-3-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=887 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002060021
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As described, gup_pgd_range is a lockless pagetable walk. So, in order to
track against THP split/collapse, it disables/enables irq around it.

To make use of the new tracking functions, it replaces irq disable/enable
by {begin,end}_lockless_pgtbl_walk().

As local_irq_{save,restore} is present inside
{begin,end}_lockless_pgtbl_walk, there should be no change in the
workings.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 mm/gup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..04e6f46993b6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2369,7 +2369,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
 {
 	unsigned long len, end;
-	unsigned long flags;
+	unsigned long irq_mask;
 	int nr = 0;
 
 	start = untagged_addr(start) & PAGE_MASK;
@@ -2395,9 +2395,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_save(flags);
+		irq_mask = begin_lockless_pgtbl_walk();
 		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
-		local_irq_restore(flags);
+		end_lockless_pgtbl_walk(irq_mask);
 	}
 
 	return nr;
@@ -2450,9 +2450,9 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_disable();
+		begin_lockless_pgtbl_walk();
 		gup_pgd_range(addr, end, gup_flags, pages, &nr);
-		local_irq_enable();
+		end_lockless_pgtbl_walk(IRQS_ENABLED);
 		ret = nr;
 	}
 
-- 
2.24.1

