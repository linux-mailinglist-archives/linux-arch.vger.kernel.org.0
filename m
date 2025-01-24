Return-Path: <linux-arch+bounces-9901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C0A1BF6B
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6847A3A98
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA351F5430;
	Fri, 24 Jan 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TKAFsMxw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E41F4729;
	Fri, 24 Jan 2025 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763008; cv=none; b=dmlPqhlmrlQQC0m+72VgNmPrLLL4mqeG3Y8UplaSO23yU8jGzSK5rjrOcBiCi/D7JplnKXZx7vGtyXO5Xs5Mcbkfmr9bXCm1MOo2FwRlJpHgjc3htPuBFzLS7guHqiJhcWSEcIWpuxMsNyE08WWwTXv7ABJGujiLd5CKdS2lw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763008; c=relaxed/simple;
	bh=r9ZQ12ZIgNTFTk7kaqzMBVjLOWGf8XLqE9dCL3V25Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzIzt3/kycmiijU/DTdFc/zdM6w9zjLJh896VtMfB/aJ3orb86q3rtPndaXzkYxRMmun+je3jKhUjuA12Cb9tUVj5BUCCGzYeg8qYQTpIuIwVCFZNlm2K1K/6jxk/57efOgYwrUwa9bWwNYYX+wGSP3Nb/lUAaSy9ejelYHV8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TKAFsMxw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIDTDv002066;
	Fri, 24 Jan 2025 23:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=W/gkk
	8s5Xxm+HTDJna5mPHZqxpMgtw4DEDxvy6ObgxU=; b=TKAFsMxw1dXtdtOqEkfGV
	AVdqkRY2RaTdu3ZmNNPD24QQMG/BLy7lFLPKQesBM2vgbBHmiE9tOyS6uYXZD9a8
	igkuBfXhy7Q+VQB0Bm8CIozCZ7QQEBlmnDjvf+UaytMwnp0OMnxpxlBDMaVKYQmq
	P9D0laJVFb14OHi14s8rtz/KnzjNr/Fh6nc8gkVLCGAATk+D/arv9PRIvMfr7kHG
	6/lLtbfBmh/jzKaJR+mgTQutGpbydQuuNkiX+EmfQy6FHGubtdh8EJOxsuwy9JOT
	yAsDLorshtbQQvpBZtJ7Z37vUlSH8xD+TAbBo5nI9nKMmO7mYH7lUg8XO5iRsEmU
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b06j5j4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMEEls036463;
	Fri, 24 Jan 2025 23:56:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4aqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQM018051;
	Fri, 24 Jan 2025 23:56:12 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-21;
	Fri, 24 Jan 2025 23:56:11 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: anthony.yznaga@oracle.com, jthoughton@google.com, corbet@lwn.net,
        dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
        liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, tglx@linutronix.de, cgroups@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: [PATCH 20/20] mm/mshare: associate a mem cgroup with an mshare file
Date: Fri, 24 Jan 2025 15:54:54 -0800
Message-ID: <20250124235454.84587-21-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124235454.84587-1-anthony.yznaga@oracle.com>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: Z6OzEU8bsVr0C8NMG9E5ROuvsfbs4fjT
X-Proofpoint-GUID: Z6OzEU8bsVr0C8NMG9E5ROuvsfbs4fjT

This patch shows one approach to associating a specific mem cgroup to
an mshare file and was inspired by code in mem_cgroup_sk_alloc().
Essentially when a process creates an mshare region, a reference is
taken on the mem cgroup that the process belongs to and a pointer to
the memcg is saved. At fault time set_active_memcg() is used to
temporarily enable charging of __GFP_ACCOUNT allocations to the saved
memcg. This does consolidate pagetable charges to a single memcg, but
there are issues to address such as how to handle the case where the
memcg is deleted but becomes a hidden, zombie memcg because the mshare
file has a reference to it.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/fault.c | 11 +++++++++++
 include/linux/mm.h  |  5 +++++
 mm/mshare.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4b55ade61a01..1b50417f68ad 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -21,6 +21,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/memcontrol.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1219,6 +1220,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	bool is_shared_vma;
 	unsigned long addr;
+	struct mem_cgroup *mshare_memcg;
+	struct mem_cgroup *memcg;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1375,6 +1378,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	if (unlikely(vma_is_mshare(vma))) {
+		mshare_memcg = get_mshare_memcg(vma);
+
 		fault = find_shared_vma(&vma, &addr);
 
 		if (fault) {
@@ -1402,6 +1407,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
+	if (is_shared_vma && mshare_memcg)
+		memcg = set_active_memcg(mshare_memcg);
+
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
@@ -1417,6 +1425,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	fault = handle_mm_fault(vma, addr, flags, regs);
 
+	if (is_shared_vma && mshare_memcg)
+		set_active_memcg(memcg);
+
 	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
 	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs)))
 		mmap_read_unlock(mm);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80429d1a6ae4..eaa304d22a9d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1110,12 +1110,17 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
 int vma_is_stack_for_current(struct vm_area_struct *vma);
 
 #ifdef CONFIG_MSHARE
+struct mem_cgroup *get_mshare_memcg(struct vm_area_struct *vma);
 vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp);
 static inline bool vma_is_mshare(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_MSHARE;
 }
 #else
+static inline struct mem_cgroup *get_mshare_memcg(struct vm_area_struct *vma)
+{
+	return NULL;
+}
 static inline vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp)
 {
 	WARN_ON_ONCE(1);
diff --git a/mm/mshare.c b/mm/mshare.c
index 5cc416cfd78c..a56e56c90aaa 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/memcontrol.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <linux/spinlock_types.h>
@@ -30,8 +31,22 @@ struct mshare_data {
 	spinlock_t m_lock;
 	struct mshare_info minfo;
 	struct mmu_notifier mn;
+#ifdef CONFIG_MEMCG
+	struct mem_cgroup *memcg;
+#endif
 };
 
+struct mem_cgroup *get_mshare_memcg(struct vm_area_struct *vma)
+{
+	struct mshare_data *m_data = vma->vm_private_data;
+
+#ifdef CONFIG_MEMCG
+	return m_data->memcg;
+#else
+	return NULL;
+#endif
+}
+
 static void mshare_invalidate_tlbs(struct mmu_notifier *mn, struct mm_struct *mm,
 				   unsigned long start, unsigned long end)
 {
@@ -358,6 +373,9 @@ msharefs_fill_mm(struct inode *inode)
 	struct mm_struct *mm;
 	struct mshare_data *m_data = NULL;
 	int ret = 0;
+#ifdef CONFIG_MEMCG
+	struct mem_cgroup *memcg;
+#endif
 
 	mm = mm_alloc();
 	if (!mm) {
@@ -383,6 +401,17 @@ msharefs_fill_mm(struct inode *inode)
 
 #ifdef CONFIG_MEMCG
 	mm->owner = NULL;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+	if (mem_cgroup_is_root(memcg))
+		goto out;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		goto out;
+	if (css_tryget(&memcg->css))
+		m_data->memcg = memcg;
+out:
+	rcu_read_unlock();
 #endif
 	return 0;
 
@@ -396,6 +425,10 @@ msharefs_fill_mm(struct inode *inode)
 static void
 msharefs_delmm(struct mshare_data *m_data)
 {
+#ifdef CONFIG_MEMCG
+	if (m_data->memcg)
+		css_put(&m_data->memcg->css);
+#endif
 	mmput(m_data->mm);
 	kfree(m_data);
 }
-- 
2.43.5


