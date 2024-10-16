Return-Path: <linux-arch+bounces-8230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5F9A09C1
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252E51C21168
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D06B20C03E;
	Wed, 16 Oct 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewgSS7JQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FD20821C;
	Wed, 16 Oct 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081625; cv=none; b=s38+MPhnutUqUtm0FqgK7HuElUjrN3z/XJYpnGkenQMOPVAb+8cucCTVvG2oV34ixVp9h6FD1LdHM++3A7+PGdkwlnQjodM/5lOpcrrM4CI6tTnUVzqtsvdzpS9wNf0WYeM4DK8b7FJYVmwsLyjPAuskVBXjgULupFYEp+J04ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081625; c=relaxed/simple;
	bh=eY6kLN8OlN+AhPSjfqE9l5XEI+8YBmb961qfGDylvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsXymXiubOq2IXvnyu0Yr9ixv0wQBG5QA74AwF064eBSsVSagv3o/B/N/i8zUZN+ztAOY2SNdNuXtQO7boiCqt0izGETpatR+l3wTHFsr4fcJCOEWD2FG1khESIXBR34hzAbsR2cjO+P5BvGN3HrMhlayBnoNyIiE8OiIYp8CZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewgSS7JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4677BC4CECF;
	Wed, 16 Oct 2024 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729081624;
	bh=eY6kLN8OlN+AhPSjfqE9l5XEI+8YBmb961qfGDylvwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewgSS7JQnctq7Hgrv3uuVnVef5NJ6/W1nB36pkS9n4SMtyIyVrElKtKyFF1q0jkpP
	 EsFcTPX0SKB8iugJZ8fG/3GbaKQ9JTTxiSf0x8Je0VGHSki/f8KCPFSVhlw3IAbCgq
	 dHZxxLb3XDQt5YWY63oWKwfSJfIRrZ4ETnxR7W4suuZEwzrS9kg5Y5qEjXIsmjEAIc
	 d+qNLfS/dkDTekE3774d/xn4huY0MjrfXRLRM5fT0pICnGA4BMmSBqBpOwDvhxDH7h
	 lEAtUAvDJvuqN4dGETbbq15U4XHTm20JcFbizm6eRWYoC4wDxNk9mafVHZRkNrpKww
	 GhffryNbJ3RBQ==
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
Subject: [PATCH v6 8/8] x86/module: enable ROX caches for module text on 64 bit
Date: Wed, 16 Oct 2024 15:24:24 +0300
Message-ID: <20241016122424.1655560-9-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016122424.1655560-1-rppt@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
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


