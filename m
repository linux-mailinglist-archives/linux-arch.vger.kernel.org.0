Return-Path: <linux-arch+bounces-5705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C513A9408B3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C74284F8C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8818FDD2;
	Tue, 30 Jul 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEtbsRJn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362E524C;
	Tue, 30 Jul 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321849; cv=none; b=aYzxOsv6ZhM0BjxoebV4zsjLcsLic7+OjQQ8TE5K0aMtCyoyhykOSrWcTNgI1XFVORfkbFH1ik0CCyCO9Nk1LdlAziICKsXzTUXvEFAvmRRkijrifraMtA3OfhGkjxW2Veje5+fnrwe6jQvX30s18G5/KZXj8mS1xmfVURLjvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321849; c=relaxed/simple;
	bh=PV8eOJ4vyzS4FxAkaZ5NDLLSz9ktugALPQl2HkO57GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjC+VepTAcSpYVlNGBFFWdVUcbvOOKyfXFKJGYJJrBLObkJ8ikwgDMzEUJKqH94VPDvb3BY9+kUQad8wPWuCN4f0GoaI5oIMklxs3+tCq7Yk1DWKCogbGm3iQoyYJrvfPTnyA8ut3PKcLm0wJmMeJwDFgaUvDXdTK2GH43dG2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEtbsRJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1846C4AF11;
	Tue, 30 Jul 2024 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321848;
	bh=PV8eOJ4vyzS4FxAkaZ5NDLLSz9ktugALPQl2HkO57GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEtbsRJnMf7Ux0oUP43wBe2ysz4FoXhhZTuwRiPtnQvwBzcF04hW3I71Xi5W3eYCz
	 vb88N88O7flGQsN6anDDUISBm6/xyE43fRkDhAbxLnCjDlVv82fGw6FotjAYvt6GYX
	 QFHcPrRinsx/+c7KPzDEsLxpolwpWompiMzb0pXGb0blFP07SEq1UyKFHAQv8XC/pa
	 pwgu/eKYgUvwjUgeNQmkj2V0n+sfCR/zx78ePeUsj8CmLWrWcX3OzbvvjpOQap3f7i
	 4IH69bYV6ej5Ph0nh99eBqc8supUb+vBuZOERYMAwubQqITEfEu+UKFYgdgEO9AhVB
	 gqDximJu4aCiQ==
From: alexs@kernel.org
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Brian Cain <bcain@quicinc.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-s390@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 06/18] mm/thp: convert insert_pfn_pmd and its caller to use ptdesc
Date: Tue, 30 Jul 2024 14:47:00 +0800
Message-ID: <20240730064712.3714387-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730064712.3714387-1-alexs@kernel.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Since we have ptdesc struct now, better to use replace pgtable_t, aka
'struct page *'. It's alaos a preparation for return ptdesc pointer
in pte_alloc_one series function.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/huge_memory.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d86108d81a99..a331d4504d52 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1136,7 +1136,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
-		pgtable_t pgtable)
+		struct ptdesc *ptdesc)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
@@ -1166,10 +1166,10 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		entry = maybe_pmd_mkwrite(entry, vma);
 	}
 
-	if (pgtable) {
-		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	if (ptdesc) {
+		pgtable_trans_huge_deposit(mm, pmd, ptdesc_page(ptdesc));
 		mm_inc_nr_ptes(mm);
-		pgtable = NULL;
+		ptdesc = NULL;
 	}
 
 	set_pmd_at(mm, addr, pmd, entry);
@@ -1177,8 +1177,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 out_unlock:
 	spin_unlock(ptl);
-	if (pgtable)
-		pte_free(mm, pgtable);
+	if (ptdesc)
+		pte_free(mm, ptdesc_page(ptdesc));
 }
 
 /**
@@ -1196,7 +1196,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
-	pgtable_t pgtable = NULL;
+	struct ptdesc *ptdesc = NULL;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1213,14 +1213,14 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 		return VM_FAULT_SIGBUS;
 
 	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
+		ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+		if (!ptdesc)
 			return VM_FAULT_OOM;
 	}
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
-	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
+	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, ptdesc);
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
-- 
2.43.0


