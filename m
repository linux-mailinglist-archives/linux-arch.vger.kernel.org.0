Return-Path: <linux-arch+bounces-9903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8AA1BF7B
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 01:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9E916EC44
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21B1F76C7;
	Fri, 24 Jan 2025 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B3fjZHZb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E91EEA33;
	Fri, 24 Jan 2025 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763090; cv=none; b=l2RV9FXAbX7V1u3CB3qsgEwQ5fEVzHn71kLSTx922W6djiChN0ro5YAY7FEri5cfDhGMui5O1RrBMvIhGFyWjLbPQr4ttXv0Xm1OwmmOqxrpooomIi5j3R0lavg2sd8zFjrEU2hS4O9jnc9k0E6WCs/842NuPp18c8s94cY1SZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763090; c=relaxed/simple;
	bh=f19dEU0waQS5E0P/wf9Asn87RUd8SB9dbmqgvMGp6K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igs5iDYaQjJ9u4POoYrbxnWEt6VvXP8313NCz4eW1xLjBdSAHjiMPtSyu5YI26Sb1lLaHAKxUmDSr9q6sFeV7MjVJKPhN6/7l8Of5R2BPXq9Gnr7vPwFK5uVoEbGfJvHNnROly3hINJic2Hd6tr8e+axyfJ0fGmd3h59STB3fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B3fjZHZb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIBhnG000613;
	Fri, 24 Jan 2025 23:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=SM5Ww
	7fWlIZajv0rUMSJsMcTKUFDtvzpjq2xibJD7zc=; b=B3fjZHZbj/1OatG3T8blh
	RsVs7af8iubXIbp5pCA/LmBolWeub9ZWDjgfFw/eUeRi9kdXt4spr34dzUUkjVYH
	8YFGdxJ4Z5/RpbERJYmTWBrzS9ds8FNE2A0kyKEfgzObXPdQl7S+wid3oS7YndzN
	RZR9201pZ9PZfSijDDQmyNa/mBgI2y7nL9PF9mqYFcwu3MYFtqG6NtUY/EBfUsRO
	9kYqDw1UwZamvlgb0Lzhzui1+zNUkKTJbSnBNmyZJxKmd7jmxIsBEVT1go/vz6CP
	ybAZTHMbWjqjXO8Y8QBEbLr+RzKlZtiw3vGENMpoLhyb+Mkvr3LTEbk1ar79lSPf
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh5rkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMPchS036590;
	Fri, 24 Jan 2025 23:56:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4aq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:56:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQK018051;
	Fri, 24 Jan 2025 23:56:08 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-20;
	Fri, 24 Jan 2025 23:56:08 +0000
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
Subject: [PATCH 19/20] mm/mshare: get memcg from current->mm instead of mshare mm
Date: Fri, 24 Jan 2025 15:54:53 -0800
Message-ID: <20250124235454.84587-20-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=912 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: mhtNEYRHB3aSsRiiq5ZgkAR2eaM2NkII
X-Proofpoint-GUID: mhtNEYRHB3aSsRiiq5ZgkAR2eaM2NkII

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
index 6e74b8254d9b..e458ca80e833 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -987,6 +987,9 @@ static inline void count_memcg_events_mm(struct mm_struct *mm,
 	if (mem_cgroup_disabled())
 		return;
 
+	if (test_bit(MMF_MSHARE, &mm->flags))
+		mm = current->mm;
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
 	if (likely(memcg))
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..ba6267615ee6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -938,7 +938,8 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 		mm = current->mm;
 		if (unlikely(!mm))
 			return root_mem_cgroup;
-	}
+	} else if (test_bit(MMF_MSHARE, &mm->flags))
+		mm = current->mm;
 
 	rcu_read_lock();
 	do {
diff --git a/mm/mshare.c b/mm/mshare.c
index 4c3f6c2410d6..5cc416cfd78c 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -381,6 +381,9 @@ msharefs_fill_mm(struct inode *inode)
 	if (ret)
 		goto err_free;
 
+#ifdef CONFIG_MEMCG
+	mm->owner = NULL;
+#endif
 	return 0;
 
 err_free:
-- 
2.43.5


