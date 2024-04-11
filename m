Return-Path: <linux-arch+bounces-3587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C688A1BFC
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2325E1F213ED
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7054914EC6F;
	Thu, 11 Apr 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCiKYoZ6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6313AA47;
	Thu, 11 Apr 2024 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851586; cv=none; b=UdIO9VA+KnVUrZrwl6/SkF+9Uvpqr2clFrpRMPgj2qS1mPwh6zPMTvjTSRzQV5Cv+6Hkmns4ormqK7TzN+ZY6EUycWp51f2jRuniLTPxgGO4l99EJYLKKNgkOWpWBzXStxL+z3YgZlA6HwLdAgNQiuWXvbXYLxTO+dFFsbvMrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851586; c=relaxed/simple;
	bh=aqEBZkTkaYczGp1AE5Ythw1GwnOgeya9k56OhW6zvCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwfsKAfMyh9DwcwNW6RaWcZKqTOYcXDTY7CfvA70nAyhRlWFZzvey8oFKoXx3X4Unc4DzCuQo3c6QzJ8aDS/dVnjfV+XjN7um40UeOUUnSpSnZTzoVYni5nF9CDcuvvfouVGPopOYH2/uKzHi2PRgXtMLL/A4BAykHBmA1o/Iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCiKYoZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECE2C072AA;
	Thu, 11 Apr 2024 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851585;
	bh=aqEBZkTkaYczGp1AE5Ythw1GwnOgeya9k56OhW6zvCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCiKYoZ68sls+F3mv6Ez+CsUVYYsX7z9pwgLnoqIj7tyPAICa/XZVRpmFtd/bl+Tc
	 qZlc7udJ4ZNm6hg+lIdRf/t4e0oXKNP+lcjs+/Wpfh4Xtqrr3EQDfJIUEkJ2lIokWe
	 sTkmfvWoJNbC/k0m1M1sM4nLNAgHqf2JWsEelcY4ru/sqfCDrM/De2gJ/gz5e8Uv/i
	 eULjLO4l90aQoexGiFBQMQodDD8FhmYIxLn8lcW3NhsMiXtcIlpC/HwDv2foKAXF0L
	 ejuIF2T7Pa6d42uZkvnZ8/Eew5t0RTPo/ERtD6/7vqcol1STFbKpXTHBXTF4lXoQJG
	 8xTZjAjJzpgbQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [RFC PATCH 5/7] x86/module: perpare module loading for ROX allocations of text
Date: Thu, 11 Apr 2024 19:05:24 +0300
Message-ID: <20240411160526.2093408-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160526.2093408-1-rppt@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

When module text memory will be allocated with ROX permissions, the
memory at the actual address where the module will live will contain
invalid instructions and there will be a writable copy that contains the
actual module code.

Update relocations and alternatives patching to deal with it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/um/kernel/um_arch.c           |  11 ++-
 arch/x86/entry/vdso/vma.c          |   3 +-
 arch/x86/include/asm/alternative.h |  14 +--
 arch/x86/kernel/alternative.c      | 152 +++++++++++++++++------------
 arch/x86/kernel/ftrace.c           |  41 +++++---
 arch/x86/kernel/module.c           |  17 ++--
 6 files changed, 140 insertions(+), 98 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index c5ca89e62552..5183c955974e 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -437,24 +437,25 @@ void __init arch_cpu_finalize_init(void)
 	os_check_bugs();
 }
 
-void apply_seal_endbr(s32 *start, s32 *end)
+void apply_seal_endbr(s32 *start, s32 *end, struct module *mod)
 {
 }
 
-void apply_retpolines(s32 *start, s32 *end)
+void apply_retpolines(s32 *start, s32 *end, struct module *mod)
 {
 }
 
-void apply_returns(s32 *start, s32 *end)
+void apply_returns(s32 *start, s32 *end, struct module *mod)
 {
 }
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-		   s32 *start_cfi, s32 *end_cfi)
+		   s32 *start_cfi, s32 *end_cfi, struct module *mod)
 {
 }
 
