Return-Path: <linux-arch+bounces-13221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC1BB2D134
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF151896598
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64B22B8BE;
	Wed, 20 Aug 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqBI7DFR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB5227E80;
	Wed, 20 Aug 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651972; cv=none; b=RWOxhAogH6eCJk2Tcs+RjGqTey15TSovy6msPYTDrS1oMRFNK6jA+4jtec0vmLYM85iZMRwQJZADHi/sGXiVr6bc452vIP8rYcbLhbG7HWL+t6Dz7njcpXl4UsFaE5yftK98pX9h/fcIddV4QudosTDsyvCPIJTvrvk6+Q9xwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651972; c=relaxed/simple;
	bh=cZvyvJf9F6u/jKKs7PEWyR5kNPKqZD+jYnQg0JJWqt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnggqZNZFMFCfgeaElz8pEy0T8G+7s7wrfoV2hOfJmYPHkEAEKaK5WTldRn/LqDinxaBKTbOY32yRrKDDuIMNy9pLlLcemeSYIMpnVXwcWpZvLUJB4zpJhgsczHAr+RrHfIDZtVJGD3tFb6KLOt+v/fV55xjQw27gVCYiqaSQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqBI7DFR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBm8q005364;
	Wed, 20 Aug 2025 01:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=wjoGm
	Xa06NlpaxdsM8t7M7zxrx9vuEjCZ5dRGwsl5fo=; b=eqBI7DFRKH03KpiWOKlQf
	pzdHTAwO0jt+gAj0aiyhXZ7ydUPU9y8RrH3DJrC63erHzODgdCM2RrnPmJM97X+N
	LPOQUfn5t06eVLinkRf2Vg5N1oTgZOjDnWktianvw1G2rBucX63YcwwJ68McS438
	TZGY+iCIOpv1cPS4v9pslIQ5fxwtXKFEfa8tJXmg+gOvy4jyx3MIiQ9M08KtkZyH
	/3Av8GeliSmEpbU0g93GGsM1D4awpgJkRda72kbvOsZ0J1bapVSn0bjfhK8VXGtJ
	3wUfhG1HhKI4KCH3awJAhph3eF4nPjmigTG2UBKVSXYvS+XLEGwwLUXr9ZJfuVNq
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsr855-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNU7G0007374;
	Wed, 20 Aug 2025 01:05:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Ndg011685;
	Wed, 20 Aug 2025 01:05:14 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-20;
	Wed, 20 Aug 2025 01:05:14 +0000
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
Subject: [PATCH v3 19/22] mm/mshare: Add an ioctl for unmapping objects in an mshare region
Date: Tue, 19 Aug 2025 18:04:12 -0700
Message-ID: <20250820010415.699353-20-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: FZMDyNrGz-kBXzU0LBJu2U9tFf2PbkWF
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a51f4d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=ZK8ikAtwNUxspKypWBsA:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: FZMDyNrGz-kBXzU0LBJu2U9tFf2PbkWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX35ivsWoahLZu
 OeP1bjg8Z0tMRWMw9IQpQf+HzRLKANG5OcR+e6vIIvyehO7/EfOP7EKF7mYHaeLs1zOUbk42VPv
 pcnrCHHnsnC7whM/YZccUTxGwclUxSBVR4ahC6i9lAu+hmAPB9pVnGprW3dm5bPqy3e8J0QVT3n
 sHJPY5xDwK75i7WjxBSv5E9SuKtcS8BAdUpE2RjrB1lH0Le3QtTkfEvPr0+nOMf0jY6WTX49NRu
 pLXVE/vdWj/bOYm+scKriNbB7FBk8vb0snFbp0cIhm+aeM5T/ROmxBiulqhlyfEI7PodM0crGjk
 0hKMNeQz27agz45/NeAebGDpPhrOhlxUw1KvxNK3TZI2Ii9K1010hFWVTpEGviy3hrj4Gxx9UjO
 +KlU8JgsG8w5D/pIsDiYYP/qBs/n3g==

The arguments are the same as munmap() except that the start of the
mapping is specified as an offset into the mshare region instead of
as an address.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/linux/msharefs.h |  7 +++++++
 mm/mshare.c                   | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

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
index ebec51e655e4..b1e02f5e1f60 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -394,11 +394,41 @@ msharefs_create_mapping(struct mshare_data *m_data, struct mshare_create *mcreat
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
 
 	if (!mshare_is_initialized(m_data))
 		return -EINVAL;
@@ -411,6 +441,13 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		return msharefs_create_mapping(m_data, &mcreate);
 
+	case MSHAREFS_UNMAP:
+		if (copy_from_user(&munmap, (struct mshare_unmap __user *)arg,
+			sizeof(munmap)))
+			return -EFAULT;
+
+		return msharefs_unmap(m_data, &munmap);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.47.1


