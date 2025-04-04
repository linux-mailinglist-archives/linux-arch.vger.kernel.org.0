Return-Path: <linux-arch+bounces-11269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2608A7B5D3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D7716DA2B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5B13B58A;
	Fri,  4 Apr 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0ycFXWg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C619EED2;
	Fri,  4 Apr 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733214; cv=none; b=jF9Be9I9SMj9Nt+HsL07jA+QIpipLjrBOgN3Y6qYqxYE+LnJeepGYQSHrnMMQPFaCJ8y7oyvQOSzOoW/URvtbB0GuVK/YujgPNTXS+nCW1gAb9RYIpb+YJ2QkC0ukchJRe9zDUkrVTGBzymcjxPPaORj2IlSAN11scfWP0eshQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733214; c=relaxed/simple;
	bh=2twzEc2VPgYbeQKHoHVmgKko7eeSFN0yLl3zdeiZ2gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsNVhajxUaObBuERy22xtojpmrkOBE3feW9ddKi/65G/68B3yDAhSqJOv9P9Zp257t1jShLfzkIdVt66hQDpFck3ZV7pNXVIqmGiRPR8ywSfIL0lIghFfcHkka0AYP4W86ENxl4DQZT3n6eNxiY0SLcQxyqseGmSfk2rU+PLUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0ycFXWg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341NUVY014912;
	Fri, 4 Apr 2025 02:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=XVOpB
	G1ATs5p2zVw52i4mZc77HmrRT8TPOxFoHoCrjM=; b=T0ycFXWglr4qG264tZ4Ua
	MFwJwR8/2kxZcnXFrVn/sI6L1fLnrrw6eDHlDynQx8dF+z+9m3rsgdVC0h22DwM6
	H6uYS4hBH+KoVpdkgRS2AEL4jAE/3/vLNOLww79LUl1q+dk6FH5Clcw6YhckMZjy
	s5ISGg4LFT/eOAL1LikyzzKT0aGfd1vTIT7j+EZ3SXZYMitMd+u3CQpb+TE4HK9h
	ncIUxelY8nsWUTAo6lvZW1y6l2b+z510lALMrb8gEIXTg+7ACvBTeahW5IC+Yp5w
	ZcygkdkENPGmMv6QJx1fOtVv2F0yoWC5m8+mHaMr9DAJBCuBnHnnO7rDcfpHJFq+
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2efne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340gpBJ017418;
	Fri, 4 Apr 2025 02:19:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8hC030074;
	Fri, 4 Apr 2025 02:19:50 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-19;
	Fri, 04 Apr 2025 02:19:50 +0000
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
Subject: [PATCH v2 18/20] mm/mshare: provide a way to identify an mm as an mshare host mm
Date: Thu,  3 Apr 2025 19:19:00 -0700
Message-ID: <20250404021902.48863-19-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: EgU8HPZBLjq7O2rxK59i4iWFx0NytBa0
X-Proofpoint-GUID: EgU8HPZBLjq7O2rxK59i4iWFx0NytBa0

Add new mm flag, MMF_MSHARE.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm_types.h | 2 ++
 mm/mshare.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..392605b23c62 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1741,6 +1741,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
 
+#define MMF_MSHARE		32	/* mm is an mshare host mm */
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/mm/mshare.c b/mm/mshare.c
index a6106f6264cb..0a75bd3928fc 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -415,6 +415,7 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 
+	set_bit(MMF_MSHARE, &mm->flags);
 	mm->mmap_base = mshare_base;
 	mm->task_size = 0;
 
-- 
2.43.5


