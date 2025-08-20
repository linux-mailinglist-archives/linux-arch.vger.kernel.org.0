Return-Path: <linux-arch+bounces-13216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E11B2D112
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87157A03203
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D9D21D5B3;
	Wed, 20 Aug 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJNxdG7n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393E21772A;
	Wed, 20 Aug 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651963; cv=none; b=NP4LdlCBxUB2cARrnfiMPgUzZ29XBd/YevXzEbakGwo5/YWj4wKK497GuD4DgWuQy5hbtsYHuHPkKfhHnFCdEG8wzwXybWAii1xoHD8sGDpR0Hv7wTas2Iy4ckdeKAlcdiHNHtAvMbsUzxSL6+fN4sI6XA5JnnSkhzjBpyhVbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651963; c=relaxed/simple;
	bh=a3k1tweFTP+K8uO5a5NJ/5ox2KH5eglPmhPGC9jZ0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK1RqDCwGNY4BYs//3OdRpGlIk08xHk+QhFPlcO/d86XqquHQAAwLdtUzzADOZf7CEB1Yb+p5roJcpihdLBUCYK67owslp+oaoee1y+tXi5TqObesPq4CmhOvBqYTC6AEU/hV5mGv4avRRhdVl15IL9IEjw01//NA8KFA+KbmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TJNxdG7n; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBvvG004970;
	Wed, 20 Aug 2025 01:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=r5c6g
	UgwZz1vea1f0Y4r0+NHJZn6xlXu4ov6LR/succ=; b=TJNxdG7nIaxwt5fsrW9NJ
	0ZyCpVhhyouLb2tN3m6windeIj9P+Rnf6Ayt0iUxac2oE/fYgHtvDF+R7mH+M4u9
	kJZST3SwGl7GiZxoFHK0ix7/TuVbDqJSO593Tqoh9+EiIpXmf1Cph8QepIORlX33
	i5jfGLd/xRfWgY1Middf65v5/S5Y44QzLV0+FOX+PXu4L4vfUPkRvKGzVXs1DfLQ
	JsTTv5+TF11xOEnVQC8FsSR1WiqIXlM3LUwTNkvFX9QLu/yD/zx7E/mekk2jzRnt
	ngnbozolIbEHlyUCDJ0GKXwS66BF9St9J7hMFTqJxSn9IqduwRaMvs/7IxXspP8o
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqr8b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNXLMI007358;
	Wed, 20 Aug 2025 01:05:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Nda011685;
	Wed, 20 Aug 2025 01:05:05 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-17;
	Wed, 20 Aug 2025 01:05:05 +0000
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
Subject: [PATCH v3 16/22] mm: pass the mm in vma_munmap_struct
Date: Tue, 19 Aug 2025 18:04:09 -0700
Message-ID: <20250820010415.699353-17-anthony.yznaga@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX/0m/BDOMomdc
 mjmcUu91DMOoaRioIccCUu/ZMLajNDbMYXYBa19rJLPyRf5+D7f1Q6tm1H7iPlpDp/PUkj6zEeh
 kOTM/Enzm2D+HZODMwqSlS8ot+iFWzmQ4CYqiHX+9NVanA6mIUUhE0vV7w/5MueGm0Z3Cm/7Bdw
 c1nMwb8yCVyEHLNDnFc0T6X3Ivlw6qiFTiwW4wVM5u5HjHL+tdRSwWRG9oRajZ1dKbMHSHhcryw
 jqEw4F/dVjEqsEWLfvRSf1dqXDoTPTnn6a75a8oNsJaoh2rgN+KV5IcqQFVme9WFzUfBMcl5Pa2
 6VVkJV3h2aT5rQKyX+Up5/TkdfMOp7N4nC1eMOKydpDMATxvqnMnUFgFBMWjJngqVuSRJ8hdBP/
 TYCr5kr/aabAjlzCUWsAseatQ5faiA==
X-Proofpoint-ORIG-GUID: GZpwVOy5OHxElfkRP804gWCLz5akPFy_
X-Proofpoint-GUID: GZpwVOy5OHxElfkRP804gWCLz5akPFy_
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a51f44 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=KjIxs5Qxk5BEPHft6hcA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

Allow unmap to work with an mshare host mm.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/vma.c | 10 ++++++----
 mm/vma.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a7fbd339d259..c09b2e1a08e6 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1265,7 +1265,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
-	mm = current->mm;
+	mm = vms->mm;
 	mm->map_count -= vms->vma_count;
 	mm->locked_vm -= vms->locked_vm;
 	if (vms->unlock)
@@ -1473,13 +1473,15 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
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
@@ -1523,7 +1525,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vma_munmap_struct vms;
 	int error;
 
-	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, mm, unlock);
 	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
@@ -2346,7 +2348,7 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 
 	/* Find the first overlapping VMA and initialise unmap state. */
 	vms->vma = vma_find(vmi, map->end);
-	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
+	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf, map->mm,
 			/* unlock = */ false);
 
 	/* OK, we have overlapping VMAs - prepare to unmap them. */
diff --git a/mm/vma.h b/mm/vma.h
index 20fc1c2a32fd..4946d7dc13fd 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -51,6 +51,7 @@ struct vma_munmap_struct {
 	unsigned long exec_vm;
 	unsigned long stack_vm;
 	unsigned long data_vm;
+	struct mm_struct *mm;
 };
 
 enum vma_merge_state {
-- 
2.47.1


