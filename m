Return-Path: <linux-arch+bounces-11270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6FA7B5D9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21473BAA76
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27221145B25;
	Fri,  4 Apr 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIFU++hR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926E2629D;
	Fri,  4 Apr 2025 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733221; cv=none; b=oz8tO6YPEITyuGcxZdudjXRJJAC/Utaw+3I5RE9q6sblyoS0e1K/AuKWejfN+Xoudnj/t4AM6pwCd39rUpG9AyfyHSgir1n5QmgPeNQMtuAbohLbsJcJ1MMI/DpKFWlHk5ZWqH5QgNblth9LrwVUM+V2pCcIn8A6tZEm36bLH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733221; c=relaxed/simple;
	bh=XF/BxC67zLdhqwMqdbDDe7EdWPkQ7k5mYY8vbD+aZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSdKHpxy/OSLcaLwvdIEQCAqoZmFl6BmyAWeY0Y3C464iZw+Wj0zCH//kaQsEJRj9Dgg0Ly1p6d5x/YimF0bzOQkB4EydWyMjFIZtGi5vj3UoT/q9oQD1Uh73SPKIHf5nocq8+NGZ6cbgZ2qYhechMKpN1HNHGGMUvd/YhTNPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIFU++hR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341NVOE008087;
	Fri, 4 Apr 2025 02:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Ktr19
	sh/3ozrpHi17WBwpuZmpP/ujNYWxACqCHdmQzw=; b=HIFU++hRb/Xbnty+H/4sa
	/c7uqUGMCT8WHv7K8qEEhwEnTnqO3rmkv4oGC1MrjPh+JzyumQoeE1uh62Lf9YKD
	PxUZqo0Cy1o48l9EiQ9j+4Ko/kwlfwJkLcoZsGPsTKbr6rsZ+gO+40IZrgAMQKWr
	ssftNQbJs5pk6WlNzEfwBG1qvIj3lPK08D6cgNxPyzLE107WaZLEKbTd8bdqZVNh
	psRtut/9atoCgF/c9lfZd137EHgKwiHwPRs9ceU7cVqj7cz56RtiYVGCDqqkRzzs
	ORW2VBPNDtVxk7FboZ2l6yjKgHVrXWb95jySIF8jJI1ODWSD2WDFfEBM1BB4cl3j
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79ceaj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340ZtwD017309;
	Fri, 4 Apr 2025 02:19:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8hG030074;
	Fri, 4 Apr 2025 02:19:55 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-21;
	Fri, 04 Apr 2025 02:19:55 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: anthony.yznaga@oracle.com, andreyknvl@gmail.com, dave.hansen@intel.com,
        luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: [PATCH v2 20/20] mm/mshare: associate a mem cgroup with an mshare file
Date: Thu,  3 Apr 2025 19:19:02 -0700
Message-ID: <20250404021902.48863-21-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250404021902.48863-1-anthony.yznaga@oracle.com>
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040014
X-Proofpoint-GUID: 7vkFVKheDEa9Sb1cTcQnlOeo0S0Hrku-
X-Proofpoint-ORIG-GUID: 7vkFVKheDEa9Sb1cTcQnlOeo0S0Hrku-

This patch shows one approach to associating a specific mem cgroup to
an mshare file and was inspired by code in mem_cgroup_sk_alloc().
Essentially when a process creates an mshare region, a reference is
taken on the mem cgroup that the process belongs to and a pointer to
the memcg is saved. At fault time set_active_memcg() is used to
temporarily enable charging of __GFP_ACCOUNT allocations to the saved
memcg. This does consolidate pagetable charges to a single memcg, but
there are issues to address such as how to handle the case where the
memcg is deleted but becomes a hidden, zombie memcg because the
mshare file has a reference to it.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/fault.c | 11 +++++++++++
 include/linux/mm.h  |  5 +++++
 mm/mshare.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 49659d2f9316..f79186b76ffe 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/memcontrol.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1218,6 +1219,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	bool is_shared_vma;
 	unsigned long addr;
+	struct mem_cgroup *mshare_memcg;
+	struct mem_cgroup *memcg;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1374,6 +1377,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	if (unlikely(vma_is_mshare(vma))) {
+		mshare_memcg = get_mshare_memcg(vma);
+
 		fault = find_shared_vma(&vma, &addr);
 
 		if (fault) {
@@ -1401,6 +1406,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
+	if (is_shared_vma && mshare_memcg)
+		memcg = set_active_memcg(mshare_memcg);
+
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
@@ -1416,6 +1424,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	fault = handle_mm_fault(vma, addr, flags, regs);
 
+	if (is_shared_vma && mshare_memcg)
+		set_active_memcg(memcg);
+
 	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
 	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs)))
 		mmap_read_unlock(mm);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9e64deae3d64..e848c29eafe4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1179,12 +1179,17 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
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
index 276fb825cc9a..509b1ae8ce72 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/memcontrol.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <uapi/linux/magic.h>
@@ -34,8 +35,22 @@ struct mshare_data {
 	unsigned long size;
 	unsigned long flags;
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
@@ -408,6 +423,9 @@ msharefs_fill_mm(struct inode *inode)
 	struct mm_struct *mm;
 	struct mshare_data *m_data = NULL;
 	int ret = 0;
+#ifdef CONFIG_MEMCG
+	struct mem_cgroup *memcg;
+#endif
 
 	mm = mm_alloc();
 	if (!mm) {
@@ -434,6 +452,17 @@ msharefs_fill_mm(struct inode *inode)
 
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
 
@@ -447,6 +476,10 @@ msharefs_fill_mm(struct inode *inode)
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


