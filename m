Return-Path: <linux-arch+bounces-11257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6BCA7B5B9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600813B83E6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA90143895;
	Fri,  4 Apr 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EEveCq6A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2492628C;
	Fri,  4 Apr 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733197; cv=none; b=byjTZHYuFWs8VJXZGlTpi4qGD5Is7snZ3Y3wy9SX8XRrZp3mntNovJ23TEsPa/3Cg9Oels/88TJAp64jcWY4MSXL0LQkelsAbwNqMc7zWqKKpfD7uf1/0u0v9kQH5Uq5/HO/8Nlum5oKOvUa+z5osR46CyAv0MjBXJkZke8gYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733197; c=relaxed/simple;
	bh=NmEjsVLdyEE/A6rEcgd5zqrQs0bAAPC9yJ1zxdUDkGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep8r7wQc3/tRIROUq0i+gQtTHjb78S15iYKKR8xhpEcGCNissAM3oWJE1ARtSqnJ/LD6GySTREYNGZBmM4gNvnRKtmmOmz1CG/avCpD+bn/YM063IX32AIJNZnBTfHUPCpKzmUf/IhESqT8wXAZSZBD7Ht5kHF9/XLII6El04Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EEveCq6A; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N2YB018250;
	Fri, 4 Apr 2025 02:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=P2XFH
	geO4VsoVgQxIbbUAqjLop0i7SOFEtZvQx9+un4=; b=EEveCq6AMr+euQTlVS1HT
	YDUUD4VMHH7ZeJOrwBHdW1ZNljHVeLPDfiMlRcTMCD3h+Wq3cHHFSUTwHX6TsH7V
	ne6t8CIVI25Jx9uUQh1dQ1x5cV55hbzK1NnylKABXIXWwTFf21w+9/ej2OEDTScR
	sVpqS8Uri8pFmytEG1l9dw/VzxFqLk/tUgeHHAARRLs5uSZXH4OmTkYmQVJz1FTz
	bqXKxUjGrsTIfNYV2183lwK4TcTTGkG8lsIxPWPCyQxD/7TsRmeK0EFeJt3pnmhm
	Yzs5LFhxV/GDwHfUTgnBkOgddmapHWzHTEaYX+RNX6NtKjcS32bAnfqeENJbUqcJ
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtp4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340dfDs017355;
	Fri, 4 Apr 2025 02:19:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gq030074;
	Fri, 4 Apr 2025 02:19:25 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-9;
	Fri, 04 Apr 2025 02:19:25 +0000
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
Subject: [PATCH v2 08/20] mm/mshare: flush all TLBs when updating PTEs in an mshare range
Date: Thu,  3 Apr 2025 19:18:50 -0700
Message-ID: <20250404021902.48863-9-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: x_lMRsGn6qiH95awEN80uSxpY_3-EKKe
X-Proofpoint-GUID: x_lMRsGn6qiH95awEN80uSxpY_3-EKKe

Unlike the mm of a task, an mshare host mm is not updated on context
switch. In particular this means that mm_cpumask is never updated
which results in TLB flushes for updates to mshare PTEs only being
done on the local CPU. To ensure entries are flushed for non-local
TLBs, set up an mmu notifier on the mshare mm and use the
.arch_invalidate_secondary_tlbs callback to flush all TLBs.
arch_invalidate_secondary_tlbs guarantees that TLB entries will be
flushed before pages are freed when unmapping pages in an mshare region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index 6bdbcfa8deea..792d86c61042 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,8 +16,10 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/mman.h>
+#include <linux/mmu_notifier.h>
 #include <uapi/linux/magic.h>
 #include <linux/falloc.h>
+#include <asm/tlbflush.h>
 
 const unsigned long mshare_align = P4D_SIZE;
 const unsigned long mshare_base = mshare_align;
@@ -29,6 +31,17 @@ struct mshare_data {
 	unsigned long start;
 	unsigned long size;
 	unsigned long flags;
+	struct mmu_notifier mn;
+};
+
+static void mshare_invalidate_tlbs(struct mmu_notifier *mn, struct mm_struct *mm,
+				   unsigned long start, unsigned long end)
+{
+	flush_tlb_all();
+}
+
+static const struct mmu_notifier_ops mshare_mmu_ops = {
+	.arch_invalidate_secondary_tlbs = mshare_invalidate_tlbs,
 };
 
 static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -237,6 +250,10 @@ msharefs_fill_mm(struct inode *inode)
 	m_data->mm = mm;
 	m_data->start = mshare_base;
 	inode->i_private = m_data;
+	m_data->mn.ops = &mshare_mmu_ops;
+	ret = mmu_notifier_register(&m_data->mn, mm);
+	if (ret)
+		goto err_free;
 
 	return 0;
 
-- 
2.43.5


