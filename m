Return-Path: <linux-arch+bounces-9883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49439A1BF29
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCEA16D0C5
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812A1EEA29;
	Fri, 24 Jan 2025 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QY/j1Qke"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CE1EE009;
	Fri, 24 Jan 2025 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762967; cv=none; b=GaP/HU3RW/61ujcA+vv620VE17jYkVnQiybboY1u3Zb7y2UIWuUbzvdG29kqalKk+sk3XzsxpFw76ejgJ39yX3DBThXHNV8aIXCorIpS/DUcdWFLoYua8AGqjoacgus/HJQbMAN0xqKrswXD+YOrMlIYYikK7fU4f9K3dD8EO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762967; c=relaxed/simple;
	bh=7T0+gS5pbd7zyOp8YcgTaGqBemKbGNrkHRa0N6K/1kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNl4OXXb2/J+8mDFXtI2BZuQa7CMHnToMujPXc/UhvR+EIrblcv1Rocw8LRYpxgGxgKMBqwL+JtRqHmd3d1eIdq+RqQePk4OHdnLOA09inMjsM2erzbb+8p750FVEHqiiJO8KPJAZl6eZ3Z1SJh0Alli5wL+ibvrJ2l5jHVIcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QY/j1Qke; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIV8E3018170;
	Fri, 24 Jan 2025 23:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=NhoD2
	UyohCxfveoHgDD+cR1/Lz5zOg29Zxa7SdPOnus=; b=QY/j1QkegXiviWjeo98nh
	F0qYOSLXLhPu8lHvxPBkZWcdoJTdL2kQQ5KKhw+r7FvhKfeT89mU/GBPMUJZNV3J
	PLsm+Z+tUfUcTvEMYs/I9TZQg/kCUageWG+NC9Ow86/c7xqZ6XfG7HIwmrRcphEF
	+HN9Liqi6GKNxKo2ChglsrDyGdD6jGWhUk28dqmv7mwWG6OZYzVbfs0c30TFBalR
	OpDG5IKFMnf11Dpt5fmN2XHOxGC1WWE47hJZcGx69mrCkjQIGSQGxoJ1wXQjKiWq
	zw7sr5SS7cLQITieF9uBlt92uCVh0tlWN+AiCW9hSbdu9Fwbafc5QECw6zdjIMir
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96am96g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50ON3eWg036495;
	Fri, 24 Jan 2025 23:55:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4a7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPo018051;
	Fri, 24 Jan 2025 23:55:16 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-5;
	Fri, 24 Jan 2025 23:55:16 +0000
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
Subject: [PATCH 04/20] mm/mshare: allocate an mm_struct for msharefs files
Date: Fri, 24 Jan 2025 15:54:38 -0800
Message-ID: <20250124235454.84587-5-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=829 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-GUID: Zg9k0kA44bw59zVgGS2FFhExNRlmmq9n
X-Proofpoint-ORIG-GUID: Zg9k0kA44bw59zVgGS2FFhExNRlmmq9n

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
index b755346da827..060292fb6a00 100644
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
 	.open		= simple_open,
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
@@ -142,6 +191,16 @@ static const struct inode_operations msharefs_dir_inode_ops = {
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
@@ -159,6 +218,7 @@ static const struct file_operations mshare_info_ops = {
 
 static const struct super_operations mshare_s_ops = {
 	.statfs		= simple_statfs,
+	.evict_inode	= mshare_evict_inode,
 };
 
 static int
-- 
2.43.5


