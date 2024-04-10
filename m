Return-Path: <linux-arch+bounces-3530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07E89EDC2
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC581F21B42
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0754154BF4;
	Wed, 10 Apr 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGO9oWBZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFB13D607;
	Wed, 10 Apr 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738276; cv=none; b=jz2I4emDBYohjlhehEcsNiAjjmdcqvaiTxQJPRq5DeSarjwoNs3wtDUU7RDMMjsKtxgNMmRgI7LjkjEMhtJiBZw3ioF+TS3IaDHoGo7cq1OiagauSSv8TRi6YQLRlf1dTbtzaDefZPu4qD2DPLAH2ni7q6mrFUbD4hQjyeCpwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738276; c=relaxed/simple;
	bh=yIdIemOnTziXqNpLh8yEnKKFNrbqsF06OfPzOTHOcbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJBItvxM+FwovXWJB0ul/mwYdvs7WCbIrDrfJZWZ0oZ74s0RbH5DhhNZD9TRg6yVpFioo1rUVnX/GK5CnuHiwGDiNWTnIvAWSoKs3ZviQ65F5VU/N6UgBM5WYgJRU+kI+gYhf1QjJRaw0Uy2ckll/W29Wq+icSNweBnAs/A4kAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGO9oWBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45198C433C7;
	Wed, 10 Apr 2024 08:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712738276;
	bh=yIdIemOnTziXqNpLh8yEnKKFNrbqsF06OfPzOTHOcbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TGO9oWBZCnrkYFJOnvj3/5hP17eIupKKEZ7xBFRoxiLlPLTvn+gRNNzzRUi2KKZEN
	 JDSJOtOkQQg0c6febzk8GxIYwf/bESKqGHh3gkuUfGL+v6JpdH16QE5FdIKENbrVCB
	 MoojmL+l1IUBPUj+2W+EccTK/yPb75RcBdxCvKen/9FACh7XU/Ry6MPQUg3h6YRxMJ
	 uGq39KL1RYomMCTLpqziztv377/AjsBrqOPJIuZduu3ZSrq/x5QpjW0KIW5iYnB9A6
	 HCkYQ47agBokjq1I5snV56G3pj7m21ataYtEhKEnPPjgiKM2chSFf71hdYCkrV3gPy
	 h/vxegaUrI3CQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d858501412so82635331fa.0;
        Wed, 10 Apr 2024 01:37:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVsc6dFgsAV6NvHL1biywmssl/Wl1cEsatiCczFqm7Me+40Ff711Bn2PtUoVOaL3TDP0s0mlcsMldMeOU9q8iVVDuemuoIPGJjMpiMuAXvLTM1na1omLtw+MVFZTk6sDEmJckeFh87KPjrC+41HpjpAJFraOHvE/HcXezbexX5WQoTr9/d6YBrUJTDrXsWUO+eMeOzEAydxg/t3w==
X-Gm-Message-State: AOJu0Yw3NCoMiDlC2o4pzTGFSiOUt5sgSYLETq0ec1mE2yz5w2+dVvsg
	TKqdc6t+Ap/hlMFsbqlz1peX5hgdsdHhe5GVW49fuTCqdQF9rg3oKdMu8btv4w/CMwNMWI/U/NV
	hEkDBfK4KLRoeS0jJXN5JX0kENRM=
X-Google-Smtp-Source: AGHT+IErSky0zBx8VsJq18v2HDQ+IG2X2DLhHy2ORhAG5DQJYR3dQ/hVwRYoQ6FiWK4PuY4e2gnC4YDKAM8JXi22gts=
X-Received: by 2002:a05:651c:169c:b0:2d6:ff04:200f with SMTP id
 bd28-20020a05651c169c00b002d6ff04200fmr1261201ljb.33.1712738274441; Wed, 10
 Apr 2024 01:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409150132.4097042-5-ardb+git@google.com> <20240409150132.4097042-8-ardb+git@google.com>
 <ZhZMITbXAR63hkoD@krava>
In-Reply-To: <ZhZMITbXAR63hkoD@krava>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 10 Apr 2024 10:37:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHuHVJn9H62GeA8kHNXm8L39BdCowebFkeCcNfYN29DjA@mail.gmail.com>
Message-ID: <CAMj1kXHuHVJn9H62GeA8kHNXm8L39BdCowebFkeCcNfYN29DjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btf: Avoid weak external references
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 10:22, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Apr 09, 2024 at 05:01:36PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > If the BTF code is enabled in the build configuration, the start/stop
> > BTF markers are guaranteed to exist in the final link but not during the
> > first linker pass.
> >
> > Avoid GOT based relocations to these markers in the final executable by
> > providing preliminary definitions that will be used by the first linker
> > pass, and superseded by the actual definitions in the subsequent ones.
> >
> > Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF so
> > that inadvertent references to this section will trigger a link failure
> > if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
> >
> > Note that Clang will notice that taking the address of__start_BTF cannot
> > yield NULL any longer, so testing for that condition is no longer
> > needed.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 9 +++++++++
> >  kernel/bpf/btf.c                  | 4 ++--
> >  kernel/bpf/sysfs_btf.c            | 6 +++---
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index e8449be62058..4cb3d88449e5 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -456,6 +456,7 @@
> >   * independent code.
> >   */
> >  #define PRELIMINARY_SYMBOL_DEFINITIONS                                       \
> > +     PRELIMINARY_BTF_DEFINITIONS                                     \
> >       PROVIDE(kallsyms_addresses = .);                                \
> >       PROVIDE(kallsyms_offsets = .);                                  \
> >       PROVIDE(kallsyms_names = .);                                    \
> > @@ -466,6 +467,14 @@
> >       PROVIDE(kallsyms_markers = .);                                  \
> >       PROVIDE(kallsyms_seqs_of_names = .);
> >
> > +#ifdef CONFIG_DEBUG_INFO_BTF
> > +#define PRELIMINARY_BTF_DEFINITIONS                                  \
> > +     PROVIDE(__start_BTF = .);                                       \
> > +     PROVIDE(__stop_BTF = .);
> > +#else
> > +#define PRELIMINARY_BTF_DEFINITIONS
> > +#endif
>
> hi,
> I'm getting following compilation fail when CONFIG_DEBUG_INFO_BTF is disabled
>
>         [jolsa@krava linux-qemu]$ make
>           CALL    scripts/checksyscalls.sh
>           DESCEND objtool
>           INSTALL libsubcmd_headers
>           UPD     include/generated/utsversion.h
>           CC      init/version-timestamp.o
>           LD      .tmp_vmlinux.kallsyms1
>         ld: kernel/bpf/btf.o: in function `btf_parse_vmlinux':
>         /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5988: undefined reference to `__start_BTF'
>         ld: /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5989: undefined reference to `__stop_BTF'
>         ld: /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5989: undefined reference to `__start_BTF'
>         make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
>         make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1160: vmlinux] Error 2
>         make: *** [Makefile:240: __sub-make] Error 2
>
> maybe the assumption was that kernel/bpf/btf.o is compiled only
> for CONFIG_DEBUG_INFO_BTF, but it's actually:
>
>   obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
>

Interesting. I did build test this with and without
CONFIG_DEBUG_INFO_BTF, but not with CONFIG_BPF_SYSCALL=y and
CONFIG_DEBUG_INFO_BTF=n.

> I guess we just need !CONFIG_DEBUG_INFO_BTF version of btf_parse_vmlinux
> function
>

The below gives me a working build.

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
        struct btf *btf = NULL;
        int err;

+       if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+               return ERR_PTR(-ENOENT);
+
        env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
        if (!env)
                return ERR_PTR(-ENOMEM);

