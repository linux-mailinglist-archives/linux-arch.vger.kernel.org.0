Return-Path: <linux-arch+bounces-9898-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00284A1BF6E
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5763B09FD
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22701FA838;
	Fri, 24 Jan 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkhH1ABN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F541FA161;
	Fri, 24 Jan 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762987; cv=none; b=pieuTlw+my+Pd6ZXMLnYZZARxf9BsfHjrZh7yQ1KOpLdFaXl9hLEvZZJacSVIxr6RsHh0jCo+4zedNi/hIRoWcR97htX6vOwAEUVV8eJ4TiVLPEI1nm+3gN7O8AcHMZu41u8NvMBvQUGwiHWsCp8USnO8v0n50xP5dj90ggzpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762987; c=relaxed/simple;
	bh=3PW7iCBTwBLcxZKogfBgwoW3ehwvbpc/i/0LbqUN4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSb7JRT3XMhdYqyehw9/Lyz1SKZHs02gFrxIgEuDVO9OKJ0lOsgh3s0fAyQ2Tb9xJs8hE8hIpxc4k2fOAcI9iqDGt//9o3D/Rnj2w7I+BaTgyDBM/QPfRmjnQrTDuDqlmqYit81j3Hq6mYcmGG8z0YzfQ+q+HpV2YXWpg2ziPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkhH1ABN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIHwxb022439;
	Fri, 24 Jan 2025 23:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=rU9rP
	udGLwBZN+ul8ATDIQZHL+5JLK1AK68Xl6t+yJk=; b=dkhH1ABNUHDgkMbcNjOVe
	HLOlO3zpfZ6/zcXgH1MWSMApJp53Zwemc5AMBv8VgZ8H72pMejt0H3iho7yOmvzF
	H9xMiQUdAlws7OQLQt3lEzupvIdFAz9lcZVHNY52vnuTO1jN4+4NOIRkaG0aXtrA
	L01uc+qtH7o9rswF60olv2Vbr/OTaxT5KAyuoPLHYUCrd1ijEpIlZlcF0e0FXYcT
	iEBP96177UVbNmeouIy0f2vKY7Z3tP7ni1ruGvCXQ6tLrF4NkSSbvbYlOZXQNQuo
	FddCVtbP+byHiQ2Hg2u0Y9K411peP9nCUuiZ90jxeGRg+PLZXMcNjZr1ChereVuS
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qm4y4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMEElh036463;
	Fri, 24 Jan 2025 23:55:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4acw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPw018051;
	Fri, 24 Jan 2025 23:55:31 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-9;
	Fri, 24 Jan 2025 23:55:31 +0000
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
Subject: [PATCH 08/20] mm/mshare: flush all TLBs when updating PTEs in an mshare range
Date: Fri, 24 Jan 2025 15:54:42 -0800
Message-ID: <20250124235454.84587-9-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: G0_gkNzHGYYH-z86dDhJuuCCuwBORxu-
X-Proofpoint-ORIG-GUID: G0_gkNzHGYYH-z86dDhJuuCCuwBORxu-

Unlike the mm of a task, an mshare host mm is not updated on context
switch. In particular this means that mm_cpumask is never updated
which results in TLB flushes for updates to mshare PTEs only being
done on the local CPU. To ensure entries are flushed for non-local
TLBs, set up an mmu notifier on the mshare mm and use the
.arch_invalidate_secondary_tlbs callback to flush all TLBs.
arch_invalidate_secondary_tlbs guarantees that TLB entries will be
flushed before pages are freed when unmapping pages in an mshare region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index 529a90fe1602..8dca4199dd01 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -17,9 +17,11 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/mman.h>
+#include <linux/mmu_notifier.h>
 #include <linux/spinlock_types.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/msharefs.h>
+#include <asm/tlbflush.h>
 
 const unsigned long mshare_align = P4D_SIZE;
 
@@ -27,6 +29,17 @@ struct mshare_data {
 	struct mm_struct *mm;
 	spinlock_t m_lock;
 	struct mshare_info minfo;
+	struct mmu_notifier mn;
+};
+
+static void mshare_invalidate_tlbs(struct mmu_notifier *mn, struct mm_struct *mm,
+				   unsigned long start, unsigned long end)
+{
+	flush_tlb_all();
+}
+
+static const struct mmu_notifier_ops mshare_mmu_ops = {
+	.arch_invalidate_secondary_tlbs = mshare_invalidate_tlbs,
 };
 
 static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -191,6 +204,10 @@ msharefs_fill_mm(struct inode *inode)
 	m_data->mm = mm;
 	spin_lock_init(&m_data->m_lock);
 	inode->i_private = m_data;
+	m_data->mn.ops = &mshare_mmu_ops;
+	ret = mmu_notifier_register(&m_data->mn, mm);
+	if (ret)
+		goto err_free;
 
 	return 0;
 
-- 
2.43.5


