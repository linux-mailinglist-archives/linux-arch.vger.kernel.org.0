Return-Path: <linux-arch+bounces-6981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C907D96ACCE
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4806E1F245F9
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5A1D5CEB;
	Tue,  3 Sep 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWnQoH6O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553062AEFD;
	Tue,  3 Sep 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405837; cv=none; b=fGmM1eDblso6QRQuzavgeACFduyXA16svZM9lnRjBNHD3rJ2pkqLhixk1UylgVzr2h8SxbDe4X4A8YCNmVpgWzudYENovzfp/3t9DRSv7JfUIgck+j5Bnz61B+/9J76WV/lzgcoDfIjkmMtqlavgX281dx14cMwSFZgP2zzOkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405837; c=relaxed/simple;
	bh=l1aua5QjxYnfaM+Sg2x+rSMYWSN9XrTl9DaL1t8sp2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYVCxxgCe0oa/hEdAAHA7iRXG+KfJ+/S8uba69P8+cMj45D4M7NrV9uPgP//iPETQdw1orHRiNHtgUrgIgMYXiEORgieKPFkmWzz7mIN/qbSBsz2KQlxMIoeei6IAAfwy98WbuZNqIB89tE7ji9a9MZu47nylfWKvUOQDoptsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWnQoH6O; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBX5G019218;
	Tue, 3 Sep 2024 23:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=6
	B0tKbUVx2G5pw+r7fZGx9eSPo2EK+YI2lXoEXcda9U=; b=JWnQoH6OkoRsK/s6Y
	pYOu63ObV4XAiFYZHrkfMbGHjP4QhBQGg+TwphKXfWvY2Z8qDsMyd9a1Jprv7IMu
	8QdGSPdH6BPbLRBQNRorn7egiix4VMt88WdNf5uTfdDWdJ+T0orhKeqIPV/Ef8vk
	rcl9DsghKzUObYBJFv6YMrba7G1L6Vz67A1sPXps7pQ0F4WOZuPk53C4RWkyQi9S
	iPLGth4Q49ly5FIicWwRDuldjaT9lkRygrHyUOBa9HybefSgesYdwsVrDWN7GC6F
	VcaJ8Mhtr9wkZZl6NIWrp3cKvjLHANz5oEbA9ClYXCKd+Sj3lYTcAGdTITuF+F5u
	8d5oQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dw51t434-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483NAKBu001869;
	Tue, 3 Sep 2024 23:23:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmnad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfC040456;
	Tue, 3 Sep 2024 23:23:23 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-4;
	Tue, 03 Sep 2024 23:23:23 +0000
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
Subject: [RFC PATCH v3 03/10] mm/mshare: make msharefs writable and support directories
Date: Tue,  3 Sep 2024 16:22:34 -0700
Message-ID: <20240903232241.43995-4-anthony.yznaga@oracle.com>
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
 mlxlogscore=670 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-ORIG-GUID: dkXLeEH9FYZojdDG1RlpfQIloPnwy2Wb
X-Proofpoint-GUID: dkXLeEH9FYZojdDG1RlpfQIloPnwy2Wb

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
index 6562000545e1..f718b8934cdf 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -21,11 +21,126 @@ struct msharefs_info {
 	struct dentry *info_dentry;
 };
 
+static const struct inode_operations msharefs_dir_inode_ops;
+static const struct inode_operations msharefs_file_inode_ops;
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
 	.llseek		= no_llseek,
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
@@ -104,7 +219,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0777;
 	simple_inode_init_ts(inode);
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &msharefs_dir_inode_ops;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
 
-- 
2.43.5


