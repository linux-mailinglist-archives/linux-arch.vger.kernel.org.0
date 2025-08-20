Return-Path: <linux-arch+bounces-13201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5070B2D0F0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C012189D3F6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321919DF4A;
	Wed, 20 Aug 2025 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9rqNDyW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FFEACD;
	Wed, 20 Aug 2025 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651951; cv=none; b=BnXcrOO0i4aowJY6AGaRiSCA+ibthbmFvz8sHF1gonMbAI5HJ0AOWan3V7om5DBIBwPhTFgsz4kUla1X80V0LT9xBg5Kzx8WCKV1xpTrMNlVXpwSYQXBrpUXnSudRJMAu5v63y2Sfmj/7qJKqwxenjUycb/4uJsydBlIqLW1xak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651951; c=relaxed/simple;
	bh=k/0CokvgxVQXuD5EoA1X+9nYuoVnaLv2zm+DaVfTfHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCHHhuJjYKq7Nc1oexlvO80VXUUHLlpsrcWm1LKSrmdEp8Suc2HJGihTBO35FpmMfHUY1s9iESdqbekTtrURV2dlzMkkAhOdhuNdfmRYB56CeFad/OSxDY9IKtFC9vlcZ88TFvOzJbId6zELoICGezHjDgNLQrNmScxAv6uqM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f9rqNDyW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLE2Aa008324;
	Wed, 20 Aug 2025 01:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/DmF+
	MuOx9lfBDmRRC8FPNiO57MW57fL18nJmrC16ww=; b=f9rqNDyWguXWS8I3hcAkX
	X1+oBex+YWZjxY0OjWF3weAMJoB2p1d19UfDHmEMJ/Zd3EPCw7YnMRAdlWBkUa+I
	XzW12RSIvzijTDDl/J5h+i5AKTKm4492PkE8He4GFKmTXv3kdmE3ZmWkYnl+u/tH
	IS1f4fSsd8YOBXg4UzcF47uMhW13LpiE11UpOIJI/juZcUfTIfzDxH07Fy5UkVX2
	AACD+gZjoNaxb8+Tv5/EU+pyFh7aCo/10g4hyCk5xOeeM5sHZH1Ktzt0ob4HyEtM
	uydW/XfgTuxCWSPo3dcGI3vpj918cf/PQZvm2LVNkLUtN45uFsWR3CcohbQN/LRI
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ts88gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNZVeL007332;
	Wed, 20 Aug 2025 01:04:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdM011685;
	Wed, 20 Aug 2025 01:04:48 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-10;
	Wed, 20 Aug 2025 01:04:48 +0000
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
Subject: [PATCH v3 09/22] sched/numa: do not scan msharefs vmas
Date: Tue, 19 Aug 2025 18:04:02 -0700
Message-ID: <20250820010415.699353-10-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: kkX1jrsmAmAWOAdgPkvoTgAV_QB4TK5z
X-Proofpoint-ORIG-GUID: kkX1jrsmAmAWOAdgPkvoTgAV_QB4TK5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX0BPSeq4GrA/L
 zcO7Tgz46CTrssMsJV5wS1/futixs+GLOYvakk8NrmOdZlica8nXpVsUSRCkA2eufd8HR3A7ZGu
 WtfGhUo7KPw1v4ADEbD1xtPqCJN5vIyzRB9ac4rYNSMoh9Xf6GrckvYH9Rgps/DdSoAyuGQ0Ec9
 YHfvbvxxYuoolnI0WT2SMefEJjoO25LD7Z64ZnQV6HYfm9Vb9u5vSUrbw1wnLThPSrKkDshpYGr
 miZcYEJY5ZQbPMEIKle2JH2tFBGURcNhgLj5EOVLXCGXWHaL4yiv+CnPJV+gkZsBDPqvILdjQmu
 73cvbt3i2u/bDVPuI8y7M48qB0CmuupNGTgM0hugejYo7jfAjySQyqij8MdACSaDDCl8RJSjBvq
 02W20G4UPnLctmK5FXLCr4Lt7Xbh5w==
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a51f32 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=2OwiNFxuFh20pgB9HS0A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

Scanning an msharefs vma results in changes to the shared page
table but with TLB flushes incorrectly only going to the process
with the vma.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e256793b9a08..6f28395991cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3379,7 +3379,8 @@ static void task_numa_work(struct callback_head *work)
 
 	for (; vma; vma = vma_next(&vmi)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
-			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP) ||
+			vma_is_mshare(vma)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
 			continue;
 		}
-- 
2.47.1


