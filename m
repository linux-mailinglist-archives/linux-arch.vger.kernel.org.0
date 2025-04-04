Return-Path: <linux-arch+bounces-11272-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A1A7B5DB
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDCC189559A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FB13D539;
	Fri,  4 Apr 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/L4jxDX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6A33993;
	Fri,  4 Apr 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733256; cv=none; b=Pv8Sk1fF1zzxCKpqLq58P53SIMHa/5+C5E61VWJDeWLEQ8jfofrAd8Ou+QHxkStcVNjBXkDvY33vEcoqthdLorTL/lIjIko97ftbogWozOOuyusfoirfq0lwJrBbUkHymvsClEfplmFX1X6VxuZoycTevpczY0YV1wr38ycHMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733256; c=relaxed/simple;
	bh=0c6HNmTH664MrBmm5ZpFzSUVr5wtWMNENPOrdOvbctc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvIJ6TGPI8fWe7jyKzGdhDfJdGD9KcdAy+7urw42Eq1yGdNug1GZAYxn6W0kyUTCvXpKWF2iqrCmHuO0SXMNtqI7HoCDBu9Wjx+5jFSi1UWCRvS1uawmbjEUbd40m2Nmeo9nP0uJNwBBaBlPZuzzJ617CCzXZVB4+5GwpdbGn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/L4jxDX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O27D030347;
	Fri, 4 Apr 2025 02:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=BdRPF
	+sf/RDOZJ0I0WvcHOUgTUy24Kq80kPmQD17F1o=; b=P/L4jxDXxOgg0UV8cbnKo
	CrLZxzligmPb4xbXzxI+mEBC9kJqicEJdvfbZg8GU0EA3/4yrLnjewlx0DZ54x8S
	P7dInIod7uCRCUiR4rjuRlCrqS0rC0SZ1SCPWht6QKt3Jb4/bY6tEg7e/WbmmXT9
	XNRbyBUD/bZrBJYUpnAdzGkwZoPiEsOuslIUz6c7N15L6jwZYa66n8airnQdEYyP
	q/eqDpAJCOKzieY1Ap+seXCLsbcYCJhORymKJ5AgnUwnlEW5rwUiGKtwKnt536Zv
	vzxWFf924qln/KyUa/QCzlkBomKwmolMusmnfxaY13nVUJJHX+2MVSux9K4SyB+L
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0p1nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340hM7d017366;
	Fri, 4 Apr 2025 02:19:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gu030074;
	Fri, 4 Apr 2025 02:19:30 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-11;
	Fri, 04 Apr 2025 02:19:30 +0000
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
Subject: [PATCH v2 10/20] mm: add mmap_read_lock_killable_nested()
Date: Thu,  3 Apr 2025 19:18:52 -0700
Message-ID: <20250404021902.48863-11-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: CJAr9j-c4aQzEF5Z5RSFuAWWQe2jfl-Y
X-Proofpoint-GUID: CJAr9j-c4aQzEF5Z5RSFuAWWQe2jfl-Y

This will be used to support mshare functionality where the read
lock on an mshare host mm is taken while holding the lock on a
process mm.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mmap_lock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 4706c6769902..a14d74822846 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -185,6 +185,13 @@ static inline void mmap_read_lock(struct mm_struct *mm)
 	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
 
+static inline void mmap_read_lock_nested(struct mm_struct *mm, int subclass)
+{
+	__mmap_lock_trace_start_locking(mm, false);
+	down_read_nested(&mm->mmap_lock, subclass);
+	__mmap_lock_trace_acquire_returned(mm, false, true);
+}
+
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
 	int ret;
-- 
2.43.5