-void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
+			struct module *mod)
 {
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 6d83ceb7f1ba..31412adef5d2 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -51,7 +51,8 @@ int __init init_vdso_image(const struct vdso_image *image)
 
 	apply_alternatives((struct alt_instr *)(image->data + image->alt),
 			   (struct alt_instr *)(image->data + image->alt +
-						image->alt_len));
+						image->alt_len),
+			   NULL);
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fcd20c6dc7f9..6f4b0776fc89 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -96,16 +96,16 @@ extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
  * instructions were patched in already:
  */
 extern int alternatives_patched;
+struct module;
 
 extern void alternative_instructions(void);
-extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
-extern void apply_retpolines(s32 *start, s32 *end);
-extern void apply_returns(s32 *start, s32 *end);
-extern void apply_seal_endbr(s32 *start, s32 *end);
+extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
+			       struct module *mod);
+extern void apply_retpolines(s32 *start, s32 *end, struct module *mod);
+extern void apply_returns(s32 *start, s32 *end, struct module *mod);
+extern void apply_seal_endbr(s32 *start, s32 *end, struct module *mod);
 extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
-			  s32 *start_cfi, s32 *end_cfi);
-
-struct module;
+			  s32 *start_cfi, s32 *end_cfi, struct module *mod);
 
 struct callthunk_sites {
 	s32				*call_start, *call_end;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 45a280f2161c..b4d6868df573 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -462,7 +462,8 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
  * to refetch changed I$ lines.
  */
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
-						  struct alt_instr *end)
+						  struct alt_instr *end,
+						  struct module *mod)
 {
 	struct alt_instr *a;
 	u8 *instr, *replacement;
@@ -490,10 +491,18 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * order.
 	 */
 	for (a = start; a < end; a++) {
+		unsigned long ins_offs, repl_offs;
 		int insn_buff_sz = 0;
+		u8 *wr_instr, *wr_replacement;
 
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
+		ins_offs =  module_writable_offset(mod, instr);
+		wr_instr = instr + ins_offs;
+
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
+		repl_offs = module_writable_offset(mod, replacement);
+		wr_replacement = replacement + repl_offs;
+
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
@@ -504,17 +513,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops_inplace(instr, a->instrlen);
+			optimize_nops_inplace(wr_instr, a->instrlen);
 			continue;
 		}
 
-		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
+		DPRINTK(ALT, "feat: %d*32+%d, old: (%px (%px) len: %d), repl: (%px (%px), len: %d) flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->flags);
+			instr, wr_instr, a->instrlen,
+			replacement, wr_replacement, a->replacementlen, a->flags);
 
-		memcpy(insn_buff, replacement, a->replacementlen);
+		memcpy(insn_buff, wr_replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
 		if (a->flags & ALT_FLAG_DIRECT_CALL) {
@@ -528,11 +537,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);
 
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, wr_instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		text_poke_early(wr_instr, insn_buff, insn_buff_sz);
 	}
 
 	kasan_enable_current();
@@ -723,18 +732,20 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 /*
  * Generated by 'objtool --retpoline'.
  */
-void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end,
+						struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		struct insn insn;
 		int len, ret;
 		u8 bytes[16];
 		u8 op1, op2;
 
-		ret = insn_decode_kernel(&insn, addr);
+		ret = insn_decode_kernel(&insn, wr_addr);
 		if (WARN_ON_ONCE(ret < 0))
 			continue;
 
@@ -762,9 +773,9 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
-			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(RETPOLINE, ((u8*)wr_addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RETPOLINE, ((u8*)bytes), len, "%px: repl: ", addr);
-			text_poke_early(addr, bytes, len);
+			text_poke_early(wr_addr, bytes, len);
 		}
 	}
 }
@@ -800,7 +811,8 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 	return i;
 }
 
