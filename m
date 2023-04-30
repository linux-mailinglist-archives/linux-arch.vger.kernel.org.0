Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173C6F2932
	for <lists+linux-arch@lfdr.de>; Sun, 30 Apr 2023 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjD3OYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Apr 2023 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3OYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Apr 2023 10:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D619AF;
        Sun, 30 Apr 2023 07:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D440660B52;
        Sun, 30 Apr 2023 14:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33707C4339B;
        Sun, 30 Apr 2023 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682864649;
        bh=WUyj3KdAd9Atl/1BkhWqnGH8ctqOWWJAAQ/DHP6egtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a4yplviEOx38Wp99s2w4MVC83zgmhuv9g+r2VyqA4cqMsF4bDuIMWqmv+kxgP6d/4
         Ez6W38wtgU3uP/JosUh31ZT0WWjRWZFLrzL7wC8e0McPuFu/GPhP8ei5Rgp9LiZn5B
         kBA61cZZ9A2Z/jNrExu9vEVfh3iqhPkaWfcXh6GJZ5MPbvV9ojMxMYwjSwpKqSOnbS
         Ckt6e4A7HWs+OFDK/rNKbGVkUv3AfC8Mn9ApNjAa+pXMjcHuAOwMYEjBoNH3X4KXcF
         YC/5Vad2LV1lkfGZ+uhbp151TwG9D1bgcnSW55s8PKge3SPhKO2G2+OlF/S2Wf0OcD
         ooULd0PRupvMg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso15301281fa.2;
        Sun, 30 Apr 2023 07:24:09 -0700 (PDT)
X-Gm-Message-State: AC+VfDxshHpHDaMVc/l5IM8w0i1H6/hIvXdCfvPrbQHVbbNdDagcWJv9
        A4VBZO5EZv3YaGyhA3Tpw3MHjK+mjU4FAtg6lT4=
X-Google-Smtp-Source: ACHHUZ7iatufvCefUtOyZ/IMApy0Vb+ISlpGz7nI2uoEJ+4S+ZBqNx8ntCKsGERzEGQJY7SH9khYhduc9IuVbXP3lso=
X-Received: by 2002:a2e:8ecc:0:b0:2a8:ea1e:bde9 with SMTP id
 e12-20020a2e8ecc000000b002a8ea1ebde9mr3233347ljl.45.1682864647193; Sun, 30
 Apr 2023 07:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com> <980069339b23a6cc4ae6d605d188338467a5b08b.1682673543.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <980069339b23a6cc4ae6d605d188338467a5b08b.1682673543.git.houwenlong.hwl@antgroup.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 30 Apr 2023 16:23:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFFo6Y=p63N41DrN4wLzMNVdtD-hp6gBVQwNqrzt7oqwQ@mail.gmail.com>
Message-ID: <CAMj1kXFFo6Y=p63N41DrN4wLzMNVdtD-hp6gBVQwNqrzt7oqwQ@mail.gmail.com>
Subject: Re: [PATCH RFC 25/43] x86/mm: Make the x86 GOT read-only
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Apr 2023 at 11:55, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>
> From: Thomas Garnier <thgarnie@chromium.org>
>
> From: Thomas Garnier <thgarnie@chromium.org>
>
> The GOT is changed during early boot when relocations are applied. Make
> it read-only directly. This table exists only for PIE binary. Since weak
> symbol reference would always be GOT reference, there are 8 entries in
> GOT, but only one entry for __fentry__() is in use.  Other GOT
> references have been optimized by linker.
>
> [Hou Wenlong: Change commit message and skip GOT size check]
>
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S     |  2 ++
>  include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index f02dcde9f8a8..fa4c6582663f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -462,6 +462,7 @@ SECTIONS
>  #endif
>                "Unexpected GOT/PLT entries detected!")
>
> +#ifndef CONFIG_X86_PIE
>         /*
>          * Sections that should stay zero sized, which is safer to
>          * explicitly check instead of blindly discarding.
> @@ -470,6 +471,7 @@ SECTIONS
>                 *(.got) *(.igot.*)
>         }
>         ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> +#endif
>
>         .plt : {
>                 *(.plt) *(.plt.*) *(.iplt)
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d1f57e4868ed..438ed8b39896 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -441,6 +441,17 @@
>         __end_ro_after_init = .;
>  #endif
>
> +#ifdef CONFIG_X86_PIE
> +#define RO_GOT_X86

Please don't put X86 specific stuff in generic code.

> +       .got        : AT(ADDR(.got) - LOAD_OFFSET) {                    \
> +               __start_got = .;                                        \
> +               *(.got) *(.igot.*);                                     \
> +               __end_got = .;                                          \
> +       }
> +#else
> +#define RO_GOT_X86
> +#endif
> +

I don't think it makes sense for this definition to be conditional.
You can include it conditionally from the x86 code, but even that
seems unnecessary, given that it will be empty otherwise.

>  /*
>   * .kcfi_traps contains a list KCFI trap locations.
>   */
> @@ -486,6 +497,7 @@
>                 BOUNDED_SECTION_PRE_LABEL(.pci_fixup_suspend_late, _pci_fixups_suspend_late, __start, __end) \
>         }                                                               \
>                                                                         \
> +       RO_GOT_X86                                                      \
>         FW_LOADER_BUILT_IN_DATA                                         \
>         TRACEDATA                                                       \
>                                                                         \
> --
> 2.31.1
>
