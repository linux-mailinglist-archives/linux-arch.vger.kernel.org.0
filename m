Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BC8153D73
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgBFDNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:13:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727577AbgBFDNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:13:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01639EMI096736;
        Wed, 5 Feb 2020 22:12:53 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhn60kte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:12:53 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0163Bgpt101390;
        Wed, 5 Feb 2020 22:12:52 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhn60kt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:12:52 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0163BmQl013924;
        Thu, 6 Feb 2020 03:12:51 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2xykc9489r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 03:12:51 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0163Cnb937028238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 03:12:50 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE62EBE053;
        Thu,  6 Feb 2020 03:12:49 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1A82BE051;
        Thu,  6 Feb 2020 03:12:33 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.163.250])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 03:12:33 +0000 (GMT)
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
Subject: [PATCH v6 10/11] powerpc/mm: Adds counting method to track lockless pagetable walks
Date:   Thu,  6 Feb 2020 00:08:59 -0300
Message-Id: <20200206030900.147032-11-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060022
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implements an additional feature to track lockless pagetable walks,
using a per-cpu counter: lockless_pgtbl_walk_counter.

Before a lockless pagetable walk, preemption is disabled and the
current cpu's counter is increased.
When the lockless pagetable walk finishes, the current cpu counter
is decreased and the preemption is enabled.

With that, it's possible to know in which cpus are happening lockless
pagetable walks, and optimize serialize_against_pte_lookup().

Implementation notes:
- Every counter can be changed only by it's CPU
- It makes use of the original memory barrier in the functions
- Any counter can be read by any CPU

Due to not locking nor using atomic variables, the impact on the
lockless pagetable walk is intended to be minimum.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/pgtable.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 535613030363..bb138b628f86 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -83,6 +83,7 @@ static void do_nothing(void *unused)
 
 }
 
+static DEFINE_PER_CPU(int, lockless_pgtbl_walk_counter);
 /*
  * Serialize against find_current_mm_pte which does lock-less
  * lookup in page tables with local interrupts disabled. For huge pages
@@ -120,6 +121,15 @@ unsigned long __begin_lockless_pgtbl_walk(bool disable_irq)
 	if (disable_irq)
 		local_irq_save(irq_mask);
 
+	/*
+	 * Counts this instance of lockless pagetable walk for this cpu.
+	 * Disables preempt to make sure there is no cpu change between
+	 * begin/end lockless pagetable walk, so that percpu counting
+	 * works fine.
+	 */
+	preempt_disable();
+	(*this_cpu_ptr(&lockless_pgtbl_walk_counter))++;
+
 	/*
 	 * This memory barrier pairs with any code that is either trying to
 	 * delete page tables, or split huge pages. Without this barrier,
@@ -158,6 +168,14 @@ inline void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq)
 	 */
 	smp_mb();
 
+	/*
+	 * Removes this instance of lockless pagetable walk for this cpu.
+	 * Enables preempt only after end lockless pagetable walk,
+	 * so that percpu counting works fine.
+	 */
+	(*this_cpu_ptr(&lockless_pgtbl_walk_counter))--;
+	preempt_enable();
+
 	/*
 	 * Interrupts must be disabled during the lockless page table walk.
 	 * That's because the deleting or splitting involves flushing TLBs,
-- 
2.24.1

