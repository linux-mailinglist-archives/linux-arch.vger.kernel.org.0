Return-Path: <linux-arch+bounces-13222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A9B2D12C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07284165912
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8697A22D4C8;
	Wed, 20 Aug 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T60BrX8Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC21228CB5;
	Wed, 20 Aug 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651972; cv=none; b=ltrvtkcPIMOFvmoSC3QVODxrP6v/943W1YBjBTYckke3bLa14t2BqJ3wB6koXbdinwsPNqxdvVEJ1OTfeagGugVaakCgWdmHhX1c9wghq54lfL7SyPzlDPhx6J3Du/8EpASiog4v3lnnBwuGJheuKcRhF4nDfzFULaTh4Ua3CGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651972; c=relaxed/simple;
	bh=z7GVUXgnefSvjb4ZQLTbaIE2/vWnbF28ErxIdtf3blg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iETmQNRs6S8KV6jGfnJTL8LkPysTZc/II0mlPmeLG2Cp/5eiD+VP482Nx1iJZLdjgs6B1ckPYCvHAgN08fKM9mwLU5TdyRX7ix3tdpeLGIyhkJejIu36QJCtwmsDK3bvK+EckhJRy3EnsDm+vYZSjcSboe3Lih50yZYA4xbtAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T60BrX8Q; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBnpF005373;
	Wed, 20 Aug 2025 01:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=infP1
	lJZ7Ka8IX5+GWUINM3qKZZWXr34+Aqn/QJlI4Q=; b=T60BrX8QOrU3Uf13MxnNg
	ONRGEb9jRBgXTNgFlp27/vPFA3Dft51qeT+l6NwTHT0YitxzvIwigPTTQrRLf3Xk
	94CK5Yvtx2hCcpmJlO+v2VqpY1g6bgJhkueU624LEwsmf0VaZk0vPO+Y2fjhaIoR
	R/Ev7R1vhM9XmTq5PeDG7zbFm4toh5mneAmIg0dPn4VeNcN+xhwK8/m/BzFRe56v
	vh81AHOU3f45rYG8+bs2NSULQlnzhEX4NeGXTJkN8hxlpQABkFvi3DpvPmgtonk3
	YcOSJoJhkw1ZBuUT0ZSXfD0Ahq26CLLtDrNkndXrcgw59eiiqCe7/EO0D/PAeOmO
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsr858-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNPt9O007235;
	Wed, 20 Aug 2025 01:05:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2aba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Ndk011685;
	Wed, 20 Aug 2025 01:05:19 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-22;
	Wed, 20 Aug 2025 01:05:19 +0000
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
Subject: [PATCH v3 21/22] mm/mshare: provide a way to identify an mm as an mshare host mm
Date: Tue, 19 Aug 2025 18:04:14 -0700
Message-ID: <20250820010415.699353-22-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: z9by1qV16PLcYdBxBbw-tvoWMv6AlGCh
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a51f52 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=mFgWS2ekddffsZ1b:21 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8
 a=VYm1j9aar4kuMGX0MzQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: z9by1qV16PLcYdBxBbw-tvoWMv6AlGCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX2xGjmgVR1QC5
 CZxdsBOHh4VIMmGeNE7QLyPjvtpWcFHeWyInZ0UEuuhQnz7P8txovb5Y99DBRMzfiJ0RDJlQeYW
 l4jo3Ytu6EwXuM8t67BbQdUmDe4h5MKDLFMIrafpTX84pFg6eRwgkQeI50hmp1Ynv0bpGJzaDhJ
 AKJYann+OnPJTpyvrCvWS2RhvBMbJD31ka/eFH0Gh4ilzT33PBJCKHNtUw0t0pdTImPtWzNG2Bv
 f635KwsF4kOxiSZwieU1/YLmiNkucPbbRWYueRGhcNedL1a77dY+n0keJUxAlU7PWDVscTaQ9xG
 reT/oj9b0hLszWvN8I/RzrHZTwWuwJOrvZY6ZS07V4fAGxt+UPi/pSsyjG0WPB2+5v9CdD5OLpX
 G+iDse/42ToobEW6TQ1/7NAtBx5zcg==

Add new mm flag, MMF_MSHARE.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm_types.h | 2 ++
 mm/mshare.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index da5a7a31a81d..4586a3f384f1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1847,6 +1847,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
 
+#define MMF_MSHARE		32	/* mm is an mshare host mm */
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/mm/mshare.c b/mm/mshare.c
index ddcf7bb2e956..22e2aedb74d3 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -578,6 +578,7 @@ msharefs_fill_mm(struct inode *inode)
 	if (!mm)
 		return -ENOMEM;
 
+	mm_flags_set(MMF_MSHARE, mm);
 	mm->mmap_base = mshare_base;
 	mm->task_size = 0;
 
-- 
2.47.1


