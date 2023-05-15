Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738F703FCD
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 23:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbjEOV3b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 17:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245556AbjEOV33 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 17:29:29 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C310A0F
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2023 14:29:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75765c213fbso568918685a.2
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2023 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684186162; x=1686778162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lbYY6n0SwGUcyKsxDL1IIEcw7fQq3k67Vm8jiZt1PI=;
        b=oHaPXJgO8h0xuJ30mdoVzc3EcsSIH+ugZ5KaxJ9pNdfzDrKqVSfncuzpmlvH5+PMNz
         vFB70oDNkVrmfiNNuNmLqfpg7oRKIm34f4o0HQ/51a72NiOG0T3QFo1g3qfijviDmihb
         p8MGBwiG+BkxCKnCLPqm9jAxmqQe0JXNTSQYakQ8cHvNeXOPWVyRgjfeyC5QZ091YVAv
         Ba1w+gH6ILogCRJ1uDm9Izyo0vzuGGWOBg8vsEFPLIbEsAeZBzSFZC37JYK2gI6ug2+W
         JpUY50pT+7UOU+BSirsevF4kJtZ6E8XTHbNvyc4RVaLlWbbtxT70pRoUyv0zL4G6/PCS
         8Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684186162; x=1686778162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lbYY6n0SwGUcyKsxDL1IIEcw7fQq3k67Vm8jiZt1PI=;
        b=LyHNKBNNRfU0lVxaXunJo6YzLByOYn9ZqYB4BC/hi+n2Vve3jFCWnDwCK3h2DYRB5/
         CZC8Gv6koSU4v7vYJngq/hHKpku1+/+I1VZL4wi5ffQ3cRhvzRhRnzfFL2JrSmG3K4c6
         NRkqo3D3fNx0EZ9d/f++MBj8wZJrA2jr0W15gteqm/ERzLrBbzc6IRg+QE4QfATCk3jo
         q/csgzNIaJQ/SZqoGEljKCuPD2jjOUYc6ZSFIZKVG9uOp+3Zl5ZAT+wunkcDt3j7qn8J
         3Z2BNP3oKXkvVwoBBypG9x1peYKWRo3t8Dh1z5TbdKvcRXCM+CTVmbrUi3EioggguPKc
         xFvQ==
X-Gm-Message-State: AC+VfDy5J5nb3QyGKjBK/kmyG1a7f6UFoOg8AYESAkxk/t/ueYqx/Suq
        QytMmvVLXOg6c2cOxarBwUvtNSwSVNqcBeuzv9s81g==
X-Google-Smtp-Source: ACHHUZ6o4Y5deE3MywpCz4dRMiG+IGEgPmdAv3urst4Xq/TLVsMyTSbvixGAaiFTSccbqqMfyXyg15r9kizMSnXvo10=
X-Received: by 2002:a05:6214:20ce:b0:5ab:a50b:e610 with SMTP id
 14-20020a05621420ce00b005aba50be610mr64920191qve.33.1684186161858; Mon, 15
 May 2023 14:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230504174320.3930345-1-ardb@kernel.org>
In-Reply-To: <20230504174320.3930345-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 May 2023 14:29:10 -0700
Message-ID: <CAKwvOd=uh9wmaWD8ksQYDqbJv7qO483oFa=dyULhmnfF8KhbNg@mail.gmail.com>
Subject: Re: [RFC PATCH] kallsyms: Avoid weak references for kallsyms symbols
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 4, 2023 at 10:43=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
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
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch.  I did some quick boot tests of this with:
- x86 defconfig + CONFIG_KALLSYMS_SELFTEST=3Dy
- x86 defconfig + CONFIG_KALLSYMS_SELFTEST=3Dy + CONFIG_LTO_CLANG_THIN=3Dy
- arm64 defconfig + CONFIG_KALLSYMS_SELFTEST=3Dy

Curiously, I only see:
[    1.002200] kallsyms_selftest: start

in the output (when grepping for kallsyms_selftest as instructed by
the help text for KALLSYMS_SELFTEST in init/Kconfig). But that happens
regardless of this patch.

I did not test backtraces or live patching (seems like kallsyms is
related to those reading through the help texts in init/Kconfig), or
measure for binary changes.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot

Based on my interpretation of
https://sourceware.org/binutils/docs/ld/PROVIDE.html, this LGTM.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h |  9 +++++++
>  kernel/kallsyms.c                 |  6 -----
>  kernel/kallsyms_internal.h        | 25 +++++++-------------
>  3 files changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index d1f57e4868ed341d..dd42c0fcad2b519f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -460,6 +460,15 @@
>   */
>  #define RO_DATA(align)                                                 \
>         . =3D ALIGN((align));                                            =
 \
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
> +       PROVIDE(kallsyms_seqs_of_names =3D .);                           =
 \
>         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
>                 __start_rodata =3D .;                                    =
 \
>                 *(.rodata) *(.rodata.*)                                 \
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 77747391f49b66cb..5b16009ee53aa05b 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -331,12 +331,6 @@ static unsigned long get_symbol_pos(unsigned long ad=
dr,
>         unsigned long symbol_start =3D 0, symbol_end =3D 0;
>         unsigned long i, low, high, mid;
>
> -       /* This kernel should never had been booted. */
> -       if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
> -               BUG_ON(!kallsyms_addresses);
> -       else
> -               BUG_ON(!kallsyms_offsets);

Even previously with weak definitions, wouldn't these values always be true=
?

> -
>         /* Do a binary search on the sorted kallsyms_addresses array. */
>         low =3D 0;
>         high =3D kallsyms_num_syms;
> diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> index 27fabdcc40f57931..cf4124dbcc5b6d0e 100644
> --- a/kernel/kallsyms_internal.h
> +++ b/kernel/kallsyms_internal.h
> @@ -8,24 +8,17 @@
>   * These will be re-linked against their real values
>   * during the second link stage.
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
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
