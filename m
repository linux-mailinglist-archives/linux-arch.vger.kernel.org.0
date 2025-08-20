Return-Path: <linux-arch+bounces-13220-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DDB2D121
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B0C3B865D
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650622A4CC;
	Wed, 20 Aug 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CK7XsvN6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55436226CF9;
	Wed, 20 Aug 2025 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651970; cv=none; b=gdxtgrbEL5j1uKcVMcRwhYzaSyDGcsCHAHQ3wFVoWPk0kBN9GgowzdYO93+aR/BiD4Bv5/XYcVbOH5cYakGZdP3knSfwf736Csg/X8irTtsYXGXejsG70Vmwi7xdfF48dyKW4u4QvfVwLhr67ZC/fyIDj1RX7AZB9mfbzFpY//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651970; c=relaxed/simple;
	bh=CqA3axyEPPWlesCqDyBoHkyQgtsyMscDG5i4SWFiEFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzkIHmbEHgHjlZar/v8SoJhpKR+9C0Dccf8CEkXSGNtQLX5VaT2r30Zn/tKPkmFmdEClL9fLNuPbtx1bEaqTTBeYS73DdvqqGuQn4Fr5b3k1Z6cZONU1mvUS5vg0hd0rquFOZt/yWnWP/7hQqDNN+/W2wJSZWYvWYGXpA2bm8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CK7XsvN6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBnPc004722;
	Wed, 20 Aug 2025 01:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=U4HJJ
	F0kT82Axkedvm6cvuJARVtxnZRVAJyk6ERDIjM=; b=CK7XsvN6rvcD7Zupjeg5X
	Ndh9sJleqGacn6JLqO0fgZv0/6AtmxRPDx+lDH8kFekLdygetxOw5o3j5Rt1iPQh
	Ltt6ZMlZVPAVN4vlUZFTXR6w1+7jTfjszbbnOj82K8TrH/8oWp8fg/VxbrdHzLbg
	v8VuBryVrG8t5YxXk18NwaA2KnwOOr/PRWhXjF3/1m79K921+ER0kiolxV5Gbi6Z
	ym7K/+z7L9hncg/66izRvioYM5ByowrjcrcfIzs6rNpQyZJWXguG5mWk5Gp0Dq6y
	e2ZfCqLFgf4xEgFqn9IcVgprLCYYAWA+7aqhzNIq0fw1uNE5SYpgvNTHTd3ZGUUx
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqr8bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JN39es007104;
	Wed, 20 Aug 2025 01:05:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:18 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Ndi011685;
	Wed, 20 Aug 2025 01:05:17 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-21;
	Wed, 20 Aug 2025 01:05:17 +0000
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
Subject: [PATCH v3 20/22] mm/mshare: support mapping files and anon hugetlb in an mshare region
Date: Tue, 19 Aug 2025 18:04:13 -0700
Message-ID: <20250820010415.699353-21-anthony.yznaga@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX2k3PXK72Qe4k
 1dRywlpIWn1TF8G6IA+amQjnns06VIRSoOhrhwH97/DPeZopg7zbcy+1zz2ERVjTJnPe5qapaM0
 1XYINXRshxWmpVav31HI94SLLMD67TA2bw/pzEYyjy4louZ8Cp5zPXfaO6zdxtJ/R6s7Cw/XWti
 p2hEu764Ge4PpFzMOlp4B9qpKkO7cJlfoYYhz0X8OF9zxj9XPCF19VFZS7GVgDaZSHLQOAPOOZU
 y2xNNNKCWkDmL0HwEMwfFTRgMUWxoxLQAclotjuUD3b5ijsInTXUixM1N5XSnYX/0hjqNF80Vq8
 1xYkuYqU2XMsGkxREnhSute87OMnlobolzbWxyut2Bx6/Fb9fAGemSOknKcogxkxJ4aChj6Dt2C
 SYqmcQq5Mrtfmy5gqz3PmPmcsfJJyw==
X-Proofpoint-ORIG-GUID: OZAPdZWoBtvoOPQXRPTcW7j3zLPp_reX
X-Proofpoint-GUID: OZAPdZWoBtvoOPQXRPTcW7j3zLPp_reX
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a51f4f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=fqiw4W1tFLHFuho4Wq4A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

