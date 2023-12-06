Return-Path: <linux-arch+bounces-719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE234807549
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7098EB20EF6
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0445BE2;
	Wed,  6 Dec 2023 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mFV0PJjQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209AD3;
	Wed,  6 Dec 2023 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=evl1U5G+v7p9gMxFFsHi0NmzyC/QyjntfdGiRP4l5KI=; b=mFV0PJjQXYK/i1bHZs3i4ArIx2
	d+67mDb1sq/1LHA4CRjlKQFBybEQ/pPdtvl3YCA6rjyaE1TstBZDO3xznhyQPDrCnlR9QGuHq3P+S
	narwijdN41kTVPuDq/6+3vxrGUyBvNIMT9JwiAoZ+bKsub8Bznx2HjLBVgDnJa7Nw9VaQgcFYyPFS
	crmsGQu6piC1a+orpEC7xdDPk1laSZFsjU9j97438gE7BXKWwta+0GMp+qulr7yAxnnu2WxNfAdpE
	JfXYDiufGNKc/x4BwwXFLE93CGGLVcxqD4Rmg8yirLAoTf4UUc8Ax39kqbOCpn2HNkZKVZz0E48Xo
	Wk6R1rlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAuue-0034Um-DJ; Wed, 06 Dec 2023 16:38:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 09FD5300451; Wed,  6 Dec 2023 17:38:15 +0100 (CET)
Date: Wed, 6 Dec 2023 17:38:14 +0100
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
Message-ID: <20231206163814.GB36423@noisy.programming.kicks-ass.net>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net>
 <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>

On Mon, Dec 04, 2023 at 05:18:31PM -0800, Alexei Starovoitov wrote:

> [   13.978497]  ? asm_exc_invalid_op+0x1a/0x20
> [   13.978798]  ? tcp_set_ca_state+0x51/0xd0
> [   13.979087]  tcp_v6_syn_recv_sock+0x45c/0x6c0
> [   13.979401]  tcp_check_req+0x497/0x590

> The stack trace doesn't have any bpf, but it's a bpf issue too.
> Here tcp_set_ca_state() calls
> icsk->icsk_ca_ops->set_state(sk, ca_state);
> which calls bpf prog via bpf trampoline.



Specifically, I think this is
tools/testing/selftests/bpf/progs/bpf_cubic.c, which has:

        .set_state      = (void *)bpf_cubic_state,

which comes from:

BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 *new_state)

which then wraps:

BPF_PROG()

which ends up generating:

static __always_inline ___bpf_cubic_state(unsigned long long *ctx, struct sock *sk, __u8 *new_state)
{
	...
}

void bpf_cubic_state(unsigned long long *ctx)
{
	return ____bpf_cubic_state(ctx, ctx[0], ctx[1]);
}


I think this then uses arch_prepare_bpf_trampoline(), but I'm entirely
lost how this all comes together, because the way I understand it the
whole bpf_trampoline is used to hook into an ftrace __fentry hook.

And a __fentry hook is very much not a function pointer. Help!?!?


The other case:

For tools/testing/selftests/bpf/progs/bloom_filter_bench.c we have:

        bpf_for_each_map_elem(&array_map, bloom_callback, &data, 0);

and here bloom callback appears like a normal function:

static __u64
bloom_callback(struct bpf_map *map, __u32 *key, void *val,
               struct callback_ctx *data)


But what do functions looks like in the JIT? What's the actual address
that's then passed into the helper function. Given this seems to work
without kCFI, it should at least have an ENDBR, but there's only 3 of
those afaict:

  - emit_prologue() first insn
  - emit_prologue() tail-call site
  - arch_preprare_bpf_trampoline()

If the function passed to the helper is from do_jit()/emit_prologue(),
then how do I tell what 'function' is being JIT'ed ?

If it is arch_prepare_bpf_trampoline(), then we're back at the previous
question and I don't see how a __fentry site becomes a callable function
pointer.


Any clues would be much appreciated.

