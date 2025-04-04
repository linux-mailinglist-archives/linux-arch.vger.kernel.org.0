Return-Path: <linux-arch+bounces-11254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA66AA7B5B5
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D87C7A7710
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605967DA66;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kUgz0VAG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C676034;
	Fri,  4 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733196; cv=none; b=CcKwQfoLfmPtVjw6wElSFkxAijiXXhcKAWZpfgkl03tDDA2JHc34+Sdly4PmhC0zgLsLfj/0hl+XovuUMx8at3mdxGlAk5gE6+NXRk8ByL9NIJPTu2WlfPgm53Q/SlQDHMcyzw07i7Ch/RJUaMcuPI/+vWbUQq8u9scsK09Vo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733196; c=relaxed/simple;
	bh=tq0LiVCJuWel6Zm7qlmUwWuNeEcvYz2/N259UZubJ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN08YHgVNQm/3tnKrZF5qI7EwHvtCu9kGUc7x/N3zpTDCAImeZ0dTSZcSXnv/6ZOU/pUqwK7WXxjxjFp3syre+ggtAHaWvv6ZscrSghpsEodsGh4ztcKwNZpsiV/z703J/sn72JBAhLXFfPv80ZCXC3Q/qrwYSJsBf/7SC3Stpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kUgz0VAG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N2KX003850;
	Fri, 4 Apr 2025 02:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Jiiyc
	qv5NaezAa4akWRM0oZtFs3Zbqyk8RRdDi/cYQE=; b=kUgz0VAGp7FWZz6OmUrqy
	d+XaVJHy5AOwRFGI6rP0IJRxEDEeP0BoWlWgkk7E/GTiIwTsFHGDB9m6BeT7VG9D
	pP1P4xpGi12py8FYsC3+icBQDMAHXqbyfqF7hqsFU0aeBdSUAJKqT9KMymyJNR45
	nYZc3p6C8gbCvApjUgzKtCHiBDadyVGtg+w5Rmu/utTlym9bo59BMlPbdoOPoBfn
	+GtODKf8Rv0W2Y5ZmdkDov86aRwKi3J7y5oeZLFNWVhDS/0banOGbUgz4J5jp0Nh
	tex9KMV4t0kFsngj7gmSwVV70fJTDwUMIn0neOG4jQLZ7bPQ9inpOhPK0B1qOHHI
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7sax3x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340fRNi017354;
	Fri, 4 Apr 2025 02:19:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:16 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gi030074;
	Fri, 4 Apr 2025 02:19:15 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-5;
	Fri, 04 Apr 2025 02:19:15 +0000
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
Subject: [PATCH v2 04/20] mm/mshare: allocate an mm_struct for msharefs files
Date: Thu,  3 Apr 2025 19:18:46 -0700
Message-ID: <20250404021902.48863-5-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: XffFeJm3vpyUA90a03acjGYQrghcbXqg
X-Proofpoint-ORIG-GUID: XffFeJm3vpyUA90a03acjGYQrghcbXqg

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
index 5d9e25da0244..551d12cb9fdb 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -19,6 +19,10 @@
 
 const unsigned long mshare_align = P4D_SIZE;
 
+struct mshare_data {
+	struct mm_struct *mm;
+};
+
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
@@ -26,11 +30,51 @@ static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
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
@@ -43,6 +87,11 @@ static struct inode
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


