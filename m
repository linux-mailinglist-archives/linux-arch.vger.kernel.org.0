Return-Path: <linux-arch+bounces-11265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2500A7B5CE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A4616F2B7
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8B19CC22;
	Fri,  4 Apr 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n61RHZno"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67E86348;
	Fri,  4 Apr 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733210; cv=none; b=CwTRTf91matpK70SbUCKeiirtpr/fBAnUjTc7U9blP4B6z3veJSdhyb1x4wdOAWJtLitNGddVjQwSSuM+SQ2auoJ3/PIsPRkNI3F51A/Yr66v60XnW+bTD/zFohYr8HHK3D5/h+QjURGUx1fKl3FLi4zyQ7YcMk+W4RVB0EKMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733210; c=relaxed/simple;
	bh=AMYCFe8WWTL9WvkjnkEVJ4BmcUEcNMG/zk73LCWi20c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeIbMhJQwhiWsNwSSl14/Y1Xxh/nsiSW99dJNddHeVvYEayYynIz/JiIoGLVaFmvYFHLcNO3JJta+gP88agovD89ycq5z1WEpEEv7HSkX1Der35IKIhCmrQcGBV6SdONwRorjR5/XbMNiDkuj8xByilSlx39lxySevtBMgqng6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n61RHZno; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341OBoX001653;
	Fri, 4 Apr 2025 02:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ryv0h
	p50CeHBUKVemJw6FHGxU5zvzxNYohzdpJ9sUII=; b=n61RHZnoKkN0JJfs3/Hlf
	h6IrWJsnEFlUd/b4B366oinRoZVtDrmHY6pJX+O1s6xwlt8kKurAEo87AkEjywet
	GCKGU4Oq2MpXtVGgo+BIE7n5ZED139vL7UjDN56/6Z1/oYWQ2ycqS6kmtQJY8L9W
	EjE4D4rqdQDRuaFIK1q2sjRo9scjpD7yi3lFVHgB1koE+oNDCWoorlaT/Tw4d2Im
	IegTCC+lyj5HsAdM6FCwJgSuv9+dfc8iF4W4HnW060ZO2uBoIziivg4X+9KlSh1z
	4lALQIVlSBw+2Hzo/7vjiGgC5f4oSwZ+3QUrf7tgv2begUWCGjDQy/9bA5hVe4eA
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcpnq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340epsJ017365;
	Fri, 4 Apr 2025 02:19:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8h4030074;
	Fri, 4 Apr 2025 02:19:40 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-15;
	Fri, 04 Apr 2025 02:19:40 +0000
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
Subject: [PATCH v2 14/20] mm: create __do_mmap() to take an mm_struct * arg
Date: Thu,  3 Apr 2025 19:18:56 -0700
Message-ID: <20250404021902.48863-15-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: 6acAiO5dqkv4w9rAuQqqhxtWfBXsThgQ
X-Proofpoint-ORIG-GUID: 6acAiO5dqkv4w9rAuQqqhxtWfBXsThgQ

In preparation for mapping objects into an mshare region, create
__do_mmap() to allow mapping into a specified mm. There are no
functional changes otherwise.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 mm/mmap.c          | 10 +++++-----
 mm/vma.c           | 12 ++++++------
 mm/vma.h           |  2 +-
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f06be2f20c20..9e64deae3d64 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3480,10 +3480,26 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	return __get_unmapped_area(file, addr, len, pgoff, flags, 0);
 }
 
+#ifdef CONFIG_MMU
+unsigned long __do_mmap(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot, unsigned long flags,
+	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
+	struct list_head *uf, struct mm_struct *mm);
+static inline unsigned long do_mmap(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot, unsigned long flags,
+	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
+	struct list_head *uf)
+{
+	return __do_mmap(file, addr, len, prot, flags, vm_flags, pgoff,
+			 populate, uf, current->mm);
+}
+#else
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
 	struct list_head *uf);
+#endif
+
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool unlock);
diff --git a/mm/mmap.c b/mm/mmap.c
index bd210aaf7ebd..0cc187a60a0f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -278,7 +278,7 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 }
 
 /**
- * do_mmap() - Perform a userland memory mapping into the current process
+ * __do_mmap() - Perform a userland memory mapping into the current process
  * address space of length @len with protection bits @prot, mmap flags @flags
  * (from which VMA flags will be inferred), and any additional VMA flags to
  * apply @vm_flags. If this is a file-backed mapping then the file is specified
@@ -330,17 +330,17 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
  * @uf: An optional pointer to a list head to track userfaultfd unmap events
  * should unmapping events arise. If provided, it is up to the caller to manage
  * this.
+ * @mm: The mm_struct
  *
  * Returns: Either an error, or the address at which the requested mapping has
  * been performed.
  */
-unsigned long do_mmap(struct file *file, unsigned long addr,
+unsigned long __do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
 			unsigned long flags, vm_flags_t vm_flags,
 			unsigned long pgoff, unsigned long *populate,
-			struct list_head *uf)
+			struct list_head *uf, struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
 	int pkey = 0;
 
 	*populate = 0;
@@ -558,7 +558,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
-	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
+	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf, mm);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
diff --git a/mm/vma.c b/mm/vma.c
index 5cdc5612bfc1..9069b42edab6 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2452,9 +2452,8 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+		struct list_head *uf, struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
@@ -2521,18 +2520,19 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
  * the virtual page offset in memory of the anonymous mapping.
  * @uf: Optionally, a pointer to a list head used for tracking userfaultfd unmap
  * events.
+ * @mm: The mm struct
  *
  * Returns: Either an error, or the address at which the requested mapping has
  * been performed.
  */
 unsigned long mmap_region(struct file *file, unsigned long addr,
 			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-			  struct list_head *uf)
+			  struct list_head *uf, struct mm_struct *mm)
 {
 	unsigned long ret;
 	bool writable_file_mapping = false;
 
-	mmap_assert_write_locked(current->mm);
+	mmap_assert_write_locked(mm);
 
 	/* Check to see if MDWE is applicable. */
 	if (map_deny_write_exec(vm_flags, vm_flags))
@@ -2551,13 +2551,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		writable_file_mapping = true;
 	}
 
-	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf, mm);
 
 	/* Clear our write mapping regardless of error. */
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
 
-	validate_mm(current->mm);
+	validate_mm(mm);
 	return ret;
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 7356ca5a22d3..a6db191e65cf 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -292,7 +292,7 @@ void mm_drop_all_locks(struct mm_struct *mm);
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf);
+		struct list_head *uf, struct mm_struct *mm);
 
 int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 		 unsigned long addr, unsigned long request, unsigned long flags);
-- 
2.43.5


