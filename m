Return-Path: <linux-arch+bounces-3689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E88A55A9
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9424428689F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92B757EA;
	Mon, 15 Apr 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUVBaWHC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED374BE4;
	Mon, 15 Apr 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192915; cv=none; b=tppAJLtguHSyO0EwBPKjwpuYIfvYQAYXZtp6wMxHGAWtjuII85tnyglqtQulLXQjoWGl2GPjp7fADTnuYCKfN6dQc+Yz0Gu84LlA3TDR0GBdXOvpFuhfihulLAIuzYXWRl6UTg+CfZqO9Tjuk++mZUEvzmQgqq09UUwJWcorIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192915; c=relaxed/simple;
	bh=yDn2hW/lNFEjQCB1gxGyWpykAsZ3yzu0fv+O3nmo+PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGWhsuej951CjiHh7zC6u6iDyjoFdVuzXe/JtwgOQzXfWQRaG8bU1rEU+hEuuEGyAvNZEsxX+fPHLFvYUBQXUzx3G/f4lh6ej+rEMfI0xI8TIzofQbcZsXdzBkCU3/itIczTeEDWiuqY/qe3X8xvDpb2m046ItFZNTcdeMrgIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUVBaWHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A11CC4AF08;
	Mon, 15 Apr 2024 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713192915;
	bh=yDn2hW/lNFEjQCB1gxGyWpykAsZ3yzu0fv+O3nmo+PE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YUVBaWHCqoTZA1fwuUTuWrQYuIaHl07F30+pdiye78ib3MaJle4fCRW+GaQFHeNad
	 s1q5yzrh+OPAw4JOlE1DA6c7nDpPWToQQiu86/CdsqR2WDf4R3+ssA8y+DTg4FgaYO
	 hVm6CwxVJarnq2SQsHFMNayI+ZxDhufQkiJ3nZLq5Hbezx2TfxMFGP7ug0+rrT3asj
	 yp01OLtOx9agxqf8TEgikVU/cB+8v8OseFvSwpzPAiwDR/iv1ljVbEDM6OAljUu5wP
	 lWBu4vERska4tiRfET2dkpBTt2gMym43T97a7/I7PJ1FgrnFp/Xyd/lCjUw6H4XPhk
	 XXGjY2a776kBg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d886f17740so48714951fa.1;
        Mon, 15 Apr 2024 07:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHDJmmqr03FjFGA+Ni0paQTsFsGvm0D6Dtw5l/Z0PdqSiK5RJhJ1yD13kso1y5PteaUKxn/3DmLP/nCgGrLNPL1CLKTADDbi8SFm2j4S8NQMSmVhRvth/osts8Qgkv6+gDqLmKe3YoyHMZG3E3LA2pl5cj/5mQCq7pY45w4w==
X-Gm-Message-State: AOJu0YzcvSCUKOwv8pR9mdHmM7vEfLuT4YXcq5adRecSEEs+44PKr83T
	EFvdvu1PbFbuY3o1MLMBFpx0dr3oZyOidQ60Xe1/58c/0VE7GfV11b1rzpIDuoimFPe3xbUTxPP
	4NWrL1jBnzI6mjaz0aszrrq36jyM=
X-Google-Smtp-Source: AGHT+IGQ66Ve/NazfhjLkQ0OmB02ih7SC/F0MlgKeiiSMdYkZqeA6tfSUqtsfh0RVGBInJp+sSOUvbycEEPYREWcdYk=
X-Received: by 2002:a2e:a418:0:b0:2da:6f6e:ebda with SMTP id
 p24-20020a2ea418000000b002da6f6eebdamr1153991ljn.24.1713192913761; Mon, 15
 Apr 2024 07:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415075837.2349766-5-ardb+git@google.com> <20240415075837.2349766-8-ardb+git@google.com>
