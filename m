Return-Path: <linux-arch+bounces-9889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE1A1BF3E
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C57216CD13
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EDD1F8EF7;
	Fri, 24 Jan 2025 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XLe18pnp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EC1F540D;
	Fri, 24 Jan 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762971; cv=none; b=ulPOIwIdcsNPOOUFBzFTUTU/6l4O85eWJ1wkdmUbjc2QwZNWdFyp6RhXjDweduQdlAFXS4QcYO9zDOMnSMp84sNIWn7/RryHYTjT6lohp51eGODLIVTNkbtyufBkDutTSVUOH3QN81NQMHYg+219ZowGkaHu9gSkmRTrQNZgt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762971; c=relaxed/simple;
	bh=KA0RXiiZYKNy+BTXtgfifYFrTPjnKGtN7rVQlC/9mqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG3xfyQ9Qhntaj3QO86nCYg146I21H8hNsc+2bBX4PLVXhjF6KZWIpgJVlJ+9cTt5FL7VQ4s9qrzGE8kggftBN40svbUTIVTwZ+98e/MbsUrv4XZWbffBPmC3S/XCd1LllZvD+TXbJq8q7GYgbRzqtk1wpJJDwJTjjtkoNlPtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLe18pnp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIeKEZ031124;
	Fri, 24 Jan 2025 23:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Gmt7Q
	B3NcOmNhQjBszQbUI804S0rjvRagMuhEI7yvaU=; b=XLe18pnpG/WvE0w7WwOXY
	y5bIblHn+FdWnW185Ykktr4sL6Xalmuzdvdq/qHYMpRSdi04j7yf3G2gLCAOwqeB
	fG2s3UJ9KB1t74mh62AMLQTe2v8989/wdSHUdojO0jsNTy50uFy027OHPa8QotEv
	R6Ri1dWaU2E006hYgPKoVSgJf67h/+Jhr1rH5KxT103ZQfoSo0rl3bJ/zsRQI4vh
	atf7VHTBh+aTE1GNhGUW3jDHJC2/4vgvLBi6Yp3S5ZgtPNJowCSCOF/ZfQknDTFq
	jC414yxxNtO9fER2M5ALcVKQZveFIoMWPpoENC9GIW3eYktUka4GcR5EX0S0/qs2
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsmvms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMEpto036739;
	Fri, 24 Jan 2025 23:55:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4aav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPs018051;
	Fri, 24 Jan 2025 23:55:24 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-7;
	Fri, 24 Jan 2025 23:55:24 +0000
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
Subject: [PATCH 06/20] mm/mshare: Add a vma flag to indicate an mshare region
Date: Fri, 24 Jan 2025 15:54:40 -0800
Message-ID: <20250124235454.84587-7-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=724 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-GUID: fAnTHbbqevGjh-8GbPtHZ8_gFx9Uqmua
X-Proofpoint-ORIG-GUID: fAnTHbbqevGjh-8GbPtHZ8_gFx9Uqmua

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
index 8483e09aeb2c..bca7aee40f4d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -440,6 +440,13 @@ extern unsigned int kobjsize(const void *objp);
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
@@ -1092,6 +1099,18 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
 
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
index 3bc8656c8359..0c7d50ab56cd 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -160,6 +160,12 @@ IF_HAVE_PG_ARCH_3(arch_3)
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
@@ -193,6 +199,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_MSHARE(VM_MSHARE,		"mshare"	)		\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
-- 
2.43.5


