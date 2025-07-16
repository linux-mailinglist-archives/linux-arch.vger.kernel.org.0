Return-Path: <linux-arch+bounces-12794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31015B06B1A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 03:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3477B40AD
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 01:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF623E320;
	Wed, 16 Jul 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uw6J4xZt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B227227E95;
	Wed, 16 Jul 2025 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629213; cv=none; b=KKQgg4ZhkRQwSxg+NuTJCcBfpLxMuX+clgcJMZpMNgRVQ51qJnpQhkP2Iuz4a5/Tchlgj4me7396b7zyCmrT2WEKhCQ1BZx8eqWSuG7vhrpuFPYUEb/xtw19kQH1HZKte7zr8sg6dxh1PYRULmYqgICblBlhB+wc09wcqUQiJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629213; c=relaxed/simple;
	bh=XRW+frtfA36uP/XwcRX0tproFeNr6NFU6iZOQTS2dUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlgXAeI3St4q+T0qQ+98FdzuGnWcx9P4TGH5k8/5wcuu14kRWCwtH0FPjszOTvMJnBoxsIHq3mjqrjpJbkXaSZkWXqWI/SGaemqXHBt7YFImZHQxngCwv+eihzHwObb/zpARCtF0/8v3Q4FiS2vA3zcKUfp6mVYMPfhfgm0AiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uw6J4xZt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0fxQw007321;
	Wed, 16 Jul 2025 01:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4Xor0
	+SnTbcULPGmKl9jLsl3EvNhi9BnucZijnagg1w=; b=Uw6J4xZtZ7UH1oLbPU0V4
	rUUJpY/2b6zOnduGNFwzsPCFuGn4qg6XWGvdZ5J7nUtxFiMb/YoPMcO+jhvfkl2+
	0UB27vPLQqbuyl+4XuZVu5CKZJ+JGI4EXd1byWH9TdGWFQDIblCK78CSUmWfBHDL
	ERQseyB10gPe8DtS8SzuGvglMLnFQelDfoaJ8HpdioPcXoaFA7grZQwmZNYO7xgH
	8ccUhaEWaA5l56VRUAEHoNmzyxuawHg12YavZZuJpFODwZUNKt4HqeJrc9P3ZDnr
	nIqPOWjGiQCTu3FZs26VMRykCF82dy0KqZMgtA44cdiJvkSMNV4vfBldpjEp53Ks
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqrqp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FN5RA2029612;
	Wed, 16 Jul 2025 01:26:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5afdrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:16 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56G1QCRc036586;
	Wed, 16 Jul 2025 01:26:15 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5afdph-3;
	Wed, 16 Jul 2025 01:26:15 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
        muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        agordeev@linux.ibm.com, anshuman.khandual@arm.com,
        christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
Subject: [PATCH 2/3] mm: remove call to hugetlb_free_pgd_range()
Date: Tue, 15 Jul 2025 18:26:10 -0700
Message-ID: <20250716012611.10369-3-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716012611.10369-1-anthony.yznaga@oracle.com>
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160010
X-Proofpoint-GUID: HBUa7SeNl4iqu1JclRHVLT6xJ1KL3Z--
X-Proofpoint-ORIG-GUID: HBUa7SeNl4iqu1JclRHVLT6xJ1KL3Z--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAxMSBTYWx0ZWRfX0L5u2YRxlENR QjqOW8VZjNogQ4VeD93giivDkYvHDkOxs0x8GGDiZFOiAzn9ohwgr9T0rQfj5/Zayq2H2kIFouA ERwpPDTb/zszU067j7CGi1P0ZJ/FBMkd0vk/cJS7nbps5vR/Z6Ej2qaEhWl7aHBZ7UgdVakj/D0
 a9qhORIrp2KQxUDSkXCWItHM316IVGd64BEh3FzJu2xk85F34aGcn7Dta0ZPHNd1Y2oNZ5dVLxS R+DZdT43bvPqcZwZSQEJU0R+4QZ1pG1qPStqC3PXo/RYFXChP+0/5cFiHyMWXQ9A62mWHPPjwd+ 8zCEoSdynLZUzYCSHtfFTk62UC2vmiivq/1soVs50eSfZLt/4Lm3yxug0xdXDBE6mwZQ51GM8yf
 0I2N0mT5CfpoN2SdIu2IuorvHx0BprO93NBAYhGrWF3CKVLm0xgQx2sFzbe4rF0Qqi3ASxVn
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6876ffbf cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=5pK39rES65KkRvXanccA:9

With the removal of the last arch-specific implementation of
hugetlb_free_pgd_range(), hugetlb VMAs no longer need special
handling when freeing page tables.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/memory.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..49792af5b7d0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -380,32 +380,26 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			vma_start_write(vma);
 		unlink_anon_vmas(vma);
 
-		if (is_vm_hugetlb_page(vma)) {
-			unlink_file_vma(vma);
-			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next ? next->vm_start : ceiling);
-		} else {
-			unlink_file_vma_batch_init(&vb);
-			unlink_file_vma_batch_add(&vb, vma);
+		unlink_file_vma_batch_init(&vb);
+		unlink_file_vma_batch_add(&vb, vma);
 
-			/*
-			 * Optimization: gather nearby vmas into one call down
-			 */
-			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
-				vma = next;
-				next = mas_find(mas, ceiling - 1);
-				if (unlikely(xa_is_zero(next)))
-					next = NULL;
-				if (mm_wr_locked)
-					vma_start_write(vma);
-				unlink_anon_vmas(vma);
-				unlink_file_vma_batch_add(&vb, vma);
-			}
-			unlink_file_vma_batch_final(&vb);
-			free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next ? next->vm_start : ceiling);
+		/*
+		 * Optimization: gather nearby vmas into one call down
+		 */
+		while (next && next->vm_start <= vma->vm_end + PMD_SIZE) {
+			vma = next;
+			next = mas_find(mas, ceiling - 1);
+			if (unlikely(xa_is_zero(next)))
+				next = NULL;
+			if (mm_wr_locked)
+				vma_start_write(vma);
+			unlink_anon_vmas(vma);
+			unlink_file_vma_batch_add(&vb, vma);
 		}
+		unlink_file_vma_batch_final(&vb);
+
+		free_pgd_range(tlb, addr, vma->vm_end,
+			floor, next ? next->vm_start : ceiling);
 		vma = next;
 	} while (vma);
 }
-- 
2.47.1


