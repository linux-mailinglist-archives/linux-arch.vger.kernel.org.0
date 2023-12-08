Return-Path: <linux-arch+bounces-822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698A80ADA8
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 21:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FB3B20B03
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1657327;
	Fri,  8 Dec 2023 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1ntypyX"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82C123;
	Fri,  8 Dec 2023 12:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rRfUKKpVJaX2GBwm20UFJtXdCC5Gt18eCCN9NLFBXGg=; b=S1ntypyXXnH5/Zhmllff4W7CqE
	zvKEGCwpJiV6CNOuMqcAx4RdNPWtDIz2wWfgO64jF9VTQsJPihe7ZgsJ5Aui0fouYWgOcD9MnMek/
	Qw0qaDYlc8wkXBNuBNMpvKGH1proCkWQ7owqEVwrXCdttqYkXESI6larGqgZwhg9OBfBUOQtOI/29
	x071uzp8HcuHIXHZAB0KuEs0TbzqucgbaSkUc/nB5qIR+l6CS7NooXMW1vzUQHxDz0ebc3/9JpYtW
	cVJqlZa1MBgZfaxao7Q0joX1+LKJW8Lf1KS/RKmyC2puCXnf8JHhnhKq7CsotPXpzzlAbIkfFuetu
	UOGg6Fiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBhIi-006Ud2-EY; Fri, 08 Dec 2023 20:18:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BE5B3003F0; Fri,  8 Dec 2023 21:18:19 +0100 (CET)
Date: Fri, 8 Dec 2023 21:18:19 +0100
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
Message-ID: <20231208201819.GE36716@noisy.programming.kicks-ass.net>
References: <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net>
 <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <CAADnVQJFB_CPtFS3=VV=RwnP=EQRL3yEsR8wXVcicb07P8NODw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJFB_CPtFS3=VV=RwnP=EQRL3yEsR8wXVcicb07P8NODw@mail.gmail.com>

On Fri, Dec 08, 2023 at 11:32:07AM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 5:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Dec 08, 2023 at 11:29:40AM +0100, Peter Zijlstra wrote:
> > > The only problem I now have is the one XXX, I'm not entirely sure what
> > > signature to use there.
> >
> > > @@ -119,6 +119,7 @@ int bpf_struct_ops_test_run(struct bpf_p
> > >       op_idx = prog->expected_attach_type;
> > >       err = bpf_struct_ops_prepare_trampoline(tlinks, link,
> > >                                               &st_ops->func_models[op_idx],
> > > +                                             /* XXX */ NULL,
> > >                                               image, image + PAGE_SIZE);
> > >       if (err < 0)
> > >               goto out;
> >
> > Duh, that should ofcourse be something of dummy_ops_test_ret_fn type.
> > Let me go fix that.
> 
> Right. That should work.
> A bit wasteful to generate real code just to read hash from it
> via cfi_get_func_hash(), but it's a neat idea.

Right, bit wasteful. But the advantage is that I get a structure with
pointers that exactly mirrors the structure we're writing.

> I guess it's hard to get kcfi from __ADDRESSABLE in plain C
> and sprinkling asm("cfi_xxx: .long   __kcfi_typeid..."); is worse?
> Even if it's a macro ?

I can try this, but I'm not sure it'll be pretty. Even if I wrap it in a
decent macro, I still get to define a ton of variables and then wrap the
lot into a structure -- one that expects function pointers.

I'll see how horrible it will become.

