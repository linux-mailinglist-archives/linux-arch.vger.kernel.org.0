Return-Path: <linux-arch+bounces-13208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98765B2D0FC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA037B8E2F
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711A1F4180;
	Wed, 20 Aug 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sgpRAyWw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815E1EB5E1;
	Wed, 20 Aug 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651957; cv=none; b=LwMoodRPr1mDGvisxhCKOUEUbYIE6Ra8FZFPAPIcnvZ4+hJ7iX2gqrBdTfCkT5qtGHxfTj6yKRx1s9gogMibyw+P45+4/XSKAASxfe1iMeXtrmdcUHpMHnBAVeal4ifesF9gqFy5BVmDNT7V6LC9jEGCH4ZbonqpDVtvGIFvBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651957; c=relaxed/simple;
	bh=cK+Yhbyrxz6cRQ4ja5MMJn+1dAtSfifLO4P/ZHRpVvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9hDo8ZY4vVtAyRm+5q6rZxxZHdbHQxnHWycQiRxmDcs+35uSLlLf+JlzgzDt7nLnX/DHtYW36ODnjdY12cpI88V2SB9y0XJTJlNgl4UAU36kuGtj2HVuCXhgO6vwSHfI3MvvoMqXwl5JbQNTCvmEuJTo7GErTRed2Jt5VgBxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sgpRAyWw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLCHQM028221;
	Wed, 20 Aug 2025 01:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9L4mK
	jeGA5OyWK8/K1NWQvE53M9E3W4TNz8fycuQ5CQ=; b=sgpRAyWwR+4TxZS77Pv5L
	tgfjsj36FrQShtOvaWE1EKMDedetv9gjtQb2i/mDPxzLObU9kSms/jiMJPoHxgyc
	/gj6FAco0ZyI8fwy+IlkiFbctnFoEXApIwVg38Y6P7DBLLLkNpH8LkOq2bsS8ARJ
	IMMkNpLqo/ZKVsQmoDRu37awClhkyxdLpqznfi8WePpokF7EMaNfdqs8HcWGQfsZ
	NjBHTmb6YEhhdgTdsHgBj1btzELw5YvMemlqmBAnguxDeOkRT09yUwKlGTR2a7zD
	g40KsVeOUhbo84S4FRxPjZ48XJbOY5mR+fs1UmNHZJEI4afelYI5AviWgvMQgJvG
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tt08bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNWIUI007267;
	Wed, 20 Aug 2025 01:04:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdK011685;
	Wed, 20 Aug 2025 01:04:45 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-9;
	Wed, 20 Aug 2025 01:04:45 +0000
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
Subject: [PATCH v3 08/22] mm/mshare: flush all TLBs when updating PTEs in an mshare range
Date: Tue, 19 Aug 2025 18:04:01 -0700
Message-ID: <20250820010415.699353-9-anthony.yznaga@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=YvRWh4YX c=1 sm=1 tr=0 ts=68a51f2f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=0InV0jWQfKTt0iU26UwA:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: tBA8mk8grAxjezx5ksHcHYHuEzgvJI8t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfXzCjnlAcKDkxl
 M/W3GCTi3Cck0tQGb9R4qooCLskGa3VkpOpP1pf05OmPWvaJ4/I3KFOr2i+jRYpiUjl9h2+I7Zm
 r+MHQ41Jz7B3jRarYNRwg1IS1+nXFLIinc7PIhYtdbe8cvHEXjrMrbNdaHNXdHc31hYsW0MVJJP
 aYitiektuIMWnkwGeXWhA2XJYGQ1OW47P3nMNmgGH+93OqRxBzEZEMjKx6Z17oOiLCRSX891ssA
 fVkubZUw/W3QdfS064dz2uCg5T34F/+oC4JjhtEKFsd3pklDXl3GTfV79URq/kRGVpfpQgl/A8R
 Vxv7SsSsXg7ynDPsmQ3t9pHRH5fI+tcrfSK0jLh3Un6YRPiyhs1vrU/5En5Q2lE1bqoPSqWlv+8
 Oa6w1RHw3jA0PIujvZ5D7VWqENudvw==
X-Proofpoint-ORIG-GUID: tBA8mk8grAxjezx5ksHcHYHuEzgvJI8t

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
index e0dc42602f7f..be7cae739225 100644
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
@@ -30,6 +32,7 @@ struct mshare_data {
 	unsigned long start;
 	unsigned long size;
 	unsigned long flags;
+	struct mmu_notifier mn;
 };
 
 static inline bool mshare_is_initialized(struct mshare_data *m_data)
@@ -37,6 +40,16 @@ static inline bool mshare_is_initialized(struct mshare_data *m_data)
 	return test_bit(MSHARE_INITIALIZED, &m_data->flags);
 }
 
+static void mshare_invalidate_tlbs(struct mmu_notifier *mn, struct mm_struct *mm,
+				   unsigned long start, unsigned long end)
+{
+	flush_tlb_all();
+}
+
+static const struct mmu_notifier_ops mshare_mmu_ops = {
+	.arch_invalidate_secondary_tlbs = mshare_invalidate_tlbs,
+};
+
 static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	return -EINVAL;
@@ -238,6 +251,10 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	m_data->mm = mm;
 	m_data->start = mshare_base;
+	m_data->mn.ops = &mshare_mmu_ops;
+	ret = mmu_notifier_register(&m_data->mn, mm);
+	if (ret)
+		goto err_free;
 
 	refcount_set(&m_data->ref, 1);
 	inode->i_private = m_data;
-- 
2.47.1


