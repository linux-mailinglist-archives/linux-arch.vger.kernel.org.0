Return-Path: <linux-arch+bounces-5706-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5AC9408BE
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E6B23920
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388F18FDB7;
	Tue, 30 Jul 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Njo24p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD818F2FF;
	Tue, 30 Jul 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321862; cv=none; b=T78rMS8oxAiArTibFjJYAtlBIaQFlN6LYJEsWZbrjxNdF8Shi6AaOufCGKwZfLCBXZB7Gb6KzN9duA2C+H3yfiZp0jO1IcP+MC4pJvM0FoyRQhTaoXKi/FYrx5s7zxsjNd+a4Vt2L6zmCT2OEldUNendmfBv7ZQOMZxYNKdT0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321862; c=relaxed/simple;
	bh=G//eVJ9Nw8aOOKl2d7JUp/+QzzL5npEnufgRCiBDKNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdnpl+vDhTBNDDtWYpxG7fthOrQSp9bhRqTAYYlSclpZAFYWceVH/2a/W5I8W/SUlKGuQBeDeHvJN2gtuWdwwkTHxaQS1Nak/F3XK1N+h9gtnvX48x0bNFcf6SEfXdwJz6cNQDqMXCjiT7dcGIOyLDFs4G3emyqlD6vwq3qvSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Njo24p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20371C4AF09;
	Tue, 30 Jul 2024 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321862;
	bh=G//eVJ9Nw8aOOKl2d7JUp/+QzzL5npEnufgRCiBDKNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/Njo24pZ085kd/eT/gy5nmywtW77TTpW3xwRWYKhIkRHK+lzJdbLggDAN6TpyGvN
	 rW07M9G7E1rNbOiK/BYavaoAKy5hQTRctqPFFo3zD8RaDkoOT734VNnkfzYGuRTgPr
	 7lKhNURsW3JqfLiFVe6G4I5vB1kH5jyn1aLmIMd7FJoJlqMApaFJRvyhUsEwo7ZIpN
	 7RM5QFW8/cV4jRPKXNJ+uwP9fbxQTUYzoz9IEwP+GKQXDzHKvni3jbtRsnh4VwsG8Q
	 iDZw7zJUhoXwEXAb/FQFLoYiOb7hjhzSksX+Dz2XjNV5rBm5sV5pprZ9SrmxaTGPRh
	 KrVL8p90HnjKQ==
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
Subject: [RFC PATCH 07/18] mm/thp: use ptdesc in copy_huge_pmd
Date: Tue, 30 Jul 2024 14:47:01 +0800
Message-ID: <20240730064712.3714387-8-alexs@kernel.org>
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
index a331d4504d52..236e1582d97e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1369,15 +1369,15 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	struct page *src_page;
 	struct folio *src_folio;
 	pmd_t pmd;
-	pgtable_t pgtable = NULL;
+	struct ptdesc *ptdesc = NULL;
 	int ret = -ENOMEM;
 
 	/* Skip if can be re-fill on fault */
 	if (!vma_is_anonymous(dst_vma))
 		return 0;
 
-	pgtable = pte_alloc_one(dst_mm);
-	if (unlikely(!pgtable))
+	ptdesc = page_ptdesc(pte_alloc_one(dst_mm));
+	if (unlikely(!ptdesc))
 		goto out;
 
 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
@@ -1404,7 +1404,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		}
 		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, ptdesc_page(ptdesc));
 		if (!userfaultfd_wp(dst_vma))
 			pmd = pmd_swp_clear_uffd_wp(pmd);
 		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
@@ -1414,7 +1414,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 #endif
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
-		pte_free(dst_mm, pgtable);
+		pte_free(dst_mm, ptdesc_page(ptdesc));
 		goto out_unlock;
 	}
 	/*
@@ -1440,7 +1440,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
 		folio_put(src_folio);
-		pte_free(dst_mm, pgtable);
+		pte_free(dst_mm, ptdesc_page(ptdesc));
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 		__split_huge_pmd(src_vma, src_pmd, addr, false, NULL);
@@ -1449,7 +1449,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, ptdesc_page(ptdesc));
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_clear_uffd_wp(pmd);
-- 
2.43.0


