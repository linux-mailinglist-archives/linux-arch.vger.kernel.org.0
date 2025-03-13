Return-Path: <linux-arch+bounces-10730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04CA5F6D6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DAE3A7CF2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646926869F;
	Thu, 13 Mar 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkCN8WEi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53947267F74;
	Thu, 13 Mar 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873930; cv=none; b=cyVhUICiSr+4RDjzml0mPwveWqFgo8tBkclLlzZYL9olP+ov7kywr/WQhf8d5llKTX71reZyCPpqlI/EAy3uO29ld+Dc9tt2TBjypzUq6yw6ou6xww7hDsuKSzu+VTgyoIsMF56aMWuGcQK+Sd7Z4xKT0rVYu0RGowhhGOSXHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873930; c=relaxed/simple;
	bh=Af9gKlZIDExjo3NK0sfX49tiYlvs18loCfa3z4qCS4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgvoq+3cec70oEUrZgpipOMFVVJeonZgPvDAi00yTK+DjDZYeD0RhySzQZw1LAYNXAqvOHbm5WEY+4hTlRtgKDBrHDV2VVk95SMHAfoQvBtkesW84vjlZu1fX/j+H9cYzP66lVIj1FnL5Bv/bPJvfg3XolLdGXtal4yFgeP0iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkCN8WEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47360C4CEEA;
	Thu, 13 Mar 2025 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873930;
	bh=Af9gKlZIDExjo3NK0sfX49tiYlvs18loCfa3z4qCS4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkCN8WEiZBDjOoNXkOEhfAhooerV5dkF2AGCJWQINBT3fsaxpVBZFUOQ//qEwjrlr
	 2bPNOWsGN1jhMAGqtWghdbP/jbKVpjyzoCccZNeP956MHM+FvQnV9vxHUVxRi1f57Z
	 Cy2YUjxboCWMf8Ik4jDKpmCaERo0psIxJMx1djt5KJO5hJIfLq+Tx6yluPloxucc9B
	 6OYJdeY4IAXQhLphwpYrBpClaEiHNJqeML3xePGY/xtE3X+oYEZbMNo1hpUyjyziIo
	 HNC9zwJ99nOKR2UIM2I44zSMPyeB7SMX8Wiy499daNzgPSdZFBmii2RnjlN8BaRWiJ
	 bOL4XjeNb0D3Q==
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
Subject: [PATCH v2 08/13] xtensa: split out printing of virtual memory layout to a function
Date: Thu, 13 Mar 2025 15:49:58 +0200
Message-ID: <20250313135003.836600-9-rppt@kernel.org>
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

This will help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/xtensa/mm/init.c | 97 ++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index b2587a1a7c46..01577d33e602 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -66,6 +66,55 @@ void __init bootmem_init(void)
 	memblock_dump_all();
 }
 
+static void __init print_vm_layout(void)
+{
+	pr_info("virtual kernel memory layout:\n"
+#ifdef CONFIG_KASAN
+		"    kasan   : 0x%08lx - 0x%08lx  (%5lu MB)\n"
+#endif
+#ifdef CONFIG_MMU
+		"    vmalloc : 0x%08lx - 0x%08lx  (%5lu MB)\n"
+#endif
+#ifdef CONFIG_HIGHMEM
+		"    pkmap   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+		"    fixmap  : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+#endif
+		"    lowmem  : 0x%08lx - 0x%08lx  (%5lu MB)\n"
+		"    .text   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+		"    .rodata : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+		"    .data   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+		"    .init   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+		"    .bss    : 0x%08lx - 0x%08lx  (%5lu kB)\n",
+#ifdef CONFIG_KASAN
+		KASAN_SHADOW_START, KASAN_SHADOW_START + KASAN_SHADOW_SIZE,
+		KASAN_SHADOW_SIZE >> 20,
+#endif
+#ifdef CONFIG_MMU
+		VMALLOC_START, VMALLOC_END,
+		(VMALLOC_END - VMALLOC_START) >> 20,
+#ifdef CONFIG_HIGHMEM
+		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
+		(LAST_PKMAP*PAGE_SIZE) >> 10,
+		FIXADDR_START, FIXADDR_END,
+		(FIXADDR_END - FIXADDR_START) >> 10,
+#endif
+		PAGE_OFFSET, PAGE_OFFSET +
+		(max_low_pfn - min_low_pfn) * PAGE_SIZE,
+#else
+		min_low_pfn * PAGE_SIZE, max_low_pfn * PAGE_SIZE,
+#endif
+		((max_low_pfn - min_low_pfn) * PAGE_SIZE) >> 20,
+		(unsigned long)_text, (unsigned long)_etext,
+		(unsigned long)(_etext - _text) >> 10,
+		(unsigned long)__start_rodata, (unsigned long)__end_rodata,
+		(unsigned long)(__end_rodata - __start_rodata) >> 10,
+		(unsigned long)_sdata, (unsigned long)_edata,
+		(unsigned long)(_edata - _sdata) >> 10,
+		(unsigned long)__init_begin, (unsigned long)__init_end,
+		(unsigned long)(__init_end - __init_begin) >> 10,
+		(unsigned long)__bss_start, (unsigned long)__bss_stop,
+		(unsigned long)(__bss_stop - __bss_start) >> 10);
+}
 
 void __init zones_init(void)
 {
@@ -77,6 +126,7 @@ void __init zones_init(void)
 #endif
 	};
 	free_area_init(max_zone_pfn);
