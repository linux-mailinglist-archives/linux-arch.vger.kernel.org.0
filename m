Return-Path: <linux-arch+bounces-12795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C1B06B1E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB447B4658
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EAA264F99;
	Wed, 16 Jul 2025 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AIIxJX2H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E222A1C5;
	Wed, 16 Jul 2025 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629214; cv=none; b=RuehcW+jsgbvQoyna1Ra8NursvoMyShBuOM7DIJe9Xf6oHW9iv/jRKn//XrD5BOXNc97N3Fzjefy+DSP+o4IlRHlJHjI6KQZFipwmqpGuku7JadJCBnk9LvAeSsE7Hr4fMCBDU20qJg6oXvA69P0VF1LswOtLNAILsYXcD6Tb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629214; c=relaxed/simple;
	bh=dhmRHC6omUzZl+BhxCjM/v9Ct0N8di0JDdmsBX7FkhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATMuKaPqFiKFlqepwlCbGSJmKuRfifaNHMZ9vTXNyaq/Eha4mC6aEyTIG+O1+5H5s9hgOLdV4F9lwzEX9oSGw/9ktRJB+CBmgJ/5MhJe5W4SX9gZXn9OZrBaRyhTG/qQVwxHH9AdcZIJUE38z4xwWwammWIoZAW2afOJGz25k0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AIIxJX2H; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0fmq0026786;
	Wed, 16 Jul 2025 01:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3Zym5
	azNXiz9qVHXMLPgaEgHeOyb0ea+hw0Xt9bHqAA=; b=AIIxJX2HrC7ltRXRyFrhx
	g+9nNpq/fVSnB4Z+1/ySYPvAWx8+dzAgOjQX7GiJpwTiREZwkvSR9KNcRQM+l1Ra
	yXjIDllyZXObtozKjxrVzDpN4VJ87XeQzhtJuO+1kK5zv9nPd09PVAMvTsxFUCBM
	rfbjGP1PsRGmlrXXdoC8u3V9gN+1LX4l82ubtQiP5HmLub8yRiaifOSfslVIVyIZ
	r6/M8LkfBNn6ClUrVfkqstjI/Npia4hkrvnx3jcad1JAXUZ1NCX51go+6g+5fIKf
	0nhdl4WNUQ/meW30AAJG7XsVl69ofmwKmIpQWcgsXGVjuyiHScbk+b/iAVbncdb9
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g0038-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0K5pc029002;
	Wed, 16 Jul 2025 01:26:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5afds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56G1QCRe036586;
	Wed, 16 Jul 2025 01:26:16 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5afdph-4;
	Wed, 16 Jul 2025 01:26:16 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
        muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        agordeev@linux.ibm.com, anshuman.khandual@arm.com,
        christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
Subject: [PATCH 3/3] mm: drop hugetlb_free_pgd_range()
Date: Tue, 15 Jul 2025 18:26:11 -0700
Message-ID: <20250716012611.10369-4-anthony.yznaga@oracle.com>
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
 suspectscore=0 adultscore=0 mlxlogscore=898 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160010
X-Proofpoint-ORIG-GUID: bMDuweexcGO3OD1A_a-oXN_tSS3SJ0_z
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6876ffba cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=xJtxJrIqMAcFdswKMKAA:9
X-Proofpoint-GUID: bMDuweexcGO3OD1A_a-oXN_tSS3SJ0_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAxMSBTYWx0ZWRfX4NfffmIEIG3p N3a+WZplz1bCX1jn4LyAn0Mg9WGbS66Ae/IXdekWEZ8HpCd2ULlHj94+xQfD91kOdXMJLjIJZBJ BHyzjjh+ZiInL5iHrEPF4lm9ZApbdNEgklvXvocDgTXnvu0TcOM1kzybRY0vBO1i/xEuPhXgnA5
 yrAvFJrWoF09AYgXkHxg3pq+0nEFXSHRS1fCdVoY5AgSB9199iOrCmmPhXz+WaOWbM1dEz+03cm DmJ60pjZZzA/1kvuYMlxG8mgQ9+wWIevEK1+RYDE+iziHtkLTgKaYS9+98rdEvUwngQanRbzCFt KQ6YCiJlBSFGdIe4cTv/GBaAxgyYbm7iUsaLuvDm8TWThjOVs6piSbfZLcSDUiIPWL6bXsVK4OM
 6EoS4uXRcll+dz7OaKjJHMG7xtd3OU79Dra32xDnhOgspTTObnBARiE1Yo73aD6tC+swqz2r

There are no longer any callers of hugetlb_free_pgd_range().

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/asm-generic/hugetlb.h | 9 ---------
 include/linux/hugetlb.h       | 7 -------
 2 files changed, 16 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 3e0a8fe9b108..2558daea1a32 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -66,15 +66,6 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 }
 #endif
 
-#ifndef __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-		unsigned long addr, unsigned long end,
-		unsigned long floor, unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-#endif
-
 #ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pte, unsigned long sz)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 42f374e828a2..adf59868e5ba 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -396,13 +396,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
-{
-	BUG();
-}
-
 #ifdef CONFIG_USERFAULTFD
 static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
-- 
2.47.1


