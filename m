Return-Path: <linux-arch+bounces-9896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E059A1BF63
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAB13AE3EE
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A111EEA2C;
	Fri, 24 Jan 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XeEkIkrW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8D1F9F52;
	Fri, 24 Jan 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762985; cv=none; b=g8zNkWAOO7yusgIJ1kQlqToxcmFu+oxbBaY+Ig5HlAx4496tt6uHuoEpXlyBilCKfbFT5FA0QiyhD2ldJ+M/fgvJk1ipH085Hs1O/pyLEhFylOgjIhkPeEy0NVJR8H9R6NH9ViuMleR47p5xorMiKY6ygrVjN+AZDoTz/0Yl84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762985; c=relaxed/simple;
	bh=xCdkXXItEa2FHdDdBHgXXWt/ZfsvCW5Qe+7mnLT88Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNGHjYE6K/TJBdqKBuVvKMf9B3alDmRuPCXdrlE/lqxb9vnR6RaAEVXXr0R959VAqstP0Vdzk4zoQutbiidvlS/KVodJ46T4WQPnpkyUptRrlZq8mQXQkaH4AtJvixnOBtGfPVyyiSAL6ezIgIIymMMY+L8y16COTSWBm+u4M1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XeEkIkrW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIeKEb031124;
	Fri, 24 Jan 2025 23:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=nCdkv
	5pMD/BW8EJZHRB98QYPFY1ik8038tE9HN9GQDQ=; b=XeEkIkrWDwXm5HtebbhBD
	p3lABo0GMrvK4ZvGeh56K+Ji9vVwuOJ6CfP9WQgDNnIg/fylBvrEnda76gj1hlaH
	djlWZy7JPMD3YWvJ07uS/u2FQf/WNtgihIgs+ahOJw7m476tTNkDwMXzkkvgVlMb
	WaAhY1K9BmKIjf9cBYWQCBii9KnDOWEQ86r5Jgcb+DoKoPYGmvQzlxO/2s1/HjSE
	2X8wi2WkZkemqVoSzjBSlGdAQCPFca5ePjZctgTNBHixFaMq6YMIwXCF0STwxFVX
	1V8aXMFIhRqshW3vli+id7PjxsJ0s6TGm5KFe5oka0l703yelWNl+uHD03Bpstfy
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsmvn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMD09a036431;
	Fri, 24 Jan 2025 23:55:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4ahx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQ8018051;
	Fri, 24 Jan 2025 23:55:48 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-14;
	Fri, 24 Jan 2025 23:55:48 +0000
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
Subject: [PATCH 13/20] x86/mm: enable page table sharing
Date: Fri, 24 Jan 2025 15:54:47 -0800
Message-ID: <20250124235454.84587-14-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: m7wXHyW69pLXZ8gl0E-xcyVHCx0Mq1Za
X-Proofpoint-ORIG-GUID: m7wXHyW69pLXZ8gl0E-xcyVHCx0Mq1Za

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
index 6682b2a53e34..32474cdcb882 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1640,6 +1640,9 @@ config HAVE_ARCH_PFN_VALID
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	bool
 
+config ARCH_SUPPORTS_MSHARE
+	bool
+
 config ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e1a3e4386de..453a39098dfa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -120,6 +120,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_MSHARE		if X86_64
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..4b55ade61a01 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1217,6 +1217,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	bool is_shared_vma;
+	unsigned long addr;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1330,6 +1332,12 @@ void do_user_addr_fault(struct pt_regs *regs,
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
@@ -1358,17 +1366,38 @@ void do_user_addr_fault(struct pt_regs *regs,
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
@@ -1386,7 +1415,11 @@ void do_user_addr_fault(struct pt_regs *regs,
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
@@ -1414,6 +1447,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto retry;
 	}
 
+	if (unlikely(is_shared_vma))
+		mmap_read_unlock(vma->vm_mm);
 	mmap_read_unlock(mm);
 done:
 	if (likely(!(fault & VM_FAULT_ERROR)))
diff --git a/mm/Kconfig b/mm/Kconfig
index ba3dbe31f86a..4fc056bb5643 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1360,7 +1360,7 @@ config PT_RECLAIM
 
 config MSHARE
 	bool "Mshare"
-	depends on MMU
+	depends on MMU && ARCH_SUPPORTS_MSHARE
 	help
 	  Enable msharefs: A ram-based filesystem that allows multiple
 	  processes to share page table entries for shared pages. A file
-- 
2.43.5


