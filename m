Return-Path: <linux-arch+bounces-556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69F7FF075
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 14:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9791C20CDF
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F465482CE;
	Thu, 30 Nov 2023 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdwTyjuW"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9EADD;
	Thu, 30 Nov 2023 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=89DeeaBjwlEE7RwgSFnDKuYif8D8CI/kXtgkrlUTaUQ=; b=qdwTyjuWnwpl943jb8NYbreVkm
	9Y7q0qX2ZluVaT5/NQ7LszGfztCSd78Aud7m/MqyVNeVf2ojf1Pf78i5EG2hCBceTMJZYXLD2ScK5
	dmeA5cBaq/8G0+TW6b4ukbVRrHcCLqCjFE+ICBUodpE3L68Oezn2Gu6edr/27vSyPsShYrybFNnuV
	pk7MXFZJ3lVS4I5WQ+M/Xv5TdKLFqPYny3nZZK4lBI64HYpgyhKdbsgDSHB+PLOB3xysizPLfykzj
	JhWhP9qE7Iotkl07mh4nCySAch7XoCQ85wjT3sOjJaOH8OFom3LH81CHbzPu7mVbbhmzLsd8wWZCX
	fgnaBAjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8hJs-00EUoE-0d; Thu, 30 Nov 2023 13:43:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 5A5923011E8; Thu, 30 Nov 2023 14:43:07 +0100 (CET)
Message-Id: <20231130134204.136058029@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 30 Nov 2023 14:36:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@google.com,
 haoluo@google.com,
 jolsa@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 samitolvanen@google.com,
 keescook@chromium.org,
 nathan@kernel.org,
 ndesaulniers@google.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 jpoimboe@kernel.org,
 joao@overdrivepizza.com,
 mark.rutland@arm.com
Subject: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
References: <20231130133630.192490507@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The current BPF call convention is __nocfi, except when it calls !JIT things,
then it calls regular C functions.

It so happens that with FineIBT the __nocfi and C calling conventions are
incompatible. Specifically __nocfi will call at func+0, while FineIBT will have
endbr-poison there, which is not a valid indirect target. Causing #CP.

Notably this only triggers on IBT enabled hardware, which is probably why this
hasn't been reported (also, most people will have JIT on anyway).

Implement proper CFI prologues for the BPF JIT codegen and drop __nocfi for
x86.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h    |   94 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/alternative.c |   47 +++++++++++++++---
 arch/x86/net/bpf_jit_comp.c   |  108 +++++++++++++++++++++++++++++++++++++-----
 include/linux/bpf.h           |   12 +++-
 kernel/bpf/core.c             |   20 +++++++
 5 files changed, 260 insertions(+), 21 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -9,15 +9,109 @@
  */
 #include <linux/bug.h>
 
+/*
+ * An overview of the various calling conventions...
+ *
+ * Traditional:
+ *
+ * foo:
+ *   ... code here ...
+ *   ret
+ *
+ * direct caller:
+ *   call foo
+ *
+ * indirect caller:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   call *%r11
+ *
+ *
+ * IBT:
+ *
+ * foo:
+ *   endbr64
+ *   ... code here ...
+ *   ret
+ *
+ * direct caller:
+ *   call foo / call foo+4
+ *
+ * indirect caller:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   call *%r11
+ *
+ *
+ * kCFI:
+ *
+ * __cfi_foo:
+ *   movl $0x12345678, %eax
+ *				# 11 nops when CONFIG_CALL_PADDING
+ * foo:
+ *   endbr64			# when IBT
+ *   ... code here ...
+ *   ret
+ *
+ * direct call:
+ *   call foo			# / call foo+4 when IBT
+ *
+ * indirect call:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   movl $(-0x12345678), %r10d
+ *   addl -4(%r11), %r10d	# -15 when CONFIG_CALL_PADDING
+ *   jz   1f
+ *   ud2
+ * 1:call *%r11
+ *
+ *
+ * FineIBT (builds as kCFI + CALL_PADDING + IBT + RETPOLINE and runtime patches into):
+ *
+ * __cfi_foo:
+ *   endbr64
+ *   subl 0x12345678, %r10d
+ *   jz   foo
+ *   ud2
+ *   nop
+ * foo:
+ *   osp nop3			# was endbr64
+ *   ... code here ...
+ *   ret
+ *
+ * direct caller:
+ *   call foo / call foo+4
+ *
+ * indirect caller:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   movl $0x12345678, %r10d
+ *   subl $16, %r11
+ *   nop4
+ *   call *%r11
+ *
+ */
+enum cfi_mode {
+	CFI_DEFAULT,	/* FineIBT if hardware has IBT, otherwise kCFI */
+	CFI_OFF,	/* Taditional / IBT depending on .config */
+	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
+	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
+};
+
+extern enum cfi_mode cfi_mode;
+
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+#define __bpfcall
+extern u32 cfi_bpf_hash;
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
+#define cfi_bpf_hash 0U
 #endif /* CONFIG_CFI_CLANG */
 
 #endif /* _ASM_X86_CFI_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -30,6 +30,7 @@
 #include <asm/fixmap.h>
 #include <asm/paravirt.h>
 #include <asm/asm-prototypes.h>
