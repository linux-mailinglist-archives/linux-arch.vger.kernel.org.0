Return-Path: <linux-arch+bounces-3919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA408AE86B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410661F23310
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6089136983;
	Tue, 23 Apr 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4kl05cm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C6290F;
	Tue, 23 Apr 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879904; cv=none; b=NcAKCQF9l10dQnqP7Cmv2gK4c9QeE4yDHyhGsJpphwkczjtAkYrfCZvCZWQlOCN8NK2gZHV9q/fzTWfr71MxzTCc8vRhlUh94CJIuTVn0IhCiEe6dA75/MaTAh6RTOmgmc3fZLIDnS/Ddx2C0l/WHlxnizOzFYHnFd/Q7y6K1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879904; c=relaxed/simple;
	bh=zWK2ReDFbkliJtaNVR7CmsOANV76XcgqSo5F0cqc4rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oo8Zx2cPxXFrEyXYud75gY5vA7hJPZ/wiGcPTJfvCkFZcc6t4DlEK0LkR2HyOCy9WeB+iUfl4JLbgQOA2sylE2wbu4sVEZm3aWF6w46PR2a4OpUnzdWDmMMkFJ0gnZor9am3tuMfqUrAU5cPB5dCTQBtthEC3EwOhqdLwgbx2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4kl05cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220ECC32783;
	Tue, 23 Apr 2024 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713879904;
	bh=zWK2ReDFbkliJtaNVR7CmsOANV76XcgqSo5F0cqc4rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4kl05cml6OpRcGFHeQw9n3dATJ/Ob+Tc/PDPgR76CXhiaG8ll72J+9JZ8il2UPUP
	 y7QgwvZQOVjw2Bnm+UYZ4XJY6XvauiC83A7eYqWphs9M25ZTugbLtEO8o7sful4gWg
	 fx82dtiy/pGO2gfDRbRF+aJAsmB3NtBxqTskQzoXcxCuNgoKMdTxYtIHy9vfkBn5iQ
	 GxZe066I4Nk+/k5ZKq4tnY2pKhoEcJCmcLpH/bN8tSBxWyYTjr62NtRHkuEo5w/zyt
	 Nqa3/GOhS8cKz2xj3fcy6FDdOlHsWfWiZ+i/a3J1ASsbKTsSOQ+7MXY+ukV5tpfHaA
	 EMQC3bu6GPNVw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d2600569so7150292e87.0;
        Tue, 23 Apr 2024 06:45:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb0kuXropkWuunCugs5zOPoe7oQ/cwZ/QVFju6sSepS4uAFn1N9ArHVP9B/PHy2HM69cXbcMtphi/TnSgsubfRXh4p7DJhbk+V8AhIPY370NGaBtin4UeyE2GxW92EXr1a0RYJRsUrSbuXuYvxjF0HwHDmlOnEvleb90+LKQ==
X-Gm-Message-State: AOJu0YzVDO/Ssv1exOOz4quoR6Fpo6kZlxU0cyIya8O4M3on76BEZJ74
	MytUh8wGuBhetvKQ93y/k2CQ+XtOuM0MkdfHvRfma65/hvkir4wvjPL5k5NwfY1dpcBbJqcV7If
	rqT7AqGmSMxQSF0DW13Z2gYDnim8=
X-Google-Smtp-Source: AGHT+IGYNwxeuuPgiHKtxd4oJygpTKk9VWJFI3uQjC7JbCruESydOS1HJ9g7YXGPSpKzTcYy2uUHXvX/yneINltO5BE=
X-Received: by 2002:a2e:9a95:0:b0:2da:9f24:44a8 with SMTP id
 p21-20020a2e9a95000000b002da9f2444a8mr9158584lji.11.1713879902758; Tue, 23
 Apr 2024 06:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <20240415162041.2491523-6-ardb+git@google.com>
In-Reply-To: <20240415162041.2491523-6-ardb+git@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 23 Apr 2024 22:44:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQi33YR35QZi3gX8Gfe-J3mfuEB5GWjmfT7W07mjmgKYw@mail.gmail.com>
Message-ID: <CAK7LNAQi33YR35QZi3gX8Gfe-J3mfuEB5GWjmfT7W07mjmgKYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kallsyms: Avoid weak references for kallsyms symbols
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:20=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> kallsyms is a directory of all the symbols in the vmlinux binary, and so
> creating it is somewhat of a chicken-and-egg problem, as its non-zero
> size affects the layout of the binary, and therefore the values of the
> symbols.
>
> For this reason, the kernel is linked more than once, and the first pass
> does not include any kallsyms data at all. For the linker to accept
> this, the symbol declarations describing the kallsyms metadata are
> emitted as having weak linkage, so they can remain unsatisfied. During
> the subsequent passes, the weak references are satisfied by the kallsyms
> metadata that was constructed based on information gathered from the
> preceding passes.
>
> Weak references lead to somewhat worse codegen, because taking their
> address may need to produce NULL (if the reference was unsatisfied), and
> this is not usually supported by RIP or PC relative symbol references.
>
> Given that these references are ultimately always satisfied in the final
> link, let's drop the weak annotation, and instead, provide fallback
> definitions in the linker script that are only emitted if an unsatisfied
> reference exists.
>
> While at it, drop the FRV specific annotation that these symbols reside
> in .rodata - FRV is long gone.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.or=
g
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---


