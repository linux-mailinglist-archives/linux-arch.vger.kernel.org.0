Return-Path: <linux-arch+bounces-9895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435FA1BF62
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFCB3B0674
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658821F9F7F;
	Fri, 24 Jan 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QXXOQ6N2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9F1F12FA;
	Fri, 24 Jan 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762985; cv=none; b=A0Y9lhPNyNlTs/l4exYWBdDqNkFOmCbkx7ShyK4yQghjPLJeSi3XwnpInxWprzgDyVqFPGdHh41iJtK0k8X32E6+/n6y4asjaaGRHPWZ4pNRUXMg5RBToMZjGlR94WfGVbbcGh7l0P1kLedwsjfJjos3WgvwBVquMtL/P7nIMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762985; c=relaxed/simple;
	bh=TsZz4DGP6w00s3ZTot4Nn5rn1+kOmHLDotmoFkt2kso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB9fF7thywDp4hOzf3Ekia4lo8wolZQayAFJkujoWMn3/1l1e50ye9FNWPO2u1Tdb8zDZbQXiDrYHsroKEjAR5Q9tcx/IKCqsg3HSpWOr8bP0XV+1yenKfo87nqhraw1OFN/lLMh1fBERnq5ZzaQURzPILQnA2bzcQpxDirpqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QXXOQ6N2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIioeL018166;
	Fri, 24 Jan 2025 23:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=W2H0c
	tTufvhNvnXZJs2k6LGmiWdy4rqMSHVr4raXjx0=; b=QXXOQ6N23uk7G9VbZbPAF
	f/QqSAc5iOsT9xCDTdmT6oyWhAgniQUG3Z7HmFAfZ0bDBwKBIvV+YT7Vjcn2YUsw
	4BXCgx2yNsC2NOEOkIHJOoc4cywTGNGprHkX2qJmp3Xx+WG/52Czo16Ed3Ov5QhM
	7/Iq8gqTqAgrLzC/67EBmTQU8e0ckWYvZEkC9eoZSGIttbuEitMyfH3mwJVOB5cq
	nCTIcpd5kRDYGcIOT0w0nMvOGTNdnhFcaiRQEsEqsDLWzbY7hJ3r5tDcUZkZM2sm
	w/OjPwtIAYWhM4xN3xfWaR0SlPwYAKwlvDlxi/32YuE+r3YbcTLRLr2NJor30AJL
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96am96t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50ONC16b036516;
	Fri, 24 Jan 2025 23:55:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4akt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQC018051;
	Fri, 24 Jan 2025 23:55:55 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-16;
	Fri, 24 Jan 2025 23:55:55 +0000
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
Subject: [PATCH 15/20] mm: pass the mm in vma_munmap_struct
Date: Fri, 24 Jan 2025 15:54:49 -0800
Message-ID: <20250124235454.84587-16-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: 3Bsi0dEb_NSrsadh2i7dfRhctL6iq62g
X-Proofpoint-ORIG-GUID: 3Bsi0dEb_NSrsadh2i7dfRhctL6iq62g

Allow unmap to work with an mshare host mm.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/vma.c | 10 ++++++----
 mm/vma.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 28942701e301..60a37a9eb15e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1174,7 +1174,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
-	mm = current->mm;
+	mm = vms->mm;
 	mm->map_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
@@ -1382,13 +1382,15 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
  * @start: The aligned start address to munmap
  * @end: The aligned end address to munmap
  * @uf: The userfaultfd list_head
+ * @mm: The mm struct
  * @unlock: Unlock after the operation.  Only unlocked on success
  */
 static void init_vma_munmap(struct vma_munmap_struct *vms,
 		struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
+		struct mm_struct *mm, bool unlock)
 {
+	vms->mm = mm;
 	vms->vmi = vmi;
 	vms->vma = vma;
 	if (vma) {
@@ -1432,7 +1434,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vma_munmap_struct vms;
 	int error;
 
-	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, mm, unlock);
 	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
@@ -2229,7 +2231,7 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 
 	/* Find the first overlapping VMA and initialise unmap state. */
 	vms->vma = vma_find(vmi, map->end);
-	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
+	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf, map->mm,
 			/* unlock = */ false);
 
 	/* OK, we have overlapping VMAs - prepare to unmap them. */
diff --git a/mm/vma.h b/mm/vma.h
index e704f56577f3..03d69321312d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -49,6 +49,7 @@ struct vma_munmap_struct {
 	unsigned long exec_vm;
 	unsigned long stack_vm;
 	unsigned long data_vm;
+	struct mm_struct *mm;
 };
 
 enum vma_merge_state {
-- 
2.43.5


