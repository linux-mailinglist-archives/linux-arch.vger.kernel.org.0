Return-Path: <linux-arch+bounces-5711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A3940994
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E8EB234A9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237A19007D;
	Tue, 30 Jul 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I93puTgZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AB18FDB8;
	Tue, 30 Jul 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324160; cv=none; b=Xkg0e+cObz930z7yr47w1xMEAGQzNBnMURwLoCBBrAfnxFp8EEzJnVG9alXhssJcSHzVJ+q2BRb+gLGOY2WYNp8nFJ/cU1Aex6oEGWsmEW01JeZszIg5q9/+wqRU7yQmzmjGVv9Xf13A9BF5ip2DnBssaxaQSuj3FOkw952VLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324160; c=relaxed/simple;
	bh=F4rT1yReaNgoNPAOrss44yWnUe6Elb31IIk03kOZru4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9qWygakTc30LB43gfEpX221n30In7QYbXJ14QM3T5vKZTjYM3D0C02W1VSk5TUs9lc7b1BcpSpzLWwrtwSDbMoCYh61GTipCSav5QJGw4dRmvj7AEuZmhGhUFpQWF4suTq7cMP+20x+3mrdBeBdcnTIpFSswr8NrwN762Drkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I93puTgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684EBC4AF17;
	Tue, 30 Jul 2024 07:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722324159;
	bh=F4rT1yReaNgoNPAOrss44yWnUe6Elb31IIk03kOZru4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I93puTgZYyNM8LhENhjVfRqUnOmgCNGDgnG5jenN7sEcro1xD8o4LG0tV9ptaSFwY
	 PJLaerU/r2mHKee1c2YvQSyvlJg4Wwwvxp1DBp3niYcmBM0VqGPFTQP0rUYMj+49cB
	 SBIYzw7Mq5blsyH6UBISlMfioxXEJu7mMlQJHH4yDgrhD4CTQ9hIsmJZsmVNBl3JKi
	 WBQjq0R3FTO/cpgH/VFebdmXxc1+QxwdDz9Jy5MJW1j7QPpkEyrb970dyzBwR9zmXp
	 QzRAanhlQYpwwtfa6YKWEQwsDF/tgyU1IBDAE2+6tQC7zeslhLzdguUkGZ689CjSZ6
	 ORaa3vXAkOiLQ==
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
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 12/18] mm/thp: pass ptdesc to set_huge_zero_folio function
Date: Tue, 30 Jul 2024 15:27:13 +0800
Message-ID: <20240730072719.3715016-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730072719.3715016-1-alexs@kernel.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
 <20240730072719.3715016-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Aim is still replace struct page to ptdesc.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dc323453fa02..1c121ec85447 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1055,7 +1055,7 @@ gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
 }
 
 /* Caller must hold page table lock. */
-static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
+static void set_huge_zero_folio(struct ptdesc *ptdesc, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long haddr, pmd_t *pmd,
 		struct folio *zero_folio)
 {
@@ -1064,7 +1064,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 		return;
 	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
-	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	pgtable_trans_huge_deposit(mm, pmd, ptdesc_page(ptdesc));
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
 }
@@ -1113,7 +1113,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 				ret = handle_userfault(vmf, VM_UFFD_MISSING);
 				VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			} else {
-				set_huge_zero_folio(ptdesc_page(ptdesc), vma->vm_mm, vma,
+				set_huge_zero_folio(ptdesc, vma->vm_mm, vma,
 						   haddr, vmf->pmd, zero_folio);
 				update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 				spin_unlock(vmf->ptl);
-- 
2.43.0


