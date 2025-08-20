Return-Path: <linux-arch+bounces-13209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75795B2D0FD
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBFFA7B8EC4
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED9A1F463F;
	Wed, 20 Aug 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtfXpejm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CC1EB5C2;
	Wed, 20 Aug 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651957; cv=none; b=jsfgNB/LrbHqRDQ2DXQ/prIsC+pLlThpwzS12+PtFTAUhvZrcOblbSS7V8t4RGTOdqPQMCJZnHbppMWZFpegYxkKQisio1WmMWMUTLjNg73KSLr6pUyuZmr6YHycJM/A8XFO8ycQBDLaUUr9au9A3uzsMPccdoUDP+WNJ2QiJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651957; c=relaxed/simple;
	bh=vt/bnNThzd6lIXdsG+ux5P+TJ6dCttwxkS20QlIPpeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2Bk0SGMXRDaXLjNI9vA62DPu3mlO0gzpccSE5F7ZzBAZIXdicBJ5Z3Ok13pwr20saTPjpI7RWIdeIENAEAf3y2P/kC/SinABe2Kqzkb7Dq5eSnBFQZaPTo+SqObzrU61HTXNkM59SMFGWO0buNEgEV5emiBL3NtCit26lzHCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtfXpejm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBqcb011356;
	Wed, 20 Aug 2025 01:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=vFVJ7
	GCdYMNMRdvxqqjco1umADEpiPX0dC61Kp/W1YM=; b=FtfXpejmbXjtyreLF0sLS
	IFvkL6wSldqBZRFQ4MrwNBi0uGNac3WHZchzdGUde+tPoDKE+8s2zVsdMBH1dMwJ
	poWWxfeI5zgSx73mzR/j+d6rdeWsval1Hkt81iUAewu6ZFwYtwtlwP8vixyRQfwS
	KdJY7Nw2zCChLneVMN/0QagUHMW35WQSbJlgpbBFhmTXI8Arf6mdJwLenN85xdrU
	MYYxwbc6gYHvD99C7U5jISNfOrIi4j7QjgD50ruy3lDfcDk7hdaiC46WeYVYy4lW
	22I/+wsDb6ipS4i+0ve5ldYw4i2aLnwr7avpA2r09fsbg3FGnIW1ZPbk6bIB9hgs
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trr8dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNaG3E007329;
	Wed, 20 Aug 2025 01:04:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdI011685;
	Wed, 20 Aug 2025 01:04:43 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-8;
	Wed, 20 Aug 2025 01:04:42 +0000
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
Subject: [PATCH v3 07/22] mm/mshare: Add mmap support
Date: Tue, 19 Aug 2025 18:04:00 -0700
Message-ID: <20250820010415.699353-8-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: wIfT0P-xPLPfkzb9YRueG9mDMcete3Gx
X-Proofpoint-GUID: wIfT0P-xPLPfkzb9YRueG9mDMcete3Gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX3e3pgJ8CVHxe
 qJOtxNuqvZuvQRB3WvNsGAeFXqSKO5ojFOBf4f282kadjKp3Q24tjqPPay03XzG7B4pCtYnG41z
 T0IuzOTUuV644NlCXyNIJYQ3GBPKqU3OIYl/mkcAuseEDUKy88Nlar7pCL8ctD0VCh3RAgiSdvr
 LYChS83SlBPoooe0gsrkPfFH7nXfPRDn6Gclvd5RffulCvHBYFhS+aC79vpv7tQPwvnhU5UXHn4
 1gLpGdw0M2WHTCcaH7ATi8Xv43leg6mzUGVaAsRud8Gjh6kWyahPNLtmGm8pgcoYtdOh8hR2rlJ
 NfRIGmTBMw+InoPPpQzZMqjNh4ylVZHpk9tMhbLgePj0nAKBeS0C2eh8SLQxy1WBR0p8E+Cjyvu
 jAUX6BbXR+HjHMRPl0hgOfqcHdnDFg==
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a51f2d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Zqnq54RP4WoKE8Fhti4A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

From: Khalid Aziz <khalid@kernel.org>

