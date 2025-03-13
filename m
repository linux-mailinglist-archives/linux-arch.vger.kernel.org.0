Return-Path: <linux-arch+bounces-10729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FEA5F6AB
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924F7189F9D2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048A267B93;
	Thu, 13 Mar 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkivtWoT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2F267B62;
	Thu, 13 Mar 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873917; cv=none; b=DGiDiY3IOEs3JZIHgJ/ui8qHFqcuh5g7hIFh2ichm2s8zi3GEJNW1CXDnvlol/sd9v90NF7f2JpfYPhBiv9Vi5nipqy1iQv87jJLG0yrMQO751Ehx5xDx44w+lQEYG97ngyn6Opp7OLT/nf5n5yNA/QupROZpBSIwNPJo2br41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873917; c=relaxed/simple;
	bh=vJ1t8jcOv4IahmAbojjG/hS3bRjZ1yhzZyXAgkQKcCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBAzGs+u6EHZLqXCqMD+m4WQR/g2rGUaLesyf5NWALy249IcE9whNbwYDw/eIjVKOAqciqromZMSsRV5BqypvsfF13mO0ruLzZjfWNLnVq1rbYrz25XRBc2KElhoeReeuCUlsHGOQYYeDBn4dFaQg1SU8sdCW9braooblL3id4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkivtWoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D278CC4CEE5;
	Thu, 13 Mar 2025 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873916;
	bh=vJ1t8jcOv4IahmAbojjG/hS3bRjZ1yhzZyXAgkQKcCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkivtWoTeJzPisCwCmeZ9L2Fz06iBYCw7N7oUdPfSyVbKGHBQSJRQN557ej/tzus0
	 RT9LYZZKsZEuccc831bWhcS16iFVfInWEJvOyu28bZGwYqulYjyTkus9rBocPVvhz4
	 m8zeNcqioCGuPo109d5hVWHgDD9f18aJRE/THVHMZkClmOyxFtvaA5ad1Sbfx5UsQa
	 /mN176Bn7itUz9e8h5ICJhb2Pyd0QqADYzYHfdo8hw/y2vYpPI7xdW6pUdF2K5dqLP
	 rpEfF6BvQYYCTc7YKFjKCOY7th9g+KIym2sJYOE6kTLClyLAp0snpD940nJFfAVx96
	 iFppF0Okn7hYA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v2 07/13] s390: make setup_zero_pages() use memblock
Date: Thu, 13 Mar 2025 15:49:57 +0200
Message-ID: <20250313135003.836600-8-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Allocating the zero pages from memblock is simpler because the memory is
already reserved.

This will also help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/mm/init.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f2298f7a3f21..f8333feb6a7e 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -73,8 +73,6 @@ static void __init setup_zero_pages(void)
 {
 	unsigned long total_pages = memblock_estimated_nr_free_pages();
 	unsigned int order;
-	struct page *page;
-	int i;
 
 	/* Latest machines require a mapping granularity of 512KB */
 	order = 7;
@@ -83,16 +81,7 @@ static void __init setup_zero_pages(void)
 	while (order > 2 && (total_pages >> 10) < (1UL << order))
 		order--;
 
-	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!empty_zero_page)
-		panic("Out of memory in setup_zero_pages");
-
-	page = virt_to_page((void *) empty_zero_page);
-	split_page(page, order);
-	for (i = 1 << order; i > 0; i--) {
-		mark_page_reserved(page);
-		page++;
-	}
+	empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, PAGE_SIZE);
 
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
@@ -176,9 +165,10 @@ void __init mem_init(void)
 	pv_init();
 	kfence_split_mapping();
 
+	setup_zero_pages();	/* Setup zeroed pages. */
+
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-	setup_zero_pages();	/* Setup zeroed pages. */
 }
 
 unsigned long memory_block_size_bytes(void)
-- 
2.47.2


