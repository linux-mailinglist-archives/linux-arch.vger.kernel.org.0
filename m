Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A1F7054E7
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEPRWo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPRWn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 13:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2261FC
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 10:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC3663D1C
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 17:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B670FC4339C
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684257760;
        bh=QFT/8CGCepmbME6J6M+gcmIcYl3norv2iZWOWagx40U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NkQprYZuTHQOpEmZdpSUH0reJ/a9H2yMYI4vE8GjGvrriDG19/3zdJDw2b5TTMoLA
         mAw+pQJuq7fuHYENt7uKVWSK/7B10Iio6yUMKFfP1JRMikVYUvGGCi/py/4rOAWASs
         zrNoUSUwhlZETlpcj1GAYaW0IDKWmUAFaNGuA2dg334B9W6YPhIdnAD4LNKjNzjk7Q
         k0VeHH4+uSEPX92foRkdf2R1gGu0T4TXjbc5Ph+HxRfIUmDRh06dM9gDkhbP1XjLeq
         2JWgLKcg5OQxketGQ8BpheTZGAtM0am7oDxDSkM0fkXW3oNZkC8FPkijR33ZPGMsOW
         s3rTz8NB3F84A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f24ceae142so13147311e87.3
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 10:22:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDwg8MoHaSdZQMg++5k1eQJuLVoPC6I2oW25plnY1xuj0LYD0jNr
        n4JZZOYKt7+xL5Pg+QzQV/KeaaMad8vmIDcaakE=
X-Google-Smtp-Source: ACHHUZ5dOHOQbEgToKxwzPr2IS3v2p/hDA7R1vjtStTSP9sPEuDt+dm/1O8Jn4nJtQXKjlcA65LWY76TwVwtVGFUj7U=
X-Received: by 2002:ac2:44b2:0:b0:4ec:8d50:d124 with SMTP id
 c18-20020ac244b2000000b004ec8d50d124mr8248210lfm.48.1684257758772; Tue, 16
 May 2023 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230504174320.3930345-1-ardb@kernel.org> <CAKwvOd=uh9wmaWD8ksQYDqbJv7qO483oFa=dyULhmnfF8KhbNg@mail.gmail.com>
In-Reply-To: <CAKwvOd=uh9wmaWD8ksQYDqbJv7qO483oFa=dyULhmnfF8KhbNg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:22:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGZNe9FsCWAy=M3m=+A=v5HOGDy0QfkgvhSwDV14REoLQ@mail.gmail.com>
Message-ID: <CAMj1kXGZNe9FsCWAy=M3m=+A=v5HOGDy0QfkgvhSwDV14REoLQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kallsyms: Avoid weak references for kallsyms symbols
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 15 May 2023 at 23:29, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Thu, May 4, 2023 at 10:43=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > kallsyms is a directory of all the symbols in the vmlinux binary, and s=
o
> > creating it is somewhat of a chicken-and-egg problem, as its non-zero
> > size affects the layout of the binary, and therefore the values of the
> > symbols.
> >
> > For this reason, the kernel is linked more than once, and the first pas=
s
> > does not include any kallsyms data at all. For the linker to accept
> > this, the symbol declarations describing the kallsyms metadata are
> > emitted as having weak linkage, so they can remain unsatisfied. During
> > the subsequent passes, the weak references are satisfied by the kallsym=
s
> > metadata that was constructed based on information gathered from the
> > preceding passes.
> >
> > Weak references lead to somewhat worse codegen, because taking their
> > address may need to produce NULL (if the reference was unsatisfied), an=
d
> > this is not usually supported by RIP or PC relative symbol references.
> >
> > Given that these references are ultimately always satisfied in the fina=
l
> > link, let's drop the weak annotation, and instead, provide fallback
> > definitions in the linker script that are only emitted if an unsatisfie=
d
> > reference exists.
> >
> > While at it, drop the FRV specific annotation that these symbols reside
> > in .rodata - FRV is long gone.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Fangrui Song <maskray@google.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the patch.  I did some quick boot tests of this with:
> - x86 defconfig + CONFIG_KALLSYMS_SELFTEST=3Dy
> - x86 defconfig + CONFIG_KALLSYMS_SELFTEST=3Dy + CONFIG_LTO_CLANG_THIN=3D=
y
> - arm64 defconfig + CONFIG_KALLSYMS_SELFTEST=3Dy
>
> Curiously, I only see:
> [    1.002200] kallsyms_selftest: start
>
> in the output (when grepping for kallsyms_selftest as instructed by
> the help text for KALLSYMS_SELFTEST in init/Kconfig). But that happens
> regardless of this patch.
>
> I did not test backtraces or live patching (seems like kallsyms is
> related to those reading through the help texts in init/Kconfig), or
> measure for binary changes.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
>
> Based on my interpretation of
> https://sourceware.org/binutils/docs/ld/PROVIDE.html, this LGTM.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>

