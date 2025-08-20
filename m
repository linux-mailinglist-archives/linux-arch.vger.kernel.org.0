Return-Path: <linux-arch+bounces-13217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13BB2D124
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CECB5A0DD6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7722156B;
	Wed, 20 Aug 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="htbZnQZQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94421A92F;
	Wed, 20 Aug 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651964; cv=none; b=YSbAv020rgdfsOCN+wRBku+NM/t8a7RAA6irs9BIPdD9R3U07omqfJqjf94XV0HK3GlEQT/TZQ1JODjYUCDyAIxSumxfjqHSw8eRjhmufeSh9oviivHcioTZBE2LcjycuF0OqMv0z0MBe6Zbx5iRJLMn51tZHJ5kxsC7xAqst3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651964; c=relaxed/simple;
	bh=OW3d/JEyHsp4z0Q2OUIVjqNBCBoPj2TrgTMapGv6n5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piMUCBttaW4vM8pdX/h94YbdWsxr7Ymkoaa4CCIcwaaYmglLB09nunilT35WclVR/qRS+7QvT4YPKwmTC9gorFbCI+01Vmiu50TiPOz/Nscei6IgHJey0xvV+0tRa3zm6LkTH1JAs2maLlG7b/nRZwLAXBl8DoIvLrsBEtPfm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=htbZnQZQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBvtH005009;
	Wed, 20 Aug 2025 01:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=M5Hpt
	mkD2k7saiCVXTbFxXoicAZ47I2SdR8LsHkZ+Dw=; b=htbZnQZQl7VEqAQ+KB3Hv
	KZlrT2qVjkF2zAFwcI83HExFEvqPyxIMIzFYBAS63iG62wNi25UQfr8FqqVLJZbV
	u6260g4yKvAOZ40bEnYANDjU6EW+RYmxE1YNZhYT4a8cIyw7SxKlEFE/Rwr5NuW4
	z5Ub12w7wwk+S0WwnHUkwxGE2z88E+orfaKQKI3o/dcWJJD/uOl/B6vohrWGZwny
	vntpnof1cihDbFeNnA2uGp3OeuVxh5c+d+1+iBjxTNXxC4L3Ibmk03kkN1sc7Klo
	DIkMzF1tnUgLCZJDeGBV+zGWmkJyVQ1iWiZMsL1/3XKD2OyVtnnUEj1VGZbAGd+a
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqr8b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57K00ocR007355;
	Wed, 20 Aug 2025 01:05:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Ndc011685;
	Wed, 20 Aug 2025 01:05:08 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-18;
	Wed, 20 Aug 2025 01:05:08 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 17/22] sched/mshare: mshare ownership
Date: Tue, 19 Aug 2025 18:04:10 -0700
Message-ID: <20250820010415.699353-18-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820010415.699353-1-anthony.yznaga@oracle.com>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXwPsFLjftIuCD
 3eipW0vP5sRTRRqnr1pXf3t1dD/HahI2T8F5xStQvPfgK8SlsmENTBRjcEd2pecwXuMKbWbwjFg
 8KuGQYXoafaWoFQcOEIS9zXp42nlitXN8pWYuVu7Zi83RRPeD04OZ8tIXj7o/mPMT8zh4u5PRU1
 CLFjuA3BEIMA3YO/fSKrcBHqasShWM4pm0pLSuzz1YLt/QhjEqaXQujf4hzZlQxLsw5MdunqK1w
 reAWzftsPzmtOiweSy70ySYx4DClnx7d2Lpy8HFEjcFU+38wxGVW4lltcqPxpefycCAUxBJ9xXm
 3USWuFRc9iuUZV/DzGi2AmfQF5w1viV6sPIdq5RLR70Y5e/aGTyMZR0tzVmJAwZ8c9nhPWmBdsB
 C2/8IlVs0Fu1R+PMorsdASVpRszaMA==
X-Proofpoint-ORIG-GUID: 7gnbcA1QiiEQgIIbSFbyw9kCgcSxWa8J
X-Proofpoint-GUID: 7gnbcA1QiiEQgIIbSFbyw9kCgcSxWa8J
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a51f46 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=ZiWb_19Z13N3sy88laYA:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

Ownership of an mshare region is assigned to the process that creates
it. Establishing ownership ensures that accounting the memory in an
mshare region is applied to the owner and not spread among the processes
sharing the memory. It also provides a means for freeing mshare memory
in an OOM situation. Once an mshare owner exits, access to the memory by
a non-owner process results in a SIGSEGV. For this initial implementation
ownership is not shared or transferred through forking or other means.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mshare.h | 25 +++++++++++++
 include/linux/sched.h  |  5 +++
 kernel/exit.c          |  1 +
 kernel/fork.c          |  1 +
 mm/mshare.c            | 83 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 include/linux/mshare.h

diff --git a/include/linux/mshare.h b/include/linux/mshare.h
new file mode 100644
index 000000000000..b62f0e54cf84
--- /dev/null
+++ b/include/linux/mshare.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MSHARE_H_
+#define _LINUX_MSHARE_H_
+
+#include <linux/types.h>
+
+struct task_struct;
+
+#ifdef CONFIG_MSHARE
+
+void exit_mshare(struct task_struct *task);
+#define mshare_init_task(task) INIT_LIST_HEAD(&(task)->mshare_mem)
+
+#else
+
+static inline void exit_mshare(struct task_struct *task)
+{
+}
+static inline void mshare_init_task(struct task_struct *task)
+{
+}
+
+#endif
+
+#endif /* _LINUX_MSHARE_H_ */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b272382673d..17f2f3c0b465 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -48,6 +48,7 @@
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/unwind_deferred_types.h>
+#include <linux/mshare.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1654,6 +1655,10 @@ struct task_struct {
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
+#ifdef CONFIG_MSHARE
+	struct list_head		mshare_mem;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/exit.c b/kernel/exit.c
index 343eb97543d5..24445109865d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -951,6 +951,7 @@ void __noreturn do_exit(long code)
 	if (group_dead)
 		acct_process();
 
