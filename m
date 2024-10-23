Return-Path: <linux-arch+bounces-8480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3449AD0F8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C802825F4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE671CDFB9;
	Wed, 23 Oct 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdMzqkFo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC961C831A;
	Wed, 23 Oct 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700988; cv=none; b=VRi6oPYSx3/84tnI8RGXj8AApKPO98CW1OWtVkQznMOAlX41uYtA4W53yGTkWHtuJzUg9NADnD8Q7gVcYTR+KFy4RapNpFF+l/xFnyKONPzKUDZzPqKIllssXMujWIYc6HuaGGszteYTc0NQ2pOfrdLfFLb228J/ddCTbTeiwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700988; c=relaxed/simple;
	bh=nyFGHJdxaOJGfMON4ADcqNZmm4B8ZcjCFybfUwv2QVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/+N/KANHtRXodB6IgA+5n0Z7BdAdOrqKJyJF2FMmvgDdXpdr23hhycyMNPxyE2x84A5Ny83C03hi241Ea0TTcu1p/f3vcP9MBr7jb+7eM0OZPQC85Af1mFOdKxg+aSVUeYhOpSdPZoiB1pgHRg1xY2vZFNlwW/wFg6rtUNzJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdMzqkFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049B0C4CEE4;
	Wed, 23 Oct 2024 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729700987;
	bh=nyFGHJdxaOJGfMON4ADcqNZmm4B8ZcjCFybfUwv2QVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CdMzqkFoGWX2b7PqUYjaOLgPsSgx3plKCU2vqNIX57DWGYdA1jQq4ksX86hcp0Ugv
	 TTVaihtq3olFqvVRmH4ux8HQokYedngI7cAAhfPrCPYYsXHZZoiN6pzJ3nAylPiH7K
	 bb3YEyoMAywWZl5IK4NAIOnByYJRe15tMtAbd8c35ogVw5e7dfuIjpFNGGCC1fiF6J
	 /n44T1S2NIJoA2evc0gIvR+SyqVMDPqyfLYX2YcniiVUZMFhNwBT2CtJTAHhahGj3z
	 RBCgFt12Z6rRkFTgodgEgYga72XUQsWs+/9cBfVknah4t5l6IuPX9VAK7YH01aas8U
	 j3vCYJbVvZIxQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v7 8/8] x86/module: enable ROX caches for module text on 64 bit
Date: Wed, 23 Oct 2024 19:27:11 +0300
Message-ID: <20241023162711.2579610-9-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023162711.2579610-1-rppt@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
text allocations on 64 bit.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: kdevops <kdevops@lists.linux.dev>
---
 arch/x86/Kconfig   |  1 +
 arch/x86/mm/init.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..ff71d18253ba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_EXECMEM_ROX		if X86_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f53c319..c2e4f389f47f 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1053,18 +1053,53 @@ unsigned long arch_max_swapfile_size(void)
 #ifdef CONFIG_EXECMEM
 static struct execmem_info execmem_info __ro_after_init;
 
+#ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
+void execmem_fill_trapping_insns(void *ptr, size_t size, bool writeable)
+{
+	/* fill memory with INT3 instructions */
+	if (writeable)
+		memset(ptr, INT3_INSN_OPCODE, size);
+	else
+		text_poke_set(ptr, INT3_INSN_OPCODE, size);
+}
+#endif
+
 struct execmem_info __init *execmem_arch_setup(void)
 {
 	unsigned long start, offset = 0;
+	enum execmem_range_flags flags;
+	pgprot_t pgprot;
 
 	if (kaslr_enabled())
 		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
 
 	start = MODULES_VADDR + offset;
 
+	if (IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX)) {
+		pgprot = PAGE_KERNEL_ROX;
+		flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
+	} else {
+		pgprot = PAGE_KERNEL;
+		flags = EXECMEM_KASAN_SHADOW;
+	}
+
 	execmem_info = (struct execmem_info){
 		.ranges = {
-			[EXECMEM_DEFAULT] = {
+			[EXECMEM_MODULE_TEXT] = {
+				.flags	= flags,
+				.start	= start,
+				.end	= MODULES_END,
+				.pgprot	= pgprot,
+				.alignment = MODULE_ALIGN,
+			},
+			[EXECMEM_KPROBES ... EXECMEM_BPF] = {
+				.flags	= EXECMEM_KASAN_SHADOW,
+				.start	= start,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = MODULE_ALIGN,
+			},
+			[EXECMEM_MODULE_DATA] = {
 				.flags	= EXECMEM_KASAN_SHADOW,
 				.start	= start,
 				.end	= MODULES_END,
-- 
2.43.0


