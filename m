Return-Path: <linux-arch+bounces-13206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7FCB2D0F6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6580CA01A4F
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940871C1F05;
	Wed, 20 Aug 2025 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R6Ykf47M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11E19CD1B;
	Wed, 20 Aug 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651952; cv=none; b=GBINba7hpUh81Tw5fmbAwy9X166GNxiveYyWglsGUeXTgORpC8oZKMuOAg60Eh9M1FCG5u3fba+0yAe7TvaLgNi7+mnvGSP/6oUHioESm/oHE7u6SJ/8cVr4ED8q3/LIgETFrmseMbaxxGek7zugZ5RlpKwJQcjK1oFRxfo/f/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651952; c=relaxed/simple;
	bh=VOTlOBxtM59V7Zzj573LgcG59E0PSEmDSLHYYRxscvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/hOTa0ai2qbkpjXJrVvnm645Nb4G7z5jVIOi3Od1YpQi8kPC0EeH2qKsRQZmKw4CIia1N7Tx+1AFpgRqiG6zO7SNMxjG2BC6Byok2fCIGuMXNwxj9l2xYSaIEwIUT2b3kDR3n8XyosxFr6DRjx9C5l+n7EojWvkF6T+5HAjqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R6Ykf47M; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLCEq1012242;
	Wed, 20 Aug 2025 01:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=x+H+s
	A2wbapk0bAi60LM8rU+Rifb31fILDaW1a9nREQ=; b=R6Ykf47MjXhvjC985/OeR
	XVQkGZBP3q1CQ9WiaQXraupQua32LyA7cZULB8GPAWTmTSwLS/qCk3YMf3nP/45M
	pjVR4W74u+wlnNz2O0D0Z7sbGmtLyw6gh0ZFvQRoWFLs3SmKGGmy5vHHCGbAiPww
	SetDygntZgUFHaqH9mFwG6ukU915Us+9e8ro+95jFBh3IQKcwB8Q4Iujl276LowT
	xXfZpbZ7bC6pPv6J1uNa1QKFuzxNCrN+6gH9eRdQpetPz5dBGB+DmlaVl9bh3e1n
	KE/RDgiMpk/TM839b0GUCVQDr3PecQjKbl7pG9Ftk8lMyqx+GR+ps5gDClnaJGQF
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trr8dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNXLM8007358;
	Wed, 20 Aug 2025 01:04:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdE011685;
	Wed, 20 Aug 2025 01:04:37 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-6;
	Wed, 20 Aug 2025 01:04:37 +0000
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
Subject: [PATCH v3 05/22] mm/mshare: add ways to set the size of an mshare region
Date: Tue, 19 Aug 2025 18:03:58 -0700
Message-ID: <20250820010415.699353-6-anthony.yznaga@oracle.com>
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
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=920
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200007
X-Proofpoint-ORIG-GUID: LHUwwBAlFDOKUZ1C5Oa7Uw7vETmGP-xi
X-Proofpoint-GUID: LHUwwBAlFDOKUZ1C5Oa7Uw7vETmGP-xi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXx3Dliz+VYorm
 6jh3wb507jjHEcFE0clu3pt9XherMgo3M8okFWpuLKVV3v18+WVZ9MrDLbAbNSh/rBYC+oeCTEi
 mUV7mFEwJlu7igr87w1/qX5BoID8gLdojVVlJQTiCuEQHuXK9NokfAKVqP6lQGfewsWqZLgDOZ2
 rAd9lsgKVUgfAoXSXYHf8xUSyADucGmPpyt1Y5Kacq+MuA6gZ7ajiyxcJX2n9r2UYE6StbhnxeQ
 bkLJTtYhBQ33OksTNqeY5QvhgeI4HBqrDcSuRdnPIeiAIEtcoek17PrwPPFoG+lYv8qK6suKaru
 MYgTMkAoC+5KcYgWUMAG3AlNEhb0EO4Sud42kXQuLcCNXsfk9xXsmwS2kXMAhqzbOvcwSxvNVr/
 7WtJTJSbNs4sxi3ttoA9MzxGJtmOlA==
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a51f27 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RpjSixA7iQhGN-bV:21 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8
 a=HTk2KgwdMEbdErbPyz8A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

Add file and inode operations to allow the size of an mshare region
to be set fallocate() or ftruncate().

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 400f198c0791..bf859b176e09 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,19 +16,78 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/magic.h>
+#include <linux/falloc.h>
 
 const unsigned long mshare_align = P4D_SIZE;
 
+#define MSHARE_INITIALIZED	0x1
+
 struct mshare_data {
 	struct mm_struct *mm;
 	refcount_t ref;
+	unsigned long size;
+	unsigned long flags;
 };
 
+static inline bool mshare_is_initialized(struct mshare_data *m_data)
+{
+	return test_bit(MSHARE_INITIALIZED, &m_data->flags);
+}
+
+static int msharefs_set_size(struct mshare_data *m_data, unsigned long size)
+{
+	int error = -EINVAL;
+
+	if (mshare_is_initialized(m_data))
+		goto out;
+
+	if (m_data->size || (size & (mshare_align - 1)))
+		goto out;
+
+	m_data->mm->task_size = m_data->size = size;
+
+	set_bit(MSHARE_INITIALIZED, &m_data->flags);
+	error = 0;
+out:
+	return error;
+}
+
+static long msharefs_fallocate(struct file *file, int mode, loff_t offset,
+				loff_t len)
+{
+	struct inode *inode = file_inode(file);
+	struct mshare_data *m_data = inode->i_private;
+	int error;
+
+	if (mode != FALLOC_FL_ALLOCATE_RANGE)
+		return -EOPNOTSUPP;
+
+	if (offset)
+		return -EINVAL;
+
+	inode_lock(inode);
+
+	error = inode_newsize_ok(inode, len);
+	if (error)
+		goto out;
+
+	error = msharefs_set_size(m_data, len);
+	if (error)
+		goto out;
+
+	i_size_write(inode, len);
+out:
+	inode_unlock(inode);
+
+	return error;
+}
+
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
 static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
+	.fallocate		= msharefs_fallocate,
 };
 
 static int
@@ -128,6 +187,32 @@ msharefs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return 0;
 }
 
+static int msharefs_setattr(struct mnt_idmap *idmap,
+			    struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct mshare_data *m_data = inode->i_private;
+	unsigned int ia_valid = attr->ia_valid;
+	int error;
+
+	error = setattr_prepare(idmap, dentry, attr);
+	if (error)
+		return error;
+
+	if (ia_valid & ATTR_SIZE) {
+		loff_t newsize = attr->ia_size;
+
+		error = msharefs_set_size(m_data, newsize);
+		if (error)
+			return error;
+
+		i_size_write(inode, newsize);
+	}
+
+	setattr_copy(idmap, inode, attr);
+	return 0;
+}
+
 static int
 msharefs_create(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, umode_t mode, bool excl)
@@ -182,7 +267,7 @@ msharefs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 static const struct inode_operations msharefs_file_inode_ops = {
-	.setattr	= simple_setattr,
+	.setattr	= msharefs_setattr,
 };
 
 static const struct inode_operations msharefs_dir_inode_ops = {
-- 
2.47.1


