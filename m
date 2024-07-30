Return-Path: <linux-arch+bounces-5700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EE94088F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26741282ABC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098E18F2DC;
	Tue, 30 Jul 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMNS+x8H"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F018EFF1;
	Tue, 30 Jul 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321780; cv=none; b=dZKtXmRFfWFNJce0UTjsjzp3j8CWWbgAUor/ogTNd7zMHzNtiSzM36ya1GEVX/bucykMiaR/37pRmd5DDzq95LpVrjwHu3o4sZepauMoT5DX/UJFbUaHgzxKqXZyCawY3fmt7o7mpeEuNMTYR1Ei9vJDx2SmMpbXQL+HcB8Qx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321780; c=relaxed/simple;
	bh=gTArplwlUTbTCuHNeuVct9T0SiQYRSRnIpLhqPQ+rcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYy5u8Kf8IsqTdwF/Lj+yHSg4oBclNFDOdX0bepNBVozhTPt4V4T0HP41/n8aBmAQ510vjtjVP6K7iI5mfS4vG2IitdqafAbtCs6sVqb7JOgMUh8bURaMBXr6OVNHNna2qPVvLSH5ziRmzO4ptW/rjNPbEZ2ghbh+zIwcKO3Fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMNS+x8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E2C4AF10;
	Tue, 30 Jul 2024 06:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321779;
	bh=gTArplwlUTbTCuHNeuVct9T0SiQYRSRnIpLhqPQ+rcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMNS+x8HI+8Q08E7NcZ4WD5BkiWh9xAxJgNUSeEC7wUsbadoC1FFu91tQMZE7Hy2S
	 IUmoRLjOcThG09j1Sqjri8IS5v5L/GqTmjdQarB0bmky4bNiqAj/NZnJ7JFHJeD8eM
	 xp4GUDXu8Pgl+WLlnMHA4AQrs4fRuuLAioV9xJyUj3Qfg+O5uVNHyjdnKujlXeeMze
	 y4pE/ENss3Y27SBqOaPJvTM3lQjwDoA5fmkCORb6Q7jSG49BTJJjCdSyOBxPURAgT7
	 N7ujc9Lmfynti/YNZ3I4QClP7CXUI+TSJh/h+u7SmrhYbHOtbMTzdHI4QxlG3cF9IU
	 WbYLxc+yhe31Q==
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
Subject: [RFC PATCH 01/18] mm/pgtable: use ptdesc in pte_free_now/pte_free_defer
Date: Tue, 30 Jul 2024 14:46:55 +0800
Message-ID: <20240730064712.3714387-2-alexs@kernel.org>
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

page table descriptor is splited from struct page, use it to replace struct
page in right place.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox  <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/pgtable-generic.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 13a7705df3f8..2ce714f1dd15 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -238,18 +238,17 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 #ifndef pte_free_defer
 static void pte_free_now(struct rcu_head *head)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = container_of(head, struct page, rcu_head);
-	pte_free(NULL /* mm not passed and not used */, (pgtable_t)page);
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	pte_free(NULL /* mm not passed and not used */, (pgtable_t)ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 {
-	struct page *page;
+	struct ptdesc *ptdesc = page_ptdesc(pgtable);
 
-	page = pgtable;
-	call_rcu(&page->rcu_head, pte_free_now);
+	call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
 }
 #endif /* pte_free_defer */
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -330,7 +329,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
  * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
  * modification by software, with a pointer to that spinlock in ptlp (in some
  * configs mm->page_table_lock, in SPLIT_PTLOCK configs a spinlock in table's
- * struct page).  pte_unmap_unlock(pte, ptl) to unlock and unmap afterwards.
+ * struct ptdesc).  pte_unmap_unlock(pte, ptl) to unlock and unmap afterwards.
  *
  * But it is unsuccessful, returning NULL with *ptlp unchanged, if there is no
  * page table at *pmd: if, for example, the page table has just been removed,
-- 
2.43.0


