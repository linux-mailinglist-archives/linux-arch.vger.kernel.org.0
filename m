Return-Path: <linux-arch+bounces-11259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFB8A7B5BE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653983B98BE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6E15382E;
	Fri,  4 Apr 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oc9A+bH1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF2282EB;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733198; cv=none; b=syt2ds4SJmfe4Uqz5r+QbY/wak0p8LlqIKa0KdwCFz/vp9R8ON5RwMP5VMYe5XReq23f58yXbFSdbPYYTlGJWlt267kExnHG7qa0EJPP7xZci0LUFDmbksCh2HzjqeOgRdZer28xUHXc0zAY4N5ApNoRynOqrY4BC+OVmkHUlw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733198; c=relaxed/simple;
	bh=IAjhGRedpXnRBwjD4HMkKH61Z0SSmnPiyH+3HqwaJOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEkKhx2ZtKeDVt5ru5/dEArNYSxpyedxaT7ivbeqp5Qr7d0bG9GUchPwYVqgvkVjAVDl3wqJdI77ZiDl32uXhgj3mUunTJZGR8TczxSn/BJROFkqdukLsb5K1WofAJr32Xgh1tWVGG760WoXIBrj0dnp/S9yGrhKsl0S0Fc9660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oc9A+bH1; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341NZt7019542;
	Fri, 4 Apr 2025 02:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=NIZj0
	NmRXwYI88V+aUcfHMTYJsx+jXY2ugUEXgva0Lw=; b=oc9A+bH1+TNDIELUNtbN4
	Lf4KhIRPl4fLuOM4pD8iz7i/gmjo4hE9zrIE+kEIIb5DfDgLhEyPoj7calY7428U
	Gj+gz33ZF5fK+ihgCiXzBQcywO7Za8HwH+JjptMt4yTRL7n3fxZqJmHD4ShwU0Wa
	DaljXnGZ2OWSbKCLEZwnevc9Ltt5F7+C/EBVSwajAbyTAJNC9njWcYLuXZV9NpWV
	7TypwWrqGJodGrJR0thOfcxqt0s/2gnv/4lgJq8x4GmXrSy6+IX7REOnEGpqJIBl
	rywKuYdH3eC1rtQz+/4wqKh/1gcz8ZDuxY5piAOT/2jBOVuqDVe0e4VFrpaLbNKb
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtp4n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340fGw8017328;
	Fri, 4 Apr 2025 02:19:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gs030074;
	Fri, 4 Apr 2025 02:19:28 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-10;
	Fri, 04 Apr 2025 02:19:27 +0000
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
Subject: [PATCH v2 09/20] sched/numa: do not scan msharefs vmas
Date: Thu,  3 Apr 2025 19:18:51 -0700
Message-ID: <20250404021902.48863-10-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: 9h4yNhwaRZZl92DAM61KrKfJObLin3fk
X-Proofpoint-GUID: 9h4yNhwaRZZl92DAM61KrKfJObLin3fk

Scanning an msharefs vma results in changes to the shared page
table but with TLB flushes incorrectly only going to the process
with the vma.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e43993a4e580..6e1649a28551 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3386,7 +3386,8 @@ static void task_numa_work(struct callback_head *work)
 
 	for (; vma; vma = vma_next(&vmi)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
-			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP) ||
+			vma_is_mshare(vma)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
 			continue;
 		}
-- 
2.43.5


