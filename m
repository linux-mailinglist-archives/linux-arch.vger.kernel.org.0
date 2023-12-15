Return-Path: <linux-arch+bounces-1074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20CA814494
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4A22841FC
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4230179A2;
	Fri, 15 Dec 2023 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jFpUSyeM"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0252288DD;
	Fri, 15 Dec 2023 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MCUZcifVBbh4jTlbDrOicZht7hCfL66Ib8nwra146uo=; b=jFpUSyeMwgLTWbV2PALOxZGQbm
	wiV8p/KxPLfG27bxfj82u2/yxJHqajdUlKgK6kcMqwSE8YJ9kT0sRDKZtDqIVofQrjpldY7cjj27M
	JKKxHWCIpnCSY4tRV8kZwsxVxwvxwsvaCLKynjvG+sUxGOvtLPO3M5jHmNkym6nXTzC6UPPZ9xifs
	PFnw/WrzeCidbA6/2PJrHyG5oX8tDm8AKwtPd+dt5w8tED75xicumn1hIxsB+ai7hGoVTGx+J6tzB
	72FZozFY5yGacMn/luTcaXmCmUGLYVkHCj8qcEL0I83ycPRoEpfToUAK1oLfzuzjMfBYSAvCPl+Zd
	Gk/zCnIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4ZE-009rFy-0d;
	Fri, 15 Dec 2023 09:33:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D18BE300940; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215092707.566977112@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 mark.rutland@arm.com,
 peterz@infradead.org
Subject: [PATCH v3 4/7] x86/cfi,bpf: Fix bpf_struct_ops CFI
References: <20231215091216.135791411@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

BPF struct_ops uses __arch_prepare_bpf_trampoline() to write
trampolines for indirect function calls. These tramplines much have
matching CFI.

In order to obtain the correct CFI hash for the various methods, add a
matching structure that contains stub functions, the compiler will
generate correct CFI which we can pilfer for the trampolines.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h     |    6 +++
 arch/x86/kernel/alternative.c  |   22 +++++++++++++
 arch/x86/net/bpf_jit_comp.c    |   66 +++++++++++++++++++++++++--------------
 include/linux/bpf.h            |   13 +++++++
 kernel/bpf/bpf_struct_ops.c    |   16 ++++-----
 net/bpf/bpf_dummy_struct_ops.c |   31 +++++++++++++++++-
 net/ipv4/bpf_tcp_ca.c          |   69 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 191 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -123,6 +123,8 @@ static inline int cfi_get_offset(void)
 }
 #define cfi_get_offset cfi_get_offset
 
+extern u32 cfi_get_func_hash(void *func);
+
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
@@ -130,6 +132,10 @@ static inline enum bug_trap_type handle_
 }
 #define cfi_bpf_hash 0U
 #define cfi_bpf_subprog_hash 0U
+static inline u32 cfi_get_func_hash(void *func)
+{
+	return 0;
+}
 #endif /* CONFIG_CFI_CLANG */
 
 #endif /* _ASM_X86_CFI_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -883,6 +883,28 @@ asm (
 "	.size	cfi_bpf_subprog_hash, 4				\n"
 "	.popsection						\n"
 );
