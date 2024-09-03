Return-Path: <linux-arch+bounces-6985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5796ACD7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF22E286C51
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180A1D88CF;
	Tue,  3 Sep 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lgqq6CIz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17CA1EC01D;
	Tue,  3 Sep 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405848; cv=none; b=NGSRbVy5RHlil5BeOAt6iXPZRYVr7PoOoaCyXwPeLt/8q79XcgoJB1U3RyedEGq2BjwLD1N9+4HQ7SP5B+YVqmsnQl1PtfYBVd4pNdtbQgd3gtQQoQ+0L+dl0/eBZRvFF3+MbXa9/1gDsPTKved5fVEzSfrBi+q4VQXXjNH4Iao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405848; c=relaxed/simple;
	bh=E0wdGn4erRY3cJDI5vot5H6GCBmQffIc9up71IcdSjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHXgDyc/w56snBikQPPTEtpgMgux2JOoKVH5L7+G/OzznMKUW9zGqVh1M7in6RsVZANFczl9H4ZXGDSsR2d2yFpsIyjTGfHzjF2qmBDPu6y3w6YzvvLK+rHasvlFcn1Xe3gu7atLJzQRXjNfjT47lCQLwMFmXZMd3rY5GfT+pBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lgqq6CIz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBXtV019214;
	Tue, 3 Sep 2024 23:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=I
	ZQX5Rr0ub/XJMfRdfY262glhjZWupIHzaraDs2Ywu8=; b=Lgqq6CIzpuQX3U9X6
	iDa58SGs4E0AAapCVCBdEQV877eZHX/dUHEHyK6LTiS6pGCk5JUG8g43WwdiC9jJ
	ZrKgW8RSINLnh7hb74L3mn/6X7muQGneLkQSOvvOnXiVKWY5ACbPi1G5jZF/GYtY
	6tWLZdVZ9UleXIrnz9Q8Ho4mtzdsmuB6jSwuFYHJZ6KmSD4BZYVfAy+KXYlDUBmR
	i/iHccgvQVxuoJQshtVXcBUs3OktK3mu3Wv5ja0oR1UjkbM1G1H+uBz2iAsfYWE4
	ktReTIrdKQ/MpcGjsU5QimzV0roVztQ0ppHy13/qvSRm1rCYpdhxzoUEfLcszL1E
	fhY/Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dw51t439-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483MmNpe001958;
	Tue, 3 Sep 2024 23:23:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmnf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfI040456;
	Tue, 3 Sep 2024 23:23:34 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-7;
	Tue, 03 Sep 2024 23:23:33 +0000
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
Subject: [RFC PATCH v3 06/10] mm/mshare: Add vm flag for shared PTEs
Date: Tue,  3 Sep 2024 16:22:37 -0700
Message-ID: <20240903232241.43995-7-anthony.yznaga@oracle.com>
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
 mlxlogscore=679 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-ORIG-GUID: atzil67mt7N0tlp4YnnhsIyhWgXr7t7D
X-Proofpoint-GUID: atzil67mt7N0tlp4YnnhsIyhWgXr7t7D

From: Khalid Aziz <khalid@kernel.org>

Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
a function to determine if a vma shares PTEs by checking this flag.
This is to be used to find the shared page table entries on page fault
for vmas sharing PTEs.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h             | 7 +++++++
 include/trace/events/mmflags.h | 3 +++
 mm/internal.h                  | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6549d0979b28..3aa0b3322284 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -413,6 +413,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_DROPPABLE		VM_NONE
 #endif
 
+#ifdef CONFIG_64BIT
+#define VM_SHARED_PT_BIT	41
+#define VM_SHARED_PT		BIT(VM_SHARED_PT_BIT)
+#else
+#define VM_SHARED_PT		VM_NONE
+#endif
+
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index b63d211bd141..e1ae1e60d086 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -167,8 +167,10 @@ IF_HAVE_PG_ARCH_X(arch_3)
 
 #ifdef CONFIG_64BIT
 # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
+# define IF_HAVE_VM_SHARED_PT(flag, name) {flag, name},
 #else
 # define IF_HAVE_VM_DROPPABLE(flag, name)
+# define IF_HAVE_VM_SHARED_PT(flag, name)
 #endif
 
 #define __def_vmaflag_names						\
@@ -204,6 +206,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_SHARED_PT(VM_SHARED_PT,	"sharedpt"	)		\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..8005d5956b6e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1578,4 +1578,9 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.43.5


