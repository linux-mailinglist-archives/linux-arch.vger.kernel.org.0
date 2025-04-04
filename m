Return-Path: <linux-arch+bounces-11258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81884A7B5BB
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0463B84A8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA114830A;
	Fri,  4 Apr 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5gkmJ/1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488554764;
	Fri,  4 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733197; cv=none; b=YTm/0hrE8aN6tLcpaSQiVWNZKO+9zVdeu0+3u/VLQJuXIs65m2U2zahuMQtuH8aha1hSsUNIymqJ03FQ9ureODN6V1Zi0v/WzBuaQ9TXoGdk+rJrY9y5iGWvzWk2j3ZXSlxnLOYuoZBZ675ij4BUyFoaAnOrQqT5yO0vZZkIzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733197; c=relaxed/simple;
	bh=OBcceEBTlBKe9PDBLAhQDbvOYL6sagehrK5ALucxSfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSkZowGD+n+sNLn3ReT3GeWHTHRhNFjxmByTQ4YDEtH/4Zb+YP3yVLRMqhU9REXi4/oBRJxZc+ebyDhkO8n5OP3wyF1nSgyhU7HQtKoN2TPJKVrQCyNMlaXgbdjAM8SxziL/bFfNTP+cnggQirNqfuu8evapJm21ho3mphIhFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I5gkmJ/1; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N50Q018277;
	Fri, 4 Apr 2025 02:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ycdDJ
	TgDlYIEQjukDNkKC68His+LWjtA3oN+O4pSL40=; b=I5gkmJ/1vSaakrJl85e7J
	aXiS6+GmZw0MrmqmdkJzCCOfcsydJu9q/8uk9+deDz3OCI1OwWfBZ8LXkWspArw+
	b+uxgndtCdcyt9D+Ue8dgwCnrHBl0fTSKwGi8nt97lCjcz8Ov+GIueB8ZKvGTz4X
	9xA/Wm7pQK6iXJEWy42H/ryZNuH/Nwbc2AaPqxt/aNFcON8vaAspnNmQqLLo/ew4
	erfq2uJnYJj/eKicpq0sTOcz/i2UeG9/nkk/kwKL3FdT/4S3c7hV6nDF6QD2AxrC
	ByApYYqoDOeJdOLsJfs6tYPj1dBALQv/xNwXi/zoThky56B5YYGApUi886XVycrd
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtp4mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340e3TA017325;
	Fri, 4 Apr 2025 02:19:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspj97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8ge030074;
	Fri, 4 Apr 2025 02:19:10 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-3;
	Fri, 04 Apr 2025 02:19:10 +0000
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
Subject: [PATCH v2 02/20] mm/mshare: pre-populate msharefs with information file
Date: Thu,  3 Apr 2025 19:18:44 -0700
Message-ID: <20250404021902.48863-3-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: 5EX2FvNmxhkCoLSUIS8A4xTErMV4vc5S
X-Proofpoint-GUID: 5EX2FvNmxhkCoLSUIS8A4xTErMV4vc5S

From: Khalid Aziz <khalid@kernel.org>

Users of mshare need to know the size and alignment requirement
for shared regions. Pre-populate msharefs with a file, mshare_info,
that provides this information. For now, pagetable sharing is
hardcoded to be at the PUD level.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index f703af49ec81..d666471bc94b 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,18 +17,74 @@
 #include <linux/fs_context.h>
 #include <uapi/linux/magic.h>
 
+const unsigned long mshare_align = P4D_SIZE;
+
 static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
 };
 
+struct msharefs_info {
+	struct dentry *info_dentry;
+};
+
+static ssize_t
+mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
+		loff_t *ppos)
+{
+	char s[80];
+
+	sprintf(s, "%ld\n", mshare_align);
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
@@ -37,6 +93,12 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -52,7 +114,9 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	return 0;
+	ret = msharefs_create_mshare_info(sb);
+
+	return ret;
 }
 
 static int
@@ -72,10 +136,19 @@ mshare_init_fs_context(struct fs_context *fc)
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


