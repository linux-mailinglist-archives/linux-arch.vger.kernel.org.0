Return-Path: <linux-arch+bounces-11271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C8A7B5D8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA15189CF6A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC71A5B88;
	Fri,  4 Apr 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+Hv+G97"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB913D539;
	Fri,  4 Apr 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733222; cv=none; b=s/A4dAU+ldWlOLOZNmxkIWgVB1QWNEVgX+xTvdFppmnQ6i3PtOD2cCMNPOigdWeU1rsfSgkBXoInU0AhxMgzMAS7ucVNFC5cJUpVkGHRlnwKa9R6wB4w6pT8QKw5/4lrMZZDUiLN9xkigZwj0DpK6/+ow56PgcP0bAnE5v0yr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733222; c=relaxed/simple;
	bh=07U7v1sAH/fhDZh5KcolmJco6x2GMPzXsEu54zp1fmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXfhDAbL9xLpjGUjdPkC8WnuAXU/gGwOf3ifz2tBG/ki3OakeX4QJH9TacYRcDx+9Qsdc4xJu4izci14seCvpmI3oi/Yl9oORysoRzbQQOzG3WfZedlbsulA0gRno4bnF09/GAy9/tGiCsBUIbepj0lGDAg3fVNaVz4lqdtptJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J+Hv+G97; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341NVI4004896;
	Fri, 4 Apr 2025 02:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=hihIy
	QehB7q3j7k+6F2JpGTXdpMmcUUzS5/DDX7tIkU=; b=J+Hv+G970s0UNw7Fk1O+I
	xyb+oyhmnpc0YLXuDBxUI4y887SHTjDoosdvUioBOI2UD3vL1iPyM4kEriPVsSNp
	O1DNYb66WnGlUUJbuhwUWCGnw5hFVCk7NmmNACCCuMQi8gsFpqfb7K0nsaZMrO+c
	mQyHqX0CLb5xbWuUowP5rBxaFxl6wt7r3CzYeHb1bHPAXl5Qxiy6CrERuLjBFlty
	FOsfk+Ueac1YYRGI7BG/DwYCi/7h8NtXLqD4RfoY67QlLjMwRqEgPd5SAmJVZSYt
	cza36SA4valOVbQ3YWNcdGnR5MfhrrmRJo92rigToLHyxAZ9f45wuer+uxd3iyDj
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7sax3xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340f1pR017372;
	Fri, 4 Apr 2025 02:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8hE030074;
	Fri, 4 Apr 2025 02:19:53 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-20;
	Fri, 04 Apr 2025 02:19:52 +0000
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
Subject: [PATCH v2 19/20] mm/mshare: get memcg from current->mm instead of mshare mm
Date: Thu,  3 Apr 2025 19:19:01 -0700
Message-ID: <20250404021902.48863-20-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: 9RFuy4xjdkKWNLG9OWrPNtaQOlvZ7H_s
X-Proofpoint-ORIG-GUID: 9RFuy4xjdkKWNLG9OWrPNtaQOlvZ7H_s

Because handle_mm_fault() may operate on a vma from an mshare host mm,
the mm passed to cgroup functions count_memcg_event_mm() and
get_mem_cgroup_from_mm() may be an mshare host mm. These functions find
a memcg by dereferencing mm->owner which is set when an mm is allocated.
Since the task that created an mshare file may exit before the file is
deleted, use current->mm instead to find the memcg to update or charge
to.
This may not be the right solution but is hopefully a good starting
point. If charging should always go to a single memcg associated with
the mshare file, perhaps active_memcg could be used.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/memcontrol.h | 3 +++
 mm/memcontrol.c            | 3 ++-
 mm/mshare.c                | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..0d7a8787c876 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -983,6 +983,9 @@ static inline void count_memcg_events_mm(struct mm_struct *mm,
 	if (mem_cgroup_disabled())
 		return;
 
+	if (test_bit(MMF_MSHARE, &mm->flags))
+		mm = current->mm;
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
 	if (likely(memcg))
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c96c1f2b9cf5..42465e523caa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -945,7 +945,8 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 		mm = current->mm;
 		if (unlikely(!mm))
 			return root_mem_cgroup;
-	}
+	} else if (test_bit(MMF_MSHARE, &mm->flags))
+		mm = current->mm;
 
 	rcu_read_lock();
 	do {
diff --git a/mm/mshare.c b/mm/mshare.c
index 0a75bd3928fc..276fb825cc9a 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -432,6 +432,9 @@ msharefs_fill_mm(struct inode *inode)
 	if (ret)
 		goto err_free;
 
+#ifdef CONFIG_MEMCG
+	mm->owner = NULL;
+#endif
 	return 0;
 
 err_free:
-- 
2.43.5