-void __init_or_module noinline apply_returns(s32 *start, s32 *end)
+void __init_or_module noinline apply_returns(s32 *start, s32 *end,
+					     struct module *mod)
 {
 	s32 *s;
 
@@ -809,12 +821,13 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		struct insn insn;
 		int len, ret;
 		u8 bytes[16];
 		u8 op;
 
-		ret = insn_decode_kernel(&insn, addr);
+		ret = insn_decode_kernel(&insn, wr_addr);
 		if (WARN_ON_ONCE(ret < 0))
 			continue;
 
@@ -834,28 +847,31 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 
 		len = patch_return(addr, &insn, bytes);
 		if (len == insn.length) {
-			DUMP_BYTES(RET, ((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(RET, ((u8*)wr_addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RET, ((u8*)bytes), len, "%px: repl: ", addr);
-			text_poke_early(addr, bytes, len);
+			text_poke_early(wr_addr, bytes, len);
 		}
 	}
 }
 #else
-void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
+void __init_or_module noinline apply_returns(s32 *start, s32 *end,
+					     struct module *mod) { }
 #endif /* CONFIG_MITIGATION_RETHUNK */
 
 #else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
-void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
-void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end,
+						struct module *mod) { }
+void __init_or_module noinline apply_returns(s32 *start, s32 *end,
+					     struct module *mod) { }
 
 #endif /* CONFIG_MITIGATION_RETPOLINE && CONFIG_OBJTOOL */
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-static void poison_cfi(void *addr);
+static void poison_cfi(void *addr, void *wr_addr);
 
-static void __init_or_module poison_endbr(void *addr, bool warn)
+static void __init_or_module poison_endbr(void *addr, void *wr_addr, bool warn)
 {
 	u32 endbr, poison = gen_endbr_poison();
 
@@ -874,7 +890,7 @@ static void __init_or_module poison_endbr(void *addr, bool warn)
 	 */
 	DUMP_BYTES(ENDBR, ((u8*)addr), 4, "%px: orig: ", addr);
 	DUMP_BYTES(ENDBR, ((u8*)&poison), 4, "%px: repl: ", addr);
-	text_poke_early(addr, &poison, 4);
+	text_poke_early(wr_addr, &poison, 4);
 }
 
 /*
@@ -883,22 +899,23 @@ static void __init_or_module poison_endbr(void *addr, bool warn)
  * Seal the functions for indirect calls by clobbering the ENDBR instructions
  * and the kCFI hash value.
  */
-void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
+void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 
-		poison_endbr(addr, true);
+		poison_endbr(addr, wr_addr, true);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_cfi(addr - 16);
+			poison_cfi(addr - 16, wr_addr - 16);
 	}
 }
 
 #else
 
-void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
+void __init_or_module apply_seal_endbr(s32 *start, s32 *end, struct module *mod) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
@@ -1120,7 +1137,7 @@ static u32 decode_caller_hash(void *addr)
 }
 
 /* .retpoline_sites */
-static int cfi_disable_callers(s32 *start, s32 *end)
+static int cfi_disable_callers(s32 *start, s32 *end, struct module *mod)
 {
 	/*
 	 * Disable kCFI by patching in a JMP.d8, this leaves the hash immediate
@@ -1132,6 +1149,7 @@ static int cfi_disable_callers(s32 *start, s32 *end)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		u32 hash;
 
 		addr -= fineibt_caller_size;
@@ -1139,13 +1157,13 @@ static int cfi_disable_callers(s32 *start, s32 *end)
 		if (!hash) /* nocfi callers */
 			continue;
 
-		text_poke_early(addr, jmp, 2);
+		text_poke_early(wr_addr, jmp, 2);
 	}
 
 	return 0;
 }
 
-static int cfi_enable_callers(s32 *start, s32 *end)
+static int cfi_enable_callers(s32 *start, s32 *end, struct module *mod)
 {
 	/*
 	 * Re-enable kCFI, undo what cfi_disable_callers() did.
@@ -1155,6 +1173,7 @@ static int cfi_enable_callers(s32 *start, s32 *end)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		u32 hash;
 
 		addr -= fineibt_caller_size;
@@ -1162,19 +1181,20 @@ static int cfi_enable_callers(s32 *start, s32 *end)
 		if (!hash) /* nocfi callers */
 			continue;
 
-		text_poke_early(addr, mov, 2);
+		text_poke_early(wr_addr, mov, 2);
 	}
 
 	return 0;
 }
 
 /* .cfi_sites */
