Return-Path: <linux-arch+bounces-6988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD496ACDB
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E9D1F25139
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ACC1D9D6F;
	Tue,  3 Sep 2024 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EejzamMD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5E126C07;
	Tue,  3 Sep 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405860; cv=none; b=V8VVwqO87YPeYnSsI9E42b/B4E+I0jxXZFZOF8b4r/2S2of6Voobw1kBEDm12eJWOPmmpAPFgy4sq5RgByaDdPRYH4zjpxuTRofK/y+ANAdbIuceyckcjDptNHRJmR+VmhwiDhmg8xMu/QSAZQLi0ImoYNs/QSWpOKHNaQSfdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405860; c=relaxed/simple;
	bh=uxUP/pNkMUv55TyRlpx3+NMZ38gYu44VEuKodr0xvtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNq5k3d3mbhRs2T8HXXFHsHl0FL1PhffqPAi5RmuEeFYw1gTxonn9Et82QnFWsf8+VdXw3tO5I/8clVsQUFV4d+3LEpwOsB7ds1QFoXVfTGW2PYcBWse7Llxv584Qi7AxOQnZELnmhheRekLaJWo5xJksdNTskcDz6FJgGUGwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EejzamMD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBTND022739;
	Tue, 3 Sep 2024 23:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=V
	K2/rT5IIEmxprXEAU2yy+HHJnHBBZfWU/+zXLoCJkA=; b=EejzamMDBK7bPK5bb
	0qt0mQjn5qkF+bv+ii/+f+UA/hfcsO4FDUSATiJLfN5sAhb7njBr6XKEg26G43N/
	Un0lt+S0CoRg1U2RIXQEp2EBtenc6w8MFGkXGalrrGGgX+F6rBhwPpmnzH1Z5DYr
	V8mNpL9sRagOGCX1auCuiIUgINwjowoouwBVLdEAAKjCXCelimkJHpMK/Z5SQDTQ
	TyJViwri2XDZLuPG2Fdm15FlIXv2tB/d/mu3VV4Gd2UIeLec5OK9m409R1dId+Nt
	iN6SRiC/qf/BhY5+gFW4u/jdhJJw6ekLNzFbxSu0DGBJSoD86IlNKtM/wexRBsJl
	r0XFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84jug1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483KsE5R001736;
	Tue, 3 Sep 2024 23:23:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmnn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfQ040456;
	Tue, 3 Sep 2024 23:23:48 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-11;
	Tue, 03 Sep 2024 23:23:48 +0000
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
Subject: [RFC PATCH v3 10/10] mshare: add MSHAREFS_CREATE_MAPPING
Date: Tue,  3 Sep 2024 16:22:41 -0700
Message-ID: <20240903232241.43995-11-anthony.yznaga@oracle.com>
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
 mlxlogscore=792 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-GUID: o4IuCMD6qVU1RpEdvToueyKdV1ZsTS0a
X-Proofpoint-ORIG-GUID: o4IuCMD6qVU1RpEdvToueyKdV1ZsTS0a

Add an ioctl for mapping objects within an mshare region. The
arguments are the same as mmap() although only shared anonymous
memory with some restrictions is supported initially.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/linux/msharefs.h |  9 +++++
 mm/mshare.c                   | 71 +++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/uapi/linux/msharefs.h b/include/uapi/linux/msharefs.h
index c7b509c7e093..fea0afdf000d 100644
--- a/include/uapi/linux/msharefs.h
+++ b/include/uapi/linux/msharefs.h
@@ -20,10 +20,19 @@
  */
 #define MSHAREFS_GET_SIZE	_IOR('x', 0,  struct mshare_info)
 #define MSHAREFS_SET_SIZE	_IOW('x', 1,  struct mshare_info)
+#define MSHAREFS_CREATE_MAPPING	_IOW('x', 2,  struct mshare_create)
 
 struct mshare_info {
 	__u64 start;
 	__u64 size;
 };
 
+struct mshare_create {
+	__u64 addr;
+	__u64 size;
+	__u64 offset;
+	__u32 prot;
+	__u32 flags;
+	__u32 fd;
+};
 #endif
diff --git a/mm/mshare.c b/mm/mshare.c
index 8f47c8d6e6a4..7b89bf7f5ffc 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/mman.h>
 #include <linux/spinlock_types.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/msharefs.h>
@@ -154,12 +155,65 @@ msharefs_set_size(struct mm_struct *mm, struct mshare_data *m_data,
 	return 0;
 }
 
+static long
+msharefs_create_mapping(struct mm_struct *mm, struct mshare_data *m_data,
+		        struct mshare_create *mcreate)
+{
+	unsigned long mshare_start, mshare_end;
+	unsigned long mapped_addr;
+	unsigned long populate = 0;
+	unsigned long addr = mcreate->addr;
+	unsigned long size = mcreate->size;
+	unsigned int fd = mcreate->fd;
+	int prot = mcreate->prot;
+	int flags = mcreate->flags;
+	vm_flags_t vm_flags;
+	int err = -EINVAL;
+
+	mshare_start = m_data->minfo.start;
+	mshare_end = mshare_start + m_data->minfo.size;
+
+	if ((addr < mshare_start) || (addr >= mshare_end) ||
+	    (addr + size > mshare_end))
+		goto out;
+
+	/*
+	 * XXX Keep things simple initially and only allow the mapping of
+	 * anonymous shared memory at fixed addresses without unmapping.
+	 */
+	if ((flags & (MAP_SHARED | MAP_FIXED)) != (MAP_SHARED | MAP_FIXED))
+		goto out;
+
+	if (fd != -1)
+		goto out;
+
+	flags |= MAP_FIXED_NOREPLACE;
+	vm_flags = VM_NOHUGEPAGE;
+
+	if (mmap_write_lock_killable(mm)) {
+		err = -EINTR;
+		goto out;
+	}
+
+	err = 0;
+	mapped_addr = __do_mmap(NULL, addr, size, prot, flags, vm_flags,
+				0, &populate, NULL, mm);
+
+	if (IS_ERR_VALUE(mapped_addr))
+		err = (long)mapped_addr;
+
+	mmap_write_unlock(mm);
+out:
+	return err;
+}
+
 static long
 msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct mshare_data *m_data = filp->private_data;
 	struct mm_struct *mm = m_data->mm;
 	struct mshare_info minfo;
+	struct mshare_create mcreate;
 
 	switch (cmd) {
 	case MSHAREFS_GET_SIZE:
@@ -188,6 +242,23 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		return msharefs_set_size(mm, m_data, &minfo);
 
+	case MSHAREFS_CREATE_MAPPING:
+		if (copy_from_user(&mcreate, (struct mshare_create __user *)arg,
+			sizeof(mcreate)))
+			return -EFAULT;
+
+		/*
+		 * validate mshare region
+		 */
+		spin_lock(&m_data->m_lock);
+		if (m_data->minfo.start == 0) {
+			spin_unlock(&m_data->m_lock);
+			return -EINVAL;
+		}
+		spin_unlock(&m_data->m_lock);
+
+		return msharefs_create_mapping(mm, m_data, &mcreate);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.43.5


