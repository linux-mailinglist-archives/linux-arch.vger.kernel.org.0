Return-Path: <linux-arch+bounces-11255-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C967A7B5B4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757533B83F1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906348634E;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKlOLGk0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AABDF5C;
	Fri,  4 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733196; cv=none; b=IDbDkbE/X9WtNk2ju0yzh6tHCYoOvvzC6ACZbt7Q0OtplYs4psFzl67N1erpAdI9F0URZWA3W7vNO7LDLEwzqtwzBRoQm773t9nKb/ZuHL1S9uqTiHrHFKzOnnY1IDrVzEDhTCKaj9AYheehTxjy78ZRf7q7Cckwc58oGttO+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733196; c=relaxed/simple;
	bh=UoEpgylRZTHgfV2Gs1CtWLFih7A2CuS6icRjCIURP3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS4EvHAButb7cWDuMBZQ/xic5tl2v18g6E1HMPPU6K8IVjMIfz9BI6HjOZ+wMwkfkWG4uchbhvP7uMR5WAQ/Ol6QkCnYJ78gc8AykJxXXzJFdFVYmjw00P8v6rz1h/MwWntZWSRTaEaSMoMx1ZsJ2YL1QScM6zREqkDZ6m7GEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKlOLGk0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N2KY003850;
	Fri, 4 Apr 2025 02:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ERxbM
	bNvl+07Cj+9Wuvp+iaT7q1L4pPpVQOiYDgyC2I=; b=kKlOLGk0hCq15sHQdr7YF
	FJ+gGpYRYlDa3QhxUreQtsXVZPwi78CKzQHO2+oky6un4GjA6Hzf1g98WotpaCjs
	Q4RAaeqWyovEO6QQFm1741D44rbTtCyUN13U86JQNrQet4tUPk6G5aGz5Ah3IXIp
	OZ5bDebKWoZ3aF/6iTUotD5VHa/Z+V3eUbi1F1p+NjKfrPFjg7UcakfFeZUqZSEw
	eElHzpO6pSIe0wPahnKOu98BSdHW7TcgGKCd7p4sikkQsrPiCirxIaIVh0kFGIi2
	ghWQcWxRIJMIyckngwRUk9CdEnIt5eIk2k34P5my53MC8vqx+tSs3bNyJ6RrMxZj
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7sax3xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340VAmN017338;
	Fri, 4 Apr 2025 02:19:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gm030074;
	Fri, 4 Apr 2025 02:19:20 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-7;
	Fri, 04 Apr 2025 02:19:20 +0000
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
Subject: [PATCH v2 06/20] mm/mshare: Add a vma flag to indicate an mshare region
Date: Thu,  3 Apr 2025 19:18:48 -0700
Message-ID: <20250404021902.48863-7-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: CqLOZCNIvjq0vvOwi8VweFI6kJqfrYBW
X-Proofpoint-ORIG-GUID: CqLOZCNIvjq0vvOwi8VweFI6kJqfrYBW

From: Khalid Aziz <khalid@kernel.org>

An mshare region contains zero or more actual vmas that map objects
in the mshare range with shared page tables.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h             | 19 +++++++++++++++++++
 include/trace/events/mmflags.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 778f5de6a12e..f2f9d15213ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -414,6 +414,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_DROPPABLE		VM_NONE
 #endif
 
+#ifdef CONFIG_MSHARE
+#define VM_MSHARE_BIT		41
+#define VM_MSHARE		BIT(VM_MSHARE_BIT)
+#else
+#define VM_MSHARE		VM_NONE
+#endif
+
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
@@ -1161,6 +1168,18 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
 
 int vma_is_stack_for_current(struct vm_area_struct *vma);
 
+#ifdef CONFIG_MSHARE
+static inline bool vma_is_mshare(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_MSHARE;
+}
+#else
+static inline bool vma_is_mshare(const struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 15aae955a10b..02ebd354ed55 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -202,6 +202,12 @@ IF_HAVE_PG_ARCH_3(arch_3)
 # define IF_HAVE_VM_DROPPABLE(flag, name)
 #endif
 
+#ifdef CONFIG_MSHARE
+# define IF_HAVE_VM_MSHARE(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_MSHARE(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -235,6 +241,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_MSHARE(VM_MSHARE,		"mshare"	)		\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
-- 
2.43.5


