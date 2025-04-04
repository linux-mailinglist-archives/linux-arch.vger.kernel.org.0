Return-Path: <linux-arch+bounces-11253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E14A7B5B3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042F53B7B54
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8D27702;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cxSCOxsf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48462E62AA;
	Fri,  4 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733196; cv=none; b=Efa2qjvtnE9NYC9ddLqZBGL2I6RWspPvPcW4tvJfcrsCTlPh9DQbWueAlvoTgjLJoX/VHGu3hdVZUqyl1PwDUATZ/AD1lUTY43+ezP+nzyX33vQGnPHf6uNCooasx03I1aYmFnEvXD/y8kB6JS8zDvv+4onVX7EpYzjQczQIJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733196; c=relaxed/simple;
	bh=DCUWNJFgcS/C1qQ/FHVsjaPZyn8+0Y8jjlGECeikpkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ9OR5/F+HcCmqSuHtY8zImb34qpgBdBm6531iZNXxpXLy25x4zhU9Y2V4l14/yi1a51QIj0GxErt/nPvoXDu6HmqogpvN/rj3T7SNNsNn9IUsEROAn/+A84FrqgVrYuc60exYdu/L2+ppZomRMnfTxatz4yKTD4KvhqkcD7Kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cxSCOxsf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341ND7v027856;
	Fri, 4 Apr 2025 02:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=MGRNl
	Hjm2NzE/Ygwoev9rb9WkAWCS/ZSx8jSVZ/ywzM=; b=cxSCOxsfTYCu7dCZHdjUY
	1auFj+JrZqQERrU9rOlhlRZU/iIhe8/AqDt51WtcOo77HHNblyzS+79uDMIaLvCw
	2tb0h05n+851Wz/3Ff4fj4SOYs0qEbOecahI5Wt7rpNRLcX2mOLN2Kxx3Qsgm48o
	88LuB+/eDQ3gSNKPhL4AO4exixU3DQEg/Bf26j3nBKmUm/yN9TEGMA7wKueDpRW8
	Anp1GRHYpP3w0oH+c67RS8aeXIhX0ijRUn/J1jaU/CeBbzj36KfcC7DUX0E3cPyk
	7GW+iRxZ70ZwWKDzCg5guf6TK+KHz+PsrbfnxJRH9M3PWDhqKBn9fAbZnlGIxN//
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0p1nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340Ztw7017309;
	Fri, 4 Apr 2025 02:19:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gk030074;
	Fri, 4 Apr 2025 02:19:18 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-6;
	Fri, 04 Apr 2025 02:19:17 +0000
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
Subject: [PATCH v2 05/20] mm/mshare: add ways to set the size of an mshare region
Date: Thu,  3 Apr 2025 19:18:47 -0700
Message-ID: <20250404021902.48863-6-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: 9H4YH3MygLBCUPRBRZGsso8O3POOnB6W
X-Proofpoint-GUID: 9H4YH3MygLBCUPRBRZGsso8O3POOnB6W

Add file and inode operations to allow the size of an mshare region
to be set fallocate() or ftruncate().

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 551d12cb9fdb..5eed18bc3b51 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,18 +16,72 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/magic.h>
+#include <linux/falloc.h>
 
 const unsigned long mshare_align = P4D_SIZE;
 
+#define MSHARE_INITIALIZED	0x1
+
 struct mshare_data {
 	struct mm_struct *mm;
+	unsigned long size;
+	unsigned long flags;
 };
 
+static int msharefs_set_size(struct mshare_data *m_data, unsigned long size)
+{
+	int error = -EINVAL;
+
+	if (test_bit(MSHARE_INITIALIZED, &m_data->flags))
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
@@ -123,6 +177,32 @@ msharefs_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -177,7 +257,7 @@ msharefs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 static const struct inode_operations msharefs_file_inode_ops = {
-	.setattr	= simple_setattr,
+	.setattr	= msharefs_setattr,
 };
 
 static const struct inode_operations msharefs_dir_inode_ops = {
-- 
2.43.5


