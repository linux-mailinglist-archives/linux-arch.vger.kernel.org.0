Return-Path: <linux-arch+bounces-806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A989B80AAA4
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFB01C20895
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC443985B;
	Fri,  8 Dec 2023 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UbHNqkRu"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58419A2;
	Fri,  8 Dec 2023 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V28FqpOL+oZWPnnuXFJFyawoJ5nIS3QYSrjANXac/eI=; b=UbHNqkRus+VeXqxGP09vb359cH
	2Q/ZEqAjQU4IsYvHCMQxbyYEYrxhTuo3gNlyMc13ZpTy7FurwxlfYnyeyVDkDjthklMDFdHv1pk2O
	iWXktzpJ3MHht6J+8CJzFNs4XhJWPpe7r1gsueyYfHT+aGpqaquovUgnsujDTcrKtmsVXQZhAkhX3
	MSmklMcr0V/IrT3Kb9WlygDyHLhiA9akWeqV9GmCO7S6JlbTqOHzZSk9q8AEFWqokE4RFo3ShjLBN
	Wc6sCSMhme6ocjs7BtVEOFRgo4Ltt1gOhE8YN6Q1c3Mrfepb5uEV/MLWuqzaQ0TRqBEzEgKeY6qtL
	tiKWKUbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBeXw-0069mX-TN; Fri, 08 Dec 2023 17:21:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 89F2A3003F0; Fri,  8 Dec 2023 18:21:52 +0100 (CET)
Date: Fri, 8 Dec 2023 18:21:52 +0100
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
Message-ID: <20231208172152.GD36716@noisy.programming.kicks-ass.net>
References: <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net>
 <20231208134041.GD28727@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208134041.GD28727@noisy.programming.kicks-ass.net>

On Fri, Dec 08, 2023 at 02:40:41PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 08, 2023 at 11:29:40AM +0100, Peter Zijlstra wrote:
> > The only problem I now have is the one XXX, I'm not entirely sure what
> > signature to use there.
> 
> > @@ -119,6 +119,7 @@ int bpf_struct_ops_test_run(struct bpf_p
> >  	op_idx = prog->expected_attach_type;
> >  	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
> >  						&st_ops->func_models[op_idx],
> > +						/* XXX */ NULL,
> >  						image, image + PAGE_SIZE);
> >  	if (err < 0)
> >  		goto out;
> 
> Duh, that should ofcourse be something of dummy_ops_test_ret_fn type.
> Let me go fix that.

Next one.. bpf_obj_free_fields: field->kptr.dtor(xchg_field);

The one that trips is bpf_cgroup_release().

objtool doesn't think the address of that function 'escapes' and
'helpfully' seals that function, and then BPF thinks it does escape and
manages the above indirect call and *boom*.

How can I tell which functions escape according to BPF such that I might
teach objtool this?

