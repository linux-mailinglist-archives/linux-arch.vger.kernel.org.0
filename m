Return-Path: <linux-arch+bounces-11266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA1A7B5CF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EA0171DCE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF519D07B;
	Fri,  4 Apr 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jjuzDj3q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282619ABD8;
	Fri,  4 Apr 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733211; cv=none; b=IwXvxQpMnrj+5Bz0fvGn3avwIY9zY2sog2R9hWA53a1hB0rUifbMQfyymICpnwYgSNpUgQwnumPh3ZL+veXX/vqrWcOOXd6h0jcY5X8Xdbl9xSNT4xKSdT6CdSo6oaI8Dep5cHe4AjU2ctq+RiVSQwJbITrMpZCtxUSeZDibqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733211; c=relaxed/simple;
	bh=PGwCrmXWpTivLnjbLGvLfrqkDZddXP82gsfvejD3RYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYwq7/fWfL16aZuzQ5w4EgLWyFLAfrJR2ElivwW7fgySdouKRGMjQZ+Bo/a40xU8n4LM2lb8YFwM5HtIsjHz2l2bUMqrgYuzdcmyIlviR9eGH2gSnXlnQkaYPQlRA4/2KHv4u5DrIVSbeNvbuLT2ql24QMqk6jPxSVsUnEE78p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jjuzDj3q; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341NVrf000752;
	Fri, 4 Apr 2025 02:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=K79b8
	8UIyoJS+J3UJtmo5bx4rIGf4HjUwc2YR+jqvkc=; b=jjuzDj3qp82UuFSa0katb
	Z4ToABUz7mu2SzMP6UijRLaJJfhB0/O+5g/tMRQLUrB2dNA3/8ZFs5xYMKuvLMNj
	HVRrOfgC1Zu94cIkXMTDAh4cl6SeV9PG9TUd8uMtVXj8tCIqT1oAi+HSwyJPQpla
	eIDKkD9z3w+8H4Lev0pUX3tOVHFenoWpeI/BWWHO+U4pqSVb4w7TALvUEK90DPC7
	PZRqkJo/RN/2fW+NI2Y2GQZd4d26GgP+fFVlYkD+881h6g8268dHG4oASKT8Ju5k
	pMFxyayFU7ZXg8oQWAc5Fhtn4w8nLWZ7YMjIlw3wv99A1g7xmQVZQfLVEg5ZrQKC
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcpnq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340g3PN017380;
	Fri, 4 Apr 2025 02:19:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8h6030074;
	Fri, 4 Apr 2025 02:19:43 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-16;
	Fri, 04 Apr 2025 02:19:42 +0000
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
Subject: [PATCH v2 15/20] mm: pass the mm in vma_munmap_struct
Date: Thu,  3 Apr 2025 19:18:57 -0700
Message-ID: <20250404021902.48863-16-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: FD5x5FdaburlWteo41CRHnMs6Jy6iOM4
X-Proofpoint-ORIG-GUID: FD5x5FdaburlWteo41CRHnMs6Jy6iOM4

Allow unmap to work with an mshare host mm.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/vma.c | 10 ++++++----
 mm/vma.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 9069b42edab6..c56f773c06c0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1188,7 +1188,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
-	mm = current->mm;
+	mm = vms->mm;
 	mm->map_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
@@ -1396,13 +1396,15 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
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
@@ -1446,7 +1448,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vma_munmap_struct vms;
 	int error;
 
-	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, mm, unlock);
 	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
@@ -2247,7 +2249,7 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 
 	/* Find the first overlapping VMA and initialise unmap state. */
 	vms->vma = vma_find(vmi, map->end);
-	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
+	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf, map->mm,
 			/* unlock = */ false);
 
 	/* OK, we have overlapping VMAs - prepare to unmap them. */
diff --git a/mm/vma.h b/mm/vma.h
index a6db191e65cf..572a11274114 100644
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