+	print_vm_layout();
 }
 
 static void __init free_highpages(void)
@@ -118,53 +168,6 @@ void __init mem_init(void)
 	high_memory = (void *)__va(max_low_pfn << PAGE_SHIFT);
 
 	memblock_free_all();
-
-	pr_info("virtual kernel memory layout:\n"
-#ifdef CONFIG_KASAN
-		"    kasan   : 0x%08lx - 0x%08lx  (%5lu MB)\n"
-#endif
-#ifdef CONFIG_MMU
-		"    vmalloc : 0x%08lx - 0x%08lx  (%5lu MB)\n"
-#endif
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
-		"    fixmap  : 0x%08lx - 0x%08lx  (%5lu kB)\n"
-#endif
-		"    lowmem  : 0x%08lx - 0x%08lx  (%5lu MB)\n"
-		"    .text   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
-		"    .rodata : 0x%08lx - 0x%08lx  (%5lu kB)\n"
-		"    .data   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
-		"    .init   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
-		"    .bss    : 0x%08lx - 0x%08lx  (%5lu kB)\n",
-#ifdef CONFIG_KASAN
-		KASAN_SHADOW_START, KASAN_SHADOW_START + KASAN_SHADOW_SIZE,
-		KASAN_SHADOW_SIZE >> 20,
-#endif
-#ifdef CONFIG_MMU
-		VMALLOC_START, VMALLOC_END,
-		(VMALLOC_END - VMALLOC_START) >> 20,
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
-		(LAST_PKMAP*PAGE_SIZE) >> 10,
-		FIXADDR_START, FIXADDR_END,
-		(FIXADDR_END - FIXADDR_START) >> 10,
-#endif
-		PAGE_OFFSET, PAGE_OFFSET +
-		(max_low_pfn - min_low_pfn) * PAGE_SIZE,
-#else
-		min_low_pfn * PAGE_SIZE, max_low_pfn * PAGE_SIZE,
-#endif
-		((max_low_pfn - min_low_pfn) * PAGE_SIZE) >> 20,
-		(unsigned long)_text, (unsigned long)_etext,
-		(unsigned long)(_etext - _text) >> 10,
-		(unsigned long)__start_rodata, (unsigned long)__end_rodata,
-		(unsigned long)(__end_rodata - __start_rodata) >> 10,
-		(unsigned long)_sdata, (unsigned long)_edata,
-		(unsigned long)(_edata - _sdata) >> 10,
-		(unsigned long)__init_begin, (unsigned long)__init_end,
-		(unsigned long)(__init_end - __init_begin) >> 10,
-		(unsigned long)__bss_start, (unsigned long)__bss_stop,
-		(unsigned long)(__bss_stop - __bss_start) >> 10);
 }
 
 static void __init parse_memmap_one(char *p)
-- 
2.47.2