I dropped v5, and picked up this one.

Thanks.



>  include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
>  kernel/kallsyms.c                 |  6 ----
>  kernel/kallsyms_internal.h        | 30 ++++++++------------
>  3 files changed, 31 insertions(+), 24 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index f7749d0f2562..e8449be62058 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -448,11 +448,30 @@
>  #endif
>  #endif
>
> +/*
> + * Some symbol definitions will not exist yet during the first pass of t=
he
> + * link, but are guaranteed to exist in the final link. Provide prelimin=
ary
> + * definitions that will be superseded in the final link to avoid having=
 to
> + * rely on weak external linkage, which requires a GOT when used in posi=
tion
> + * independent code.
> + */
> +#define PRELIMINARY_SYMBOL_DEFINITIONS                                 \
> +       PROVIDE(kallsyms_addresses =3D .);                               =
 \
> +       PROVIDE(kallsyms_offsets =3D .);                                 =
 \
> +       PROVIDE(kallsyms_names =3D .);                                   =
 \
> +       PROVIDE(kallsyms_num_syms =3D .);                                =
 \
> +       PROVIDE(kallsyms_relative_base =3D .);                           =
 \
> +       PROVIDE(kallsyms_token_table =3D .);                             =
 \
> +       PROVIDE(kallsyms_token_index =3D .);                             =
 \
> +       PROVIDE(kallsyms_markers =3D .);                                 =
 \
> +       PROVIDE(kallsyms_seqs_of_names =3D .);
> +
>  /*
>   * Read only Data
>   */
>  #define RO_DATA(align)                                                 \
>         . =3D ALIGN((align));                                            =
 \
> +       PRELIMINARY_SYMBOL_DEFINITIONS                                  \
>         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
>                 __start_rodata =3D .;                                    =
 \
>                 *(.rodata) *(.rodata.*)                                 \
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 18edd57b5fe8..22ea19a36e6e 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -325,12 +325,6 @@ static unsigned long get_symbol_pos(unsigned long ad=
dr,
>         unsigned long symbol_start =3D 0, symbol_end =3D 0;
>         unsigned long i, low, high, mid;
>
> -       /* This kernel should never had been booted. */
> -       if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
> -               BUG_ON(!kallsyms_addresses);
> -       else
> -               BUG_ON(!kallsyms_offsets);
> -
>         /* Do a binary search on the sorted kallsyms_addresses array. */
>         low =3D 0;
>         high =3D kallsyms_num_syms;
> diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> index 27fabdcc40f5..85480274fc8f 100644
> --- a/kernel/kallsyms_internal.h
> +++ b/kernel/kallsyms_internal.h
> @@ -5,27 +5,21 @@
>  #include <linux/types.h>
>
>  /*
> - * These will be re-linked against their real values
> - * during the second link stage.
> + * These will be re-linked against their real values during the second l=
ink
> + * stage. Preliminary values must be provided in the linker script using=
 the
> + * PROVIDE() directive so that the first link stage can complete success=
fully.
>   */
> -extern const unsigned long kallsyms_addresses[] __weak;
> -extern const int kallsyms_offsets[] __weak;
> -extern const u8 kallsyms_names[] __weak;
> +extern const unsigned long kallsyms_addresses[];
> +extern const int kallsyms_offsets[];
> +extern const u8 kallsyms_names[];
>
> -/*
> - * Tell the compiler that the count isn't in the small data section if t=
he arch
> - * has one (eg: FRV).
> - */
> -extern const unsigned int kallsyms_num_syms
> -__section(".rodata") __attribute__((weak));
> -
> -extern const unsigned long kallsyms_relative_base
> -__section(".rodata") __attribute__((weak));
> +extern const unsigned int kallsyms_num_syms;
> +extern const unsigned long kallsyms_relative_base;
>
> -extern const char kallsyms_token_table[] __weak;
> -extern const u16 kallsyms_token_index[] __weak;
> +extern const char kallsyms_token_table[];
> +extern const u16 kallsyms_token_index[];
>
> -extern const unsigned int kallsyms_markers[] __weak;
> -extern const u8 kallsyms_seqs_of_names[] __weak;
> +extern const unsigned int kallsyms_markers[];
> +extern const u8 kallsyms_seqs_of_names[];
>
>  #endif // LINUX_KALLSYMS_INTERNAL_H_
> --
> 2.44.0.683.g7961c838ac-goog
>
>


--=20
Best Regards
Masahiro Yamada

