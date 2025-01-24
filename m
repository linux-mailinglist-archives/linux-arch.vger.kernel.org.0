Return-Path: <linux-arch+bounces-9900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B1A1BF6A
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933841885739
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C61FAC3B;
	Fri, 24 Jan 2025 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HreZ+IIN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808841F4729;
	Fri, 24 Jan 2025 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762996; cv=none; b=Wyti0lUQ8xI+893anz0pua2DG5XAI3HvW7psHWYvYhU/+xFxDNFOIbJjT4oSm7232xJ1IJeV1+m8FHYjJcCpd/tcpnWH5Jv+y1AZDYI5VnUnouP0/4/XdqdbunOnp8dFFPbNQd5DNTxanQqPDejxlyghc93libtwlGDKIs1t+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762996; c=relaxed/simple;
	bh=HuaBhXJgjM+5zMI0EFUsmAd6q2svXLGu1wIAmSY2fGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6CT0P36DzRl4l+Y1y0ogUo+3HxoRh+WhmJwk3X4VG1dG9hSiCidKEEveeY6itAvhROqhZYscVepvxmJ+QC/6Ta3ZHktJLFmi8NU1j4thFj97VcCDDwYOAEvl3yghwHXI8wQlumNIuk/sTALcmnBvORwQhqzPGgFpGmo93FObUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HreZ+IIN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIBX66001521;
	Fri, 24 Jan 2025 23:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=X0po0
	sWopN9sdAxoG7FE/M7ahK8VIPD0eThxsGOy3dw=; b=HreZ+IINxUUt+Ox8BrN6k
	6Z+qo+dQKjtgOpUCTcmokqyKC8EDmnBK2Cf+RCng15P/GkxFg0YXJdOy4fwxNpBY
	Dg33t34z09UTLSboAUdg1aUmGbgXxjuHDSoaCEy3SrV/28oxHKjTvHW3OIS8Zx5D
	DGKtvBeW6Ae3gzmirx1E1l76v6cYlLcpkQyY2Q9SyYL+msDRSVRrRQaHj9J2imvK
	5KRtFLNDEJ2pS4aQtFeUrnedt0uyCLN7NtseR0U2zF2H23db2kvhKkEO7XVws/uZ
	ATY/rdXNTX7N0L3xJlOQh/jjZUdGVZNw2s8m51crRzx6N9pzGPxZCreQtHBzT8EX
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b06j5j48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMMu6P036606;
	Fri, 24 Jan 2025 23:56:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4an8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQG018051;
	Fri, 24 Jan 2025 23:56:01 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-18;
	Fri, 24 Jan 2025 23:56:01 +0000
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
Subject: [PATCH 17/20] mshare: add MSHAREFS_UNMAP
Date: Fri, 24 Jan 2025 15:54:51 -0800
Message-ID: <20250124235454.84587-18-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=914 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: rYZnMe-DfE5Cl4XSqOR0IwdWDQ6875RN
X-Proofpoint-GUID: rYZnMe-DfE5Cl4XSqOR0IwdWDQ6875RN

Add an ioctl for unmapping objects in an mshare region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/linux/msharefs.h |  7 ++++++
 mm/mshare.c                   | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/uapi/linux/msharefs.h b/include/uapi/linux/msharefs.h
index fea0afdf000d..f7af1f2b5ee7 100644
--- a/include/uapi/linux/msharefs.h
+++ b/include/uapi/linux/msharefs.h
@@ -21,6 +21,7 @@
 #define MSHAREFS_GET_SIZE	_IOR('x', 0,  struct mshare_info)
 #define MSHAREFS_SET_SIZE	_IOW('x', 1,  struct mshare_info)
 #define MSHAREFS_CREATE_MAPPING	_IOW('x', 2,  struct mshare_create)
+#define MSHAREFS_UNMAP		_IOW('x', 3,  struct mshare_unmap)
 
 struct mshare_info {
 	__u64 start;
@@ -35,4 +36,10 @@ struct mshare_create {
 	__u32 flags;
 	__u32 fd;
 };
+
+struct mshare_unmap {
+	__u64 addr;
+	__u64 size;
+};
+
 #endif
diff --git a/mm/mshare.c b/mm/mshare.c
index d70f10210b46..8f53b8132895 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -241,6 +241,32 @@ msharefs_create_mapping(struct mm_struct *host_mm, struct mshare_data *m_data,
 	return err;
 }
 
+static long
+msharefs_unmap(struct mm_struct *host_mm, struct mshare_data *m_data,
+		  struct mshare_unmap *m_unmap)
+{
+	unsigned long mshare_start, mshare_end;
+	unsigned long addr = m_unmap->addr;
+	unsigned long size = m_unmap->size;
+	int err;
+
+	mshare_start = m_data->minfo.start;
+	mshare_end = mshare_start + m_data->minfo.size;
+
+	if ((addr < mshare_start) || (addr >= mshare_end) ||
+	    (addr + size > mshare_end))
+		return -EINVAL;
+
+	if (mmap_write_lock_killable(host_mm))
+		return -EINTR;
+
+	err = do_munmap(host_mm, addr, size, NULL);
+
+	mmap_write_unlock(host_mm);
+
+	return err;
+}
+
 static long
 msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
@@ -248,6 +274,7 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct mm_struct *host_mm = m_data->mm;
 	struct mshare_info minfo;
 	struct mshare_create mcreate;
+	struct mshare_unmap m_unmap;
 
 	switch (cmd) {
 	case MSHAREFS_GET_SIZE:
@@ -293,6 +320,23 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		return msharefs_create_mapping(host_mm, m_data, &mcreate);
 
+	case MSHAREFS_UNMAP:
+		if (copy_from_user(&m_unmap, (struct mshare_unmap __user *)arg,
+			sizeof(m_unmap)))
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
+		return msharefs_unmap(host_mm, m_data, &m_unmap);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.43.5


