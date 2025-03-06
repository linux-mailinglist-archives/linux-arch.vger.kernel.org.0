Return-Path: <linux-arch+bounces-10548-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F77A555B6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D643118940B7
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7E26E657;
	Thu,  6 Mar 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H78DLSl+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50D26D5B8;
	Thu,  6 Mar 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287199; cv=none; b=n+Vp+u9o068wRW/L2ptf74LJIfEq3Wr6cRoMHTzvkvnFSMNUbKxZ1yxQ4W0E2PFyFlXFOCO4d+AGOBLuUHTz6tfgr4ZE3A25agivwFv2P+ASCVp6mu9cRXvo0a/qmHxZdQgepImcsQ+e+t7nomknClGjl34UkccCDKfcRhL3l1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287199; c=relaxed/simple;
	bh=BkE0IFJXSKU77+xC0N2TBlUULdAjqoteouUfp8/gZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOJEUbDc5VTXhMKFFkwcLyNkEnniRcwHEdYCIKD4YLort4JhAO1LujxNFslMYglrJFpsi77x2oVXzeqeZlC4ogtB5GvUgKxKFoBdksrASQPDdQMK9TGCVTrVjcZxxJyuKXTV527sQscgm55QzNGtxlC5FIvIMIbCcwHRxEQT0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H78DLSl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8163DC4CEE8;
	Thu,  6 Mar 2025 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287197;
	bh=BkE0IFJXSKU77+xC0N2TBlUULdAjqoteouUfp8/gZ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H78DLSl+IjdnXrOdxgT+/xt6JTBU4euW24C/yDa5I+IadYyC+HEIKf8v9/STSql0w
	 8Ci9p73t1w+Xz+YHbbWW0NqRvPAsTTGgkup9RJxFt3IWYCiwU8KzktKs78WPfgstEp
	 r3TBxtlGs5W73C+QSyCEERn1fqDTHnrNMca8jScShJM1AOJsNrVThziirlU9DWuCQI
	 NxI/6QapAZIvA0iPZvBo0oljP9L1r5qcoH4ZPCXNbth214GQA4i6M5RW8Tday7NHzb
	 PgoPccIN87hXyD3eA9w781HCQ9lk9kdOFTozIS7Gy/SywY4wv8FVfsBzQ613ahQ7F+
	 9OZnlgrDMKwRQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH 07/13] s390: make setup_zero_pages() use memblock
Date: Thu,  6 Mar 2025 20:51:17 +0200
Message-ID: <20250306185124.3147510-8-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
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

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/mm/init.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f2298f7a3f21..020aa2f78d01 100644
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
@@ -83,17 +81,10 @@ static void __init setup_zero_pages(void)
 	while (order > 2 && (total_pages >> 10) < (1UL << order))
 		order--;
 
-	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
 	if (!empty_zero_page)
 		panic("Out of memory in setup_zero_pages");
 
-	page = virt_to_page((void *) empty_zero_page);
-	split_page(page, order);
-	for (i = 1 << order; i > 0; i--) {
-		mark_page_reserved(page);
-		page++;
-	}
-
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
 
@@ -176,9 +167,10 @@ void __init mem_init(void)
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


