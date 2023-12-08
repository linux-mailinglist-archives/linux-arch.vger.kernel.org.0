Return-Path: <linux-arch+bounces-796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A478780A0ED
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 11:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C870B1C209D7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF518E1C;
	Fri,  8 Dec 2023 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhQZ25EF"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669C1BC1;
	Fri,  8 Dec 2023 02:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DFxgiZgq/cYdnTIdPLSFo/BUe19N0s9nMNiMP7WHhd0=; b=KhQZ25EFn0USBjZN7jRYbgAunx
	vIsNF2nAMXzP2ofPQBYZ4krYbAANFKHBAM2kire3Y6TZUxIuFXTV3R3QTk8hcqK/Edb6AIjoF7ySz
	cREiIkEKIsvWoAgrsCuLrE9tSGJ3iHhEhwf8s90ZA+X2IgkGJyX4IL2fWreXFvIPuetkJAFYnSUc3
	7xnNduMQ+HAnnAcPht+IZQnc1cwYVqU2ibGJ86XmiG91+Bme2TRiiRaG45f8FHD97sQNqbHlg4C4p
	++1X4RCd17bONY0qrh9pyJyGRfmfZTa6xB/tlsMU/20L6VtnLu8cYO2JsB/AMYl/CpQtbCRqtT+g4
	fgKHGnww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBY74-005XvD-00; Fri, 08 Dec 2023 10:29:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DF9D30050D; Fri,  8 Dec 2023 11:29:41 +0100 (CET)
Date: Fri, 8 Dec 2023 11:29:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
	Song Liu <songliubraving@meta.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joao Moreira <joao@overdrivepizza.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <20231208102940.GB28727@noisy.programming.kicks-ass.net>
References: <20231204125239.GA1319@noisy.programming.kicks-ass.net>
 <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>

On Thu, Dec 07, 2023 at 02:32:12PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 07, 2023 at 10:31:05AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 06, 2023 at 01:39:43PM -0800, Alexei Starovoitov wrote:
> > 
> > 
> > > All is ok until kCFI comes into picture.
> > > Here we probably need to teach arch_prepare_bpf_trampoline() to emit
> > > different __kcfi_typeid depending on kernel function proto,
> > > so that caller hash checking logic won't be tripped.
> > > I suspect that requires to reverse engineer an algorithm of computing kcfi from clang.
> > > other ideas?
> > 
> > I was going to try and extend bpf_struct_ops with a pointer, this
> > pointer will point to a struct of the right type with all ops filled out
> > as stubs.
> 
> Right. Something like this, but it's more nuanced.
> 
> The bpf_struct_ops concept is a generic mechanism to provide bpf-based callback
> to any set of kernel callbacks.
> 
> bpf tcp CC plugs into:
> struct tcp_congestion_ops {
>         /* do new cwnd calculation (required) */
>         void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
> 
>         /* call before changing ca_state (optional) */
>         void (*set_state)(struct sock *sk, u8 new_state);
> 
>         /* call when cwnd event occurs (optional) */
>         void (*cwnd_event)(struct sock *sk, enum tcp_ca_event ev);
>   ...
> };
> 
> and from bpf side we don't touch tcp kernel bits at all.
> tcp stack doesn't know whether it's calling bpf based CC or builtin CC or CC provided by kernel module.
> 
> bpf struct_ops mechanim is a zero cost extension to potentially any kernel mechanism
> that is already setup with callbacks. tcp_congestion_ops is one of them.
> 
> The allowlisting of tcp_congestion_ops for bpf use is done in net/ipv4/bpf_tcp_ca.c via:
> 
> struct bpf_struct_ops bpf_tcp_congestion_ops = {
>         ...
>         .reg = bpf_tcp_ca_reg,
>         .unreg = bpf_tcp_ca_unreg,
>         ...
>         .name = "tcp_congestion_ops",
> };
> static int bpf_tcp_ca_reg(void *kdata)
> {
>         return tcp_register_congestion_control(kdata);
> }
> and
>  int tcp_register_congestion_control(struct tcp_congestion_ops *type);
> is a normal TCP CC registration routine that is used by all CCs.
> 
> The bpf struct_ops infra prepares everything inside
> 'struct tcp_congestion_ops' that makes it indistinguishable from normal kernel CC,
> except kCFI part. sadly.
> 
> The kCFI challenge is that clang may not generate any __cfi + __kcfi_typeid at all.
> Like if vmlinux doesn't have any TCP CCs built-in there will be no kCFI hashes
> in the kernel that represent a required hash to call cong_avoid, set_state, cwnd_event.