Thanks!

> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h |  9 +++++++
> >  kernel/kallsyms.c                 |  6 -----
> >  kernel/kallsyms_internal.h        | 25 +++++++-------------
> >  3 files changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index d1f57e4868ed341d..dd42c0fcad2b519f 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -460,6 +460,15 @@
> >   */
> >  #define RO_DATA(align)                                                =
 \
> >         . =3D ALIGN((align));                                          =
   \
> > +       PROVIDE(kallsyms_addresses =3D .);                             =
   \
> > +       PROVIDE(kallsyms_offsets =3D .);                               =
   \
> > +       PROVIDE(kallsyms_names =3D .);                                 =
   \
> > +       PROVIDE(kallsyms_num_syms =3D .);                              =
   \
> > +       PROVIDE(kallsyms_relative_base =3D .);                         =
   \
> > +       PROVIDE(kallsyms_token_table =3D .);                           =
   \
> > +       PROVIDE(kallsyms_token_index =3D .);                           =
   \
> > +       PROVIDE(kallsyms_markers =3D .);                               =
   \
> > +       PROVIDE(kallsyms_seqs_of_names =3D .);                         =
   \
> >         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {          =
 \
> >                 __start_rodata =3D .;                                  =
   \
> >                 *(.rodata) *(.rodata.*)                                =
 \
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 77747391f49b66cb..5b16009ee53aa05b 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -331,12 +331,6 @@ static unsigned long get_symbol_pos(unsigned long =
addr,
> >         unsigned long symbol_start =3D 0, symbol_end =3D 0;
> >         unsigned long i, low, high, mid;
> >
> > -       /* This kernel should never had been booted. */
> > -       if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
> > -               BUG_ON(!kallsyms_addresses);
> > -       else
> > -               BUG_ON(!kallsyms_offsets);
>
> Even previously with weak definitions, wouldn't these values always be tr=
ue?
>

To be pedantic: this patch does not deal with weak definitions at all.
It only deals with weak *references*, which can remain unsatisfied.

In this particular case, one of these would remain unsatisfied, while
the other one needs to be defined in order for kallsyms not to crash
and burn as soon as it is used. After this change, both will always be
non-NULL, hence the removal.

> > -
> >         /* Do a binary search on the sorted kallsyms_addresses array. *=
/
> >         low =3D 0;
> >         high =3D kallsyms_num_syms;
> > diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> > index 27fabdcc40f57931..cf4124dbcc5b6d0e 100644
> > --- a/kernel/kallsyms_internal.h
> > +++ b/kernel/kallsyms_internal.h
> > @@ -8,24 +8,17 @@
> >   * These will be re-linked against their real values
> >   * during the second link stage.
> >   */
> > -extern const unsigned long kallsyms_addresses[] __weak;
> > -extern const int kallsyms_offsets[] __weak;
> > -extern const u8 kallsyms_names[] __weak;
> > +extern const unsigned long kallsyms_addresses[];
> > +extern const int kallsyms_offsets[];
> > +extern const u8 kallsyms_names[];
> >
> > -/*
> > - * Tell the compiler that the count isn't in the small data section if=
 the arch
> > - * has one (eg: FRV).
> > - */
> > -extern const unsigned int kallsyms_num_syms
> > -__section(".rodata") __attribute__((weak));
> > -
> > -extern const unsigned long kallsyms_relative_base
> > -__section(".rodata") __attribute__((weak));
> > +extern const unsigned int kallsyms_num_syms;
> > +extern const unsigned long kallsyms_relative_base;
> >
> > -extern const char kallsyms_token_table[] __weak;
> > -extern const u16 kallsyms_token_index[] __weak;
> > +extern const char kallsyms_token_table[];
> > +extern const u16 kallsyms_token_index[];
> >
> > -extern const unsigned int kallsyms_markers[] __weak;
> > -extern const u8 kallsyms_seqs_of_names[] __weak;
> > +extern const unsigned int kallsyms_markers[];
> > +extern const u8 kallsyms_seqs_of_names[];
> >
> >  #endif // LINUX_KALLSYMS_INTERNAL_H_
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