+	exit_mshare(tsk);
 	exit_sem(tsk);
 	exit_shm(tsk);
 	exit_files(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 5115be549234..eba6bd709c6e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2143,6 +2143,7 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 
 	unwind_task_init(p);
+	mshare_init_task(p);
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/mm/mshare.c b/mm/mshare.c
index f7b7904f0405..8a23b391fa11 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,6 +17,7 @@
 #include <linux/fs_context.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mshare.h>
 #include <uapi/linux/magic.h>
 #include <linux/falloc.h>
 #include <asm/tlbflush.h>
@@ -27,6 +28,7 @@ const unsigned long mshare_align = P4D_SIZE;
 const unsigned long mshare_base = mshare_align;
 
 #define MSHARE_INITIALIZED	0x1
+#define MSHARE_HAS_OWNER	0x2
 
 struct mshare_data {
 	struct mm_struct *mm;
@@ -35,6 +37,7 @@ struct mshare_data {
 	unsigned long size;
 	unsigned long flags;
 	struct mmu_notifier mn;
+	struct list_head list;
 };
 
 static inline bool mshare_is_initialized(struct mshare_data *m_data)
@@ -42,6 +45,65 @@ static inline bool mshare_is_initialized(struct mshare_data *m_data)
 	return test_bit(MSHARE_INITIALIZED, &m_data->flags);
 }
 
+static inline bool mshare_has_owner(struct mshare_data *m_data)
+{
+	return test_bit(MSHARE_HAS_OWNER, &m_data->flags);
+}
+
+static bool mshare_data_getref(struct mshare_data *m_data);
+static void mshare_data_putref(struct mshare_data *m_data);
+
+void exit_mshare(struct task_struct *task)
+{
+	for (;;) {
+		struct mshare_data *m_data;
+		int error;
+
+		task_lock(task);
+
+		if (list_empty(&task->mshare_mem)) {
+			task_unlock(task);
+			break;
+		}
+
+		m_data = list_first_entry(&task->mshare_mem, struct mshare_data,
+						list);
+
+		WARN_ON_ONCE(!mshare_data_getref(m_data));
+
+		list_del_init(&m_data->list);
+		task_unlock(task);
+
+		/*
+		 * The owner of an mshare region is going away. Unmap
+		 * everything in the region and prevent more mappings from
+		 * being created.
+		 *
+		 * XXX
+		 * The fact that the unmap can possibly fail is problematic.
+		 * One alternative is doing a subset of what exit_mmap() does.
+		 * If it's preferrable to preserve the mappings then another
+		 * approach is to fail any further faults on the mshare region
+		 * and unlink the shared page tables from the page tables of
+		 * each sharing process by walking the rmap via the msharefs
+		 * inode.
+		 * Unmapping everything means mshare memory is freed up when
+		 * the owner exits which may be preferrable for OOM situations.
+		 */
+
+		clear_bit(MSHARE_HAS_OWNER, &m_data->flags);
+
+		mmap_write_lock(m_data->mm);
+		error = do_munmap(m_data->mm, m_data->start, m_data->size, NULL);
+		mmap_write_unlock(m_data->mm);
+
+		if (error)
+			pr_warn("%s: do_munmap returned %d\n", __func__, error);
+
+		mshare_data_putref(m_data);
+	}
+}
+
 static void mshare_invalidate_tlbs(struct mmu_notifier *mn, struct mm_struct *mm,
 				   unsigned long start, unsigned long end)
 {
@@ -362,6 +424,11 @@ msharefs_fill_mm(struct inode *inode)
 	ret = mmu_notifier_register(&m_data->mn, mm);
 	if (ret)
 		goto err_free;
+	INIT_LIST_HEAD(&m_data->list);
+	task_lock(current);
+	list_add(&m_data->list, &current->mshare_mem);
+	task_unlock(current);
+	set_bit(MSHARE_HAS_OWNER, &m_data->flags);
 
 	refcount_set(&m_data->ref, 1);
 	inode->i_private = m_data;
@@ -380,6 +447,11 @@ msharefs_delmm(struct mshare_data *m_data)
 	kfree(m_data);
 }
 
+static bool mshare_data_getref(struct mshare_data *m_data)
+{
+	return refcount_inc_not_zero(&m_data->ref);
+}
+
 static void mshare_data_putref(struct mshare_data *m_data)
 {
 	if (!refcount_dec_and_test(&m_data->ref))
@@ -543,6 +615,17 @@ msharefs_evict_inode(struct inode *inode)
 	if (!m_data)
 		goto out;
 
+	rcu_read_lock();
+
+	if (!list_empty(&m_data->list)) {
+		struct task_struct *owner = m_data->mm->owner;
+
+		task_lock(owner);
+		list_del_init(&m_data->list);
+		task_unlock(owner);
+	}
+	rcu_read_unlock();
+
 	mshare_data_putref(m_data);
 out:
 	clear_inode(inode);
-- 
2.47.1