Right, I got that. So what I meant was something like the below
(compiled only).

By adding an actual ops struct, but filled with no-op stubs to
bpf_struct_ops, we can crib the CFI hash from those functions. They'll
never be called, but the compiler cannot tell and has to generate them.

The only problem I now have is the one XXX, I'm not entirely sure what
signature to use there.

---
Index: linux-2.6/include/linux/bpf.h
===================================================================
--- linux-2.6.orig/include/linux/bpf.h
+++ linux-2.6/include/linux/bpf.h
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
+	void *bpf_ops_stubs;
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
Index: linux-2.6/kernel/bpf/bpf_struct_ops.c
===================================================================
--- linux-2.6.orig/kernel/bpf/bpf_struct_ops.c
+++ linux-2.6/kernel/bpf/bpf_struct_ops.c
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
+							*(void **)(st_ops->bpf_ops_stubs + moff),
 							image, image_end);
 		if (err < 0)
 			goto reset_unlock;
 
-		*(void **)(kdata + moff) = image;
+		*(void **)(kdata + moff) = image + cfi_get_offset();
 		image += err;
 
 		/* put prog_id to udata */
Index: linux-2.6/net/ipv4/bpf_tcp_ca.c
===================================================================
--- linux-2.6.orig/net/ipv4/bpf_tcp_ca.c
+++ linux-2.6/net/ipv4/bpf_tcp_ca.c
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
+	.bpf_ops_stubs = &__bpf_ops_tcp_congestion_ops,
 };
 
 static int __init bpf_tcp_ca_kfunc_init(void)
Index: linux-2.6/arch/x86/include/asm/cfi.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/cfi.h
+++ linux-2.6/arch/x86/include/asm/cfi.h
@@ -123,6 +123,8 @@ static inline cfi_get_offset(void)
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
Index: linux-2.6/arch/x86/kernel/alternative.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/alternative.c
+++ linux-2.6/arch/x86/kernel/alternative.c
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
Index: linux-2.6/net/bpf/bpf_dummy_struct_ops.c
===================================================================
--- linux-2.6.orig/net/bpf/bpf_dummy_struct_ops.c
+++ linux-2.6/net/bpf/bpf_dummy_struct_ops.c
@@ -62,7 +62,7 @@ static int dummy_ops_copy_args(struct bp
 
 static int dummy_ops_call_op(void *image, struct bpf_dummy_ops_test_args *args)
 {
-	dummy_ops_test_ret_fn test = (void *)image;
+	dummy_ops_test_ret_fn test = (void *)image + cfi_get_offset();
 	struct bpf_dummy_ops_state *state = NULL;
 
 	/* state needs to be NULL if args[0] is 0 */
@@ -119,6 +119,7 @@ int bpf_struct_ops_test_run(struct bpf_p
 	op_idx = prog->expected_attach_type;
 	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[op_idx],
+						/* XXX */ NULL,
 						image, image + PAGE_SIZE);
 	if (err < 0)
 		goto out;
@@ -219,6 +220,28 @@ static void bpf_dummy_unreg(void *kdata)
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
@@ -227,4 +250,5 @@ struct bpf_struct_ops bpf_bpf_dummy_ops
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
 	.name = "bpf_dummy_ops",
+	.bpf_ops_stubs = &__bpf_bpf_dummy_ops,
 };
Index: linux-2.6/arch/x86/net/bpf_jit_comp.c
===================================================================
--- linux-2.6.orig/arch/x86/net/bpf_jit_comp.c
+++ linux-2.6/arch/x86/net/bpf_jit_comp.c
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
@@ -2596,20 +2594,27 @@ static int __arch_prepare_bpf_trampoline
 
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
@@ -2643,10 +2648,11 @@ static int __arch_prepare_bpf_trampoline
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
@@ -2665,11 +2671,12 @@ static int __arch_prepare_bpf_trampoline
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
@@ -2698,17 +2705,19 @@ static int __arch_prepare_bpf_trampoline
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
@@ -2725,11 +2734,12 @@ static int __arch_prepare_bpf_trampoline
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
@@ -2737,9 +2747,10 @@ static int __arch_prepare_bpf_trampoline
 
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

