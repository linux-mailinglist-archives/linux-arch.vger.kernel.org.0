Return-Path: <linux-arch+bounces-11260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5613FA7B5C0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B913B8CCA
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D51624C9;
	Fri,  4 Apr 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NOZ3PWdA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11313B7B3;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733198; cv=none; b=LFz8JkIWFikg8JFcOKXi5LG2VikqgXq52vzBUC3v7bHs7LovDcz4p+HzsNS0dVYng6WYZ3tW2EAEVE14CHBrh4oNWcSIoyZweCAcHlfhevf81/MjEo4cNvU3IWulvh9HDMBiOgi0YXimQgFO1eHqPBUXOfdTCPsXp0+e0/HqW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733198; c=relaxed/simple;
	bh=quf9sIli/qbvYS3GzsCRvZf1MUj5XfcEkxwuAfgF1Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By+THeoF2fanc7hudDOtdOeI4w1bJjktSIc1sMs2b+/untf1scuG0+0zmZq4D/Hfwru2bozGiy27W2mRvFV+YEq6juLt7t+GXD9NMeU2Dj/GQoy9rYYGgLawWCyQCHANMCQ4KEem6mpq/f/CFRnykLK3xVugZoZqGAoCcKzool4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NOZ3PWdA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O27B030347;
	Fri, 4 Apr 2025 02:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=u/Ka2
	4LgFH1mEp9+dOJpjfauIGm/1R9CiLlxElDfEpA=; b=NOZ3PWdAMVOTQS0+7aDuR
	skwtgjrkJZAUfqyztFxUQRUHMd8XrW5jez6ggYlpafDPnj5vl+3tvAdIkeitH8/F
	4fTizL12uMMCvYenkY3Aj/JpSFHtwJ6jmz1nJMRFlozv7NNy16r38P90LrM/nljX
	oCUF+mdsc0PQfkuUDhn7rNFtFwnhj5/YAKU30n/vVuFAQ932dqXyyrEI5OPL/s1T
	uJn+E2JG/YbS5G//Z30/xPl77vfDswZNL0WeohxrTgsPiBlm+cXEEBbWblivWGtw
	CQZtcF8wb7Ure94mM1gATTmdMCQMSa47x4XxKnu5rNx20OgD+8uyIcuLrSK2BCm5
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0p1nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340fY7x017359;
	Fri, 4 Apr 2025 02:19:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspj9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:14 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gg030074;
	Fri, 4 Apr 2025 02:19:13 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-4;
	Fri, 04 Apr 2025 02:19:13 +0000
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
Subject: [PATCH v2 03/20] mm/mshare: make msharefs writable and support directories
Date: Thu,  3 Apr 2025 19:18:45 -0700
Message-ID: <20250404021902.48863-4-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: uxvsTgFDon66oivjCAXUe9tYMbY1XvCl
X-Proofpoint-GUID: uxvsTgFDon66oivjCAXUe9tYMbY1XvCl

From: Khalid Aziz <khalid@kernel.org>

Make msharefs filesystem writable and allow creating directories
to support better access control to mshare'd regions defined in
msharefs.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index d666471bc94b..5d9e25da0244 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -19,14 +19,128 @@
 
 const unsigned long mshare_align = P4D_SIZE;
 
+static const struct inode_operations msharefs_dir_inode_ops;
+static const struct inode_operations msharefs_file_inode_ops;
+
 static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
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
+static struct dentry *
+msharefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode)
+{
+	int ret = msharefs_mknod(idmap, dir, dentry, mode | S_IFDIR);
+
+	if (!ret)
+		inc_nlink(dir);
+	return ERR_PTR(ret);
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
@@ -106,7 +220,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0777;
 	simple_inode_init_ts(inode);
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &msharefs_dir_inode_ops;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
 
-- 
2.43.5