The astute reader will notice that the code is largely copied from
ksys_mmap_pgoff() with key differences being that mapping an mshare
region within an mshare region is disallowed and that the possibly
modified size is checked to ensure the new mapping does not exceed
the bounds of the mshare region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index b1e02f5e1f60..ddcf7bb2e956 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -14,8 +14,10 @@
  *
  */
 
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mshare.h>
@@ -345,12 +347,15 @@ msharefs_get_unmapped_area(struct file *file, unsigned long addr,
 				pgoff, flags);
 }
 
+static const struct file_operations msharefs_file_operations;
+
 static long
 msharefs_create_mapping(struct mshare_data *m_data, struct mshare_create *mcreate)
 {
 	struct mm_struct *host_mm = m_data->mm;
 	unsigned long mshare_start, mshare_end;
 	unsigned long region_offset = mcreate->region_offset;
+	unsigned long pgoff = mcreate->offset >> PAGE_SHIFT;
 	unsigned long size = mcreate->size;
 	unsigned int fd = mcreate->fd;
 	int flags = mcreate->flags;
@@ -359,37 +364,87 @@ msharefs_create_mapping(struct mshare_data *m_data, struct mshare_create *mcreat
 	unsigned long mapped_addr;
 	unsigned long addr;
 	vm_flags_t vm_flags;
+	struct file *file = NULL;
 	int error = -EINVAL;
 
 	mshare_start = m_data->start;
 	mshare_end = mshare_start + m_data->size;
 	addr = mshare_start + region_offset;
 
-	if ((addr < mshare_start) || (addr >= mshare_end) ||
-	    (addr + size > mshare_end))
+	/*
+	 * Check the size later after size has possibly been
+	 * adjusted.
+	 */
+	if ((addr < mshare_start) || (addr >= mshare_end))
 		goto out;
 
 	/*
-	 * Only anonymous shared memory at fixed addresses is allowed for now.
+	 * Only shared memory at fixed addresses is allowed for now.
 	 */
 	if ((flags & (MAP_SHARED | MAP_FIXED)) != (MAP_SHARED | MAP_FIXED))
 		goto out;
-	if (fd != -1)
-		goto out;
+
+	if (!(flags & MAP_ANONYMOUS)) {
+		file = fget(fd);
+		if (!file) {
+			error = -EBADF;
+			goto out;
+		}
+		if (is_file_hugepages(file)) {
+			size = ALIGN(size, huge_page_size(hstate_file(file)));
+		} else if (unlikely(flags & MAP_HUGETLB)) {
+			error = -EINVAL;
+			goto out_fput;
+		} else if (file->f_op == &msharefs_file_operations) {
+			error = -EINVAL;
+			goto out_fput;
+		}
+	} else if (flags & MAP_HUGETLB) {
+		struct hstate *hs;
+
+		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
+		if (!hs)
+			return -EINVAL;
+
+		size = ALIGN(size, huge_page_size(hs));
+		/*
+		 * VM_NORESERVE is used because the reservations will be
+		 * taken when vm_ops->mmap() is called
+		 */
+		file = hugetlb_file_setup(HUGETLB_ANON_FILE, size,
+				VM_NORESERVE,
+				HUGETLB_ANONHUGE_INODE,
+				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
+		if (IS_ERR(file)) {
+			error = PTR_ERR(file);
+			goto out;
+		}
+	}
+
+	if (addr + size > mshare_end)
+		goto out_fput;
+
+	error = security_mmap_file(file, prot, flags);
+	if (error)
+		goto out_fput;
 
 	if (mmap_write_lock_killable(host_mm)) {
 		error = -EINTR;
-		goto out;
+		goto out_fput;
 	}
 
 	error = 0;
-	mapped_addr = __do_mmap(NULL, addr, size, prot, flags, vm_flags,
-				0, &populate, NULL, host_mm);
+	mapped_addr = __do_mmap(file, addr, size, prot, flags, vm_flags,
+				pgoff, &populate, NULL, host_mm);
 
 	if (IS_ERR_VALUE(mapped_addr))
 		error = (long)mapped_addr;
 
 	mmap_write_unlock(host_mm);
+
+out_fput:
+	if (file)
+		fput(file);
 out:
 	return error;
 }
-- 
2.47.1


