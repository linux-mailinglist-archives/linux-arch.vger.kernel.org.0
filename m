Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3628153D51
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBFDKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:10:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgBFDKj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:10:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01639Evp096685;
        Wed, 5 Feb 2020 22:09:54 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhn60hmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:09:54 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01639fC0097620;
        Wed, 5 Feb 2020 22:09:53 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhn60hmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:09:53 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01639i51021875;
        Thu, 6 Feb 2020 03:09:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 2xykc9ht08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 03:09:53 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01639pgY56492474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 03:09:51 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B0A3BE051;
        Thu,  6 Feb 2020 03:09:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D720BE04F;
        Thu,  6 Feb 2020 03:09:31 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.163.250])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 03:09:31 +0000 (GMT)
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
Subject: [PATCH v6 01/11] asm-generic/pgtable: Adds generic functions to track lockless pgtable walks
Date:   Thu,  6 Feb 2020 00:08:50 -0300
Message-Id: <20200206030900.147032-2-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=865 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060022
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's necessary to track lockless pagetable walks, in order to avoid doing
THP splitting/collapsing during them.

The default solution is to disable irq before lockless pagetable walks and
enable it after it's finished.

On code, this means you can find local_irq_disable() and local_irq_enable()
around some pieces of code, usually without comments on why it is needed.

This patch proposes a set of generic functions to be called before starting
and after finishing a lockless pagetable walk. It is supposed to make clear
that a lockless pagetable walk happens there, and also carries information
on why the irq disable/enable is needed.

begin_lockless_pgtbl_walk()
        Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk()
        Insert after the end of any lockless pgtable walk
        (Mostly after the ptep is last used)

A memory barrier was also added just to make sure there is no speculative
read outside the interrupt disabled area. Other than that, it is not
supposed to have any change of behavior from current code.

It is planned to allow arch-specific versions, so that additional steps can
be added while keeping the code clean.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 include/asm-generic/pgtable.h | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index e2e2bef07dd2..8d368d3c0974 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1222,6 +1222,57 @@ static inline bool arch_has_pfn_modify_check(void)
 #endif
 #endif
 
+#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
+/*
+ * begin_lockless_pgtbl_walk: Must be inserted before a function call that does
+ *   lockless pagetable walks, such as __find_linux_pte()
+ */
+static inline
+unsigned long begin_lockless_pgtbl_walk(void)
+{
+	unsigned long irq_mask;
+
+	/*
+	 * Interrupts must be disabled during the lockless page table walk.
+	 * That's because the deleting or splitting involves flushing TLBs,
+	 * which in turn issues interrupts, that will block when disabled.
+	 */
+	local_irq_save(irq_mask);
+
+	/*
+	 * This memory barrier pairs with any code that is either trying to
+	 * delete page tables, or split huge pages. Without this barrier,
+	 * the page tables could be read speculatively outside of interrupt
+	 * disabling.
+	 */
+	smp_mb();
+
+	return irq_mask;
+}
+
+/*
+ * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
+ *   returned by a lockless pagetable walk, such as __find_linux_pte()
+ */
+static inline void end_lockless_pgtbl_walk(unsigned long irq_mask)
+{
+	/*
+	 * This memory barrier pairs with any code that is either trying to
+	 * delete page tables, or split huge pages. Without this barrier,
+	 * the page tables could be read speculatively outside of interrupt
+	 * disabling.
+	 */
+	smp_mb();
+
+	/*
+	 * Interrupts must be disabled during the lockless page table walk.
+	 * That's because the deleting or splitting involves flushing TLBs,
+	 * which in turn issues interrupts, that will block when disabled.
+	 */
+	local_irq_restore(irq_mask);
+}
+#endif
+
 /*
  * On some architectures it depends on the mm if the p4d/pud or pmd
  * layer of the page table hierarchy is folded or not.
-- 
2.24.1

