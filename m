Return-Path: <linux-arch+bounces-377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17867F44BE
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 12:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809FA28142B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B542053;
	Wed, 22 Nov 2023 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UBmw8unh"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294A18C;
	Wed, 22 Nov 2023 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X4yB6hUSYr9jLERDuqGa1fayu3rTs8QJXDlK1nr5N+I=; b=UBmw8unhwdh3vhYMvpMxm3Fv1U
	k9cPMen7Pu7uoW1AdLnAV8UUEPAL3olyL0aLCaD39m5BkE2ZJvNOW7tfVHvOf14uqfjug8oqBGo83
	AsoenSS39FQdhv8Gp7xoZrY6vY44mLQDUiPzG6ymHjv244RQjHuoOhf9z9oNb+VvP0FAfbcB/cbE+
	taHeuBMLLvLU06Osy+46TxfajXY5WveGOQmelOB8DTQlzh31RW+28Vr7hZuMSRS38Jlc6GuV0xf9v
	QNi9xc7kf4tVPBV3Y1ZCq+Ho2us10TaF9XmEDzxL7ui5n5VEXUJHmm1NYlAomD6Hi6ay5m/aUR0R2
	GPGbTN3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5lCR-00CII2-1s;
	Wed, 22 Nov 2023 11:15:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CF283005AA; Wed, 22 Nov 2023 12:15:17 +0100 (CET)
Date: Wed, 22 Nov 2023 12:15:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
	ndesaulniers@google.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
	mark.rutland@arm.com
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <20231122111517.GR8262@noisy.programming.kicks-ass.net>
References: <20231120144642.591358648@infradead.org>
 <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com>

On Tue, Nov 21, 2023 at 06:18:17PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 20, 2023 at 03:46:44PM +0100, Peter Zijlstra wrote:
> > +
> > +#ifdef CONFIG_CFI_CLANG
> > +struct bpf_insn;
> > +
> > +extern unsigned int bpf_func_proto(const void *ctx,
> > +				   const struct bpf_insn *insn);
> 
> To make it more obvious what is going on could you rename it to
> __bpf_prog_runX()
> and add a comment that its prototype should match exactly
> bpf interpreters created by DEFINE_BPF_PROG_RUN() macro,
> otherwise cfi will explode.

Sure.

