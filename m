Return-Path: <linux-arch+bounces-9899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B081AA1BF66
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61D016EF8E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB01FA161;
	Fri, 24 Jan 2025 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2Fn/my0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418B1F4282;
	Fri, 24 Jan 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762993; cv=none; b=j54ak7bEoh/FgEGZERrcIGazWUWHzxfSEgQd5Dfg1AVN7e6VAI419JF8VQcIqM0qkJYhilcQ06qKMXLWq3Sv/spFbZzIHJPjpfX6LfNuX0HgC0quG1RvZYK0SnfHpy6Axc8uo77lbl6v0gwXQvjsoUSUO4APoOHW4uoUffgyO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762993; c=relaxed/simple;
	bh=bCi69afgKdy8QjDhA126o09f6hVRjp1J+V6hT56xlI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdGEDLnPp0c1CU/nz70GI1iauxKIg+sMVzVLpwFTvCe4GG8LlvGDfZzZJoVPULGC/QWnCAnu0MdW3riwQHZeXSDUoMtjN+6AEFWj4iRnPpJHuDwOWlFpKY0oNi2CEt4oYhXGkpCT6oinPz81ze1Ek8525CcJBLzwvT+N+x3eAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2Fn/my0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIi39S019133;
	Fri, 24 Jan 2025 23:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=fcIGc
	V/98l8ZSjQDmXrF3affeH5gAuXvROyoFcfZEuw=; b=a2Fn/my0YFitA1HTu3rMs
	vVjepHWSc4mtb1D4lZwU2+HUiFmyAfRG+b2J9B7sTQIhkhHv+5so55NFpuw+9QB6
	5IlnBjtBB1nScTizxp8+HvWpPPlV8Xk7iu5bC2OppEWguINRcXS8x0rTEEduQ8zY
	6DphIs0lyq7VA2SY/CjUxmOmQR2yda66f9hy9vTq5C4r9eoCY48aAV/BQhk/YKEf
	gXDR570rmgzu1e/LVmfqRVSIMF9lquv00jDKnJAiVDdsXsi3N1RZMtOdsZjGiBDt
	gYZ8Dcz/6PLRmaL0lP7CNShlYBppS11nC8cJec/kCQ23yo/t+0IRNU8t1fN4NuzE
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qaw408-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMD09b036431;
	Fri, 24 Jan 2025 23:55:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4ama-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQE018051;
	Fri, 24 Jan 2025 23:55:58 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-17;
	Fri, 24 Jan 2025 23:55:58 +0000
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
Subject: [PATCH 16/20] mshare: add MSHAREFS_CREATE_MAPPING
Date: Fri, 24 Jan 2025 15:54:50 -0800
Message-ID: <20250124235454.84587-17-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-GUID: 5QNgZKQltQ9yn3rK-ZEnWzGSYsobWy1O
X-Proofpoint-ORIG-GUID: 5QNgZKQltQ9yn3rK-ZEnWzGSYsobWy1O

Add an ioctl for mapping objects within an mshare region. The
arguments are the same as mmap(). Only shared anonymous memory
mapped with MAP_FIXED is supported initially.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/linux/msharefs.h |  9 +++++
 mm/mshare.c                   | 65 +++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

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
index 9ada1544aeb1..d70f10210b46 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -194,12 +194,60 @@ msharefs_set_size(struct mm_struct *host_mm, struct mshare_data *m_data,
 	return 0;
 }
 
+static long
+msharefs_create_mapping(struct mm_struct *host_mm, struct mshare_data *m_data,
+			struct mshare_create *mcreate)
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
+	 * Only anonymous shared memory at fixed addresses is allowed for now.
+	 */
+	if ((flags & (MAP_SHARED | MAP_FIXED)) != (MAP_SHARED | MAP_FIXED))
+		goto out;
+	if (fd != -1)
+		goto out;
+
+	if (mmap_write_lock_killable(host_mm)) {
+		err = -EINTR;
+		goto out;
+	}
+
+	err = 0;
+	mapped_addr = __do_mmap(NULL, addr, size, prot, flags, vm_flags,
+				0, &populate, NULL, host_mm);
+
+	if (IS_ERR_VALUE(mapped_addr))
+		err = (long)mapped_addr;
+
+	mmap_write_unlock(host_mm);
+out:
+	return err;
+}
+
 static long
 msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct mshare_data *m_data = filp->private_data;
 	struct mm_struct *host_mm = m_data->mm;
 	struct mshare_info minfo;
+	struct mshare_create mcreate;
 
 	switch (cmd) {
 	case MSHAREFS_GET_SIZE:
@@ -228,6 +276,23 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		return msharefs_set_size(host_mm, m_data, &minfo);
 
+	case MSHAREFS_CREATE_MAPPING:
+		if (copy_from_user(&mcreate, (struct mshare_create __user *)arg,
+			sizeof(mcreate)))
+			return -EFAULT;
+
+		/*
+		 * validate mshare region
+		 */
+		spin_lock(&m_data->m_lock);
+		if (m_data->minfo.size == 0) {
+			spin_unlock(&m_data->m_lock);
+			return -EINVAL;
+		}
+		spin_unlock(&m_data->m_lock);
+
+		return msharefs_create_mapping(host_mm, m_data, &mcreate);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.43.5


