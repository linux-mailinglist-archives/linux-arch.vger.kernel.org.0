Return-Path: <linux-arch+bounces-6980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E346396ACCB
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF4286B40
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D731D6C78;
	Tue,  3 Sep 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5D6NE1h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF81D5CE9;
	Tue,  3 Sep 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405830; cv=none; b=jBC8DX9ImlX95RlXCqnTieA4umEegMtzm1KRxozEDEsNNFIvCAqVSU6OHOb0MRPFW99o8uGdKw6hVOD6JXI48neAt/x40QCSA6Bq7CWY7R1nuVsR8Jl96nXKBp5XZe4ZRdZtBjn3KIcLcCocfoON+Y9a4V9GsrKTGsb6XtULDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405830; c=relaxed/simple;
	bh=zZ8ra3a+iWJC2DmmAJvAB/P2LEosZRUzT+K4W/6L0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIBxr65q/yCAzipJN7Byo1LDBomyOjXvCxwbQJi5OKJf2jmnET5eUl21jCzNHnnuFetaH0L/fNxSztKmp2ecUSqSukYp/qE+LkHUtRxWh4A5lc2i66JC+DuWosig8rne832mbQWUs4sJNh8FNr5KJ4CckEaCIsT3EAdOtePXEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5D6NE1h; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBdVa002918;
	Tue, 3 Sep 2024 23:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=+
	NwCsMY5ut7geDTvEdbHpELHUG2vwXaB0hfwIYvPX5k=; b=O5D6NE1hAI1ca/5Ka
	oNy0zYRbgBGl2kvJhbEFSE2t+s+VAqS5Itxo/2SwVNf8M9ByxtnzA+NG7rJnm7hu
	dKHsrAsHwjW5c2ZzAcCr44IVNtX6avwvIpqrGhuhAjkxpoE5yljmk5LKlsUApeAX
	wC5xQOYUl/diPl48xpZELiIr1vlTBrX86VEVJUCzmbh93L8PMabujNaI6SjRUzHe
	ga2a6MNm0f21zOLZ/IQvffXdguxhARqZAr2N0T8rkqMypo3qQgYzEPHVjYo4eS8I
	Ae+/0tBxEmbRXW7mc8M2Ycu3SODKyrTFuyTlmxcTUp/GgnTkzwG//pRma2IqyHFf
	Hbsxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvu7a3u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483L0q9W001754;
	Tue, 3 Sep 2024 23:23:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmn96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfA040456;
	Tue, 3 Sep 2024 23:23:19 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-3;
	Tue, 03 Sep 2024 23:23:19 +0000
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
Subject: [RFC PATCH v3 02/10] mm/mshare: pre-populate msharefs with information file
Date: Tue,  3 Sep 2024 16:22:33 -0700
Message-ID: <20240903232241.43995-3-anthony.yznaga@oracle.com>
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
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-ORIG-GUID: GfvRugAIhgIXGKZZXnPMCuCQwggq_Rr6
X-Proofpoint-GUID: GfvRugAIhgIXGKZZXnPMCuCQwggq_Rr6

From: Khalid Aziz <khalid@kernel.org>

Users of mshare feature to share page tables need to know the size
and alignment requirement for shared regions. Pre-populate msharefs
with a file, mshare_info, that provides this information.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index d5d8e2530e5a..6562000545e1 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,19 +17,73 @@
 #include <linux/fs_context.h>
 #include <uapi/linux/magic.h>
 
+struct msharefs_info {
+	struct dentry *info_dentry;
+};
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
 	.llseek		= no_llseek,
 };
 
+static ssize_t
+mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
+		loff_t *ppos)
+{
+	char s[80];
+
+	sprintf(s, "%ld\n", PGDIR_SIZE);
+	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
+}
+
+static const struct file_operations mshare_info_ops = {
+	.read	= mshare_info_read,
+	.llseek	= noop_llseek,
+};
+
 static const struct super_operations mshare_s_ops = {
 	.statfs		= simple_statfs,
 };
 
+static int
+msharefs_create_mshare_info(struct super_block *sb)
+{
+	struct msharefs_info *info = sb->s_fs_info;
+	struct dentry *root = sb->s_root;
+	struct dentry *dentry;
+	struct inode *inode;
+	int ret;
+
+	ret = -ENOMEM;
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+
+	inode->i_ino = 2;
+	simple_inode_init_ts(inode);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, S_IFREG | 0444);
+	inode->i_fop = &mshare_info_ops;
+
+	dentry = d_alloc_name(root, "mshare_info");
+	if (!dentry)
+		goto out;
+
+	info->info_dentry = dentry;
+	d_add(dentry, inode);
+
+	return 0;
+out:
+	iput(inode);
+
+	return ret;
+}
+
 static int
 msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct msharefs_info *info;
 	struct inode *inode;
+	int ret;
 
 	sb->s_blocksize		= PAGE_SIZE;
 	sb->s_blocksize_bits	= PAGE_SHIFT;
@@ -37,6 +91,12 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op		= &mshare_s_ops;
 	sb->s_time_gran		= 1;
 
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	sb->s_fs_info = info;
+
 	inode = new_inode(sb);
 	if (!inode)
 		return -ENOMEM;
@@ -52,7 +112,9 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	return 0;
+	ret = msharefs_create_mshare_info(sb);
+
+	return ret;
 }
 
 static int
@@ -72,10 +134,19 @@ mshare_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void
+msharefs_kill_super(struct super_block *sb)
+{
+	struct msharefs_info *info = sb->s_fs_info;
+
+	kfree(info);
+	kill_litter_super(sb);
+}
+
 static struct file_system_type mshare_fs = {
 	.name			= "msharefs",
 	.init_fs_context	= mshare_init_fs_context,
-	.kill_sb		= kill_litter_super,
+	.kill_sb		= msharefs_kill_super,
 };
 
 static int __init
-- 
2.43.5


