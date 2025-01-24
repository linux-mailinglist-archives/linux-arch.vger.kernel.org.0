Return-Path: <linux-arch+bounces-9885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45884A1BF32
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510D73A3D2E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929F1F2C57;
	Fri, 24 Jan 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UXJrjoNs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEC1EE7AC;
	Fri, 24 Jan 2025 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762968; cv=none; b=rHwXqzEVCA25bInQ2BIz4Hk/L7UWU/gdL+A29RzdWDrQ3w7QHh//VwFLC91ryX5f5nN9Gy5WYRZY8vt/OUj0rF1r3FiDIlFsAylU4js0EpoP0sRvYfzoTvH1SBjfZE6vJ1WcH7Ov5C2erHofJcrqNNwf3ykH1fLuSuLUDhKvqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762968; c=relaxed/simple;
	bh=5T7XZddVEIPtBMu8+bgxjFq296KeaC/MWrT9OSVvO4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRyjs3WK5jjLHLYQRiUhj8SEQvQmwoXbzjjSQTiMVXv8uNCrwnwFISK2lFY+zpr8pWyRnzNFrbunfrvI2ngaXvAykMHlrGzB8k82t93I11jkCIEDOCI8V8u7m0N+O8Va4ntpy/FOu5rf1zsSLcT92LKQVHqSPp/f0kdJlsGfO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UXJrjoNs; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIvxBh022712;
	Fri, 24 Jan 2025 23:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=/eSgh
	HqoT5c0J4YzgWIiRZ+XGq6p2xYWtpvcjE+ANB4=; b=UXJrjoNsfNb4WKRHZ5xkw
	OEpw+EPE0TRIcETStVh274mVMU/ko8F9hL67gSxzr76IzNOQKPesaZEDIek7KNQo
	lTIOIiv8DRhEIC8wock9il8CVWN62KiAPGD112LB69JF6EcmZpHbQQyF4QZ7sbt1
	rn3+NWx5FKLfy01BnPhLbUWAxq+AEdhO/sy850W6MLIBaCiVRDw2UNyvhIAR4ofG
	xbShQ0LMrZ4goJ6FKuRIenPA1Cszgvlb0tYwJtkOIhLiGfy5IkaK5OkK7mVGAx66
	2lHmeqb8SHErOXUSAJy4e7cWQmBAGpn2IiZyZ7FthV6IG7ozjw+QWPoUmFjH8KS5
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qm4y4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLP7er036648;
	Fri, 24 Jan 2025 23:55:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4aer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQ2018051;
	Fri, 24 Jan 2025 23:55:38 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-11;
	Fri, 24 Jan 2025 23:55:38 +0000
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
Subject: [PATCH 10/20] mm: add mmap_read_lock_killable_nested()
Date: Fri, 24 Jan 2025 15:54:44 -0800
Message-ID: <20250124235454.84587-11-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=825 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-GUID: VWyly9zRQiKlVwOlv3-7fatJDdYAY01l
X-Proofpoint-ORIG-GUID: VWyly9zRQiKlVwOlv3-7fatJDdYAY01l

This will be used to support mshare functionality where the read
lock on an mshare host mm is taken while holding the lock on a
process mm.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mmap_lock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 45a21faa3ff6..4671b4435d2a 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -191,6 +191,13 @@ static inline void mmap_read_lock(struct mm_struct *mm)
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


