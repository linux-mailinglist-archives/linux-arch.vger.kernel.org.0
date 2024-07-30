Return-Path: <linux-arch+bounces-5703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC629408A9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52696B245C2
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE718FC6E;
	Tue, 30 Jul 2024 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCvcQ31O"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845818FC61;
	Tue, 30 Jul 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321822; cv=none; b=ZyzpSlXKGXscJ0SaoG9cyQsmLhdZpyNnmqPOBxlSDsPlpxo3Fb1MjPaw6qlKzowN4xvovOuVCJXp7Rpr2DV2YCyUGN9nocYYMmMzmYEJQR7mvpGTBfH+rRx9KjsJnhhNGcCOS8tUBPDkuhsAdUZMe8nHnBzvafqmBx1PzppDa2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321822; c=relaxed/simple;
	bh=0HxdBM1LE6ysqiZRX6SJTg2axmKV4cup3qnH1WxeykQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTb3KhgRCOfVb12sp932ZnNlNUWIOzNkIpOthtwmHZgT+22bAsH3feMDOPWiTRrr7ADoFSN19lUzgpI0Sv1m7G+2suOZcaUi/wXuSc3m17jw4vAZGtlhIoXFhb9FPUl6luS72vUu/orb1ulQI3IsAV89zYNRtGgU4/5IF5v86po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCvcQ31O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACF0C4AF0F;
	Tue, 30 Jul 2024 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321821;
	bh=0HxdBM1LE6ysqiZRX6SJTg2axmKV4cup3qnH1WxeykQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCvcQ31Oh/rZrX6vYGdEMdYSwjAA1+34RzrEr/t9o7MT5D+PNTa7YGGRObsY3Vj9J
	 MUxGysHSwKrQcTkpl2SvBl6MqrXIGFBmI4eQ8UJaSIMIEoLnBkMvA28EEmbuYs8lJK
	 mCDTcdUtjWr6glb6vgLgL4UY0BRUmhgrr7fA+xoTqQOS70P7y/nWIOhbfFqpU6R5sg
	 QonRXyIz/vNUbS7vAW+pLYDApyNCiOl6Tc9/c2usw+ur/OSWJW0zIG0rK19z5A7Fpr
	 j1UM3Hg0YFwY8/lXeCo/dTo4rnWTG7ZllMILNLVedgbzdeKrt+O1TPgn6MC8iP/Fif
	 4XWWZnrr+crcw==
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
Subject: [RFC PATCH 04/18] mm/thp: use ptdesc pointer in __do_huge_pmd_anonymous_page
Date: Tue, 30 Jul 2024 14:46:58 +0800
Message-ID: <20240730064712.3714387-5-alexs@kernel.org>
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
 mm/huge_memory.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0167dc27e365..0ee104093121 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -943,7 +943,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = page_folio(page);
-	pgtable_t pgtable;
+	struct ptdesc *ptdesc;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
 
@@ -959,8 +959,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-	pgtable = pte_alloc_one(vma->vm_mm);
-	if (unlikely(!pgtable)) {
+	ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+	if (unlikely(!ptdesc)) {
 		ret = VM_FAULT_OOM;
 		goto release;
 	}
@@ -987,7 +987,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		if (userfaultfd_missing(vma)) {
 			spin_unlock(vmf->ptl);
 			folio_put(folio);
-			pte_free(vma->vm_mm, pgtable);
+			pte_free(vma->vm_mm, ptdesc_page(ptdesc));
 			ret = handle_userfault(vmf, VM_UFFD_MISSING);
 			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			return ret;
@@ -997,7 +997,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, ptdesc_page(ptdesc));
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1012,8 +1012,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 unlock_release:
 	spin_unlock(vmf->ptl);
 release:
-	if (pgtable)
-		pte_free(vma->vm_mm, pgtable);
+	if (ptdesc)
+		pte_free(vma->vm_mm, ptdesc_page(ptdesc));
 	folio_put(folio);
 	return ret;
 
-- 
2.43.0