In-Reply-To: <20240415075837.2349766-8-ardb+git@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 15 Apr 2024 23:54:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARthBeTotjUzC97zO5uL=YF31Bu_pJafyb8spcUm9sAcQ@mail.gmail.com>
Message-ID: <CAK7LNARthBeTotjUzC97zO5uL=YF31Bu_pJafyb8spcUm9sAcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] btf: Avoid weak external references
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:58=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> If the BTF code is enabled in the build configuration, the start/stop
> BTF markers are guaranteed to exist in the final link but not during the
> first linker pass.
>
> Avoid GOT based relocations to these markers in the final executable by
> providing preliminary definitions that will be used by the first linker
> pass, and superseded by the actual definitions in the subsequent ones.
>
> Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF so
> that inadvertent references to this section will trigger a link failure
> if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
>
> Note that Clang will notice that taking the address of__start_BTF cannot
> yield NULL any longer, so testing for that condition is no longer
> needed.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 9 +++++++++
>  kernel/bpf/btf.c                  | 7 +++++--
>  kernel/bpf/sysfs_btf.c            | 6 +++---
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index e8449be62058..4cb3d88449e5 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -456,6 +456,7 @@
>   * independent code.
>   */
>  #define PRELIMINARY_SYMBOL_DEFINITIONS                                 \
> +       PRELIMINARY_BTF_DEFINITIONS                                     \
>         PROVIDE(kallsyms_addresses =3D .);                               =
 \
>         PROVIDE(kallsyms_offsets =3D .);                                 =
 \
>         PROVIDE(kallsyms_names =3D .);                                   =
 \
> @@ -466,6 +467,14 @@
>         PROVIDE(kallsyms_markers =3D .);                                 =
 \
>         PROVIDE(kallsyms_seqs_of_names =3D .);
>
> +#ifdef CONFIG_DEBUG_INFO_BTF
> +#define PRELIMINARY_BTF_DEFINITIONS                                    \
> +       PROVIDE(__start_BTF =3D .);                                      =
 \
> +       PROVIDE(__stop_BTF =3D .);
> +#else
> +#define PRELIMINARY_BTF_DEFINITIONS
> +#endif
> +



Is this necessary?



The following code (BOUNDED_SECTION_BY)
produces __start_BTF and __stop_BTF symbols
under the same condition.



/*
 * .BTF
 */
#ifdef CONFIG_DEBUG_INFO_BTF
#define BTF                                                                =
\
        .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {                              =
  \
                BOUNDED_SECTION_BY(.BTF, _BTF)                             =
   \
        }                                                                \
        . =3D ALIGN(4);                                                    =
    \
        .BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {                      =
  \
                *(.BTF_ids)                                                =
\
        }
#else
#define BTF
#endif











>  /*
>   * Read only Data
>   */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 90c4a32d89ff..6d46cee47ae3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr *=
attr, bpfptr_t uattr, u32 uat
>         return ERR_PTR(err);
>  }
>
> -extern char __weak __start_BTF[];
> -extern char __weak __stop_BTF[];
> +extern char __start_BTF[];
> +extern char __stop_BTF[];
>  extern struct btf *btf_vmlinux;
>
>  #define BPF_MAP_TYPE(_id, _ops)
> @@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
>         struct btf *btf =3D NULL;
>         int err;
>
> +       if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +               return ERR_PTR(-ENOENT);
> +
>         env =3D kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
>         if (!env)
>                 return ERR_PTR(-ENOMEM);
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index ef6911aee3bb..fedb54c94cdb 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -9,8 +9,8 @@
>  #include <linux/sysfs.h>
>
>  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
> -extern char __weak __start_BTF[];
> -extern char __weak __stop_BTF[];
> +extern char __start_BTF[];
> +extern char __stop_BTF[];
>
>  static ssize_t
>  btf_vmlinux_read(struct file *file, struct kobject *kobj,
> @@ -32,7 +32,7 @@ static int __init btf_vmlinux_init(void)
>  {
>         bin_attr_btf_vmlinux.size =3D __stop_BTF - __start_BTF;
>
> -       if (!__start_BTF || bin_attr_btf_vmlinux.size =3D=3D 0)
> +       if (bin_attr_btf_vmlinux.size =3D=3D 0)
>                 return 0;
>
>         btf_kobj =3D kobject_create_and_add("btf", kernel_kobj);
> --
> 2.44.0.683.g7961c838ac-goog
>


--=20
Best Regards
Masahiro Yamada

