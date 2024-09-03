Return-Path: <linux-arch+bounces-6987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E394B96ACDC
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5643DB23F11
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E31D79B3;
	Tue,  3 Sep 2024 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QbGQwxdq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C291D79B1;
	Tue,  3 Sep 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405860; cv=none; b=eGiFkVJywrjUgjoULsSwOCVPMRUTEuEzEEzbZpoJZmjcJ3IPDulH92NJI10XKsGH1qRCCIo6cWkPbI5ryZV27kVJL8KO79p8JwKgCUeh/oqT8I/ccMNan1PN49DL7UIknaK67LCpv8JcZM4ajXaiQnHVgW/1dd74m2A2BCv05AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405860; c=relaxed/simple;
	bh=CDbVybSxOnsf88eD9KWORiop2+vIRaHIYfAXnbhNT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXDzV01ZnD9+ahFwiF9PAhjoiQ0KsoWs5sgrS+Rotzi4vb0FokM27/mFtM4rQwrm3GXTd/BFybXRHPWBweCR8q6Pnam8MtAUy0cFgguU6wpqzHzIQOCqSV4fYh6jAnVfhjcvB2VNnz7QegCHjHylwdMVjL3KTCIat1UgtJ2OSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QbGQwxdq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBWCG020127;
	Tue, 3 Sep 2024 23:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=r
	ZM9CKTeyNtS6qKT8tvvNx4uJ3f/kEX/Cc1h11gS1T4=; b=QbGQwxdqeRDyZrwon
	08Bcoq7jANjXxA5hglaPpRK1L9MX6d0tZ/JpTyZM3oKAsy8PZlwxxwg/4k6dvs12
	4OEPr+BCpgq6TIMiF45Llr7ayM0NsUT15SwvIXVeLmKMnrx+1FCCiHegmZCsPSbo
	d8M95EWG6fuaredoa85flOrMYpC2g85hNbpQefv8oLjRPImJapNjxG9Yr+JpzuwR
	eI6wMBv76u12YDJY3p23Ygg1TN//uTCtXvI38uTGSvLAS8hTUZFYzTDAfxfHLW/2
	pdiFKeE7Et85Q0w1WIfzF0WEBHZmcMwkHm0rC1Tu4DAqjyoRzllU8KQiG9YylynR
	rGhkw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj27h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483MjvRq001729;
	Tue, 3 Sep 2024 23:23:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmnkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfO040456;
	Tue, 3 Sep 2024 23:23:45 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-10;
	Tue, 03 Sep 2024 23:23:44 +0000
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
Subject: [RFC PATCH v3 09/10] mm: create __do_mmap() to take an mm_struct * arg
Date: Tue,  3 Sep 2024 16:22:40 -0700
Message-ID: <20240903232241.43995-10-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903232241.43995-1-anthony.yznaga@oracle.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_11,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=735 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-GUID: tUoy6uZR4wBNfmtmw451fh63ni68XiFs
X-Proofpoint-ORIG-GUID: tUoy6uZR4wBNfmtmw451fh63ni68XiFs

In preparation for mapping objects into an mshare region, create
__do_mmap() to allow mapping into a specified mm. There are no
functional changes otherwise.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h | 18 +++++++++++++++++-
 mm/mmap.c          | 12 +++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3aa0b3322284..a9afbda73cb0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3409,11 +3409,27 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-	struct list_head *uf);
+	struct list_head *uf, struct mm_struct *mm);
+#ifdef CONFIG_MMU
+extern unsigned long __do_mmap(struct file *file, unsigned long addr,
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
index d0dfc85b209b..4112f18e7302 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1250,15 +1250,14 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 }
 
 /*
- * The caller must write-lock current->mm->mmap_lock.
+ * The caller must write-lock mm->mmap_lock.
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
@@ -1465,7 +1464,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
-	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
+	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf, mm);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
@@ -2848,9 +2847,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+		struct list_head *uf, struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
-- 
2.43.5


