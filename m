Return-Path: <linux-arch+bounces-13214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23EB2D10B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BFF4E0E81
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC220E032;
	Wed, 20 Aug 2025 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FvMDBI9D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FA1FECBA;
	Wed, 20 Aug 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651960; cv=none; b=mkU2NwmFr+S0dqxyptthmbDLiqXPonot4R16TU3T76yY0wenyk6MbHMqRd5pdP5UNLhDen2Clmeeqls4bnvlZB18EhONyul7tj47WoqMFKVgCPfX1hwpVKcbozViIjfRUNvDIhlRXaNfrnR8iyVmk+oQ447I2YY3RExB6sx6yBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651960; c=relaxed/simple;
	bh=yw9aGqyxJXYjFULGNdmg/sm2U3OWpv9sLI5g8JLosp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMbQWkoSZ0Tl3OXkSCq7BUGCyBGLmr4f7hHbqbqrWRoPOuutzWCM40ZR70rjVYhzlf2Lpg9dMzpUB2s4ZjTAESgyiM0Rbofn9kE3jsgD7Zq8XSmvgY500Jf+hRtVnNhiVhgc7BLAKF4hVQxNI4fM8atnfLD2ymfWnKyGbi4YWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FvMDBI9D; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLCDGl005682;
	Wed, 20 Aug 2025 01:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Le2GA
	DmgFKn9Yb9MtlR8f8swzH8vtb/n0jwBJSbLGNY=; b=FvMDBI9DGn0QkQHCginz8
	JbM8/Snb0kT2s6rR5PMiJDyK2AoCK07lLecZQ7VhaW1YhjzRPi5guRmKtc+mcHTi
	Vti1+elCNJGbIjKSvvvYeqWEX2xk94TfJUpaHZ/Ni60CDgFhmHxdAZgotykkiAAL
	ym/r2YMgrLPOg/rVVpvHXihsla/+IwF/ACw4hMAfBWU5oq14YoALRLB29kkpr4Yp
	MEShVeN1tNQWcGk1rQ8FrsAv65IS3WheB8PR8yfJocniIHsmvn2hLwSH8tc5M5cH
	6on04DsFYToJRPVu6JzzHTiLvlFfQT8dD4/XLiposr/yzWOfPeKznCk4T55Pf1o8
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ts88gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNkhLF007278;
	Wed, 20 Aug 2025 01:04:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdO011685;
	Wed, 20 Aug 2025 01:04:50 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-11;
	Wed, 20 Aug 2025 01:04:50 +0000
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
Subject: [PATCH v3 10/22] mm: add mmap_read_lock_killable_nested()
Date: Tue, 19 Aug 2025 18:04:03 -0700
Message-ID: <20250820010415.699353-11-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: IzMLS54QSyw4yb-w04wcug_DzS4oYxWb
X-Proofpoint-ORIG-GUID: IzMLS54QSyw4yb-w04wcug_DzS4oYxWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXzFr7NCmWGcQS
 r6rWahbigH3tL3T2O4uUCawj1dnQ3YVLiaOroZl7zfVWUl5LBE9KSlBE1ejgxittoxyvG9/B5DK
 abA9GKMkwf4CP6bOw/uol16+0UuSfR+ubY+/NHmpTE18vRI+Mpb6ELG95jHs1lJVYTi+ZU73DBu
 VqVSO27e8ing7RpCBDzZEYh2COHHyseisJ27FHlES28cTKh6FDZfTcempDS2io8M0JUcTpuXr19
 1PJZVxAU1CNqPeAid+nwydmffWHGTh/8DJe2gf00z6GvCr8u4cEMmh35FeKXGAYyVerL5CzvUD1
 X4uM3+0g8pXvnTteXhIcMqZC2+UNIDwDl9tVuGiqi/+qtikWg8nR6zvlhq1xoY77rJeQv/OvM4S
 AWJev3h51X4zWyTVhu2KzJWh9PpFeg==
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a51f34 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=c3nol8fVUP3th71kQ2MA:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

This will be used to support mshare functionality where the read
lock on an mshare host mm is taken while holding the lock on a
process mm.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mmap_lock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 2c9fffa58714..3cf7219306a1 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -369,6 +369,13 @@ static inline void mmap_read_lock(struct mm_struct *mm)
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
2.47.1


