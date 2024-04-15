Return-Path: <linux-arch+bounces-3690-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DB8A55CD
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD9C2829E8
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AA74C02;
	Mon, 15 Apr 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tea2/Kiz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796414C618;
	Mon, 15 Apr 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193193; cv=none; b=oyGavWOYcVPT0JA0PJVI36fPypkUYxz26B6Mbmg3NItV4wujmJaQoWkGFPMZYAfJxeWAMbZj2w1SYdl+cpiLPa4a13vWzDmftfsHxlqv2DNaWE06h5udYg46wDuF6KD3+wiczQcQCJirVeaqAQ2f1U/Qf5fEFCGZJdN/RUbvlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193193; c=relaxed/simple;
	bh=ku8pR4fPI9hBepSJikilRnz3nwcTSPYHoXuviR5pDOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmuqmPVcrfgDdkuIGZ5Q4OPIi3/NYf4kenHkq28NvDpwXf+u1lHZ+dGkLGgL2mcVZCdz9EazNOctUBJNLzv+hbY4gRBmfkPvFFmnEVrLsnVGskrUcqANm7JWJ1vjAwIqiV+2RHjpuvT+pMyyP8nEIegyAXHAmzUKVmj/gB/mAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tea2/Kiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30893C3277B;
	Mon, 15 Apr 2024 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713193193;
	bh=ku8pR4fPI9hBepSJikilRnz3nwcTSPYHoXuviR5pDOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tea2/KizgZ6l37ubyYjX5ONZcGfVRNrWb2Cb5hp+NJBJ12uXvXd11TgoOxY7NbUl+
	 BEhuqREMHFBztZUY0rsnLzaCNzKFKgDBjhzbyVhfUqYNhzzZFiwoclmA4dinuhjBWR
	 YhRuQef48/Mwaroi+Fb129re59ypWU3BedNnmU0Ij2GNcMHUkuIJzHGsGNbkfYxF2U
	 jsUWy3AQ21dMAQiYN5RbfsLsjYys8loP968Y6XhfACv35GjlV1XxIXM8rg82gfBNyY
	 Tn3LqpQYMSfkpZ+bVU3fL2n/y6lyEMp6AdfoSf/VitnNV+JW6e8+6VokIsR0isvQi8
	 mktqedZXqevRw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d872102372so25503891fa.0;
        Mon, 15 Apr 2024 07:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7iXDfS57YMMSI2bKUJa2ARJgsF710ysNHpBwdVLJaPBGYM7z6lG9UziXdU0aY5gp/Mxkn+8iLYB7ChamBagrmcVIkteS+zlb856nAxLgSkPmT5lRwZT0UGeX4JXctIha/eNFzdKWaywKjT25MYDzgfGq27iJEidf0DAOTajY3cDMWFCpuTuJy3ULr4Rwv0FrA7FFFrWhjkTPUMw==
X-Gm-Message-State: AOJu0Yya4+ysGEoxWHuBFxw+pAqeVvOLhLxN7ePvzFHiUhgruFMVStIJ
	1noEUVZIrpsPdsKvVtjbo/OsJpIsz1BnAnEgGxzKodNc+aME5OxPUTr0OOiz4mQbZ3f3NHr8J1L
	AcGLXjALKHXpl3du2vQI7hYxpfG8=
X-Google-Smtp-Source: AGHT+IGdVjaPR0hPefaSFdbhKr9PxPG0R7xcDqMOIqw3PaoyBHxE4zMWgaT5BEiOnDHZhIO/HRp6NYvoe70H4+1xqUQ=
X-Received: by 2002:a2e:9c4e:0:b0:2d8:4637:405f with SMTP id
 t14-20020a2e9c4e000000b002d84637405fmr3323763ljj.9.1713193191470; Mon, 15 Apr
 2024 07:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415075837.2349766-5-ardb+git@google.com> <20240415075837.2349766-8-ardb+git@google.com>
 <CAK7LNARthBeTotjUzC97zO5uL=YF31Bu_pJafyb8spcUm9sAcQ@mail.gmail.com>
In-Reply-To: <CAK7LNARthBeTotjUzC97zO5uL=YF31Bu_pJafyb8spcUm9sAcQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Apr 2024 16:59:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFyRwfRFSK=acypXWAoFWwdcF9F+E9tsrHDycNyNdW0Og@mail.gmail.com>
Message-ID: <CAMj1kXFyRwfRFSK=acypXWAoFWwdcF9F+E9tsrHDycNyNdW0Og@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] btf: Avoid weak external references
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 at 16:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 4:58=E2=80=AFPM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > If the BTF code is enabled in the build configuration, the start/stop
> > BTF markers are guaranteed to exist in the final link but not during th=
e
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
> > Note that Clang will notice that taking the address of__start_BTF canno=
t
> > yield NULL any longer, so testing for that condition is no longer
> > needed.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 9 +++++++++
> >  kernel/bpf/btf.c                  | 7 +++++--
> >  kernel/bpf/sysfs_btf.c            | 6 +++---
> >  3 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index e8449be62058..4cb3d88449e5 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -456,6 +456,7 @@
> >   * independent code.
> >   */
> >  #define PRELIMINARY_SYMBOL_DEFINITIONS                                =
 \