Add support for mapping an mshare region into a process after the
region has been established in msharefs. Disallow operations that
could split the resulting msharefs vma such as partial unmaps and
protection changes. Fault handling, mapping, unmapping, and
protection changes for objects mapped into an mshare region will
be done using the shared vmas created for them in the host mm. This
functionality will be added in later patches.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index bf859b176e09..e0dc42602f7f 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -15,16 +15,19 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/mman.h>
 #include <uapi/linux/magic.h>
 #include <linux/falloc.h>
 
 const unsigned long mshare_align = P4D_SIZE;
+const unsigned long mshare_base = mshare_align;
 
 #define MSHARE_INITIALIZED	0x1
 
 struct mshare_data {
 	struct mm_struct *mm;
 	refcount_t ref;
+	unsigned long start;
 	unsigned long size;
 	unsigned long flags;
 };
@@ -34,6 +37,130 @@ static inline bool mshare_is_initialized(struct mshare_data *m_data)
 	return test_bit(MSHARE_INITIALIZED, &m_data->flags);
 }
 
+static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static int mshare_vm_op_mprotect(struct vm_area_struct *vma, unsigned long start,
+				 unsigned long end, unsigned long newflags)
+{
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct msharefs_vm_ops = {
+	.may_split = mshare_vm_op_split,
+	.mprotect = mshare_vm_op_mprotect,
+};
+
+/*
+ * msharefs_mmap() - mmap an mshare region
+ */
+static int
+msharefs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct mshare_data *m_data = file->private_data;
+
+	vma->vm_private_data = m_data;
+	vm_flags_set(vma, VM_MSHARE | VM_DONTEXPAND);
+	vma->vm_ops = &msharefs_vm_ops;
+
+	return 0;
+}
+
+static unsigned long
+msharefs_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_unmapped_area_info info = {};
+
+	info.length = len;
+	info.low_limit = current->mm->mmap_base;
+	info.high_limit = arch_get_mmap_end(addr, len, flags);
+	info.align_mask = PAGE_MASK & (mshare_align - 1);
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long
+msharefs_get_unmapped_area_topdown(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_unmapped_area_info info = {};
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
+	info.align_mask = PAGE_MASK & (mshare_align - 1);
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (unlikely(offset_in_page(addr))) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = current->mm->mmap_base;
+		info.high_limit = arch_get_mmap_end(addr, len, flags);
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+static unsigned long
+msharefs_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mshare_data *m_data = file->private_data;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	unsigned long mshare_start, mshare_size;
+	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
+
+	mmap_assert_write_locked(mm);
+
+	if ((flags & MAP_TYPE) == MAP_PRIVATE)
+		return -EINVAL;
+
+	if (!mshare_is_initialized(m_data))
+		return -EINVAL;
+
+	mshare_start = m_data->start;
+	mshare_size = m_data->size;
+
+	if (len != mshare_size)
+		return -EINVAL;
+
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (!IS_ALIGNED(addr, mshare_align))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (addr) {
+		addr = ALIGN(addr, mshare_align);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	if (!mm_flags_test(MMF_TOPDOWN, mm))
+		return msharefs_get_unmapped_area_bottomup(file, addr, len,
+				pgoff, flags);
+	else
+		return msharefs_get_unmapped_area_topdown(file, addr, len,
+				pgoff, flags);
+}
+
 static int msharefs_set_size(struct mshare_data *m_data, unsigned long size)
 {
 	int error = -EINVAL;
@@ -87,6 +214,8 @@ static const struct inode_operations msharefs_file_inode_ops;
 
 static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
+	.mmap			= msharefs_mmap,
+	.get_unmapped_area	= msharefs_get_unmapped_area,
 	.fallocate		= msharefs_fallocate,
 };
 
@@ -101,12 +230,14 @@ msharefs_fill_mm(struct inode *inode)
 	if (!mm)
 		return -ENOMEM;
 
-	mm->mmap_base = mm->task_size = 0;
+	mm->mmap_base = mshare_base;
+	mm->task_size = 0;
 
 	m_data = kzalloc(sizeof(*m_data), GFP_KERNEL);
 	if (!m_data)
 		goto err_free;
 	m_data->mm = mm;
+	m_data->start = mshare_base;
 
 	refcount_set(&m_data->ref, 1);
 	inode->i_private = m_data;
-- 
2.47.1


