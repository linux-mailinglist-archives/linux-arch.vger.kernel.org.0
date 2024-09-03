Return-Path: <linux-arch+bounces-6983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99296ACD1
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD65286C1D
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CA1D7E38;
	Tue,  3 Sep 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gAQPAJoT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FD1EC01D;
	Tue,  3 Sep 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405840; cv=none; b=O7kt9oH8sbtdc7K5d7oTnKdNWj8SVCIGV9D6MTILMbsVmGmxPl3xSPFiMz0Y8tcycn+/drV6WEgdP0ON1Sj2PpCLuWERmzYWNwutTkOlv3pUT65uBCLsBijVCnEYsY7wfLmRgUM1bHETOBO+bgHKttgjMhGwZ96bO8UDae96Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405840; c=relaxed/simple;
	bh=iP+5FJt1cWqUdWxQLiJhZGvwlg6IsM2EsXoBzGOw9bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ68EF2ZWDKmu3hqPxPrLvn6y6leN0zk4ZfX7vx9BJSbKJKhIwzOvnfeVHl5oFy0us0k+TDHercUcPHQp0uKbbERgKCVcIOTnIND1o49Op2ZatrtSGnPpuBIJq9mAxlJXTa6Xr/KUWhAnwQQ9dkPB9MwpAlLi4CM0BUh7N7th4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gAQPAJoT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBjM9011995;
	Tue, 3 Sep 2024 23:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=u
	uOxq7Oxho81S6TXP89tPlj4pEnJ7xSzH4D/ZNOwSLQ=; b=gAQPAJoTvI/FNK6eL
	sKJI7eQCB3J2OSzXrt3K+5f6N6xK/6rCTaImSwTOseMCrUUee9Kjl+4s/LcimnfB
	6jzUvyH6envjvVyEPq9wbYurqjKBjUX+jWk4ssZuJbYSu5v2a/CB3YZZH2AzNi5G
	rTdMnWmTm/E2WSbyVmq1dQmIeqUUhc3Sh0Lo/t1DC1dsrO35TOtS3OF9YJcP597D
	sFL2ZioyPqpRjKJ69NNfNWCb3l+F91NAWvRZWUtmga9WacuTSECGHCRouIvT0yxi
	cXleAiC4b9Iip0kjFIygGETHbRayBo9Ci+b1MGO6Iy+6z4eo0RDmK/widO8FjWmx
	C/m3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7t6wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483L2KtP001690;
	Tue, 3 Sep 2024 23:23:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmnbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfE040456;
	Tue, 3 Sep 2024 23:23:26 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-5;
	Tue, 03 Sep 2024 23:23:26 +0000
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
Subject: [RFC PATCH v3 04/10] mm/mshare: allocate an mm_struct for msharefs files
Date: Tue,  3 Sep 2024 16:22:35 -0700
Message-ID: <20240903232241.43995-5-anthony.yznaga@oracle.com>
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
 mlxlogscore=750 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-GUID: YI5SiYhe_q46H_6h3lbAj2EayvwuuRUi
X-Proofpoint-ORIG-GUID: YI5SiYhe_q46H_6h3lbAj2EayvwuuRUi

When a new file is created under msharefs, allocate a new mm_struct
to be associated with it for the lifetime of the file.
The mm_struct will hold the VMAs and pagetables for the mshare region
the file represents.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index f718b8934cdf..a37849e724e1 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,6 +17,10 @@
 #include <linux/fs_context.h>
 #include <uapi/linux/magic.h>
 
+struct mshare_data {
+	struct mm_struct *mm;
+};
+
 struct msharefs_info {
 	struct dentry *info_dentry;
 };
@@ -29,11 +33,51 @@ static const struct file_operations msharefs_file_operations = {
 	.llseek		= no_llseek,
 };
 
+static int
+msharefs_fill_mm(struct inode *inode)
+{
+	struct mm_struct *mm;
+	struct mshare_data *m_data = NULL;
+	int ret = 0;
+
+	mm = mm_alloc();
+	if (!mm) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	mm->mmap_base = mm->task_size = 0;
+
+	m_data = kzalloc(sizeof(*m_data), GFP_KERNEL);
+	if (!m_data) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+	m_data->mm = mm;
+	inode->i_private = m_data;
+
+	return 0;
+
+err_free:
+	if (mm)
+		mmput(mm);
+	kfree(m_data);
+	return ret;
+}
+
+static void
+msharefs_delmm(struct mshare_data *m_data)
+{
+	mmput(m_data->mm);
+	kfree(m_data);
+}
+
 static struct inode
 *msharefs_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
 			const struct inode *dir, umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
+	int ret;
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
@@ -46,6 +90,11 @@ static struct inode
 	case S_IFREG:
 		inode->i_op = &msharefs_file_inode_ops;
 		inode->i_fop = &msharefs_file_operations;
+		ret = msharefs_fill_mm(inode);
+		if (ret) {
+			discard_new_inode(inode);
+			inode = ERR_PTR(ret);
+		}
 		break;
 	case S_IFDIR:
 		inode->i_op = &msharefs_dir_inode_ops;
@@ -141,6 +190,16 @@ static const struct inode_operations msharefs_dir_inode_ops = {
 	.rename		= msharefs_rename,
 };
 
+static void
+mshare_evict_inode(struct inode *inode)
+{
+	struct mshare_data *m_data = inode->i_private;
+
+	if (m_data)
+		msharefs_delmm(m_data);
+	clear_inode(inode);
+}
+
 static ssize_t
 mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
 		loff_t *ppos)
@@ -158,6 +217,7 @@ static const struct file_operations mshare_info_ops = {
 
 static const struct super_operations mshare_s_ops = {
 	.statfs		= simple_statfs,
+	.evict_inode	= mshare_evict_inode,
 };
 
 static int
-- 
2.43.5