+#include <asm/cfi.h>
 
 int __read_mostly alternatives_patched;
 
@@ -832,15 +833,43 @@ void __init_or_module apply_seal_endbr(s
 #endif /* CONFIG_X86_KERNEL_IBT */
 
 #ifdef CONFIG_FINEIBT
+#define __CFI_DEFAULT	CFI_DEFAULT
+#elif defined(CONFIG_CFI_CLANG)
+#define __CFI_DEFAULT	CFI_KCFI
+#else
+#define __CFI_DEFAULT	CFI_OFF
+#endif
 
-enum cfi_mode {
-	CFI_DEFAULT,
-	CFI_OFF,
-	CFI_KCFI,
-	CFI_FINEIBT,
-};
+enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+
+#ifdef CONFIG_CFI_CLANG
+struct bpf_insn;
+
+/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
+extern unsigned int __bpf_prog_runX(const void *ctx,
+				    const struct bpf_insn *insn);
+
+/*
+ * Force a reference to the external symbol so the compiler generates
+ * __kcfi_typid.
+ */
+__ADDRESSABLE(__bpf_prog_runX);
+
+/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_hash,@object				\n"
+"	.globl	cfi_bpf_hash					\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_hash:							\n"
+"	.long	__kcfi_typeid___bpf_prog_runX			\n"
+"	.size	cfi_bpf_hash, 4					\n"
+"	.popsection						\n"
+);
+#endif
+
+#ifdef CONFIG_FINEIBT
 
-static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
 static bool cfi_rand __ro_after_init = true;
 static u32  cfi_seed __ro_after_init;
 