-static int cfi_rand_preamble(s32 *start, s32 *end)
+static int cfi_rand_preamble(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		u32 hash;
 
 		hash = decode_preamble_hash(addr);
@@ -1183,18 +1203,19 @@ static int cfi_rand_preamble(s32 *start, s32 *end)
 			return -EINVAL;
 
 		hash = cfi_rehash(hash);
-		text_poke_early(addr + 1, &hash, 4);
+		text_poke_early(wr_addr + 1, &hash, 4);
 	}
 
 	return 0;
 }
 
-static int cfi_rewrite_preamble(s32 *start, s32 *end)
+static int cfi_rewrite_preamble(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		u32 hash;
 
 		hash = decode_preamble_hash(addr);
@@ -1202,59 +1223,62 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 			 addr, addr, 5, addr))
 			return -EINVAL;
 
-		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
+		text_poke_early(wr_addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
-		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
+		text_poke_early(wr_addr + fineibt_preamble_hash, &hash, 4);
 	}
 
 	return 0;
 }
 
-static void cfi_rewrite_endbr(s32 *start, s32 *end)
+static void cfi_rewrite_endbr(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 
-		poison_endbr(addr+16, false);
+		poison_endbr(addr+16, wr_addr, false);
 	}
 }
 
 /* .retpoline_sites */
-static int cfi_rand_callers(s32 *start, s32 *end)
+static int cfi_rand_callers(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		u32 hash;
 
 		addr -= fineibt_caller_size;
 		hash = decode_caller_hash(addr);
 		if (hash) {
 			hash = -cfi_rehash(hash);
-			text_poke_early(addr + 2, &hash, 4);
+			text_poke_early(wr_addr + 2, &hash, 4);
 		}
 	}
 
 	return 0;
 }
 
-static int cfi_rewrite_callers(s32 *start, s32 *end)
+static int cfi_rewrite_callers(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		void *wr_addr = addr + module_writable_offset(mod, addr);
 		u32 hash;
 
 		addr -= fineibt_caller_size;
 		hash = decode_caller_hash(addr);
 		if (hash) {
-			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
+			text_poke_early(wr_addr, fineibt_caller_start, fineibt_caller_size);
 			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
-			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+			text_poke_early(wr_addr + fineibt_caller_hash, &hash, 4);
 		}
 		/* rely on apply_retpolines() */
 	}
@@ -1263,8 +1287,9 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 }
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-			    s32 *start_cfi, s32 *end_cfi, bool builtin)
+			    s32 *start_cfi, s32 *end_cfi, struct module *mod)
 {
+	bool builtin = mod ? false : true;
 	int ret;
 
 	if (WARN_ONCE(fineibt_preamble_size != 16,
@@ -1282,7 +1307,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 	 * rewrite them. This disables all CFI. If this succeeds but any of the
 	 * later stages fails, we're without CFI.
 	 */
-	ret = cfi_disable_callers(start_retpoline, end_retpoline);
+	ret = cfi_disable_callers(start_retpoline, end_retpoline, mod);
 	if (ret)
 		goto err;
 
@@ -1293,11 +1318,11 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			cfi_bpf_subprog_hash = cfi_rehash(cfi_bpf_subprog_hash);
 		}
 
-		ret = cfi_rand_preamble(start_cfi, end_cfi);
+		ret = cfi_rand_preamble(start_cfi, end_cfi, mod);
 		if (ret)
 			goto err;
 
-		ret = cfi_rand_callers(start_retpoline, end_retpoline);
+		ret = cfi_rand_callers(start_retpoline, end_retpoline, mod);
 		if (ret)
 			goto err;
 	}
@@ -1309,7 +1334,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		return;
 
 	case CFI_KCFI:
-		ret = cfi_enable_callers(start_retpoline, end_retpoline);
+		ret = cfi_enable_callers(start_retpoline, end_retpoline, mod);
 		if (ret)
 			goto err;
 
@@ -1319,17 +1344,17 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
 	case CFI_FINEIBT:
 		/* place the FineIBT preamble at func()-16 */
-		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
+		ret = cfi_rewrite_preamble(start_cfi, end_cfi, mod);
 		if (ret)
 			goto err;
 
 		/* rewrite the callers to target func()-16 */
-		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
+		ret = cfi_rewrite_callers(start_retpoline, end_retpoline, mod);
 		if (ret)
 			goto err;
 
 		/* now that nobody targets func()+0, remove ENDBR there */
-		cfi_rewrite_endbr(start_cfi, end_cfi);
+		cfi_rewrite_endbr(start_cfi, end_cfi, mod);
 
 		if (builtin)
 			pr_info("Using FineIBT CFI\n");
@@ -1348,7 +1373,7 @@ static inline void poison_hash(void *addr)
 	*(u32 *)addr = 0;
 }
 
