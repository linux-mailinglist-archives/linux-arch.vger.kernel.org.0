Return-Path: <linux-arch+bounces-828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8AA80AE1A
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D5DB20B03
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDB31A8C;
	Fri,  8 Dec 2023 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3MZ0atA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BAA171E;
	Fri,  8 Dec 2023 12:41:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso25063265e9.3;
        Fri, 08 Dec 2023 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702068075; x=1702672875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj7pq+OIwUID+JMsGrWjS7UT9Bcii1A8UE8TU13OktE=;
        b=G3MZ0atAgyPACTlO2h7s/lMC/oRfCFYkG7eYNPHZso8JoPnWQajw0hBD0IMwaw2k+e
         9oEUqW7bfQoZ9A+l/ZCrSnsweIma9Tc8w6L3JKjXpRsPc6TKWWxyR0wZ8+bZa5Ok1t6Q
         agD9I28vIANLCIoPCqAE+0LdgDXekeKg86moQWI2v+kl9C7cKvyaIdptKdI2prnEABas
         GK1zoen9SwdDyfr2M80/lwFlEcx6HgOyBaOMqffzIQwN6jSffBZaZMrnIrPFGVAHrZ3M
         zAVDeICaUJz663LD3pOv3GN0VX+wXf7i55v1BI5JFdcxprDOxPJ6piluZAO+k1ktyUgf
         ZytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068075; x=1702672875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj7pq+OIwUID+JMsGrWjS7UT9Bcii1A8UE8TU13OktE=;
        b=pGiuaErv8MDscLZQpGI5Wmt4Vz2tKoQkhiHIj/M11IG7P0p4o/4HiHilhocEV8rfP8
         BEz0vHSJMygaJY2pmwLXPnlBEQDntcF4Fk5PTlErJdPY5OCeRO2OJCvA4hrRHpqIZwvm
         ib0gto0unqQeI4S9doV18QizNjth+nzlTWubGfHvkCBsWuf/Xhjrz/aTbvbF5QUE2EJa
         oF9B9uwrK756SzPL1AQJo2zJqyuTcMNabvESUpUccPWtzD7pdss9/E1J2KbN3CEeu9m1
         IuC8CoD72haV0JXBO6FjWJiraUBW0u/Jh7Y1fWsluZomYxMnReMN2D9l0hyuM7m1jYRw
         6mCA==
X-Gm-Message-State: AOJu0YxcknAraaNMAEvgBx2yDhu86S2pvZ74f/v9GzYK8fwalkASBi83
	qBH4ZQzVZyD24TXSNpa40WV4BfQazH1i2WGKqGM=
X-Google-Smtp-Source: AGHT+IERcqiD0C/8xjZJmHAgSBT2DdIylL4yKHY4jgZtfjgalQtcY6Jcz2MAn3dQVMGiGBWeMdU28s7aF98ziv0/pdE=
X-Received: by 2002:adf:f00f:0:b0:333:2f14:7642 with SMTP id
 j15-20020adff00f000000b003332f147642mr344840wro.61.1702068075072; Fri, 08 Dec
 2023 12:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net> <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net> <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net> <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net> <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
 <20231208203535.GG36716@noisy.programming.kicks-ass.net>
In-Reply-To: <20231208203535.GG36716@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 12:41:03 -0800
Message-ID: <CAADnVQJzCw=qcG+jHBYG0q0SxLPkwghni0wpgV4A4PkpgVbGPw@mail.gmail.com>
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

On Fri, Dec 8, 2023 at 12:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Dec 08, 2023 at 11:40:27AM -0800, Alexei Starovoitov wrote:
>
> > typedef void (*btf_dtor_kfunc_t)(void *);
> >         btf_dtor_kfunc_t dtor;
> > but the bpf_cgroup_release takes 'struct cgroup*'.
> > From kcfi pov void * =3D=3D struct cgroup * ?
> > Do we need to change it to 'void *cgrp' ?
>
> Yes, doing that naively like the below, gets me lovely things like:
>
> validate_case:FAIL:expect_msg unexpected error: -22
> VERIFIER LOG:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> EXPECTED MSG: 'Possibly NULL pointer passed to trusted arg0'
> #48/7    cgrp_kfunc/cgrp_kfunc_acquire_untrusted:FAIL
> run_subtest:PASS:obj_open_mem 0 nsec
> libbpf: extern (func ksym) 'bpf_cgroup_release': func_proto [148] incompa=
tible with vmlinux [125610]
> libbpf: failed to load object 'cgrp_kfunc_failure'
>
>
> But let me try rebuilding everything..
>
>
> ---
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3be5742d6f1..078b207af7f0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2145,10 +2145,11 @@ __bpf_kfunc struct task_struct *bpf_task_acquire(=
struct task_struct *p)
>   * bpf_task_release - Release the reference acquired on a task.
>   * @p: The task on which a reference is being released.
>   */
> -__bpf_kfunc void bpf_task_release(struct task_struct *p)
> +__bpf_kfunc void bpf_task_release(void *p)

Yeah. That won't work. We need a wrapper.
Since bpf prog is also calling it directly.
In progs/task_kfunc_common.h
void bpf_task_release(struct task_struct *p) __ksym;

than later both libbpf and the verifier check that
what bpf prog is calling actually matches the proto
of what is in the kernel.
Effectively we're doing strong prototype check at load time.

btw instead of EXPORT_SYMBOL_GPL(bpf_task_release)
can __ADDRESSABLE be used ?
Since it's not an export symbol.

