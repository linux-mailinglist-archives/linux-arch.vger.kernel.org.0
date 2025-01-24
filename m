Return-Path: <linux-arch+bounces-9902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A13A1BF73
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9981890B1E
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E481F76D6;
	Fri, 24 Jan 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NBNz1vpN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E31F76D3;
	Fri, 24 Jan 2025 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763021; cv=none; b=redh08TH2F7AEn9dO27TvW7va9szr+DKAYYjzcdaUqs234UXpHk65JQ0gxB2YVwS8hkXC8ZmT3krOidPU1nFRPmiaHGeA5j0Ryfk4hfmDTy509i1ST5NyrjAXcnbgBkv7qprKf/Raq3Q+4B198YU/xpxTxzG2S1zg7Yu/KDXDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763021; c=relaxed/simple;
	bh=DKA9dIletWKBiV4Hg22ND8mbQB18lfg8FRVKfVLg9x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7+BckCjPjEuZU5XQWrAX5bMeNOM37p0RSToILeBcPp3MTfsQ+vDub6WZg1/UuOTMMuH3E6QYLm8E08ev31Dfl2JMJpG66J7H2QDVzXofIya1cK2LuFC32/nTYY+IqfrqcScJH0EYoBnTMlk2GXpePHsz35YzuiXgrlMHbdHPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NBNz1vpN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIXg65000799;
	Fri, 24 Jan 2025 23:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=8uftA
	rRhojvCPMIRnGj1x1yBh7nth+rSToT9QfbKQbE=; b=NBNz1vpNVG2DdlahpKAac
	mHO3DpyehCcOesPJsPnk36jiCZRFlXyz9Y8PTUI7Hnr4gFTFjbSxnZ8oKQoK/e3D
	YShuehhAQHh4kFuqiX6xE1Dt2E881mSqfHP3bmUwYsgQSJlS2PjaQJNVyT9/WOZS
	QqpVHaIbVebMBSuDVaH9otVoCtmhY/9pMaDlI/MuoyXFDkG/AksQjFluDgd4yr3H
	8+3PIMBHFEW/B1nL1bh/H1xpLlGX5rDCDlAlZV6E6aC8MIJStkhyOxHe+pAt6ki5
	1a1OSflAkFUO3oEeHVB/HBKm+9KteLBZVAsvfXVp3WGJZD8idzzQ1RJdlD0LU/Ak
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh5rkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLoFNH036500;
	Fri, 24 Jan 2025 23:56:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4ap1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQI018051;
	Fri, 24 Jan 2025 23:56:05 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-19;
	Fri, 24 Jan 2025 23:56:05 +0000
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
Subject: [PATCH 18/20] mm/mshare: provide a way to identify an mm as an mshare host mm
Date: Fri, 24 Jan 2025 15:54:52 -0800
Message-ID: <20250124235454.84587-19-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=924 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: seWEfcu2KQdw5VizmqhNebvh3voJaHP1
X-Proofpoint-GUID: seWEfcu2KQdw5VizmqhNebvh3voJaHP1

Add new mm flag, MMF_MSHARE.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm_types.h | 2 ++
 mm/mshare.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5f1b2dc788e2..dfbeb50e4c9b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1642,6 +1642,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
 
+#define MMF_MSHARE		32	/* mm is an mshare host mm */
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/mm/mshare.c b/mm/mshare.c
index 8f53b8132895..4c3f6c2410d6 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -365,6 +365,7 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 
+	set_bit(MMF_MSHARE, &mm->flags);
 	mm->mmap_base = mm->task_size = 0;
 
 	m_data = kzalloc(sizeof(*m_data), GFP_KERNEL);
-- 
2.43.5


