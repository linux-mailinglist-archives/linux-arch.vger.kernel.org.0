Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5525FD0D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgIGP1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:27:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22974 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbgIGP1G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:27:06 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 087FQVpa001816;
        Tue, 8 Sep 2020 00:26:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 087FQVpa001816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599492392;
        bh=IR6uGigyFtGDGIA+2OM5ZSYgDCjCsPA/08OP3wwPpmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HF6kxwrZWb/RyvWw0lecR13yfGnI7g+SVYuZ3GDrpLhjeQQBDFe3oweHMbptemm66
         SshCNN/29Q2UvC9TLvqIwjxGc087kf+LNwwYemZ9X8N179UEkHP+whZYbBQFKBslQI
         QLRVSs1kmDEgwP5nA60GQLqD2M/mdvIvnBM0aTB/FKDPseKBNZcIq2a2D/0zPSmgKn
         AEmqSmPA7h2X4LFcI6QPvPonC70Ag3cB7mKCBtL8/C97R4MKbM4UHwkDKT0yrD5ghL
         Zfzv833opPYiVtdnMgBuia+Ds748+7ZOS+r2vFL3fF0+vwlBvikfS9mHMkE8AAJya3
         YQxpECBRYEZSg==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id c196so3310350pfc.0;
        Mon, 07 Sep 2020 08:26:32 -0700 (PDT)
X-Gm-Message-State: AOAM531MQ94vq0bcadHaJu4h2pPF2hphNSNWiiobu5yZjv8EZaE3aG5O
        IChk22lQWldIeRKUdl3bBFeMVCfULHqrTixZCzY=
X-Google-Smtp-Source: ABdhPJzWMpKJKkob3tKKbsRMggvPdqUmZIz53kyp4B311hdgI26YjoFRx5atEqEpQRhRX5rjh34sk2xeMQI+Eblelz8=
X-Received: by 2002:a62:e116:: with SMTP id q22mr9587524pfh.179.1599492391141;
 Mon, 07 Sep 2020 08:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200903203053.3411268-14-samitolvanen@google.com>
In-Reply-To: <20200903203053.3411268-14-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Sep 2020 00:25:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnh-7a8Lq-y2u72cnk2uxSuWxjaZ8Y-JHCYu5gwt7Ekg@mail.gmail.com>
Message-ID: <CAK7LNARnh-7a8Lq-y2u72cnk2uxSuWxjaZ8Y-JHCYu5gwt7Ekg@mail.gmail.com>
Subject: Re: [PATCH v2 13/28] kbuild: lto: merge module sections
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 4, 2020 at 5:31 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> LLD always splits sections with LTO, which increases module sizes. This
> change adds a linker script that merges the split sections in the final
> module.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile               |  2 ++
>  scripts/module-lto.lds | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 scripts/module-lto.lds
>
> diff --git a/Makefile b/Makefile
> index c69e07bd506a..bb82a4323f1d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -921,6 +921,8 @@ CC_FLAGS_LTO_CLANG += -fvisibility=default
>  # Limit inlining across translation units to reduce binary size
>  LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
>  KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
> +
> +KBUILD_LDS_MODULE += $(srctree)/scripts/module-lto.lds
>  endif
>
>  ifdef CONFIG_LTO
> diff --git a/scripts/module-lto.lds b/scripts/module-lto.lds
> new file mode 100644
> index 000000000000..cbb11dc3639a
> --- /dev/null
> +++ b/scripts/module-lto.lds
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
> + * -ffunction-sections, which increases the size of the final module.
> + * Merge the split sections in the final binary.
> + */
> +SECTIONS {
> +       __patchable_function_entries : { *(__patchable_function_entries) }
> +
> +       .bss : {
> +               *(.bss .bss.[0-9a-zA-Z_]*)
> +               *(.bss..L*)
> +       }
> +
> +       .data : {
> +               *(.data .data.[0-9a-zA-Z_]*)
> +               *(.data..L*)
> +       }
> +
> +       .rodata : {
> +               *(.rodata .rodata.[0-9a-zA-Z_]*)
> +               *(.rodata..L*)
> +       }
> +
> +       .text : { *(.text .text.[0-9a-zA-Z_]*) }
> +}
> --
> 2.28.0.402.g5ffc5be6b7-goog
>


After I apply https://patchwork.kernel.org/patch/11757323/,
is it possible to do like this ?


#ifdef CONFIG_LTO
SECTIONS {
     ...
};
#endif

in scripts/module.lds.S


-- 
Best Regards
Masahiro Yamada
