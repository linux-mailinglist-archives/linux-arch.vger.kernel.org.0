Return-Path: <linux-arch+bounces-10727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E3A5F6A7
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93E13BBD50
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF82E267F79;
	Thu, 13 Mar 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3KxN3gI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E01FBCBF;
	Thu, 13 Mar 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873890; cv=none; b=WEy595eiWSSJDhlNSs48Q1J4xXYC/WkvN8X5DXuDcQdUdkYJTGxox1AN85L/4GdmiU72DJTctTEszGi22yxRRyYh/qQVIVDw4WItC0QX7ybD0Tg/DFzKTV0DS64bZD7uULtlHKYSabRRtRvFQ3zI3uXSNllCDhbKioZtYMLPdno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873890; c=relaxed/simple;
	bh=jdWrizGlyiZZhCc1iHfNv1CsWigRieeHlQFrymlBBDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9qmsTPQXMlv9kCG++/F9gTrqAphcyVTM4dAZbFmP1P8XIvsiln10KcMVPZjrdAxLEpwt+J+xnGuFTUILMsRtBMQO0fxSGvLIkgPLXtjKwwXcjAyypELZvCU0UNUd5IeE9agcQ2iyAhUbELw+4N7/9+HzEOJLGVkuT7IP6nCqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3KxN3gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015EFC4CEF6;
	Thu, 13 Mar 2025 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873889;
	bh=jdWrizGlyiZZhCc1iHfNv1CsWigRieeHlQFrymlBBDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3KxN3gI6tZkgmfjdGzHSgAamoBrtMk5mafHWD0jowj5KlnVnY175VGFXMIdiBWWr
	 B0id/FlW6EUwL50nPhHTxSa3ZYicRa5WCcAVJ1jqVKXm0jic0tczSIN1xHSKcWjdiQ
	 D4zIM9VOnf83gFmBpmn6LKIQhS824VfdxG6Q7Sc5wumpzMv1OC7V7+rYxBizu7Teaz
	 KU/I5rcojMcKt4TssZCQ8zpDNAQK4H9oQKTruuXHVBrx+VpKg8pt85mDQsZo+8ivk2
	 OY1XX/aha854nOI4DZr2fH95T6QTV9et5NHe2RoD4T67D7uTt3ju/gRHLM1ghupdhu
	 a92GRhFxvI5eA==
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
Subject: [PATCH v2 05/13] MIPS: make setup_zero_pages() use memblock
Date: Thu, 13 Mar 2025 15:49:55 +0200
Message-ID: <20250313135003.836600-6-rppt@kernel.org>
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

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/include/asm/mmzone.h |  2 --
 arch/mips/mm/init.c            | 18 +++++-------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index 14226ea42036..602a21aee9d4 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -20,6 +20,4 @@
 #define nid_to_addrbase(nid) 0
 #endif
 
-extern void setup_zero_pages(void);
-
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3db6082c611e..820e35a59d4d 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -59,24 +59,16 @@ EXPORT_SYMBOL(zero_page_mask);
 /*
  * Not static inline because used by IP27 special magic initialization code
  */
-void setup_zero_pages(void)
+static void __init setup_zero_pages(void)
 {
-	unsigned int order, i;
-	struct page *page;
+	unsigned int order;
 
 	if (cpu_has_vce)
 		order = 3;
 	else
 		order = 0;
 
-	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!empty_zero_page)
-		panic("Oh boy, that early out of memory?");
-
-	page = virt_to_page((void *)empty_zero_page);
-	split_page(page, order);
-	for (i = 0; i < (1 << order); i++, page++)
-		mark_page_reserved(page);
+	empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, PAGE_SIZE);
 
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
@@ -470,9 +462,9 @@ void __init mem_init(void)
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (PFN_PTE_SHIFT > PAGE_SHIFT));
 
 	maar_init();
-	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
+	memblock_free_all();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
@@ -486,8 +478,8 @@ void __init mem_init(void)
 void __init mem_init(void)
 {
 	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
 	setup_zero_pages();	/* This comes from node 0 */
+	memblock_free_all();
 }
 #endif /* !CONFIG_NUMA */
 
-- 
2.47.2


