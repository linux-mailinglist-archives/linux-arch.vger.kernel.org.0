Return-Path: <linux-arch+bounces-9887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE562A1BF35
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB68189012B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1771F666B;
	Fri, 24 Jan 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLHVaWZH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C41F152E;
	Fri, 24 Jan 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762970; cv=none; b=A+SMiKiMIzkGnXyZNZOT8RqRFGSDVqFJORTPeJDwoDUtyjuVrqv/ZmGHASUWMHjZ8Uj2MeVk5o5S8ey/wQkSmiIrM8KhswHH4R0wyclGxs+1qTPx90bSzQKi17FrnqUIG+cboK+SvBfp2WErScdCS7qlSMNM+5l7Fre/gwYiG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762970; c=relaxed/simple;
	bh=vJC5l/Xtc8mUerZxSYMEwyUFjgnyCqGHI/uVzckoJfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVhwr+C/d21mPOy+bGbUY0VuEh9DOsjMbwZxeb0M4MgrsJpno1H/Dv9ckYqYjcySjcWSX268O+VmyrIPOIMBHh/6IpSlevjESegbhNJr0EgQyrLx0oiIK+FmKDLZg71OmoASMHJDdWweA8WMLeRBYH1WRLjP4Scutknm0Yfqo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HLHVaWZH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OI9Khf021995;
	Fri, 24 Jan 2025 23:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=In3/Q
	U715xLhM8W3K3qF4Q+QnYxI0SeFwCtvEoqrM48=; b=HLHVaWZH0xw0fUWfpJLKK
	Yj4Z6fAZf9KRr4nhNheCUsucOkOPRtT9rUPzrmzkRBCKuu1sVUtXUNSLOfpV8vnO
	mzsnDq8PVtK0+cPlMv21opwInIiL9RXaIcA8qUMCwfBtDkTa+Cw2l6Hgjb4lxtL1
	8wHiwShDXIcH5fbohFiO6wkw3j7XMRY3aV3hfxkKGc80voJOUS8yjDJwnl2tCx7o
	8XHCVk4ukhdWd+KUJuxLfcCnVRXk6LKglh3ldQ9aFYOEdZD7NYB639sjv6SFJPNt
	p1Xgj7uGT9HaVf/GhAYRM9w1lsOsYc35T/QPV1hWYjMmqw/v5CETdhBxzWFAVgZV
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx5vpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMl7J0036434;
	Fri, 24 Jan 2025 23:55:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4a4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPk018051;
	Fri, 24 Jan 2025 23:55:09 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-3;
	Fri, 24 Jan 2025 23:55:08 +0000
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
Subject: [PATCH 02/20] mm/mshare: pre-populate msharefs with information file
Date: Fri, 24 Jan 2025 15:54:36 -0800
Message-ID: <20250124235454.84587-3-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: HTWbFrhMb8YrF3VvR_cxKBeK5wrE_S0U
X-Proofpoint-GUID: HTWbFrhMb8YrF3VvR_cxKBeK5wrE_S0U

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
index 49d32e0c20d2..6d3760d1af8e 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,18 +17,74 @@
 #include <linux/fs_context.h>
 #include <uapi/linux/magic.h>
 
+const unsigned long mshare_align = P4D_SIZE;
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
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
@@ -36,6 +92,12 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -51,7 +113,9 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	return 0;
+	ret = msharefs_create_mshare_info(sb);
+
+	return ret;
 }
 
 static int
@@ -71,10 +135,19 @@ mshare_init_fs_context(struct fs_context *fc)
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


