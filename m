Return-Path: <linux-arch+bounces-9897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86CA1BF5B
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42F07A363A
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7221FA16C;
	Fri, 24 Jan 2025 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fUnoSigK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD91F9F67;
	Fri, 24 Jan 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762986; cv=none; b=h1jwcBBFpWoQWc68M1TCdMsfj0d5tW9pcpW09i6USfE2K2TuNaZ8Q2moiS0laXw6ipVM9IZ2Raas8SbDWYgsu/p8NJYMwoOjjQt0Ad6/KE9HGD4UW2OzMCMCA6qLbXJmiP03hci3qetsfvaYELLNUdErPHgqr1ofcYNHDiVVGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762986; c=relaxed/simple;
	bh=VDs2JcgsMRcQoxPc5jG5PW9l2zO89tAiKcTbOIEaz+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts+MqoHLL40TpsBnuBqA2hGDVexgjIfWAudEcdp1GFliAfsySV2BJmGVyL3/S675eAm3v21DdAwdt2tD9ppEd3Q/ZLCnWXNtwYFhTCv//yd63lGEkL57R/jU2ON2wur14aC/1vJFRAIHzlj0Rync3mP0MPeK4EBmOPP1IqKg0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fUnoSigK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OI8hMZ022258;
	Fri, 24 Jan 2025 23:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=yJXvn
	Yoxkm1NK3qwW6jmL1jgVFm2IaD/yhkctg4U92M=; b=fUnoSigK9HLwd6NsS95Dr
	GyOpPYzCA/4kAye89j7nfUI1NddpqygTwjTKIAx8WdCkHtrXLbtzP35MIHAsmrUW
	YVajTmDtXQjTlPNn92R8YLpqiHdUn002WI1acMbJkbOE6cMhRzIe1TEbnETKclZv
	PO8InVxSqjARDaOLg0THwBHKBh7H5l7Xp4Mhgk1Fml5N0jH9z71iYiikv6v2wV/f
	gSumYFsJlOo8v1MNe/KVyxtq253t9KB/+8zgIauIoMpKEGsrxO4wJMhdS9HhNoxx
	qdHFU0fU68u6E+2F/P0wK00JlGdSUsPJJNY44LDZVvFxwFLeMFT0nDibDEg32Rfu
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx5vq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLKNdP036521;
	Fri, 24 Jan 2025 23:55:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4ajv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQA018051;
	Fri, 24 Jan 2025 23:55:52 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-15;
	Fri, 24 Jan 2025 23:55:52 +0000
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
Subject: [PATCH 14/20] mm: create __do_mmap() to take an mm_struct * arg
Date: Fri, 24 Jan 2025 15:54:48 -0800
Message-ID: <20250124235454.84587-15-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=915 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: Oa18II2kZqrAU3hlh8jjOS5UYIop2-kj
X-Proofpoint-GUID: Oa18II2kZqrAU3hlh8jjOS5UYIop2-kj

In preparation for mapping objects into an mshare region, create
__do_mmap() to allow mapping into a specified mm. There are no
functional changes otherwise.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 mm/mmap.c          |  7 +++----
 mm/vma.c           | 15 +++++++--------
 mm/vma.h           |  2 +-
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9889c4757f45..80429d1a6ae4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3398,10 +3398,26 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
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
index cda01071c7b1..2d327b148bfc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -334,13 +334,12 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
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
@@ -558,7 +557,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
-	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
+	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf, mm);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
diff --git a/mm/vma.c b/mm/vma.c
index af1d549b179c..28942701e301 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2433,9 +2433,8 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+		struct list_head *uf, struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
@@ -2485,13 +2484,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 /**
  * mmap_region() - Actually perform the userland mapping of a VMA into
- * current->mm with known, aligned and overflow-checked @addr and @len, and
+ * mm with known, aligned and overflow-checked @addr and @len, and
  * correctly determined VMA flags @vm_flags and page offset @pgoff.
  *
  * This is an internal memory management function, and should not be used
  * directly.
  *
- * The caller must write-lock current->mm->mmap_lock.
+ * The caller must write-lock mm->mmap_lock.
  *
  * @file: If a file-backed mapping, a pointer to the struct file describing the
  * file to be mapped, otherwise NULL.
@@ -2508,12 +2507,12 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
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
@@ -2532,13 +2531,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
index a2e8710b8c47..e704f56577f3 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -243,7 +243,7 @@ void mm_drop_all_locks(struct mm_struct *mm);
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf);
+		struct list_head *uf, struct mm_struct *mm);
 
 int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 		 unsigned long addr, unsigned long request, unsigned long flags);
-- 
2.43.5


