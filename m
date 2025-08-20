Return-Path: <linux-arch+bounces-13223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CAB2D133
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B6E170350
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002E23535E;
	Wed, 20 Aug 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bOYPhJ4w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41C237163;
	Wed, 20 Aug 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651976; cv=none; b=ogCvuPlmEd3scNLbpAB7g7iQuHgzSe0jGKSw2f/Rxz7fNVT2NrSdARGm35riYaN7y3sXy/8E63w5/qdoYei13y1Lu737WkrqhqKwJv8FEfcJtDQ/CMM8tBR9x/RUIH4qGOowWweFaGk0gawsEIZxe0tRuaNiF7HCbUW7GBAXZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651976; c=relaxed/simple;
	bh=dShIl1d0AGB+5S6ZwLgFhvei4FspP2iEuigbDgXUNCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNg+cfnhq1O+HuCw1THsMVt6uWddjfdjwu10o19qlNZtIfIFl6nf9WG8fw3YsOCJPqCzrWNsFSKsOTQNwwKce3gDuPyBZAu6xXAoDotLtKIgd6gOKOH/pXWkW9GUHY5FBneCu6J5ocdUU8+oSgMJfZo1fH837znQhXYhJYDYp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bOYPhJ4w; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBnPd004722;
	Wed, 20 Aug 2025 01:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bF0MG
	WFgVsHJanG/wrNJY+QDnxV4S15/3lSafFI64CE=; b=bOYPhJ4wSBJ3+LEczXzz2
	LjzyGjAu7Aw3Gke1934IsvA7v9qpf14b3z/96Zys+wT16tpp2cS9cB5IdTQsxXV0
	ykw5MIEQ9x0wPMootWonN8E1tm68NzSwgrbXNKTf2bF109gL1+Mfm2NmyILAd+1W
	gYePZd0tlcJzUX7gALfyxk5lIZ3ZKV+h3kyjzlJK+cV0n2gQxwe5CZ119oVuTjIZ
	xTVTft4VUOX8qP0Re6Aw77CaVEc9f/xBFGhV4qncpEFZdVyb8OmzYYIfoGPPonJj
	WnWk+9yLE6wsikWSidseeGDA10bA10XaxDrxDRHTvWz3VFVbYH6N+y/Nq6tT59Hb
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqr8be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JN39ew007104;
	Wed, 20 Aug 2025 01:05:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2acd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Ndm011685;
	Wed, 20 Aug 2025 01:05:22 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-23;
	Wed, 20 Aug 2025 01:05:22 +0000
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
Subject: [PATCH v3 22/22] mm/mshare: charge fault handling allocations to the mshare owner
Date: Tue, 19 Aug 2025 18:04:15 -0700
Message-ID: <20250820010415.699353-23-anthony.yznaga@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX8TOJSK7gz1xM
 dGsozF7c7go5Ju4nHoshqHdFX1NHqMX18M//9z4kt8ozI/FP8YlrREkk3LCNpCOE025+N3Td/09
 djZcCpnIvQl2nVR4R4sqbQTm+kGb1ICe2+vC1DHrbJeUX3muutedLqFYN9Ec6rynDCjB9393Y3x
 0fw8hMivk6YuhOK7pJ9mpVSVb5vIHdCOEttnWoZNihWgjHB9w94Muo/WyE5RMO3bzsGwt9sWL6J
 qlwbakYBsxoUdiRqsJ0c5cbZzNbZaFQEi8pnlusV+mJVXwrHIQwPgV1ExsU+X/iZU4xg+HnGKsk
 L/pEE5/A0aZWhPYysUqEPkrj0/AGS35RPuuYAV2bAvm/jbc+yS5Ymih5NdkRuaETtIyM/+Oypv0
 E/xDksS0eZDii/keOaR1WsMBzEaavw==
X-Proofpoint-ORIG-GUID: _RaWCOjm3DSPcPOQ-pG-pfNqWr3YDQob
X-Proofpoint-GUID: _RaWCOjm3DSPcPOQ-pG-pfNqWr3YDQob
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a51f54 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=cleBvi95ZpQhKa3SDf4A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

When handling a fault in an mshare range, redirect charges for page
tables and other allocations to the mshare owner rather than the
current task.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 177eb53475cb..127db0b9932c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6468,9 +6468,17 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 	bool is_droppable;
+	bool is_mshare = mm_flags_test(MMF_MSHARE, mm);
+	struct mem_cgroup *mshare_memcg;
+	struct mem_cgroup *memcg;
 
 	__set_current_state(TASK_RUNNING);
 
+	if (unlikely(is_mshare)) {
+		mshare_memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+		memcg = set_active_memcg(mshare_memcg);
+	}
+
 	ret = sanitize_fault_flags(vma, &flags);
 	if (ret)
 		goto out;
@@ -6530,6 +6538,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 out:
 	mm_account_fault(mm, regs, address, flags, ret);
 
+	if (unlikely(is_mshare)) {
+		set_active_memcg(memcg);
+		mem_cgroup_put(mshare_memcg);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
-- 
2.47.1


