Return-Path: <linux-arch+bounces-11267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C5BA7B5D1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3746D178B66
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50919F13B;
	Fri,  4 Apr 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g8/rtzC/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C619D8A8;
	Fri,  4 Apr 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733213; cv=none; b=GbF7KU8nuEIJdeaXdOVUWKm/ZzCFy2EzK0AimzYrPWd8wf7NXiEIvkXKkpROi04MwNONzt9UgGLkX+jb7Jr2iQ/pDe0u0NOgIPfDs01w62RIiBEGzJIphYBFnRR6mpbSV+rRPmUBYXPXsB6Vu1OAs0PTN3UFvwr3CM1E0ZID1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733213; c=relaxed/simple;
	bh=ZaoxEuAgeZ0ySsbMK/SUjVqylX3DmmyoM+i/5oRVkKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/KC9qwO6SxQLzFy3oV4h/cO7bBbLbZOGfOHJxbEOB80ofPCq1TK73KV1XgPoi7ixS8/z/X9oloynN7iecXvgjfeHgyJ1sKFhNuqDAEzLqQIF8TY8qOhlqas1iHQRzTy3vw9C1RX+Fts4LzB9Ykw1CYDhsGS+gpCWjWr0t1udVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g8/rtzC/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O7Gg024208;
	Fri, 4 Apr 2025 02:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=qKETl
	3boxGSqY1XHPbVbmfYTJqsfiqERPIv13nBPjsk=; b=g8/rtzC/YcIbSBczu3C+P
	wkfNxw3vt28s1VNtVjUrMPbz6ydnxVpgi9ZqSQN+QIZ3OIF3weOFsoF90AmHF6QF
	je+LmZn+1Nf1sogguuAS/OmcHFex4zdh0qcYUGJByl1tRXBcw72PKC/U1/o+zAW3
	QtmmRb/Fq9VmX+V1ynnqTyTBWWrIULyI+KuLLzV/DWeSjP9x9FWz6m1sXEG0h8x+
	LaIrrWJ6indGXgjZzeHXmPYNl4Szbnf1Xv1Qhi2q+pG8sm8l03CItwdpbQSuwhaS
	7yXWXOcoK0nmuDxVr6DeFrR4e8reRFHoOdwcszXYLdmLs0twU7HRagaQ+krmyOtU
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsehf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340fRNl017354;
	Fri, 4 Apr 2025 02:19:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8hA030074;
	Fri, 4 Apr 2025 02:19:48 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-18;
	Fri, 04 Apr 2025 02:19:47 +0000
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
Subject: [PATCH v2 17/20] mm/mshare: Add an ioctl for unmapping objects in an mshare region
Date: Thu,  3 Apr 2025 19:18:59 -0700
Message-ID: <20250404021902.48863-18-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: _v_EaYXFzgUP_UK3Jm0_mzqmEOIgUWb-
X-Proofpoint-GUID: _v_EaYXFzgUP_UK3Jm0_mzqmEOIgUWb-

The arguments are the same as munmap() except that the start of the
mapping is specified as an offset into the mshare region instead of
as an address.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/linux/msharefs.h |  7 ++++++
 mm/mshare.c                   | 40 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/msharefs.h b/include/uapi/linux/msharefs.h
index ad129beeef62..fb0235d1e384 100644
--- a/include/uapi/linux/msharefs.h
+++ b/include/uapi/linux/msharefs.h
@@ -19,6 +19,7 @@
  * msharefs specific ioctl commands
  */
 #define MSHAREFS_CREATE_MAPPING	_IOW('x', 0,  struct mshare_create)
+#define MSHAREFS_UNMAP		_IOW('x', 1,  struct mshare_unmap)
 
 struct mshare_create {
 	__u64 region_offset;
@@ -28,4 +29,10 @@ struct mshare_create {
 	__u32 flags;
 	__u32 fd;
 };
+
+struct mshare_unmap {
+	__u64 region_offset;
+	__u64 size;
+};
+
 #endif
diff --git a/mm/mshare.c b/mm/mshare.c
index be0aaa894963..a6106f6264cb 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -281,11 +281,41 @@ msharefs_create_mapping(struct mshare_data *m_data, struct mshare_create *mcreat
 	return error;
 }
 
+static long
+msharefs_unmap(struct mshare_data *m_data, struct mshare_unmap *munmap)
+{
+	struct mm_struct *host_mm = m_data->mm;
+	unsigned long mshare_start, mshare_end, mshare_size;
+	unsigned long region_offset = munmap->region_offset;
+	unsigned long size = munmap->size;
+	unsigned long addr;
+	int error;
+
+	mshare_start = m_data->start;
+	mshare_size = m_data->size;
+	mshare_end = mshare_start + mshare_size;
+	addr = mshare_start + region_offset;
+
+	if ((size > mshare_size) || (region_offset >= mshare_size) ||
+	    (addr + size > mshare_end))
+		return -EINVAL;
+
+	if (mmap_write_lock_killable(host_mm))
+		return -EINTR;
+
+	error = do_munmap(host_mm, addr, size, NULL);
+
+	mmap_write_unlock(host_mm);
+
+	return error;
+}
+
 static long
 msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct mshare_data *m_data = filp->private_data;
 	struct mshare_create mcreate;
+	struct mshare_unmap munmap;
 
 	switch (cmd) {
 	case MSHAREFS_CREATE_MAPPING:
@@ -298,6 +328,16 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		return msharefs_create_mapping(m_data, &mcreate);
 
+	case MSHAREFS_UNMAP:
+		if (copy_from_user(&munmap, (struct mshare_unmap __user *)arg,
+			sizeof(munmap)))
+			return -EFAULT;
+
+		if (!test_bit(MSHARE_INITIALIZED, &m_data->flags))
+			return -EINVAL;
+
+		return msharefs_unmap(m_data, &munmap);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.43.5