+
+u32 cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	func -= cfi_get_offset();
+	switch (cfi_mode) {
+	case CFI_FINEIBT:
+		func += 7;
+		break;
+	case CFI_KCFI:
+		func += 1;
+		break;
+	default:
+		return 0;
+	}
+
+	if (get_kernel_nofault(hash, func))
+		return 0;
+
+	return hash;
+}
 #endif
 
 #ifdef CONFIG_FINEIBT
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -312,9 +312,8 @@ static void pop_callee_regs(u8 **pprog,
  * in arch/x86/kernel/alternative.c
  */
 
-static void emit_fineibt(u8 **pprog, bool is_subprog)
+static void emit_fineibt(u8 **pprog, u32 hash)
 {
-	u32 hash = is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash;
 	u8 *prog = *pprog;
 
 	EMIT_ENDBR();
@@ -327,9 +326,8 @@ static void emit_fineibt(u8 **pprog, boo
 	*pprog = prog;
 }
 
-static void emit_kcfi(u8 **pprog, bool is_subprog)
+static void emit_kcfi(u8 **pprog, u32 hash)
 {
-	u32 hash = is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash;
 	u8 *prog = *pprog;
 
 	EMIT1_off32(0xb8, hash);			/* movl $hash, %eax	*/
@@ -351,17 +349,17 @@ static void emit_kcfi(u8 **pprog, bool i
 	*pprog = prog;
 }
 
-static void emit_cfi(u8 **pprog, bool is_subprog)
+static void emit_cfi(u8 **pprog, u32 hash)
 {
 	u8 *prog = *pprog;
 
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		emit_fineibt(&prog, is_subprog);
+		emit_fineibt(&prog, hash);
 		break;
 
 	case CFI_KCFI:
-		emit_kcfi(&prog, is_subprog);
+		emit_kcfi(&prog, hash);
 		break;
 
 	default:
@@ -383,7 +381,7 @@ static void emit_prologue(u8 **pprog, u3
 {
 	u8 *prog = *pprog;
 
-	emit_cfi(&prog, is_subprog);
+	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
@@ -2510,10 +2508,19 @@ static int __arch_prepare_bpf_trampoline
 	u8 *prog;
 	bool save_ret;
 
+	/*
+	 * F_INDIRECT is only compatible with F_RET_FENTRY_RET, it is
+	 * explicitly incompatible with F_CALL_ORIG | F_SKIP_FRAME | F_IP_ARG
+	 * because @func_addr.
+	 */
+	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
+		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
+
 	/* extra registers for struct arguments */
-	for (i = 0; i < m->nr_args; i++)
+	for (i = 0; i < m->nr_args; i++) {
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
 			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
+	}
 
 	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
 	 * are passed through regs, the remains are through stack.
@@ -2596,20 +2603,27 @@ static int __arch_prepare_bpf_trampoline
 
 	prog = rw_image;
 
-	EMIT_ENDBR();
-	/*
-	 * This is the direct-call trampoline, as such it needs accounting
-	 * for the __fentry__ call.
-	 */
-	x86_call_depth_emit_accounting(&prog, NULL);
+	if (flags & BPF_TRAMP_F_INDIRECT) {
+		/*
+		 * Indirect call for bpf_struct_ops
+		 */
+		emit_cfi(&prog, cfi_get_func_hash(func_addr));
+	} else {
+		/*
+		 * Direct-call fentry stub, as such it needs accounting for the
+		 * __fentry__ call.
+		 */
+		x86_call_depth_emit_accounting(&prog, NULL);
+	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-	if (!is_imm8(stack_size))
+	if (!is_imm8(stack_size)) {
 		/* sub rsp, stack_size */
 		EMIT3_off32(0x48, 0x81, 0xEC, stack_size);
-	else
+	} else {
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	}
 	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
@@ -2643,10 +2657,11 @@ static int __arch_prepare_bpf_trampoline
 		}
 	}
 
-	if (fentry->nr_links)
+	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
 			return -EINVAL;
+	}
 
 	if (fmod_ret->nr_links) {
 		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
@@ -2665,11 +2680,12 @@ static int __arch_prepare_bpf_trampoline
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true);
 
-		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, restore the
 			 * tail_call_cnt from stack to rax.
 			 */
 			RESTORE_TAIL_CALL_CNT(stack_size);
+		}
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
@@ -2698,17 +2714,19 @@ static int __arch_prepare_bpf_trampoline
 		/* Update the branches saved in invoke_bpf_mod_ret with the
 		 * aligned address of do_fexit.
 		 */
-		for (i = 0; i < fmod_ret->nr_links; i++)
+		for (i = 0; i < fmod_ret->nr_links; i++) {
 			emit_cond_near_jump(&branches[i], image + (prog - (u8 *)rw_image),
 					    image + (branches[i] - (u8 *)rw_image), X86_JNE);
+		}
 	}
 
-	if (fexit->nr_links)
+	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
 			       false, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
+	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, regs_off);
@@ -2725,11 +2743,12 @@ static int __arch_prepare_bpf_trampoline
 			ret = -EINVAL;
 			goto cleanup;
 		}
-	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 		/* Before running the original function, restore the
 		 * tail_call_cnt from stack to rax.
 		 */
 		RESTORE_TAIL_CALL_CNT(stack_size);
+	}
 
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
@@ -2737,9 +2756,10 @@ static int __arch_prepare_bpf_trampoline
 
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
-	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip our return address and return to parent */
 		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
+	}
 	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
 	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1060,6 +1060,17 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
 
+/*
+ * Indicate the trampoline should be suitable to receive indirect calls;
+ * without this indirectly calling the generated code can result in #UD/#CP,
+ * depending on the CFI options.
+ *
+ * Used by bpf_struct_ops.
+ *
+ * Incompatible with FENTRY usage, overloads @func_addr argument.
+ */
+#define BPF_TRAMP_F_INDIRECT		BIT(8)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
@@ -1695,6 +1706,7 @@ struct bpf_struct_ops {
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 	u32 type_id;
 	u32 value_id;
+	void *cfi_stubs;
 };
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
@@ -1708,6 +1720,7 @@ int bpf_struct_ops_map_sys_lookup_elem(s
 int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
+				      void *stub_func,
 				      void *image, void *image_end);
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -352,17 +352,16 @@ const struct bpf_link_ops bpf_struct_ops
 int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
-				      void *image, void *image_end)
+				      void *stub_func, void *image, void *image_end)
 {
-	u32 flags;
+	u32 flags = BPF_TRAMP_F_INDIRECT;
 	int size;
 
 	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
 	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
-	/* BPF_TRAMP_F_RET_FENTRY_RET is only used by bpf_struct_ops,
-	 * and it must be used alone.
-	 */
-	flags = model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
+
+	if (model->ret_size > 0)
+		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
 	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
 	if (size < 0)
@@ -370,7 +369,7 @@ int bpf_struct_ops_prepare_trampoline(st
 	if (size > (unsigned long)image_end - (unsigned long)image)
 		return -E2BIG;
 	return arch_prepare_bpf_trampoline(NULL, image, image_end,
-					   model, flags, tlinks, NULL);
+					   model, flags, tlinks, stub_func);
 }
 
 static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
