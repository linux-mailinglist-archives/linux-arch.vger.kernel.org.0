Return-Path: <linux-arch+bounces-6984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8996ACD4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01A91F255EF
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE961D7990;
	Tue,  3 Sep 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IhLIDQ9S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE41D88B8;
	Tue,  3 Sep 2024 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405845; cv=none; b=OC40/vwyusf5mFDoSoGbr1addJ0BF4TH/F3oomhHubmfD4c1IIzV8u8zdOLlKk7MmcZ5JOgkrUFmY6cnoPOcX1mLLpwT5tlA/x2QQbgPmqXbDNBR5ktKaQKb98iVBYXquWvHlD5FrY+tUsiYYMjSvMdLNHixxaFR7v9BWgRPsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405845; c=relaxed/simple;
	bh=4UqJFOqyqzKOmWPMGCi7PSn1cUEF6bO0CO32XgZSXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH/HhBcRt3tcBFyoHcI/tfsncycZalAMzM02As/NNTuHcGmSq5lzTTevO81bwl36PtzkSofsoR9lEvKum/EZZpLPxAy89fxYIb6Xjk26FWO7NI4lV94wkeTm6VwJl8CFoygxp2s3atGc7kwGWFlbkP5s14cOpMUQQFic8qwEOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IhLIDQ9S; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBaYt016174;
	Tue, 3 Sep 2024 23:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=B
	kNLLtEIT6PO4SxMovJKnjkv2fPS2KtWiGRrJ9D3V3g=; b=IhLIDQ9Sqp40vvnUI
	34TprUtmbQDB5n4DVDKooD0xIxnA9ArOd8ofsa0o76qCbt28HkwlJP0uB5UoAFC7
	0m8eVUkmeIcNKyr1gq7razbo9AzQRAf8cJab1G3VsDIu5Jxw+bzd4+Or4rORVC42
	2W+FRNK6aXQ5SIQjSHZbnh0AgApvLeuLnqfpwcybtrN24+ENl0PYyHL7oATWBZYp
	qwanrtCEgssoDDyQeWKpv0IeHachScW6caIdbFOknj9ypQUd+I58BAUp0x5f+iSY
	QsvxdrWujnIVHevkLnyPYhp05xrtAC7HTNxKN5eUhG6faUsjDsOxNv1+tt9mfSoB
	sUexw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsaa54m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483L5Jdg001689;
	Tue, 3 Sep 2024 23:23:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmngn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfK040456;
	Tue, 3 Sep 2024 23:23:37 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-8;
	Tue, 03 Sep 2024 23:23:37 +0000
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
Subject: [RFC PATCH v3 07/10] mm/mshare: Add mmap support
Date: Tue,  3 Sep 2024 16:22:38 -0700
Message-ID: <20240903232241.43995-8-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: OvJ_mqh9ucxXTl96GlPjzLJ-nynAvIDN
X-Proofpoint-GUID: OvJ_mqh9ucxXTl96GlPjzLJ-nynAvIDN

From: Khalid Aziz <khalid@kernel.org>

Add support for mapping an mshare region into a process after the
region has been established in msharefs. For now, disallow partial
unmaps of the region by disallowing splitting of an mshare VMA.
The functionality for mapping an object into an mshare region
will added in later patches.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index af46eb76d2bc..f3f6ed9c3761 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -33,6 +33,63 @@ struct msharefs_info {
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
+/*
+ * Disallow partial unmaps of an mshare region for now. Unmapping at
+ * boundaries aligned to the level page tables are shared at could
+ * be allowed in the future.
+ */ 
+static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct msharefs_vm_ops = {
+	.may_split = mshare_vm_op_split,
+};
+
+/*
+ * msharefs_mmap() - mmap an mshare region
+ */
+static int
+msharefs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct mshare_data *m_data = file->private_data;
+	unsigned long mshare_start, mshare_end;
+	int err = -EINVAL;
+
+	spin_lock(&m_data->m_lock);
+	mshare_start = m_data->minfo.start;
+	mshare_end = mshare_start + m_data->minfo.size;
+	spin_unlock(&m_data->m_lock);
+
+	/*
+	 * Make sure start and end of this mshare region has
+	 * been established already
+	 */
+	if (mshare_start == 0)
+		goto err_out;
+
+	/*
+	 * Verify alignment and size multiple
+	 */
+	if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
+		goto err_out;
+
+	/*
+	 * Verify this mapping does not extend outside of mshare region
+	 */
+	if (vma->vm_start < mshare_start || vma->vm_end > mshare_end)
+		goto err_out;
+
+	err = 0;
+	vma->vm_private_data = m_data;
+	vm_flags_set(vma, VM_SHARED_PT);
+	vma->vm_ops = &msharefs_vm_ops;
+
+err_out:
+	return err;
+}
+
 static long
 msharefs_set_size(struct mm_struct *mm, struct mshare_data *m_data,
 			struct mshare_info *minfo)
@@ -100,6 +157,7 @@ msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
+	.mmap		= msharefs_mmap,
 	.unlocked_ioctl	= msharefs_ioctl,
 	.llseek		= no_llseek,
 };
-- 
2.43.5


