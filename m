Return-Path: <linux-arch+bounces-13204-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B0B2D0EE
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C23BAA0B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1F1A9FAE;
	Wed, 20 Aug 2025 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ns4vnE04"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0E198A11;
	Wed, 20 Aug 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651951; cv=none; b=kTT768bgO62jF1l6f1P6zJCb37ChI+CFACPzpfX6ieMwOV7LI22zPsqgHWCpXBsfc8JSYy3TBg3IyvlJsRdvorc/W6jsRpdtoxbCvCnoUhlp80clDvxTKqctKaRU4aOveZjSJDfo/Q3ahP59heDOP4CSfMa198S63PnM6Jfoh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651951; c=relaxed/simple;
	bh=DQs2lOKramlJfbiRxzUvOaOWr9Qs+1TYMmKTXcyFxA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trZQPa8YQm6L7nLsLC9Zz41ET05Ftx8aIYFLu9pLWnT/zckRzOl6q/c1RlId1POI3PU259ipyMAAXVBHtE09pdIVnDaa7bDpMv8tqAJrUE5+Aanpb+PtFA4VfXxwAFF5SzbPBhi5glcneU/Jh/NU1D8OuNqc43MGrKtyYGGjGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ns4vnE04; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLC5u6012018;
	Wed, 20 Aug 2025 01:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1LKCO
	d90IuRKQUERNf3PP/AzsM6PPL8y1xaZdJTCpTY=; b=ns4vnE04MJGeAJTqH0K6w
	cv3s0i36oCkYZGMO2ysoAJqeZ8dlAnPEUUeqvGA/XZu3tEZirCjo/hJLl2CtYlsY
	WKG2EZKBDZ1IRNyqkzruIHctY9FZu0/UVtK0sfdAOZ0ZAwVgMcEGXjit2iLLx3ch
	TGznPTXd1h3GMUWKYoYXZIBrN6g4FysgnB5b6mgsqwRTrEyapOQE6esT+Fv6p04q
	gV3X/XA2r4o06kbm48fhpen9ByOVCmece6KJQVd/kttDOToWPX3tSlUart2el5HF
	NgjcPpxsmOgFnAQgqVjPYYFyk0eBhVezTaqLHtQbv/EhfxIM8eXbvXGwgXjgIpFd
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trr8dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57K02ibF007205;
	Wed, 20 Aug 2025 01:04:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Nd8011685;
	Wed, 20 Aug 2025 01:04:29 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-3;
	Wed, 20 Aug 2025 01:04:28 +0000
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
Subject: [PATCH v3 02/22] mm/mshare: pre-populate msharefs with information file
Date: Tue, 19 Aug 2025 18:03:55 -0700
Message-ID: <20250820010415.699353-3-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: kxNfsh9Q8YiSklUfYeZXOlaps9W-bKKp
X-Proofpoint-GUID: kxNfsh9Q8YiSklUfYeZXOlaps9W-bKKp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX6YMrtj8XpWKS
 LcqBDDeWdu/UOBa9TA9CuJrKyr7WHxicnwTZFC8DVa6AshqREBW6ABAMPiVzHKDz2uyJt3w3jTx
 QSxgWMT0p3xYqUpgtUjHd3F+dulSIXl14yY9immgOvZCF6BRyhOvwGaka0Lqb7L3+plejJ9NYsE
 6wVVY2xNLVfNWK6mMAgdKthgQr2y0O1GeAt8G81/czDVkqjdaEZv8F2/GOY5Z4BDiuanejVpVjn
 /qKPlN3qlLcUkvGbEGYZ/PwsWp668uD31YHbHpangz2ixwG/7kd3FtXH0zUMru4NXRhKNbuGeHT
 C1DKqsN0bAezloJGtQQf+/OAAEWeis0MCNb5PNMmLSEzZsWIqLRbu6hcKIfHlOjYVFytdls8gAq
 kKF+yHAgkGBhBxMnBiSBud6FnMQk4w==
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a51f1f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Nn8paf86YN4m1DmQybIA:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

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
2.47.1