-static void poison_cfi(void *addr)
+static void poison_cfi(void *addr, void *wr_addr)
 {
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
@@ -1360,8 +1385,8 @@ static void poison_cfi(void *addr)
 		 *	ud2
 		 * 1:	nop
 		 */
-		poison_endbr(addr, false);
-		poison_hash(addr + fineibt_preamble_hash);
+		poison_endbr(addr, wr_addr, false);
+		poison_hash(wr_addr + fineibt_preamble_hash);
 		break;
 
 	case CFI_KCFI:
@@ -1370,7 +1395,7 @@ static void poison_cfi(void *addr)
 		 *	movl	$0, %eax
 		 *	.skip	11, 0x90
 		 */
-		poison_hash(addr + 1);
+		poison_hash(wr_addr + 1);
 		break;
 
 	default:
@@ -1381,22 +1406,21 @@ static void poison_cfi(void *addr)
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-			    s32 *start_cfi, s32 *end_cfi, bool builtin)
+			    s32 *start_cfi, s32 *end_cfi, struct module *mod)
 {
 }
 
 #ifdef CONFIG_X86_KERNEL_IBT
-static void poison_cfi(void *addr) { }
+static void poison_cfi(void *addr, void *wr_addr) { }
 #endif
 
 #endif
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-		   s32 *start_cfi, s32 *end_cfi)
+		   s32 *start_cfi, s32 *end_cfi, struct module *mod)
 {
 	return __apply_fineibt(start_retpoline, end_retpoline,
-			       start_cfi, end_cfi,
-			       /* .builtin = */ false);
+			       start_cfi, end_cfi, mod);
 }
 
 #ifdef CONFIG_SMP
@@ -1693,16 +1717,16 @@ void __init alternative_instructions(void)
 	paravirt_set_cap();
 
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
-			__cfi_sites, __cfi_sites_end, true);
+			__cfi_sites, __cfi_sites_end, NULL);
 
 	/*
 	 * Rewrite the retpolines, must be done before alternatives since
 	 * those can rewrite the retpoline thunks.
 	 */
-	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
-	apply_returns(__return_sites, __return_sites_end);
+	apply_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
+	apply_returns(__return_sites, __return_sites_end, NULL);
 
-	apply_alternatives(__alt_instructions, __alt_instructions_end);
+	apply_alternatives(__alt_instructions, __alt_instructions_end, NULL);
 
 	/*
 	 * Now all calls are established. Apply the call thunks if
@@ -1713,7 +1737,7 @@ void __init alternative_instructions(void)
 	/*
 	 * Seal all functions that do not have their address taken.
 	 */
-	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
+	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end, NULL);
 
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8da0e66ca22d..563d9a890ce2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -118,10 +118,13 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 		return ret;
 
 	/* replace the text with the new text */
-	if (ftrace_poke_late)
+	if (ftrace_poke_late) {
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
-	else
-		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
+	} else {
+		mutex_lock(&text_mutex);
+		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
+		mutex_unlock(&text_mutex);
+	}
 	return 0;
 }
 
@@ -318,7 +321,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
 	union ftrace_op_code_union op_ptr;
-	int ret;
+	void *ret;
 
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 		start_offset = (unsigned long)ftrace_regs_caller;
@@ -349,15 +352,15 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
-	ret = copy_from_kernel_nofault(trampoline, (void *)start_offset, size);
-	if (WARN_ON(ret < 0))
+	ret = text_poke_copy(trampoline, (void *)start_offset, size);
+	if (WARN_ON(!ret))
 		goto fail;
 
 	ip = trampoline + size;
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
 		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
