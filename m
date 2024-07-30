Return-Path: <linux-arch+bounces-5704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8F9408AF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED7FB247DD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE618FDA2;
	Tue, 30 Jul 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF6QdOTY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B718F2E7;
	Tue, 30 Jul 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321835; cv=none; b=Ws6wghqM/QpLNMr46XQZzwYn6rUWVgAm+Z4F0MxwDLIF5B0Od2bnJXz4EKfy7u1mYu8LPaHwMzi6jxPyxdzjyfigUZ62HJzTRZt837Q9mY+qV45Lj2Z8dwM04NwizuLG/XBso/30+j5WfUN13TFNCGXUZQhct+U7XCn/bVPpf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321835; c=relaxed/simple;
	bh=liNll9iqljHOGZGyoe5+iBjU60hIZmqEawxmeeNx05k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTJDvKaVUnZx/d7mK4n5eseWaPG+1YrCc6C4+4E4ajil5HQAhtBXnA2vHP/7f5SE5P9kQYeCvVnA/1WwnKZXJDjkT2LchYRElpwgC9MQZaRNFZYX2Qau9xSBs+YUKXNadxsk7TSRJmO34SzHeElmD3xjFNzlGpwDKz6DB9zMb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF6QdOTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33505C4AF10;
	Tue, 30 Jul 2024 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321835;
	bh=liNll9iqljHOGZGyoe5+iBjU60hIZmqEawxmeeNx05k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sF6QdOTYXsuhZ5/wKcNXr1fpLi2Nc7NTYTTlW0GyhipNPb/9ArXCaTfUMRF4glafN
	 ERGFWbhPiJp0rpmYk//9iOQ4Y6AWC6KbdqdnXw9EAsyfZb9SiKLpZrjeJa4W887xAU
	 iVeioOBZRlSigQTkAI1svU6u1CTnxum7RI995sRZM+TABKT73TI9KeunNb+F7Daix0
	 V49XC5PL7gFKWpc7LTU2ULT4wVE0DoSUB5onWtjcXwdrpZRUDJf6X0eNb/eT2TMkmJ
	 5rFakvhSK2oYTuzfh3G24YHCdvf2JT6UzyA+rwvZu+uZaNsor+hHhabSQIlD9nTc6+
	 JA10DmcfN2EZw==
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
Subject: [RFC PATCH 05/18] mm/thp: use ptdesc in do_huge_pmd_anonymous_page
Date: Tue, 30 Jul 2024 14:46:59 +0800
Message-ID: <20240730064712.3714387-6-alexs@kernel.org>
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

ince we have ptdesc struct now, better to use replace pgtable_t, aka
'struct page *'. It's alaos a preparation for return ptdesc pointer
in pte_alloc_one series function.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/huge_memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0ee104093121..d86108d81a99 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1087,16 +1087,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
 			transparent_hugepage_use_zero_page()) {
-		pgtable_t pgtable;
+		struct ptdesc *ptdesc;
 		struct folio *zero_folio;
 		vm_fault_t ret;
 
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (unlikely(!pgtable))
+		ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+		if (unlikely(!ptdesc))
 			return VM_FAULT_OOM;
 		zero_folio = mm_get_huge_zero_folio(vma->vm_mm);
 		if (unlikely(!zero_folio)) {
-			pte_free(vma->vm_mm, pgtable);
+			pte_free(vma->vm_mm, ptdesc_page(ptdesc));
 			count_vm_event(THP_FAULT_FALLBACK);
 			return VM_FAULT_FALLBACK;
 		}
@@ -1106,21 +1106,21 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			ret = check_stable_address_space(vma->vm_mm);
 			if (ret) {
 				spin_unlock(vmf->ptl);
-				pte_free(vma->vm_mm, pgtable);
+				pte_free(vma->vm_mm, ptdesc_page(ptdesc));
 			} else if (userfaultfd_missing(vma)) {
 				spin_unlock(vmf->ptl);
-				pte_free(vma->vm_mm, pgtable);
+				pte_free(vma->vm_mm, ptdesc_page(ptdesc));
 				ret = handle_userfault(vmf, VM_UFFD_MISSING);
 				VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			} else {
-				set_huge_zero_folio(pgtable, vma->vm_mm, vma,
+				set_huge_zero_folio(ptdesc_page(ptdesc), vma->vm_mm, vma,
 						   haddr, vmf->pmd, zero_folio);
 				update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 				spin_unlock(vmf->ptl);
 			}
 		} else {
 			spin_unlock(vmf->ptl);
-			pte_free(vma->vm_mm, pgtable);
+			pte_free(vma->vm_mm, ptdesc_page(ptdesc));
 		}
 		return ret;
 	}
-- 
2.43.0


