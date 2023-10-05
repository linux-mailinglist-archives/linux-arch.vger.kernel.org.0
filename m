Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8407A7BA20C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Oct 2023 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjJEPMG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Oct 2023 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjJEPKv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2023 11:10:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235E24872;
        Thu,  5 Oct 2023 07:42:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E43C116B2;
        Thu,  5 Oct 2023 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696495568;
        bh=O28cSR7Cr0eaFyJrtrwVYzzFWiveIlOT1XkgOooL/4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IzRXU9Px5c3n01w2hL6TXrXk0qmB6XiEmc76egnT7MIKU2kJMXj+veSRyx9gk4Nef
         BxALI5NcIMpUB3Nb9X0XLivJGiGrpTFmGpocJh3NqNLFuODlIT8nwx/zF1T7FOeK0s
         J9oAGx8xCNAi2qgQ/FuLMRJCvTGsLX3gsaXMlJxqEBJneCO6njbN3SjC2Yl2ze3rCG
         9wkmiENLlRuX+sSY4jXINvd9d1CkljE0exJU9PCQnJ+tJYFVTZ0cto/uGA7DhekYSr
         66LoQmvNDibzrqqPyfZluS6pW4QPSrH2ZJgKlDFEJNbKJ4bI5btl0/d5fS96tUkZXP
         2itiGfBdegm1A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c007d6159aso8368701fa.3;
        Thu, 05 Oct 2023 01:46:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6P0EPJY2s5XILjLj5N5M7XKteYJqK9t3vuqFqPFoPQCbTTU3i
        CDqxWFY3pAfFxJCbj3cO+3M3RPM3we/2f12X40M=
X-Google-Smtp-Source: AGHT+IEtADSVn35WZ581174ge4XxOAWcE6fmbw7gaKYUjPnOtoz7NBJuPN55+Y62R/ndYxbc8dOuHuJ5Qfwv9XH3LqU=
X-Received: by 2002:a2e:b70d:0:b0:2bc:b224:98ac with SMTP id
 j13-20020a2eb70d000000b002bcb22498acmr4498033ljo.31.1696495566957; Thu, 05
 Oct 2023 01:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <72e80688.8a8.18ad9bba905.Coremail.wangkailong@jari.cn>
In-Reply-To: <72e80688.8a8.18ad9bba905.Coremail.wangkailong@jari.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Oct 2023 10:45:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXkVRKf6tq04MvP4FYsTBRPAjHSdgcvvu+NU=vXZpjXA@mail.gmail.com>
Message-ID: <CAMj1kXEXkVRKf6tq04MvP4FYsTBRPAjHSdgcvvu+NU=vXZpjXA@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: Clean up errors in vmlinux.lds.h
To:     KaiLong Wang <wangkailong@jari.cn>
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 28 Sept 2023 at 05:02, KaiLong Wang <wangkailong@jari.cn> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that ':' (ctx:WxV)
> ERROR: space required after that ',' (ctx:VxO)
> ERROR: need consistent spacing around '*' (ctx:VxW)
>
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

NAK

Please don't use checkpatch without testing the result. And please
don't go around running checkpatch on existing source files to
generate cosmetic patches: checkpatch is useful for new code
contributions but there is no desire in the community to make the
entire existing code base checkpatch-clean (and given this broken
patch, that is not even possible)

checkpatch does not work for linker scripts and this header file is
#include'd by linker scripts exclusively.

If you are looking for ways to start contributing to the linux kernel,
have a look at drivers/staging instead of proposing cosmetic 'fixes'
that break the code.



> ---
>  include/asm-generic/vmlinux.lds.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 9c59409104f6..9e19234bbf97 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -63,8 +63,8 @@
>   * up in the PT_NOTE Program Header.
>   */
>  #ifdef EMITS_PT_NOTE
> -#define NOTES_HEADERS          :text :note
> -#define NOTES_HEADERS_RESTORE  __restore_ph : { *(.__restore_ph) } :text
> +#define NOTES_HEADERS : text : note
> +#define NOTES_HEADERS_RESTORE  __restore_ph : { *(.__restore_ph) } : text
>  #else
>  #define NOTES_HEADERS
>  #define NOTES_HEADERS_RESTORE
> @@ -98,10 +98,10 @@
>   */
>  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_] * .data..L * .data..compoundliteral * .data.$__unnamed_ * .data.$L*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> -#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
> -#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> +#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_] * .rodata..L*
> +#define BSS_MAIN .bss .bss.[0-9a-zA-Z_] * .bss..compoundliteral*
>  #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
>  #else
>  #define TEXT_MAIN .text
> @@ -294,7 +294,7 @@
>  #ifdef CONFIG_SERIAL_EARLYCON
>  #define EARLYCON_TABLE()                                               \
>         . = ALIGN(8);                                                   \
> -       BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
> +       BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table,, _end)
>  #else
>  #define EARLYCON_TABLE()
>  #endif
> @@ -462,7 +462,7 @@
>         . = ALIGN((align));                                             \
>         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
>                 __start_rodata = .;                                     \
> -               *(.rodata) *(.rodata.*)                                 \
> +               *(.rodata) * (.rodata.*)                                        \
>                 SCHED_DATA                                              \
>                 RO_AFTER_INIT_DATA      /* Read only after init */      \
>                 . = ALIGN(8);                                           \
> @@ -494,28 +494,28 @@
>         /* Kernel symbol table: Normal symbols */                       \
>         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
>                 __start___ksymtab = .;                                  \
> -               KEEP(*(SORT(___ksymtab+*)))                             \
> +               KEEP(*(SORT(___ksymtab+ *)))                            \
>                 __stop___ksymtab = .;                                   \
>         }                                                               \
>                                                                         \
>         /* Kernel symbol table: GPL-only symbols */                     \
>         __ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {     \
>                 __start___ksymtab_gpl = .;                              \
> -               KEEP(*(SORT(___ksymtab_gpl+*)))                         \
> +               KEEP(*(SORT(___ksymtab_gpl+ *)))                        \
>                 __stop___ksymtab_gpl = .;                               \
>         }                                                               \
>                                                                         \
>         /* Kernel symbol table: Normal symbols */                       \
>         __kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {         \
>                 __start___kcrctab = .;                                  \
> -               KEEP(*(SORT(___kcrctab+*)))                             \
> +               KEEP(*(SORT(___kcrctab+ *)))                            \
>                 __stop___kcrctab = .;                                   \
>         }                                                               \
>                                                                         \
>         /* Kernel symbol table: GPL-only symbols */                     \
>         __kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {     \
>                 __start___kcrctab_gpl = .;                              \
> -               KEEP(*(SORT(___kcrctab_gpl+*)))                         \
> +               KEEP(*(SORT(___kcrctab_gpl+ *)))                        \
>                 __stop___kcrctab_gpl = .;                               \
>         }                                                               \
>                                                                         \
> --
> 2.17.1
