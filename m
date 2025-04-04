Return-Path: <linux-arch+bounces-11263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14122A7B5CC
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2A189D215
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EDA27702;
	Fri,  4 Apr 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P5P7gOnH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB3199252;
	Fri,  4 Apr 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733206; cv=none; b=IgUi6WPIdvQ6V/1F/KYxs97dHX1abbwUluT+eRATUXoqu3X64AXk03hW2ji3r8iZ2pakwptzfXSkOVq3KCTlLak7UQU8qeYtX1ppk0S5m+Gr05HjRrRQfj+trUkxX4W2KQGkbcfSonU6PgNnpUKw+oWwdw3tjSczcSogWH+RrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733206; c=relaxed/simple;
	bh=NK510fjJEDWP6sFaqFNuJVo7eEdN0Dlqydjcx4gOIp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjRvrNt+FgLzmfOLywns2gIg5vzaqWAzrodujLH8St9Yz678wdYgBKU371WXUaMDv+Gy0v+t2b/mWOBfnBeGQdwvXOTTxT3/uye0KVtGvN66W6gEuD+k8NodJFsNKsBffWLrz0vnHfNmTUVw1znxuyGHE2LdXGe+FNKyOzXNuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P5P7gOnH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341NVEe020022;
	Fri, 4 Apr 2025 02:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=7cpVy
	KF4ZMd3LXxrpKacQ/zYRn5BM4QzMhn1LTBJNYE=; b=P5P7gOnHiFEynlnwbYemo
	LF6MKgmZlq3ZINoC9Oxv0XiVLmwVef2WLfkNqFptvdl2faULOJ4/8cglbTnyWTWG
	sX5DOqvXDPqwKsGonJiqksUjS1QpgFx53q3/EPpBmuPE4XzxIRecFyHerePfEFcY
	5pT37h6Kf2Vg7SnIjYMbBMnlCGL8We33vWrSyLzwbfL1433bEmZuGCUQ23URynCO
	jrkGs9pps47BS7oj/hL4rlCPUd6igpxbyG9Tc3XQ5K1Gn6xRkbAu7tzU8c+A7fbd
	f3oOIgw7Gik9rSUHeMfpoxdnjoLVlvWRD2DeeYbfS0gOYR902+E1OY/KQSIV2WO9
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9ntk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340fxgu017356;
	Fri, 4 Apr 2025 02:19:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8h2030074;
	Fri, 4 Apr 2025 02:19:38 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-14;
	Fri, 04 Apr 2025 02:19:37 +0000
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
Subject: [PATCH v2 13/20] x86/mm: enable page table sharing
Date: Thu,  3 Apr 2025 19:18:55 -0700
Message-ID: <20250404021902.48863-14-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: i6lZP0jsec5VQkf8qGzbwTeR86wApoN6
X-Proofpoint-ORIG-GUID: i6lZP0jsec5VQkf8qGzbwTeR86wApoN6

Enable x86 support for handling page faults in an mshare region by
redirecting page faults to operate on the mshare mm_struct and vmas
contained in it.
Some permissions checks are done using vma flags in architecture-specfic
fault handling code so the actual vma needed to complete the handling
is acquired before calling handle_mm_fault(). Because of this an
ARCH_SUPPORTS_MSHARE config option is added.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/Kconfig        |  3 +++
 arch/x86/Kconfig    |  1 +
 arch/x86/mm/fault.c | 37 ++++++++++++++++++++++++++++++++++++-
 mm/Kconfig          |  2 +-
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f6eb09ef12d..2e000fefe9b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1652,6 +1652,9 @@ config HAVE_ARCH_PFN_VALID
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	bool
 
+config ARCH_SUPPORTS_MSHARE
+	bool
+
 config ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1502fd0c3c06..1f1779decb44 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_MSHARE		if X86_64
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..49659d2f9316 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1216,6 +1216,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	bool is_shared_vma;
+	unsigned long addr;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1329,6 +1331,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (!vma)
 		goto lock_mmap;
 
+	/* mshare does not support per-VMA locks yet */
+	if (vma_is_mshare(vma)) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+
 	if (unlikely(access_error(error_code, vma))) {
 		bad_area_access_error(regs, error_code, address, NULL, vma);
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
@@ -1357,17 +1365,38 @@ void do_user_addr_fault(struct pt_regs *regs,
 lock_mmap:
 
 retry:
+	addr = address;
+	is_shared_vma = false;
 	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma)) {
 		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
+	if (unlikely(vma_is_mshare(vma))) {
+		fault = find_shared_vma(&vma, &addr);
+
+		if (fault) {
+			mmap_read_unlock(mm);
+			goto done;
+		}
+
+		if (!vma) {
+			mmap_read_unlock(mm);
+			bad_area_nosemaphore(regs, error_code, address);
+			return;
+		}
+
+		is_shared_vma = true;
+	}
+
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
 	if (unlikely(access_error(error_code, vma))) {
+		if (unlikely(is_shared_vma))
+			mmap_read_unlock(vma->vm_mm);
 		bad_area_access_error(regs, error_code, address, mm, vma);
 		return;
 	}
@@ -1385,7 +1414,11 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault(vma, addr, flags, regs);
+
+	if (unlikely(is_shared_vma) && ((fault & VM_FAULT_COMPLETED) ||
+	    (fault & VM_FAULT_RETRY) || fault_signal_pending(fault, regs)))
+		mmap_read_unlock(mm);
 
 	if (fault_signal_pending(fault, regs)) {
 		/*
@@ -1413,6 +1446,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto retry;
 	}
 
+	if (unlikely(is_shared_vma))
+		mmap_read_unlock(vma->vm_mm);
 	mmap_read_unlock(mm);
 done:
 	if (likely(!(fault & VM_FAULT_ERROR)))
diff --git a/mm/Kconfig b/mm/Kconfig
index e6c90db83d01..8a5a159457f2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1344,7 +1344,7 @@ config PT_RECLAIM
 
 config MSHARE
 	bool "Mshare"
-	depends on MMU
+	depends on MMU && ARCH_SUPPORTS_MSHARE
 	help
 	  Enable msharefs: A ram-based filesystem that allows multiple
 	  processes to share page table entries for shared pages. A file
-- 
2.43.5


