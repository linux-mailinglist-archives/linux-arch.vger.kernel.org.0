Return-Path: <linux-arch+bounces-13203-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F0B2D0ED
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64CC7B2623
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60EE1A9F83;
	Wed, 20 Aug 2025 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWQsvBL0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72E194A45;
	Wed, 20 Aug 2025 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651951; cv=none; b=UHzTfpqdmkv8nMcSiKwy9vnxBJHbIcsPHyqPDj2JECkHGQtLtbEaQvL+1THCb6SUMX2WAfQjX7rrzBbQaARPjid6Haq3hfJ6sdr6resxTN9E6MXFO+f7mNVNXvhF9/gKJrBX+ovEOBmz7wmlyYe75jTnWiJBWAHWuDOEj1Upr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651951; c=relaxed/simple;
	bh=lAig7eb/hob+2A4NLAvkyBsI1qHNRKx8MbiGSivCp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUJF7BJTtCHltcGbmoqgh2xgfVjQ3lLKMq96xiuMIsdxG6lIIPg+xv+JVyjKnES7Rw47+8FQARw9jYlQp80hmxu2CZpBw82W2IX4Pv4/JrOhx9kdwi/mngOgFaw3g9BtRhlhggOrbJzH3Pxnz33r9zt2W03fY9eQgpKMvVwv9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWQsvBL0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLCUxL017628;
	Wed, 20 Aug 2025 01:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=vzGmx
	D04TI1mSj9V+t8aruaidXWI36zruInJlfX4dNY=; b=eWQsvBL0w0HGsmRYPf6QJ
	nKgKCB0Ak6IKgVB31Cwbq4ZFRGACcRwkED1X9KA/yjb8SIGcNRrk5Dzeb4hf2GbE
	SJF78ULl3t8V1t4EdUl4TsrZ3viw4H3AjsYtAkWPv6QcEjwFs6JurtluZbJnqgZG
	w7NeF3RniN/YQ4PI4XWF6FtIv/2XVU1pvkAyxso3d15RgS4wYHQsM7bZN/N4Ert+
	nh8Zw2rAdvM0v7eLENDcFtuw+EmcCr/SYIiUaSFtKbiNz+gzrje+YuVvlTKPpk79
	9D8Tc0gN9RCjcSKvZaFiNv+HatM6FUqK8SoX0Fa9uA8gXFVIibcD71jtER1ETWmg
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ttg8bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNsqtx007279;
	Wed, 20 Aug 2025 01:04:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdA011685;
	Wed, 20 Aug 2025 01:04:32 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-4;
	Wed, 20 Aug 2025 01:04:31 +0000
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
Subject: [PATCH v3 03/22] mm/mshare: make msharefs writable and support directories
Date: Tue, 19 Aug 2025 18:03:56 -0700
Message-ID: <20250820010415.699353-4-anthony.yznaga@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX6nrVr8GQuiM2
 KpjmSaQeCD+L4Xo8HZem/Sq+wiCbpltxbCytOR+N8x61m38VYPq6poGPjOnGit/hsZYn8ivdRgF
 bY5K+BX2GWQk6V1LjuiSqrdzBsKYtKOb44Uf/vAL/OjS4aY5Ilq4yLEEacafLde7CuWUTVvqH2P
 1furpmQ6sPJr71xRnjQ8XqEY8N8V18arQD7y6SGMZlQBkspOKSx1nTanvVEWmXMfxt9ZddnzjW+
 KMKf8+WjGcVZnYnNDFAys09xbO0fKtzCWwU151mf1HZDyB90k3kE0aaCrgqKvFTlqpbJAa9LzKI
 exHqAx/dG6oABfEE2CBw+NrYTwuadPkrDFv2YqrZawWDcEsiHyp79EuoAsCQb33VofrnXTWMjYc
 EGpUw5V/ABbuV5d98GU7IUMv7B8dOQ==
X-Proofpoint-GUID: wwEvDZgrz76BuuzQ800K3COTnMBSVo6E
X-Proofpoint-ORIG-GUID: wwEvDZgrz76BuuzQ800K3COTnMBSVo6E
X-Authority-Analysis: v=2.4 cv=V94kEeni c=1 sm=1 tr=0 ts=68a51f22 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-pbL9rYvnyYrJvq5bQ8A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

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
index d666471bc94b..c43b53a7323a 100644
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
+		iput(inode);
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
2.47.1


