Return-Path: <linux-arch+bounces-13210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BC7B2D102
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8505D3B8FD3
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C421F5617;
	Wed, 20 Aug 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chnHnyYj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4081EEA5F;
	Wed, 20 Aug 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651957; cv=none; b=tyP6zdwZiMhrVgniTTG9fwx3HnamYQWOYD6VsXNic9/G3nDBgaZltbvwIiTgRbBrXm/o9sKGoQNvCG2UjHG1zSd0BWDMTCdwLPAgwGc+SRbeY1X9RNR2AjFKshgaPeuZNC3TgmifadisNWkODp0n1z436P99f3+8iehjMG8Tfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651957; c=relaxed/simple;
	bh=UxUfGphjSgERYaOTfqq6+WCe+adUUaKoCrFrjyfVn8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6AMmfXda0wrWwjTDUGtnwjY5rLxri7vAiOhlcN27x44+LHYcVmrXd2pKm+Z/IyXfYZ9loeqE3kDM6D1o2eoCJHmvJT8k+v6OH/9EbyF/Q5eXXJkWsWQjTgdRizyR/50kFpxJ/sIpiPdLvZHpPYJ1pzodNnVkX7dcrsFU7IJ1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=chnHnyYj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBnPa004722;
	Wed, 20 Aug 2025 01:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1GQml
	N9LOVzic9ck/xp65PGIqSqPMNjfJbjfxs1Golw=; b=chnHnyYjWp3wkGD/CgOcz
	HpMSyBe+D8D4mAl/U+Okemx3m4NJsii48co+UswncZILIkGBCJAJn+dL4YDQuLJX
	K34CQ7OAEt2ZeJdpDfqttt1n5G8n/ACBg6+1xxfj/2XvZTdTFoGeQ0IP7MJ0vBOG
	bkypU4RjidEKGQsRZEs35DkR71C0IU5b95FENFjQw3R/eHx1HdSiuDa5NCZutCCc
	VXPdFSrabZc/k3nN96p+9InV+33tItDwMhW0IrX41SVR0dLBYw5KME2ic042jQEq
	kRXexCsjU0a/DYjnSw/hZEgws4ec1kw7rE0Bqc1bkhAuyUn/p91h9TLmwi2VI4zj
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqr8b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNWYJX007314;
	Wed, 20 Aug 2025 01:05:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdW011685;
	Wed, 20 Aug 2025 01:05:00 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-15;
	Wed, 20 Aug 2025 01:05:00 +0000
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
Subject: [PATCH v3 14/22] x86/mm: enable page table sharing
Date: Tue, 19 Aug 2025 18:04:07 -0700
Message-ID: <20250820010415.699353-15-anthony.yznaga@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXxdI9l8NKIh8B
 mJjG4HXLfqqFSvIWISLSu1cTPVGpy6ji5M8+A4xbOEXv5aL/rW8vKlN8CEnBcxOihMsWKnPvqyB
 ylOR9qePixVQGRrdHcgkCYEHggTsh+zrdXo//cv4ctsTGP9nZYBwonptZHHskbQHJNiQl2+xrJW
 bDhg6SSZmFhoDdB5NfKy6bN5oWd3F4drhrDhneMKS2LOOTSVmbbu+rxjFolTv/7e4Z4/rdUNW9z
 0uREjatAweDePwVOuGMaZgzFin8b7bnAFKMBzHzzR3l5Esrz4Qegf/wYm7Gkg8JVSSveeufgMSR
 MJ3e5inmMBZcYPUfWKES0bNsHknLdNwm02b9ualxapGaDbpHvbvpc1sdLI1XVRrX+eS8V1Qj96A
 og3snhv4YHTn3vfm3uLGvloRzpBRcA==
X-Proofpoint-ORIG-GUID: YSu3qm5PcULgkW0gS9e9Y7497HnEs1OT
X-Proofpoint-GUID: YSu3qm5PcULgkW0gS9e9Y7497HnEs1OT
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a51f3f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=H1hRpGHkK2FX5b2Ra40A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

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
 arch/x86/mm/fault.c | 40 +++++++++++++++++++++++++++++++++++++++-
 mm/Kconfig          |  2 +-
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..2e10a11fc442 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1676,6 +1676,9 @@ config HAVE_ARCH_PFN_VALID
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	bool
 
+config ARCH_SUPPORTS_MSHARE
+	bool
+
 config ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..1ad252eec417 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,6 +124,7 @@ config X86
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_SUPPORTS_MSHARE		if X86_64
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 998bd807fc7b..2a7df3aa13b4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1215,6 +1215,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	bool is_shared_vma;
+	unsigned long addr;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1328,6 +1330,12 @@ void do_user_addr_fault(struct pt_regs *regs,
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
@@ -1356,17 +1364,38 @@ void do_user_addr_fault(struct pt_regs *regs,
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
@@ -1384,7 +1413,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault(vma, addr, flags, regs);
+
+	/*
+	 * If the lock on the shared mm has been released, release the lock
+	 * on the task's mm now.
+	 */
+	if (unlikely(is_shared_vma) && (fault & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)))
+		mmap_read_unlock(mm);
 
 	if (fault_signal_pending(fault, regs)) {
 		/*
@@ -1412,6 +1448,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto retry;
 	}
 
+	if (unlikely(is_shared_vma))
+		mmap_read_unlock(vma->vm_mm);
 	mmap_read_unlock(mm);
 done:
 	if (likely(!(fault & VM_FAULT_ERROR)))
diff --git a/mm/Kconfig b/mm/Kconfig
index 8b50e9785729..824da2a481f9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1402,7 +1402,7 @@ config FIND_NORMAL_PAGE
 
 config MSHARE
 	bool "Mshare"
-	depends on MMU
+	depends on MMU && ARCH_SUPPORTS_MSHARE
 	help
 	  Enable msharefs: A pseudo filesystem that allows multiple processes
 	  to share kernel resources for mapping shared pages. A file created on
-- 
2.47.1


