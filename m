Return-Path: <linux-arch+bounces-9892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E34A1BF4D
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9497A1189
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FC1F9AA1;
	Fri, 24 Jan 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afhvDSIm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F1EEA2C;
	Fri, 24 Jan 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762974; cv=none; b=gXPCSketluHsf20hhBGq29Mjy431hKgrG7V/aYTQ5rJnyiMzFIuwX0bs6+faaK/vRRbFs1wvc/iFzTtIh0X4Mocxm6C6pAOX+hG/ToctAMUt2lJqK3j1DeTptQ4WJQF5KtWN8pEhp3Q1uRVIpYkrtcvXMJfN+q6+a6K7JafFQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762974; c=relaxed/simple;
	bh=ac6bMDUbpSNsLS1pkOOBz2xI7DS0JNfwYfCLr8acXrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEQ08VqpBh9e3aXYsfSY0CNrrj8pbnOjmbBQUVzScpXpZBGp8oAzU/vid9PUinXHTU6zhEHSHtxRLm+x+SkoH9DGc2KS6A9r82pJTTw+DjOLzNtEsJPNPM5WH7YP5Gj9vkVpMg2l+zMYN6wmKmCx8DsuTJzMAh4LM7Np0MBLjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afhvDSIm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIRdZF000609;
	Fri, 24 Jan 2025 23:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=nqagY
	yeBhaL2RlbKKTLc6lxU3rvGauZsyUuzovUQ98I=; b=afhvDSImLqAMVCsYQmNcG
	ariAxBqtOlnnMHGzw4+P9TuWi+BLYUBCKMY/F/pj5x5FO7305VUzzvylCnuwmP4B
	hhYHZynes5p/hwSoIKvX5ccNh78E9B6di+gQeN+eIe16U3Df3EiBZIxNruSiHRU1
	SJ50wwpE0RCkh3J6hYADyKFwjnQbcBOZwctnm2XyerXnxLsMg1bRN4OGjrNW+imS
	2mYM2mcM+4MR+bLIYKhWG2LvVwU9fbAiSjcoxgT8/1PTvpcKSwoyu2z+mjgfJzs6
	mVUJ4aXylk0CMjxwTAbeXUPl4y5yw2BzkPNJ2p8eCfMQMM1C7R1iqiPhQIjQHyEG
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b06j5j3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLP7ek036648;
	Fri, 24 Jan 2025 23:55:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4a6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPm018051;
	Fri, 24 Jan 2025 23:55:13 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-4;
	Fri, 24 Jan 2025 23:55:12 +0000
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
Subject: [PATCH 03/20] mm/mshare: make msharefs writable and support directories
Date: Fri, 24 Jan 2025 15:54:37 -0800
Message-ID: <20250124235454.84587-4-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=781 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: q87c7Eu1K_1GSRczZ328BcrLzGhppaPX
X-Proofpoint-GUID: q87c7Eu1K_1GSRczZ328BcrLzGhppaPX

From: Khalid Aziz <khalid@kernel.org>

Make msharefs filesystem writable and allow creating directories
to support better access control to mshare'd regions defined in
msharefs.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 6d3760d1af8e..b755346da827 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -19,14 +19,129 @@
 
 const unsigned long mshare_align = P4D_SIZE;
 
+static const struct inode_operations msharefs_dir_inode_ops;
+static const struct inode_operations msharefs_file_inode_ops;
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
 };
 
+static struct inode
+*msharefs_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
+			const struct inode *dir, umode_t mode)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode->i_ino = get_next_ino();
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+	simple_inode_init_ts(inode);
+
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &msharefs_file_inode_ops;
+		inode->i_fop = &msharefs_file_operations;
+		break;
+	case S_IFDIR:
+		inode->i_op = &msharefs_dir_inode_ops;
+		inode->i_fop = &simple_dir_operations;
+		inc_nlink(inode);
+		break;
+	default:
+		discard_new_inode(inode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return inode;
+}
+
+static int
+msharefs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+
+	inode = msharefs_get_inode(idmap, dir->i_sb, dir, mode);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+
+	return 0;
+}
+
+static int
+msharefs_create(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode, bool excl)
+{
+	return msharefs_mknod(idmap, dir, dentry, mode | S_IFREG);
+}
+
+static int
+msharefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode)
+{
+	int ret = msharefs_mknod(idmap, dir, dentry, mode | S_IFDIR);
+
+	if (!ret)
+		inc_nlink(dir);
+	return ret;
+}
+
 struct msharefs_info {
 	struct dentry *info_dentry;
 };
 
+static inline bool
+is_msharefs_info_file(const struct dentry *dentry)
+{
+	struct msharefs_info *info = dentry->d_sb->s_fs_info;
+
+	return info->info_dentry == dentry;
+}
+
+static int
+msharefs_rename(struct mnt_idmap *idmap,
+		struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry,
+		unsigned int flags)
+{
+	if (is_msharefs_info_file(old_dentry) ||
+	    is_msharefs_info_file(new_dentry))
+		return -EPERM;
+
+	return simple_rename(idmap, old_dir, old_dentry, new_dir,
+			     new_dentry, flags);
+}
+
+static int
+msharefs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	if (is_msharefs_info_file(dentry))
+		return -EPERM;
+
+	return simple_unlink(dir, dentry);
+}
+
+static const struct inode_operations msharefs_file_inode_ops = {
+	.setattr	= simple_setattr,
+	.getattr	= simple_getattr,
+};
+
+static const struct inode_operations msharefs_dir_inode_ops = {
+	.create		= msharefs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= msharefs_unlink,
+	.mkdir		= msharefs_mkdir,
+	.rmdir		= simple_rmdir,
+	.rename		= msharefs_rename,
+};
+
 static ssize_t
 mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
 		loff_t *ppos)
@@ -105,7 +220,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0777;
 	simple_inode_init_ts(inode);
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &msharefs_dir_inode_ops;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
 
-- 
2.43.5


