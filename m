Return-Path: <linux-arch+bounces-834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3380AFD5
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 23:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321A7281C01
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141ED59B77;
	Fri,  8 Dec 2023 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="anFV4EKn"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39250AC;
	Fri,  8 Dec 2023 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9AtZTt6OGfjsPDJQOtDfx5Cu6irtFkmWZMjDyBOLAY8=; b=anFV4EKnBK8gQJUQaPbHBdGbmh
	b2Y7tMQ6hHkQDT5vgOGk/97h6xyIa4MDZnDQV4WFLZMH0Moc2XQBReqMlEddNf22x5eaw0zAoXtGq
	dyQwgTqMZqIOn/1N4xYUukkUwd2BIl/rwN+ayXO0Y2NWwvxlGU3Yxjp8/bdR9jO8fTnclXdXuFPiN
	/eQ1qV70Ux813zNWm90BtR+BVtsuhQ7+lpHQtd95lVHbKAbeBGyJQhSdn2Nf39E/FRT7aa1T5sy3K
	KtlIjlSiXtHdzhKo1SHrWhL9Azqgm2vU4mbnqe/RW5vhus/b8/1CvhOM+ExeLbzwwDLJKGTkrTFIZ
	Ez+2V7qQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rBjba-006iqm-2j;
	Fri, 08 Dec 2023 22:46:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C66943003F0; Fri,  8 Dec 2023 23:45:57 +0100 (CET)
Date: Fri, 8 Dec 2023 23:45:57 +0100
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
Message-ID: <20231208224557.GH36716@noisy.programming.kicks-ass.net>
References: <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net>
 <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net>
 <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
 <20231208203535.GG36716@noisy.programming.kicks-ass.net>
 <CAADnVQJzCw=qcG+jHBYG0q0SxLPkwghni0wpgV4A4PkpgVbGPw@mail.gmail.com>
 <20231208205241.GK28727@noisy.programming.kicks-ass.net>
 <CAADnVQL3KsJONShsstDq5jrpbc_4FOU-VQPJgDCt50N9asoFzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL3KsJONShsstDq5jrpbc_4FOU-VQPJgDCt50N9asoFzA@mail.gmail.com>

On Fri, Dec 08, 2023 at 12:58:01PM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 12:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Dec 08, 2023 at 12:41:03PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Dec 8, 2023 at 12:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > -__bpf_kfunc void bpf_task_release(struct task_struct *p)
> > > > +__bpf_kfunc void bpf_task_release(void *p)
> > >
> > > Yeah. That won't work. We need a wrapper.
> > > Since bpf prog is also calling it directly.
> > > In progs/task_kfunc_common.h
> > > void bpf_task_release(struct task_struct *p) __ksym;
> > >
> > > than later both libbpf and the verifier check that
> > > what bpf prog is calling actually matches the proto
> > > of what is in the kernel.
> > > Effectively we're doing strong prototype check at load time.
> >
> > I'm still somewhat confused on how this works, where does BPF get the
> > address of the function from? and what should I call the wrapper?
> 
> It starts with
> register_btf_id_dtor_kfuncs() that takes a set of btf_ids:
> {btf_id_of_type, btf_id_of_dtor_function}, ...
> 
> Then based on btf_id_of_dtor_function we find its type proto, name, do checks,
> and eventually:
> addr = kallsyms_lookup_name(dtor_func_name);
> field->kptr.dtor = (void *)addr;
> 
> bpf_task_release(struct task_struct *p) would need to stay as-is,
> but we can have a wrapper
> void bpf_task_release_dtor(void *p)
> {
>   bpf_task_release(p);
> }
> 
> And adjust the above lookup with extra "_dtor" suffix.
> 
> > > btw instead of EXPORT_SYMBOL_GPL(bpf_task_release)
> > > can __ADDRESSABLE be used ?
> > > Since it's not an export symbol.
> >
> > No __ADDRESSABLE() is expressly ignored, but we have IBT_NOSEAL() that
> > should do it. I'll rename the thing and lift it out of x86 to avoid
> > breaking all other arch builds.
> 
> Makes sense.

Ok, did that. Current patches (on top of bpf-next) are here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cfi

(really should try and write better changelogs, but it's too late)

The test_progs thing still doesn't run to completion, the next problem
seems to be bpf_throw():

[  247.720159]  ? die+0xa4/0xd0
[  247.720216]  ? do_trap+0xa5/0x180
[  247.720281]  ? __cfi_bpf_prog_8ac473954ac6d431_F+0xd/0x10
[  247.720368]  ? __cfi_bpf_prog_8ac473954ac6d431_F+0xd/0x10
[  247.720459]  ? do_error_trap+0xba/0x120
[  247.720525]  ? __cfi_bpf_prog_8ac473954ac6d431_F+0xd/0x10
[  247.720614]  ? handle_invalid_op+0x2c/0x40
[  247.720684]  ? __cfi_bpf_prog_8ac473954ac6d431_F+0xd/0x10
[  247.720775]  ? exc_invalid_op+0x38/0x60
[  247.720840]  ? asm_exc_invalid_op+0x1a/0x20
[  247.720909]  ? 0xffffffffc001ba54
[  247.720971]  ? __cfi_bpf_prog_8ac473954ac6d431_F+0xd/0x10
[  247.721063]  ? bpf_throw+0x9b/0xf0
[  247.721126]  ? bpf_test_run+0x108/0x350
[  247.721191]  ? bpf_prog_5555714b685bf0cf_exception_throw_always_1+0x26/0x26
[  247.721301]  ? bpf_test_run+0x108/0x350
[  247.721368]  bpf_test_run+0x212/0x350
[  247.721433]  ? slab_build_skb+0x22/0x110
[  247.721503]  bpf_prog_test_run_skb+0x347/0x4a0

But I'm too tired to think staight. Is  this a bpf_callback_t vs
bpf_exception_cb difference?

I'll prod more later. Zzzz..

