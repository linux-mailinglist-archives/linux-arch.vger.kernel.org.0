Return-Path: <linux-arch+bounces-415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF17F55A4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 01:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CF42815D7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 00:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F0EBE;
	Thu, 23 Nov 2023 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmJY+GWq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B6A3;
	Wed, 22 Nov 2023 16:51:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso192721f8f.2;
        Wed, 22 Nov 2023 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700700695; x=1701305495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFSRqxyM60XZYlWMe+LxLHgfBXsOYKs0Arhl5TpCQS8=;
        b=bmJY+GWq3HWahs4EB4IcBFCKr1jWEWsUmI39qTWI7a6JgFRrQDLrkOwr2SHVDtfNx9
         H20fSBXyqclmaofznlPdgljsYj+r53IuuZbIyaFTIMNRnr1pIfFNV9qDCQh6o3YQHlQf
         CKsBXEn2Vr2rk7RzshD9NtJ/Sp0MIWUQ2JFzq48X1KJh3/Kw+typNZ6kBZrriqSNNOAP
         M2hSva8TsLOysae6m79iY8yqe1eg7PaZ7gPVVrCibPTFcaR5dQYFcnWZOsL+SwsOSvAK
         5BjMFCVg4QYw+b9f2jcnIxpXnbg3udrx1EbH4JLcc1epdh+8UhFdpkqBy28G4YfUg//6
         c4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700700695; x=1701305495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFSRqxyM60XZYlWMe+LxLHgfBXsOYKs0Arhl5TpCQS8=;
        b=KmRJZVNDneDJEQ6QEo9KU3Ne/Yg01ezaGRtGzl3IYxDrWSHzH1pekaQXAfTnEl/sYS
         UbTTF8l/OWzrKT22Wu7ro7TvvRTusryCJQHw/ZtdUOFWykSTx+RLaCSQ2QUwKTr2mcej
         DC+jxH7bHA7nqVcrDfSU/pRA12NiX3nczLYE+NFD6v1eht7B+lcmPUzfu+q6H+6GMCJz
         NwwPm7Lx7oKfz2bIPI43ftQVxu5TTwG112MjCs4+qMvvk3PaRKi5Bl7zRY0kTIOSXJUt
         WW6EEcKHwyqHLsqyE+Agw51rNohb8G+HV88+9ieNjSSxXvVo249Dc+X7SxBNSsavMt0S
         w/bQ==
X-Gm-Message-State: AOJu0YwpfV/imgQ6saqnmbghI0/A8qa5aHE2aJJR0Xye5C/XLycT2GVw
	2q/c02Gdq3Kn29s3bILmkOO3j1JgEJTxk45Ge1E=
X-Google-Smtp-Source: AGHT+IFsZynBqDZU07UjtjyWcGDEoU4r8+d4uBQx87ACMaj5T1mQc/a3y5MZDETnfbK00TiUJQ8Ke8+6cd2ruagK5V8=
X-Received: by 2002:a05:6000:144f:b0:332:caa9:72b2 with SMTP id
 v15-20020a056000144f00b00332caa972b2mr3445384wrx.3.1700700695019; Wed, 22 Nov
 2023 16:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120144642.591358648@infradead.org> <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com>
 <20231122111517.GR8262@noisy.programming.kicks-ass.net> <20231122124134.GP4779@noisy.programming.kicks-ass.net>
In-Reply-To: <20231122124134.GP4779@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Nov 2023 16:51:23 -0800
Message-ID: <CAADnVQKhpjt0pojdYGXpeyMvJnCUVvyrRKCmHg3cKYjAs-HDmA@mail.gmail.com>
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

On Wed, Nov 22, 2023 at 4:41=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> +/*
> + * Emit the various CFI preambles, see the large comment about FineIBT
> + * in arch/x86/kernel/alternative.c

.. and in cfi.h ..
which will have a copy-paste from your other email?

>                 prog->bpf_func =3D (void *)image + ctx.prog_offset;
>                 prog->jited =3D 1;
>                 prog->jited_len =3D proglen - ctx.prog_offset; // XXX?

Just drop XXX.

> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1431,6 +1431,9 @@ struct bpf_prog_aux {
>         struct bpf_kfunc_desc_tab *kfunc_tab;
>         struct bpf_kfunc_btf_tab *kfunc_btf_tab;
>         u32 size_poke_tab;
> +#ifdef CONFIG_FINEIBT
> +       struct bpf_ksym ksym_prefix;
> +#endif
>         struct bpf_ksym ksym;
>         const struct bpf_prog_ops *ops;
>         struct bpf_map **used_maps;
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -683,6 +683,23 @@ void bpf_prog_kallsyms_add(struct bpf_pr
>         fp->aux->ksym.prog =3D true;
>
>         bpf_ksym_add(&fp->aux->ksym);
> +
> +#ifdef CONFIG_FINEIBT
> +       /*
> +        * When FineIBT, code in the __cfi_foo() symbols can get executed
> +        * and hence unwinder needs help.
> +        */

I like the idea!

> +       if (cfi_mode !=3D CFI_FINEIBT)
> +               return;

The cfi_mode var needs to be global along with enum ?
Or some new helper function from arch/x86 ?

> +
> +       snprintf(fp->aux->ksym_prefix.name, KSYM_NAME_LEN,
> +                "__cfi_%s", fp->aux->ksym.name);
> +
> +       prog->aux->ksym_prefix.start =3D (unsigned long) prog->bpf_func -=
 16;
> +       prog->aux->ksym_prefix.end   =3D (unsigned long) prog->bpf_func;
> +
> +       bpf_ksym_add(&fp->aux->ksym_prefix);
> +#endif
>  }
>
>  void bpf_prog_kallsyms_del(struct bpf_prog *fp)

and handle deletion of ksym_prefix here.

I think it's shaping up nicely.
Pls resend both patches as a set and cc bpf @ vger.
BPF CI will pick it up and test on arm64, x86-64, s390 with gcc and clang.
We don't do CONFIG_*IBT testing automatically, but
I can manually try that after the holidays.

