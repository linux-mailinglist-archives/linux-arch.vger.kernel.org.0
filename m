Return-Path: <linux-arch+bounces-819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310D80AD19
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346011C20CFE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253A4CE0E;
	Fri,  8 Dec 2023 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjAHWZfG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C6E1712;
	Fri,  8 Dec 2023 11:32:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3332efd75c9so2257767f8f.2;
        Fri, 08 Dec 2023 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702063940; x=1702668740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ndbVL4uxU82m7aXPrJdtt1Twlz3kSpUXUFiW9WyCw=;
        b=mjAHWZfGoD3lu4E36aDFtxDI1kMWUbIwmOgOWNytWN7tiWP1KFySw0yfgSnVXNPNay
         9zeLLJXlUnZV+lwzasHiMQsmSgs/hLSCxLQBEZp1DCT/aW8buqjFeYSQ+/VN+VKV6+wU
         vL4Z73edPTFA6virPYQ1k1hlDFPhF64YmdhT+3Zlog0KAJIH2y2iVsZsDNF5swxsq++O
         EW3LIk4o3csmd13mRXnvqBd2YW/A3RjPWlx7y2f/QeMOwCAzehzhf9UpNhbpnKCn/m+a
         KEHd5XdYwH4lhxmXFr0UH639ZYhWBbQPFOQZ3RL2K1tVUilJ1Ihmr5M5tCH7WMfrUvuB
         dRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063940; x=1702668740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6ndbVL4uxU82m7aXPrJdtt1Twlz3kSpUXUFiW9WyCw=;
        b=r58FgFkZbtWk4lk4NmLVR4WZd70WHOj/TtV+jfXyZbmNwK+bfdhEPeELfEZfhpDR3X
         OXEBZmAcKkp/9GzVU9qf8NFbZYCko7HQV0QECE5rfYRjUlgo8jFu/QdFfGYL4ELFq+Sh
         JbB5V/qLTDxtSAXF8MjElxxv8ZGzAcG/TwOEYGIF/kPviL747sAhW6uYaUFtlqoxJho4
         2AewdNIIYKAnoFzEPaXc6jSnQgXnkcWVSXc/HD80YJuI5vsvXnoHJhWxw7YCd1eEZpoA
         0gPqHY6SNPZb0TtOOcjfNgK77tZBalDRK66INvnUbmUq+PI4ApFDblEAPoL1xsxmGUKx
         lR0Q==
X-Gm-Message-State: AOJu0Yyy8hx8/2h/StttI/w507W39GN8CYcraDlbSt7E2GRa/IQc3Bue
	obIytGwk1MgpCP6gfT9v+h1HPfsNnM9HSXyxkZ0=
X-Google-Smtp-Source: AGHT+IHnV39yPn1QoB9tAG00NDGLMqs4S2voOP0fLNkjc4tsDhdkd7wBpq6Za2gZRDVXSqGwHJCKQCHJJH2FbwjEGAU=
X-Received: by 2002:a05:600c:1d95:b0:40b:5f03:b3ca with SMTP id
 p21-20020a05600c1d9500b0040b5f03b3camr131680wms.236.1702063939942; Fri, 08
 Dec 2023 11:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW4LjmUKj1q6RWdL@krava> <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net> <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net> <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net> <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net> <20231208134041.GD28727@noisy.programming.kicks-ass.net>
In-Reply-To: <20231208134041.GD28727@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 11:32:07 -0800
Message-ID: <CAADnVQJFB_CPtFS3=VV=RwnP=EQRL3yEsR8wXVcicb07P8NODw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>, 
	Song Liu <songliubraving@meta.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-riscv <linux-riscv@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Joao Moreira <joao@overdrivepizza.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:41=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Dec 08, 2023 at 11:29:40AM +0100, Peter Zijlstra wrote:
> > The only problem I now have is the one XXX, I'm not entirely sure what
> > signature to use there.
>
> > @@ -119,6 +119,7 @@ int bpf_struct_ops_test_run(struct bpf_p
> >       op_idx =3D prog->expected_attach_type;
> >       err =3D bpf_struct_ops_prepare_trampoline(tlinks, link,
> >                                               &st_ops->func_models[op_i=
dx],
> > +                                             /* XXX */ NULL,
> >                                               image, image + PAGE_SIZE)=
;
> >       if (err < 0)
> >               goto out;
>
> Duh, that should ofcourse be something of dummy_ops_test_ret_fn type.
> Let me go fix that.

Right. That should work.
A bit wasteful to generate real code just to read hash from it
via cfi_get_func_hash(), but it's a neat idea.
I guess it's hard to get kcfi from __ADDRESSABLE in plain C
and sprinkling asm("cfi_xxx: .long   __kcfi_typeid..."); is worse?
Even if it's a macro ?
That macro would be used to define cfi_bpf_hash and all other stubs?

