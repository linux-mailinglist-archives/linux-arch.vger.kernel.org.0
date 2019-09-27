Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D47C0E76
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2019 01:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfI0XlL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 19:41:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfI0XlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RNbUe8012402;
        Fri, 27 Sep 2019 19:40:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9u0p9mx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:30 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RNbbf7012938;
        Fri, 27 Sep 2019 19:40:30 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9u0p9mx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:30 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RNeQkB024558;
        Fri, 27 Sep 2019 23:40:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 2v5bg8k662-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 23:40:29 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RNeSeh51380510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 23:40:28 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 107F6112069;
        Fri, 27 Sep 2019 23:40:28 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615A1112062;
        Fri, 27 Sep 2019 23:40:24 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.58])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 23:40:24 +0000 (GMT)
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
Subject: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor lockless pgtable walks
Date:   Fri, 27 Sep 2019 20:39:58 -0300
Message-Id: <20190927234008.11513-2-leonardo@linux.ibm.com>
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270205
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's necessary to monitor lockless pagetable walks, in order to avoid doing
THP splitting/collapsing during them.

Some methods rely on local_irq_{save,restore}, but that can be slow on
cases with a lot of cpus are used for the process.

In order to speedup some cases, I propose a refcount-based approach, that
counts the number of lockless pagetable	walks happening on the process.

This method does not exclude the current irq-oriented method. It works as a
complement to skip unnecessary waiting.

start_lockless_pgtbl_walk(mm)
	Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk(mm)
	Insert after the end of any lockless pgtable walk
	(Mostly after the ptep is last used)
running_lockless_pgtbl_walk(mm)
	Returns the number of lockless pgtable walks running

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  3 ++
 arch/powerpc/mm/book3s64/mmu_context.c   |  1 +
 arch/powerpc/mm/book3s64/pgtable.c       | 45 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 23b83d3593e2..13b006e7dde4 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -116,6 +116,9 @@ typedef struct {
 	/* Number of users of the external (Nest) MMU */
 	atomic_t copros;
 
+	/* Number of running instances of lockless pagetable walk*/
+	atomic_t lockless_pgtbl_walk_count;
+
 	struct hash_mm_context *hash_context;
 
 	unsigned long vdso_base;
diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 2d0cb5ba9a47..3dd01c0ca5be 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -200,6 +200,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 #endif
 	atomic_set(&mm->context.active_cpus, 0);
 	atomic_set(&mm->context.copros, 0);
+	atomic_set(&mm->context.lockless_pgtbl_walk_count, 0);
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 7d0e0d0d22c4..6ba6195bff1b 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -98,6 +98,51 @@ void serialize_against_pte_lookup(struct mm_struct *mm)
 	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
 }
 
+/*
+ * Counting method to monitor lockless pagetable walks:
+ * Uses start_lockless_pgtbl_walk and end_lockless_pgtbl_walk to track the
+ * number of lockless pgtable walks happening, and
+ * running_lockless_pgtbl_walk to return this value.
+ */
+
+/* start_lockless_pgtbl_walk: Must be inserted before a function call that does
+ *   lockless pagetable walks, such as __find_linux_pte()
+ */
+void start_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	atomic_inc(&mm->context.lockless_pgtbl_walk_count);
+	/* Avoid reorder to garantee that the increment will happen before any
+	 * part of the walkless pagetable walk after it.
+	 */
+	smp_mb();
+}
+EXPORT_SYMBOL(start_lockless_pgtbl_walk);
+
+/*
+ * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
+ *   returned by a lockless pagetable walk, such as __find_linux_pte()
+*/
+void end_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	/* Avoid reorder to garantee that it will only decrement after the last
+	 * use of the returned ptep from the lockless pagetable walk.
+	 */
+	smp_mb();
+	atomic_dec(&mm->context.lockless_pgtbl_walk_count);
+}
+EXPORT_SYMBOL(end_lockless_pgtbl_walk);
+
+/*
+ * running_lockless_pgtbl_walk: Returns the number of lockless pagetable walks
+ *   currently running. If it returns 0, there is no running pagetable walk, and
+ *   THP split/collapse can be safely done. This can be used to avoid more
+ *   expensive approaches like serialize_against_pte_lookup()
+ */
+int running_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	return atomic_read(&mm->context.lockless_pgtbl_walk_count);
+}
+
 /*
  * We use this to invalidate a pmdp entry before switching from a
  * hugepte to regular pmd entry.
-- 
2.20.1