-		memcpy(ip, retq, sizeof(retq));
+		text_poke_copy(ip, retq, sizeof(retq));
 
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
@@ -365,8 +368,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		ret = copy_from_kernel_nofault(ip, x86_nops[2], 2);
-		if (ret < 0)
+		if (!text_poke_copy(ip, x86_nops[2], 2))
 			goto fail;
 	}
 
@@ -379,7 +381,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 */
 
 	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
-	*ptr = (unsigned long)ops;
+	text_poke_copy(ptr, &ops, sizeof(unsigned long));
 
 	op_offset -= start_offset;
 	memcpy(&op_ptr, trampoline + op_offset, OP_REF_SIZE);
@@ -395,7 +397,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	op_ptr.offset = offset;
 
 	/* put in the new offset to the ftrace_ops */
-	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
+	text_poke_copy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
 	/* put in the call to the function */
 	mutex_lock(&text_mutex);
@@ -405,9 +407,9 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the depth accounting before the call already.
 	 */
 	dest = ftrace_ops_get_func(ops);
-	memcpy(trampoline + call_offset,
-	       text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
-	       CALL_INSN_SIZE);
+	text_poke_copy_locked(trampoline + call_offset,
+	      text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
+	      CALL_INSN_SIZE, false);
 	mutex_unlock(&text_mutex);
 
 	/* ALLOC_TRAMP flags lets us know we created it */
@@ -654,4 +656,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 }
 #endif
 
+void ftrace_swap_func(void *a, void *b, int n)
+{
+	unsigned long t;
+
+	WARN_ON_ONCE(n != sizeof(t));
+
+	t = *((unsigned long *)a);
+	text_poke_copy(a, b, sizeof(t));
+	text_poke_copy(b, &t, sizeof(t));
+}
+
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 837450b6e882..30eed5228f44 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -146,18 +146,21 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 		}
 
 		if (apply) {
-			if (memcmp(loc, &zero, size)) {
+			void *wr_loc = loc + module_writable_offset(me, loc);
+
+			if (memcmp(wr_loc, &zero, size)) {
 				pr_err("x86/modules: Invalid relocation target, existing value is nonzero for type %d, loc %p, val %Lx\n",
 				       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
 				return -ENOEXEC;
 			}
-			write(loc, &val, size);
+			write(wr_loc, &val, size);
 		} else {
 			if (memcmp(loc, &val, size)) {
 				pr_warn("x86/modules: Invalid relocation target, existing value does not match expected value for type %d, loc %p, val %Lx\n",
 					(int)ELF64_R_TYPE(rel[i].r_info), loc, val);
 				return -ENOEXEC;
 			}
+			/* FIXME: needs care for ROX module allocations */
 			write(loc, &zero, size);
 		}
 	}
@@ -265,20 +268,20 @@ int module_finalize(const Elf_Ehdr *hdr,
 			csize = cfi->sh_size;
 		}
 
-		apply_fineibt(rseg, rseg + rsize, cseg, cseg + csize);
+		apply_fineibt(rseg, rseg + rsize, cseg, cseg + csize, me);
 	}
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
-		apply_retpolines(rseg, rseg + retpolines->sh_size);
+		apply_retpolines(rseg, rseg + retpolines->sh_size, me);
 	}
 	if (returns) {
 		void *rseg = (void *)returns->sh_addr;
-		apply_returns(rseg, rseg + returns->sh_size);
+		apply_returns(rseg, rseg + returns->sh_size, me);
 	}
 	if (alt) {
 		/* patch .altinstructions */
 		void *aseg = (void *)alt->sh_addr;
-		apply_alternatives(aseg, aseg + alt->sh_size);
+		apply_alternatives(aseg, aseg + alt->sh_size, me);
 	}
 	if (calls || alt) {
 		struct callthunk_sites cs = {};
@@ -297,7 +300,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
-		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
+		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size, me);
 	}
 	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
-- 
2.43.0