> > +       PRELIMINARY_BTF_DEFINITIONS                                    =
 \
> >         PROVIDE(kallsyms_addresses =3D .);                             =
   \
> >         PROVIDE(kallsyms_offsets =3D .);                               =
   \
> >         PROVIDE(kallsyms_names =3D .);                                 =
   \
> > @@ -466,6 +467,14 @@
> >         PROVIDE(kallsyms_markers =3D .);                               =
   \
> >         PROVIDE(kallsyms_seqs_of_names =3D .);
> >
> > +#ifdef CONFIG_DEBUG_INFO_BTF
> > +#define PRELIMINARY_BTF_DEFINITIONS                                   =
 \
> > +       PROVIDE(__start_BTF =3D .);                                    =
   \
> > +       PROVIDE(__stop_BTF =3D .);
> > +#else
> > +#define PRELIMINARY_BTF_DEFINITIONS
> > +#endif
> > +
>
>
>
> Is this necessary?
>

I think so.

This actually resulted in Jiri's build failure with v2, and the
realization that there was dead code in btf_parse_vmlinux() that
happily tried to load the contents of the BTF section if
CONFIG_DEBUG_INFO_BTF was not enabled to begin with.

So this is another pitfall with weak references: the symbol may
unexpectedly be missing altogether rather than only during the first
linker pass.


>
>
> The following code (BOUNDED_SECTION_BY)
> produces __start_BTF and __stop_BTF symbols
> under the same condition.
>

Indeed. So if CONFIG_DEBUG_INFO_BTF=3Dn, code can still link to
__start_BTF and __stop_BTF even though BTF is not enabled.

>
>
> /*
>  * .BTF
>  */
> #ifdef CONFIG_DEBUG_INFO_BTF
> #define BTF                                                              =
  \
>         .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {                            =
    \
>                 BOUNDED_SECTION_BY(.BTF, _BTF)                           =
     \
>         }                                                                =
\
>         . =3D ALIGN(4);                                                  =
      \
>         .BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {                    =
    \
>                 *(.BTF_ids)                                              =
  \
>         }
> #else
> #define BTF
> #endif
>
>
>
>
>
>
>
>
>
>
>
> >  /*
> >   * Read only Data
> >   */
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 90c4a32d89ff..6d46cee47ae3 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >         return ERR_PTR(err);
> >  }
> >
> > -extern char __weak __start_BTF[];
> > -extern char __weak __stop_BTF[];
> > +extern char __start_BTF[];
> > +extern char __stop_BTF[];
> >  extern struct btf *btf_vmlinux;
> >
> >  #define BPF_MAP_TYPE(_id, _ops)
> > @@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
> >         struct btf *btf =3D NULL;
> >         int err;
> >
> > +       if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > +               return ERR_PTR(-ENOENT);
> > +
> >         env =3D kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
> >         if (!env)
> >                 return ERR_PTR(-ENOMEM);
> > diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> > index ef6911aee3bb..fedb54c94cdb 100644
> > --- a/kernel/bpf/sysfs_btf.c
> > +++ b/kernel/bpf/sysfs_btf.c
> > @@ -9,8 +9,8 @@
> >  #include <linux/sysfs.h>
> >
> >  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
> > -extern char __weak __start_BTF[];
> > -extern char __weak __stop_BTF[];
> > +extern char __start_BTF[];
> > +extern char __stop_BTF[];
> >
> >  static ssize_t
> >  btf_vmlinux_read(struct file *file, struct kobject *kobj,
> > @@ -32,7 +32,7 @@ static int __init btf_vmlinux_init(void)
> >  {
> >         bin_attr_btf_vmlinux.size =3D __stop_BTF - __start_BTF;
> >
> > -       if (!__start_BTF || bin_attr_btf_vmlinux.size =3D=3D 0)
> > +       if (bin_attr_btf_vmlinux.size =3D=3D 0)
> >                 return 0;
> >
> >         btf_kobj =3D kobject_create_and_add("btf", kernel_kobj);
> > --
> > 2.44.0.683.g7961c838ac-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada

