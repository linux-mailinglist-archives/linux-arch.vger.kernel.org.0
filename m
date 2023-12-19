Return-Path: <linux-arch+bounces-1132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B30818F25
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CAF281A52
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA037D0F;
	Tue, 19 Dec 2023 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx6P/DJj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62ED37D0A;
	Tue, 19 Dec 2023 18:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248D2C433C7;
	Tue, 19 Dec 2023 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009002;
	bh=UL2kffNuUbkPlnJBN+qpCzpP5kui14dRs7DZfONdDT0=;
	h=From:To:Cc:Subject:Date:From;
	b=Tx6P/DJjFhfS2hJiQefr5BQzr7JnNvODIRRy7UQlV7ksSfFMQfUEGi2O7ZYHnX46p
	 7zZWYPi/ssCCH0Z/Xb/HvTsstn+U5ywq4poEVpAPlmY6tUmyi39QY7UPJV0EdHJBJK
	 h0auiil7imG1WcV2nDuuziUeVKwCTF7BrLxBlSrcxkeJBHc6uElnSju2pnjNw0TYZp
	 I7zsC2VlkFB6MNWsigTWEybThY55+MS4U5/x/cM3+JUt6CUBm0K1KrUnhmeG94M1Ft
	 SCXWVZSV2TaN4upbjHB+1U/m0Kt3CkLh+nuKeRkxaQ0T4ePmCHdLqAh0Us6nZH2L+K
	 ncYMPB83i9ceg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] riscv: support fast gup
Date: Wed, 20 Dec 2023 01:50:42 +0800
Message-Id: <20231219175046.2496-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fast gup support to riscv.

The First patch fixes a bug in __p*d_free_tlb(). Per the riscv
privileged spec, if non-leaf PTEs I.E pmd, pud or p4d is modified, a
sfence.vma is a must.

The 2nd patch is a preparation patch.

The last two patches do the real work:
In order to implement fast gup we need to ensure that the page
table walker is protected from page table pages being freed from
under it.

riscv situation is more complicated than other architectures: some
riscv platforms may use IPI to perform TLB shootdown, for example,
those platforms which support AIA, usually the riscv_ipi_for_rfence is
true on these platforms; some riscv platforms may rely on the SBI to
perform TLB shootdown, usually the riscv_ipi_for_rfence is false on
these platforms. To keep software pagetable walkers safe in this case
we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in
include/asm-generic/tlb.h for more details.

This patch enables MMU_GATHER_RCU_TABLE_FREE, then use

*tlb_remove_page_ptdesc() for those platforms which use IPI to perform
TLB shootdown;

*tlb_remove_ptdesc() for those platforms which use SBI to perform TLB
shootdown;

Both case mean that disabling interrupts will block the free and
protect the fast gup page walker.

So after the 3rd patch, everything is well prepared, let's select
HAVE_FAST_GUP if MMU.

Jisheng Zhang (4):
  riscv: tlb: fix __p*d_free_tlb()
  riscv: tlb: convert __p*d_free_tlb() to inline functions
  riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP && MMU
  riscv: enable HAVE_FAST_GUP if MMU

 arch/riscv/Kconfig               |  2 ++
 arch/riscv/include/asm/pgalloc.h | 53 +++++++++++++++++++++++++++-----
 arch/riscv/include/asm/pgtable.h |  6 ++++
 arch/riscv/include/asm/tlb.h     | 18 +++++++++++
 4 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.40.0


