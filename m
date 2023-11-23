Return-Path: <linux-arch+bounces-414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B37F5578
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 01:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8ADA281671
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27E81388;
	Thu, 23 Nov 2023 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAhYVkDN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEC10E;
	Wed, 22 Nov 2023 16:43:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32daeed7771so202121f8f.3;
        Wed, 22 Nov 2023 16:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700700197; x=1701304997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4mDM3fOhLxMKv9Qsj/stPbdPgmQsMFznGIuQOD753M=;
        b=AAhYVkDNOyIif9CmavrWY98Y86DL8k4oXHyIICTLTPAj9elVkBZ1tLDetXk2YZ+13R
         UCvnB01W5jQR8s2sUMDm1TVemTOY5uqjvUVS2JAWQldwwAwZrOj1M4/pXnyAHTwHWhFw
         JZPXvJT3Ywvu0srodVY0D6zIwY68ESp3GrWXF8qvRTdYzUfnuPtSyl0f7N8pDEQeKwti
         OGFni6YSI8V6Ah9lxEfBySkReoT91kKG+x4UB9n3oOFO/BK1dgmmwfVwl0Sgf4LhYvmO
         SHs48AaSkdUhRHoMLHgrYeJyJasOD3PT+JXOiwsFyGeMXVuuIUyi/47VSnt2Z9vQlmkv
         gf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700700197; x=1701304997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4mDM3fOhLxMKv9Qsj/stPbdPgmQsMFznGIuQOD753M=;
        b=YOSK155JLFZseJpEYjJ1ddyUuEEAwQDd5okf24v63C9PjeCw0UJy8L9+dVItJ+4TWY
         ZGs6IuoG1BBlRdIeiLf7xL9L52Bk2VyWKsLdDkNMJjWYkliDO3P43aZ/HB9uyAARD/3M
         Koa2oUTlYGHhXRb1Os4pdVv4WTCYu5eXV68ykkjTnZQ7JxOCnlhaDcGFkw56Cmf6yBp2
         Zx41sWoauX/IFmOWWnH9+AsB2NIZOkKL5AvocwFQOTPtRQvPOwokjw6caawbSEuYtm+I
         ihdVZuw6SHJKBMDOOp6pyMsKv42IEG73TfgGylXsYn0S90jgZsqdOyWpBuVRamoT7/bR
         UQ7g==
X-Gm-Message-State: AOJu0YwNen8GTt81BW5vW2GxVp5uuEnCeQVd6n4s3oVelGk/s65SlqlM
	Yu9ffR/i9kEAeL3izrCWXLPswUkeQzcoaah3NLM=
X-Google-Smtp-Source: AGHT+IFaGuLwN1xpFTtgde8hjR8udeumSPNXj31L06f21NbuevuO4pwK/eQWIUQlq/PJPmsAyg32Y1iA4ZTIjeNqURg=
X-Received: by 2002:a05:6000:128d:b0:332:cc15:6bae with SMTP id
 f13-20020a056000128d00b00332cc156baemr2454118wrx.20.1700700196781; Wed, 22
 Nov 2023 16:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120144642.591358648@infradead.org> <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com> <20231122111517.GR8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231122111517.GR8262@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Nov 2023 16:43:05 -0800
Message-ID: <CAADnVQLhWFKcxno53zqGtuiWwUcw+TU8gB2eCBRPQC=2y5vrFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Joao Moreira <joao@overdrivepizza.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 3:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> To be very explicit, let me list all the various forms of function
> calls:
>
> Traditional:
>
> foo:
>   ... code here ...
>   ret
>
> direct caller:
>
>   call foo
>
> indirect caller:
>
>   lea foo(%rip), %r11
>   call *%r11
>
> IBT:
>
> foo:
>   endbr64
>   ... code here ...
>   ret
>
> direct caller:
>
>   call foo / call foo+4
>
> indirect caller:
>
>   lea foo(%rip), %r11
>   ...
>   call *%r11
>
>
> kCFI:
>
> __cfi_foo:
>   movl $0x12345678, %rax
>   (11 nops when CALL_PADDING)
> foo:
>   endbr64 (when also IBT)
>   ... code here ...
>   ret
>
> direct caller:
>
>   call foo / call foo+4
>
> indirect caller:
>
>   lea foo(%rip), %r11
>   ...
>   movl $(-0x12345678), %r10d
>   addl -15(%r11), %r10d (or -4 without CALL_PADDING)
>   je 1f
>   ud2
> 1:call *%r11
>
>
> FineIBT (builds as kCFI + CALL_PADDING + IBT + RETPOLINE and runtime
> patches things to look like):
>
> __cfi_foo:
>   endbr64
>   subl $0x12345678, %r10d
>   jz foo
>   ud2
>   nop
> foo:
>   osp nop3 (was endbr64)
>   ... code here ...
>   ret
>
> direct caller:
>
>   call foo / call foo+4
>
> indirect caller:
>
>   lea foo(%rip), %r11
>   ...
>   movl $0x12345678, %r10d
>   subl $16, %r11
>   nop4
>   call *%r11

Got it. That helps a lot!
You kind of have this comment scattered through arch/x86/kernel/alternative=
.c
but having it in one place like above would go a long way.
Could you please add it to arch/x86/net/bpf_jit_comp.c
or arch/x86/include/asm/cfi.h next to enum cfi_mode ?

> > I'm not sure doing cfi_bpf_hash check in JITed code is completely solvi=
ng the problem.
> > From bpf_dispatcher_*_func() calling into JITed will work,
> > but this emit_prologue() is doing the same job for all bpf progs.
> > Some bpf progs call each other directly and indirectly.
> > bpf_dispatcher_*_func() -> JITed_BPF_A -> JITed_BPF_B.
> > A into B can be a direct call (which cfi doesn't care about) and
> > indirect via emit_bpf_tail_call_indirect()->emit_indirect_jump().
> > Should we care about fineibt/kcfi there too?
>
> The way I understood the tail-call thing to work is that it jumps to
> bpf_prog + X86_TAIL_CALL_OFFSET, we already emit an extra ENDBR there to
> make this work.
>
> So the A -> B indirect call is otherwise unadornen and only needs ENDBR.
>
> Ideally that would use kCFI/FineIBT but since it also skips some of the
> setup, this gets to be non-trivial, so I've let this be as is.

I see. yeah. The setup is not trivial indeed. Keep as-is is fine.

> So the kCFI thing is 'new' but readily inspected by objdump or godbolt:
>
>   https://godbolt.org/z/sGe18z3ca
>
> (@Sami, that .Ltmp15 thing, I don't see that in the kernel, what
> compiler flag makes that go away?)

I also noticed this discrepancy. It doesn't seem to be used.
Looks weird to spend 8 bytes to store -sizeof(ud2)

> As to FineIBT, that has a big comment in arch/x86/kernel/alternative.c
> where I rewrite the kCFI thing into FineIBT. I can refer there to avoid
> duplicating comments, would that work?

Just the above comment somewhere would work.
I wouldn't worry about duplication. This is tricky stuff.
When gcc folks get around implementing kcfi they will find it useful too.

