Return-Path: <linux-arch+bounces-2520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9085C5E2
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 21:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777421F2374A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61D15098C;
	Tue, 20 Feb 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="3DviofDb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426E69D10;
	Tue, 20 Feb 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461225; cv=none; b=CdX9j/OPLFznpaahddYFbNpl80Zr8DlhcxXmnxIS59L7jzEdFTrAWpSD6HDNPi80eLMKvYY/xrK3vMEYL7fZFNw6NVuqrq1FkoLF0Wcn8NQL6CBNxsaYgTrS29wC7NalwMfCxvoPV69SWYp60Z2nZ39KeBJP9I6hStnP8qTsduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461225; c=relaxed/simple;
	bh=5fyrpL6I35oXbQ79JL+OMciY0wUkV8Hs5J/Gm9DAExw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Esn3ERIaTK7klEhKDQMe3hOzgksO7Nl+CNIf7IyxneyjzbjE93haTcvy5Q34FYAB5H5EqBLElPW28QdRtZIf8rGYRxpCaxgAZ6/WU07n/I52RrqHD/hBcO5C/rp/Kb6Zu6vT2NoQJxydHB5K6GIiSExFhLgYzXIfQ+XB8TR08sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=3DviofDb; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KJFBgl020507;
	Tue, 20 Feb 2024 20:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	DKIM202306; bh=yYaZ6KkZCfPgvE7ldRLRah8LlOxOAhyoW4Oo9vMYLI4=; b=3
	DviofDb9pzniwChbEs283Q/nhrnZBOGxIjIbYC1Xij4+lyhygZxJPN3GIzERfFUn
	FRqnViLZyoLn8VtqSCE6yax3k1cyJkMzduys1f9K06sujdOQdyJ5v8X4aLSf7YQv
	DJpHBVfe55tafJqy9d0n6/2snEve64mdY1j6Ao9A4r/vZEWTvqGph4TEb0IydBJV
	29uSUIr0Bz33FEtALIf1RFGASoSx7cTH2Mlm/csy1VwndF+H5rvB0gZI1BGaao9K
	uo4ExG1esCF3SuXWz284KarBuUKzF8ywJu6hJwimy2/BNJtTjQCKyOnRt9V1ibg4
	196bpTuBMlRupJNonffFg==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3wd22x86fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 20:33:23 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4TfWM709tKz50TkW;
	Tue, 20 Feb 2024 20:33:23 +0000 (UTC)
Received: from ilclasset01.mot.com (ilclasset01.mot.com [100.64.7.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4TfWM65bfHz3n3fr;
	Tue, 20 Feb 2024 20:33:22 +0000 (UTC)
From: Maxwell Bland <mbland@motorola.com>
To: linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, agordeev@linux.ibm.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com, andrii@kernel.org,
        aneesh.kumar@kernel.org, aou@eecs.berkeley.edu, ardb@kernel.org,
        arnd@arndb.de, ast@kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, brauner@kernel.org, catalin.marinas@arm.com,
        christophe.leroy@csgroup.eu, cl@linux.com, daniel@iogearbox.net,
        dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
        dvyukov@google.com, glider@google.com, gor@linux.ibm.com,
        guoren@kernel.org, haoluo@google.com, hca@linux.ibm.com,
        hch@infradead.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kasan-dev@googlegroups.com, kpsingh@kernel.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        lstoakes@gmail.com, mark.rutland@arm.com, martin.lau@linux.dev,
        meted@linux.ibm.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mpe@ellerman.id.au, mst@redhat.com, muchun.song@linux.dev,
        naveen.n.rao@linux.ibm.com, npiggin@gmail.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, quic_nprakash@quicinc.com,
        quic_pkondeti@quicinc.com, rick.p.edgecombe@intel.com,
        ryabinin.a.a@gmail.com, ryan.roberts@arm.com, samitolvanen@google.com,
        sdf@google.com, song@kernel.org, surenb@google.com,
        svens@linux.ibm.com, tj@kernel.org, urezki@gmail.com,
        vincenzo.frascino@arm.com, will@kernel.org, wuqiang.matt@bytedance.com,
        yonghong.song@linux.dev, zlim.lnx@gmail.com, mbland@motorola.com,
        awheeler@motorola.com
Subject: [PATCH 4/4] arm64: dynamic enforcement of pmd-level PXNTable
Date: Tue, 20 Feb 2024 14:32:56 -0600
Message-Id: <20240220203256.31153-5-mbland@motorola.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240220203256.31153-1-mbland@motorola.com>
References: <20240220203256.31153-1-mbland@motorola.com>
X-Proofpoint-ORIG-GUID: IdOVOSFTH5OwTQnHH7fAIQBlI2JoJAu-
X-Proofpoint-GUID: IdOVOSFTH5OwTQnHH7fAIQBlI2JoJAu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=766 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402200146
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

In an attempt to protect against write-then-execute attacks wherein an
adversary stages malicious code into a data page and then later uses a
write gadget to mark the data page executable, arm64 enforces PXNTable
when allocating pmd descriptors during the init process. However, these
protections are not maintained for dynamic memory allocations, creating
an extensive threat surface to write-then-execute attacks targeting
pages allocated through the vmalloc interface.

Straightforward modifications to the pgalloc interface allow for the
dynamic enforcement of PXNTable, restricting writable and
privileged-executable code pages to known kernel text, bpf-allocated
programs, and kprobe-allocated pages, all of which have more extensive
verification interfaces than the generic vmalloc region.

This patch adds a preprocessor define to check whether a pmd is
allocated by vmalloc and exists outside of a known code region, and if
so, marks the pmd as PXNTable, protecting over 100 last-level page
tables from manipulation in the process.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/include/asm/pgalloc.h | 11 +++++++++--
 arch/arm64/include/asm/vmalloc.h |  5 +++++
 arch/arm64/mm/trans_pgd.c        |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 237224484d0f..5e9262241e8b 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -13,6 +13,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#define __HAVE_ARCH_ADDR_COND_PMD
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -74,10 +75,16 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
  * of the mm address space.
  */
 static inline void
-pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
+pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep,
+			unsigned long address)
 {
+	pmdval_t pmd = PMD_TYPE_TABLE | PMD_TABLE_UXN;
 	VM_BUG_ON(mm && mm != &init_mm);
-	__pmd_populate(pmdp, __pa(ptep), PMD_TYPE_TABLE | PMD_TABLE_UXN);
+	if (IS_DATA_VMALLOC_ADDR(address) &&
+		IS_DATA_VMALLOC_ADDR(address + PMD_SIZE)) {
+		pmd |= PMD_TABLE_PXN;
+	}
+	__pmd_populate(pmdp, __pa(ptep), pmd);
 }
 
 static inline void
diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index dbcf8ad20265..6f254ab83f4a 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -34,4 +34,9 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
 extern unsigned long code_region_start __ro_after_init;
 extern unsigned long code_region_end __ro_after_init;
 
+#define IS_DATA_VMALLOC_ADDR(vaddr) (((vaddr) < code_region_start || \
+				      (vaddr) > code_region_end) && \
+				      ((vaddr) >= VMALLOC_START && \
+				       (vaddr) < VMALLOC_END))
+
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 7b14df3c6477..7f903c51e1eb 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -69,7 +69,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
+	pmd_populate_kernel_at(NULL, dst_pmdp, dst_ptep, addr);
 	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
-- 
2.39.2