@@ -1149,8 +1178,10 @@ static void __apply_fineibt(s32 *start_r
 		goto err;
 
 	if (cfi_rand) {
-		if (builtin)
+		if (builtin) {
 			cfi_seed = get_random_u32();
+			cfi_bpf_hash = cfi_rehash(cfi_bpf_hash);
+		}
 
 		ret = cfi_rand_preamble(start_cfi, end_cfi);
 		if (ret)
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -17,6 +17,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
+#include <asm/cfi.h>
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
@@ -51,9 +52,11 @@ static u8 *emit_code(u8 *ptr, u32 bytes,
 	do { EMIT4(b1, b2, b3, b4); EMIT(off, 4); } while (0)
 
 #ifdef CONFIG_X86_KERNEL_IBT
-#define EMIT_ENDBR()	EMIT(gen_endbr(), 4)
+#define EMIT_ENDBR()		EMIT(gen_endbr(), 4)
+#define EMIT_ENDBR_POISON()	EMIT(gen_endbr_poison(), 4)
 #else
 #define EMIT_ENDBR()
+#define EMIT_ENDBR_POISON()
 #endif
 
 static bool is_imm8(int value)
@@ -247,6 +250,7 @@ struct jit_context {
 	 */
 	int tail_call_direct_label;
 	int tail_call_indirect_label;
+	int prog_offset;
 };
 
 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -305,20 +309,90 @@ static void pop_callee_regs(u8 **pprog,
 }
 
 /*
+ * Emit the various CFI preambles, see asm/cfi.h and the comments about FineIBT
+ * in arch/x86/kernel/alternative.c
+ */
+
+static int emit_fineibt(u8 **pprog)
+{
+	u8 *prog = *pprog;
+
+	EMIT_ENDBR();
+	EMIT3_off32(0x41, 0x81, 0xea, cfi_bpf_hash);	/* subl $hash, %r10d	*/
+	EMIT2(0x74, 0x07);				/* jz.d8 +7		*/
+	EMIT2(0x0f, 0x0b);				/* ud2			*/
+	EMIT1(0x90);					/* nop			*/
+	EMIT_ENDBR_POISON();
+
+	*pprog = prog;
+	return 16;
+}
+
+static int emit_kcfi(u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int offset = 5;
+
+	EMIT1_off32(0xb8, cfi_bpf_hash);		/* movl $hash, %eax	*/
+#ifdef CONFIG_CALL_PADDING
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	EMIT1(0x90);
+	offset += 11;
+#endif
+	EMIT_ENDBR();
+
+	*pprog = prog;
+	return offset;
+}
+
+static int emit_cfi(u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int offset = 0;
+
+	switch (cfi_mode) {
+	case CFI_FINEIBT:
+		offset = emit_fineibt(&prog);
+		break;
+
+	case CFI_KCFI:
+		offset = emit_kcfi(&prog);
+		break;
+
+	default:
+		EMIT_ENDBR();
+		break;
+	}
+
+	*pprog = prog;
+	return offset;
+}
+
+/*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
-static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
-			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+static int emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
+			 bool tail_call_reachable, bool is_subprog,
+			 bool is_exception_cb)
 {
 	u8 *prog = *pprog;
+	int offset;
 
+	offset = emit_cfi(&prog);
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	EMIT_ENDBR();
 	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
@@ -357,6 +431,8 @@ static void emit_prologue(u8 **pprog, u3
 	if (tail_call_reachable)
 		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
+
+	return offset;
 }
 
 static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
@@ -1083,8 +1159,8 @@ static int do_jit(struct bpf_prog *bpf_p
 	bool tail_call_seen = false;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
-	int i, excnt = 0;
 	int ilen, proglen = 0;
+	int i, excnt = 0;
 	u8 *prog = temp;
 	int err;
 
@@ -1094,9 +1170,12 @@ static int do_jit(struct bpf_prog *bpf_p
 	/* tail call's presence in current prog implies it is reachable */
 	tail_call_reachable |= tail_call_seen;
 
-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
-		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+	ctx->prog_offset = emit_prologue(&prog, bpf_prog->aux->stack_depth,
+					 bpf_prog_was_classic(bpf_prog),
+					 tail_call_reachable,
+					 bpf_is_subprog(bpf_prog),
+					 bpf_prog->aux->exception_cb);
+
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -2935,9 +3014,16 @@ struct bpf_prog *bpf_int_jit_compile(str
 			jit_data->header = header;
 			jit_data->rw_header = rw_header;
 		}
-		prog->bpf_func = (void *)image;
+		/*
+		 * ctx.prog_offset is used when CFI preambles put code *before*
+		 * the function. See emit_cfi(). For FineIBT specifically this code
+		 * can also be executed and bpf_prog_kallsyms_add() will
+		 * generate an additional symbol to cover this, hence also
+		 * decrement proglen.
+		 */
+		prog->bpf_func = (void *)image + ctx.prog_offset;
 		prog->jited = 1;
-		prog->jited_len = proglen;
+		prog->jited_len = proglen - ctx.prog_offset;
 	} else {
 		prog = orig_prog;
 	}
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -29,6 +29,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
+#include <linux/cfi.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1188,7 +1189,11 @@ struct bpf_dispatcher {
 #endif
 };
 
-static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
+#ifndef __bpfcall
+#define __bpfcall __nocfi
+#endif
+
+static __always_inline __bpfcall unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	bpf_func_t bpf_func)
@@ -1278,7 +1283,7 @@ int arch_prepare_bpf_dispatcher(void *im
 
 #define DEFINE_BPF_DISPATCHER(name)					\
 	__BPF_DISPATCHER_SC(name);					\
-	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
+	noinline __bpfcall unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		bpf_func_t bpf_func)					\
@@ -1426,6 +1431,9 @@ struct bpf_prog_aux {
 	struct bpf_kfunc_desc_tab *kfunc_tab;
 	struct bpf_kfunc_btf_tab *kfunc_btf_tab;
 	u32 size_poke_tab;
+#ifdef CONFIG_FINEIBT
+	struct bpf_ksym ksym_prefix;
+#endif
 	struct bpf_ksym ksym;
 	const struct bpf_prog_ops *ops;
 	struct bpf_map **used_maps;
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -683,6 +683,23 @@ void bpf_prog_kallsyms_add(struct bpf_pr
 	fp->aux->ksym.prog = true;
 
 	bpf_ksym_add(&fp->aux->ksym);
+
+#ifdef CONFIG_FINEIBT
+	/*
+	 * When FineIBT, code in the __cfi_foo() symbols can get executed
+	 * and hence unwinder needs help.
+	 */
+	if (cfi_mode != CFI_FINEIBT)
+		return;
+
+	snprintf(fp->aux->ksym_prefix.name, KSYM_NAME_LEN,
+		 "__cfi_%s", fp->aux->ksym.name);
+
+	fp->aux->ksym_prefix.start = (unsigned long) fp->bpf_func - 16;
+	fp->aux->ksym_prefix.end   = (unsigned long) fp->bpf_func;
+
+	bpf_ksym_add(&fp->aux->ksym_prefix);
+#endif
 }
 
 void bpf_prog_kallsyms_del(struct bpf_prog *fp)
@@ -691,6 +708,9 @@ void bpf_prog_kallsyms_del(struct bpf_pr
 		return;
 
 	bpf_ksym_del(&fp->aux->ksym);
+#ifdef CONFIG_FINEIBT
+	bpf_ksym_del(&fp->aux->ksym_prefix);
+#endif
 }
 
 static struct bpf_ksym *bpf_ksym_find(unsigned long addr)