> 
> > +
> > +__ADDRESSABLE(bpf_func_proto);
> > +
> > +asm (
> > +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> > +"	.type	cfi_bpf_hash,@object				\n"
> > +"	.globl	cfi_bpf_hash					\n"
> > +"	.p2align	2, 0x0					\n"
> > +"cfi_bpf_hash:							\n"
> > +"	.long	__kcfi_typeid_bpf_func_proto			\n"
> 
> Took me some time to grok this.
> Cannot you use __CFI_TYPE() macro here ?

__CFI_TYPE() creates the content of the __cfi_foo prefix symbol, which
is different from what the above does. The above is basically:

u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid_bpf_func_proto;

Except I need to do that in asm because __kcfi_typeid magic only works
in asm. I'll put the C version in a comment on top.

> > +"	.size	cfi_bpf_hash, 4					\n"
> > +"	.popsection						\n"
> > +);
> > +#endif
> ...
> > +static int emit_fineibt(u8 **pprog)
> > +{
> > +	u8 *prog = *pprog;
> > +
> > +	EMIT_ENDBR();
> > +	EMIT3_off32(0x41, 0x81, 0xea, cfi_bpf_hash);
> > +	EMIT2(0x74, 0x07);
> > +	EMIT2(0x0f, 0x0b);
> > +	EMIT1(0x90);
> > +	EMIT_ENDBR_POISON();
> 
> Please add comments what this asm does. No one can read hex.

Well, I've stared at this so very long that I can in fact get quite a
long way with just hex :-/ But point taken. My only problem here is that
this file uses Intel syntax, and that melts my brain.

Would it be acceptable to have AT&T syntax comments?

> > +
> > +	*pprog = prog;
> > +	return 16;
> 
> 16 means "the caller of this code will jump to endbr_poison", right?

Ah, so the way FineIBT works is that direct calls go to foo()+0, as
normal. However the indirect calls will target foo()-16. The 16 bytes
preceding every symbol will contain the FineIBT landing pad.

As such, we need to offset prog->bpf_func by the expected amount,
otherwise foo()-16 will land in outer space and things go *boom*.

To be very explicit, let me list all the various forms of function
calls:

Traditional:

foo:
  ... code here ...
  ret

direct caller:

  call foo

indirect caller:

  lea foo(%rip), %r11
  call *%r11

IBT:

foo:
  endbr64
  ... code here ...
  ret

direct caller:

  call foo / call foo+4

indirect caller:

  lea foo(%rip), %r11
  ...
  call *%r11


kCFI:

__cfi_foo:
  movl $0x12345678, %rax
  (11 nops when CALL_PADDING)
foo:
  endbr64 (when also IBT)
  ... code here ...
  ret

direct caller:

  call foo / call foo+4

indirect caller:

  lea foo(%rip), %r11
  ...
  movl $(-0x12345678), %r10d
  addl -15(%r11), %r10d (or -4 without CALL_PADDING)
  je 1f
  ud2
1:call *%r11


FineIBT (builds as kCFI + CALL_PADDING + IBT + RETPOLINE and runtime
patches things to look like):

__cfi_foo:
  endbr64
  subl $0x12345678, %r10d
  jz foo
  ud2
  nop
foo:
  osp nop3 (was endbr64)
  ... code here ...
  ret

direct caller:

  call foo / call foo+4

indirect caller:

  lea foo(%rip), %r11
  ...
  movl $0x12345678, %r10d
  subl $16, %r11
  nop4
  call *%r11


As can be seen, both kCFI and FineIBT use the prefix __cfi symbol /
negative offsets.

To make this work the JIT starts by emitting the prefix text but then
offsets prog->bpf_func to point to the 'real' begin.

> > +}
> > +
> > +static int emit_kcfi(u8 **pprog)
> > +{
> > +	u8 *prog = *pprog;
> > +	int offset = 5;
> > +
> > +	EMIT1_off32(0xb8, cfi_bpf_hash);
> 
> and here too.
> 
> > +#ifdef CONFIG_CALL_PADDING
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	EMIT1(0x90);
> > +	offset += 11;
> > +#endif
> > +	EMIT_ENDBR();
> > +
> > +	*pprog = prog;
> > +	return offset;
> 
> 5 or 16 would mean "jump to endbr" ?

It's the size of the prefix symbol.

> > +}
> > +
> > +static int emit_cfi(u8 **pprog)
> > +{
> > +	u8 *prog = *pprog;
> > +	int offset = 0;
> > +
> > +	switch (cfi_mode) {
> > +	case CFI_FINEIBT:
> > +		offset = emit_fineibt(&prog);
> > +		break;
> > +
> > +	case CFI_KCFI:
> > +		offset = emit_kcfi(&prog);
> > +		break;
> > +
> > +	default:
> > +		EMIT_ENDBR();
> > +		break;
> > +	}
> > +
> > +	*pprog = prog;
> > +	return offset;
> > +}
> > +
> >  /*
> >   * Emit x86-64 prologue code for BPF program.
> >   * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
> >   * while jumping to another program
> >   */
> > -static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> > -			  bool tail_call_reachable, bool is_subprog,
> > -			  bool is_exception_cb)
> > +static int emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> > +			 bool tail_call_reachable, bool is_subprog,
> > +			 bool is_exception_cb)
> >  {
> >  	u8 *prog = *pprog;
> > +	int offset;
> >  
> > +	offset = emit_cfi(&prog);
> 
> I'm not sure doing cfi_bpf_hash check in JITed code is completely solving the problem.
> From bpf_dispatcher_*_func() calling into JITed will work,
> but this emit_prologue() is doing the same job for all bpf progs.
> Some bpf progs call each other directly and indirectly.
> bpf_dispatcher_*_func() -> JITed_BPF_A -> JITed_BPF_B.
> A into B can be a direct call (which cfi doesn't care about) and
> indirect via emit_bpf_tail_call_indirect()->emit_indirect_jump().
> Should we care about fineibt/kcfi there too?

The way I understood the tail-call thing to work is that it jumps to
bpf_prog + X86_TAIL_CALL_OFFSET, we already emit an extra ENDBR there to
make this work.

So the A -> B indirect call is otherwise unadornen and only needs ENDBR.

Ideally that would use kCFI/FineIBT but since it also skips some of the
setup, this gets to be non-trivial, so I've let this be as is.

> >  	/* BPF trampoline can be made to work without these nops,
> >  	 * but let's waste 5 bytes for now and optimize later
> >  	 */
> > -	EMIT_ENDBR();
> >  	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
> >  	prog += X86_PATCH_SIZE;
> >  	if (!ebpf_from_cbpf) {
> > @@ -357,6 +426,8 @@ static void emit_prologue(u8 **pprog, u3
> >  	if (tail_call_reachable)
> >  		EMIT1(0x50);         /* push rax */
> >  	*pprog = prog;
> > +
> > +	return offset;
> >  }
> >  
> >  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> > @@ -1083,8 +1154,8 @@ static int do_jit(struct bpf_prog *bpf_p
> >  	bool tail_call_seen = false;
> >  	bool seen_exit = false;
> >  	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
> > -	int i, excnt = 0;
> >  	int ilen, proglen = 0;
> > +	int i, excnt = 0;
> >  	u8 *prog = temp;
> >  	int err;
> >  
> > @@ -1094,9 +1165,12 @@ static int do_jit(struct bpf_prog *bpf_p
> >  	/* tail call's presence in current prog implies it is reachable */
> >  	tail_call_reachable |= tail_call_seen;
> >  
> > -	emit_prologue(&prog, bpf_prog->aux->stack_depth,
> > -		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
> > -		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
> > +	ctx->prog_offset = emit_prologue(&prog, bpf_prog->aux->stack_depth,
> > +					 bpf_prog_was_classic(bpf_prog),
> > +					 tail_call_reachable,
> > +					 bpf_is_subprog(bpf_prog),
> > +					 bpf_prog->aux->exception_cb);
> > +
> >  	/* Exception callback will clobber callee regs for its own use, and
> >  	 * restore the original callee regs from main prog's stack frame.
> >  	 */
> > @@ -2935,9 +3009,9 @@ struct bpf_prog *bpf_int_jit_compile(str
> >  			jit_data->header = header;
> >  			jit_data->rw_header = rw_header;
> >  		}
> > -		prog->bpf_func = (void *)image;
> > +		prog->bpf_func = (void *)image + ctx.prog_offset;
> 
> I don't understand this.

> Is it a some clang thing that knows to offset indirect jump by
> exactly that many hard coded bytes ?
> Something in the clang does ptr -= 16 in case of fineibt and just
> jumps there ? and ptr -= 5 for kcfi ?

Yep, that. I hope my earlier explanation clarified this.

> If so, please add a giant comment explaining that.
> No one should be reverse engineering such intricate details.

So the kCFI thing is 'new' but readily inspected by objdump or godbolt:

  https://godbolt.org/z/sGe18z3ca

(@Sami, that .Ltmp15 thing, I don't see that in the kernel, what
compiler flag makes that go away?)

As to FineIBT, that has a big comment in arch/x86/kernel/alternative.c
where I rewrite the kCFI thing into FineIBT. I can refer there to avoid
duplicating comments, would that work?

> 
> >  		prog->jited = 1;
> > -		prog->jited_len = proglen;
> > +		prog->jited_len = proglen - ctx.prog_offset; // XXX?
> 
> jited_len is used later to cover the whole generated code.
> See bpf_prog_ksym_set_addr():
>         prog->aux->ksym.start = (unsigned long) prog->bpf_func;
>         prog->aux->ksym.end   = prog->aux->ksym.start + prog->jited_len;
> we definitely want ksym [start, end] to cover every useful byte
> of JITed code in case IRQ happens on that byte.
> Without covering cfi prologue the stack dump will be wrong for that frame.
> I guess if xdp_dispatcher with fineibt=on jumps into prog->bpf_func - 16
> and IRQ fires we don't care that much about accurate stack of last frame ?
> I guess it's acceptable, but a comment is necessary.

Ah, so normally the __cfi_foo symbol would catch those, lemme see what I
can do here.

Thanks!