@@ -504,11 +503,12 @@ static long bpf_struct_ops_map_update_el
 
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 							&st_ops->func_models[i],
+							*(void **)(st_ops->cfi_stubs + moff),
 							image, image_end);
 		if (err < 0)
 			goto reset_unlock;
 
-		*(void **)(kdata + moff) = image;
+		*(void **)(kdata + moff) = image + cfi_get_offset();
 		image += err;
 
 		/* put prog_id to udata */
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -12,6 +12,11 @@ extern struct bpf_struct_ops bpf_bpf_dum
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
 
+static int dummy_ops_test_ret_function(struct bpf_dummy_ops_state *state, ...)
+{
+	return 0;
+}
+
 struct bpf_dummy_ops_test_args {
 	u64 args[MAX_BPF_FUNC_ARGS];
 	struct bpf_dummy_ops_state state;
@@ -62,7 +67,7 @@ static int dummy_ops_copy_args(struct bp
 
 static int dummy_ops_call_op(void *image, struct bpf_dummy_ops_test_args *args)
 {
-	dummy_ops_test_ret_fn test = (void *)image;
+	dummy_ops_test_ret_fn test = (void *)image + cfi_get_offset();
 	struct bpf_dummy_ops_state *state = NULL;
 
 	/* state needs to be NULL if args[0] is 0 */
@@ -119,6 +124,7 @@ int bpf_struct_ops_test_run(struct bpf_p
 	op_idx = prog->expected_attach_type;
 	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[op_idx],
+						&dummy_ops_test_ret_function,
 						image, image + PAGE_SIZE);
 	if (err < 0)
 		goto out;
@@ -219,6 +225,28 @@ static void bpf_dummy_unreg(void *kdata)
 {
 }
 
+static int bpf_dummy_test_1(struct bpf_dummy_ops_state *cb)
+{
+	return 0;
+}
+
+static int bpf_dummy_test_2(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
+			    char a3, unsigned long a4)
+{
+	return 0;
+}
+
+static int bpf_dummy_test_sleepable(struct bpf_dummy_ops_state *cb)
+{
+	return 0;
+}
+
+static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
+	.test_1 = bpf_dummy_test_1,
+	.test_2 = bpf_dummy_test_2,
+	.test_sleepable = bpf_dummy_test_sleepable,
+};
+
 struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
@@ -227,4 +255,5 @@ struct bpf_struct_ops bpf_bpf_dummy_ops
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
 	.name = "bpf_dummy_ops",
+	.cfi_stubs = &__bpf_bpf_dummy_ops,
 };
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -271,6 +271,74 @@ static int bpf_tcp_ca_validate(void *kda
 	return tcp_validate_congestion_control(kdata);
 }
 
+static u32 bpf_tcp_ca_ssthresh(struct sock *sk)
+{
+	return 0;
+}
+
+static void bpf_tcp_ca_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+}
+
+static void bpf_tcp_ca_set_state(struct sock *sk, u8 new_state)
+{
+}
+
+static void bpf_tcp_ca_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
+{
+}
+
+static void bpf_tcp_ca_in_ack_event(struct sock *sk, u32 flags)
+{
+}
+
+static void bpf_tcp_ca_pkts_acked(struct sock *sk, const struct ack_sample *sample)
+{
+}
+
+static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
+{
+	return 0;
+}
+
+static void bpf_tcp_ca_cong_control(struct sock *sk, const struct rate_sample *rs)
+{
+}
+
+static u32 bpf_tcp_ca_undo_cwnd(struct sock *sk)
+{
+	return 0;
+}
+
+static u32 bpf_tcp_ca_sndbuf_expand(struct sock *sk)
+{
+	return 0;
+}
+
+static void __bpf_tcp_ca_init(struct sock *sk)
+{
+}
+
+static void __bpf_tcp_ca_release(struct sock *sk)
+{
+}
+
+static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
+	.ssthresh = bpf_tcp_ca_ssthresh,
+	.cong_avoid = bpf_tcp_ca_cong_avoid,
+	.set_state = bpf_tcp_ca_set_state,
+	.cwnd_event = bpf_tcp_ca_cwnd_event,
+	.in_ack_event = bpf_tcp_ca_in_ack_event,
+	.pkts_acked = bpf_tcp_ca_pkts_acked,
+	.min_tso_segs = bpf_tcp_ca_min_tso_segs,
+	.cong_control = bpf_tcp_ca_cong_control,
+	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
+	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
+
+	.init = __bpf_tcp_ca_init,
+	.release = __bpf_tcp_ca_release,
+};
+
 struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.verifier_ops = &bpf_tcp_ca_verifier_ops,
 	.reg = bpf_tcp_ca_reg,
@@ -281,6 +349,7 @@ struct bpf_struct_ops bpf_tcp_congestion
 	.init = bpf_tcp_ca_init,
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
+	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
 };
 
 static int __init bpf_tcp_ca_kfunc_init(void)



