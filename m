Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A188340C21
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhCRRu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCRRuE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 13:50:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4608C06174A
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 10:50:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so5928803lfa.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnxu0Htej1H516ep79Wgi7n3VX+5maU9JLJNzsCgiUM=;
        b=Ni7pji1XH63Bsx+pQeydcoFnVFUKTo4EK8YEo+eRY0n8Z2OlAnJtkVrPBHxbEsi1+R
         +o0D2M9JZb3tGqGl8p3T5U+v1MyYLTUUMRcgkL4iuhrlTfi3bi87ds7MxG2e3n0KlK6i
         3dJiohcmgFoCgox4RNZsf0OK7goEnUFKbgGqAAdLekm/+D9U6DNU7jqJvakwMwfDAFa4
         v8f//XFUMtHrMKaTRuIfAgjuRPu2++XBnBmKfeuHtrLLgiyJIOsF+rgRl3qxfjWKRupz
         HuO8O/BYYDPWXJdD72MiPYs06QEHnux8aIOk5Nz61Niw4ufVgh0Hi+g9U0GNCsttzUhd
         wMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnxu0Htej1H516ep79Wgi7n3VX+5maU9JLJNzsCgiUM=;
        b=NlANW+014nEO1XNhIHnKjY90cJSSw2He2zYAmSye5EFca9acG4VlEyDboOVq4HGxml
         0/RmtzNEqqVNii0vNbC15DzcWpxeICMgzwG6qrroTN5seoGy891pmBzCI1icvyqEupzS
         hU5rJg7g7oXwJawTWQpfwD5sSYYzVKmubqkUanglsXT1caHGkzsUpi7vOKD4djlfgCrq
         arqSjUne1hIQulUHhJ7+fGz3FAJmwF86LFVSSa+qixlm8yA+P6VfHll51aoqvFcqc1xo
         SgKirMEdAS3osKd3QCS3/yNukvxj8yp2CIzmjvP8vrSO0uZvzJlrXjlN1xnzEo1Dd1Bl
         sCgg==
X-Gm-Message-State: AOAM531lVx/KkYLgPikIKwBUfOPmNm1qzn6PhiMS0PU4aBuuQKSlXQwW
        Q9Nt6K9EYCJkY+2DZXlIi4WpcpDd/dQLCsE8FGeWuCF8vZY=
X-Google-Smtp-Source: ABdhPJwKRBRM7MAUZwFeZ179486WWfFrS/ksEmFI/VqMTZ8H+kaaJb/iKuGQiKzYL2s45rV0vHLFMREgPO6HFTWGKDo=
X-Received: by 2002:a05:6512:985:: with SMTP id w5mr5887489lft.122.1616089801932;
 Thu, 18 Mar 2021 10:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com> <20210318171111.706303-3-samitolvanen@google.com>
In-Reply-To: <20210318171111.706303-3-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 10:49:50 -0700
Message-ID: <CAKwvOd=CfNmVT0RNsXw=vhTee40xpA-LjmyfagAQesS6VdAkXQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] cfi: add __cficanonical
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_CFI_CLANG, the compiler replaces a function address taken
> in C code with the address of a local jump table entry, which passes
> runtime indirect call checks. However, the compiler won't replace
> addresses taken in assembly code, which will result in a CFI failure
> if we later jump to such an address in instrumented C code. The code
> generated for the non-canonical jump table looks this:
>
>   <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
>         jmp noncanonical
>   ...
>   <noncanonical>:        /* function body */
>         ...
>
> This change adds the __cficanonical attribute, which tells the
> compiler to use a canonical jump table for the function instead. This
> means the compiler will rename the actual function to <function>.cfi
> and points the original symbol to the jump table entry instead:
>
>   <canonical>:           /* jump table entry */
>         jmp canonical.cfi
>   ...
>   <canonical.cfi>:       /* function body */
>         ...
>
> As a result, the address taken in assembly, or other non-instrumented
> code always points to the jump table and therefore, can be used for
> indirect calls in instrumented code without tripping CFI checks.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci.h

Irrelevant to this series, but I checked when the FN attr was first
available in clang; clang-10. (That's the minimum supported version of
clang for the kernel, and this series depends on LTO which depends on
clang-12, so no additional guards are necessary).

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/compiler-clang.h | 1 +
>  include/linux/compiler_types.h | 4 ++++
>  include/linux/init.h           | 4 ++--
>  include/linux/pci.h            | 4 ++--
>  4 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 6de9d0c9377e..adbe76b203e2 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -63,3 +63,4 @@
>  #endif
>
>  #define __nocfi                __attribute__((__no_sanitize__("cfi")))
> +#define __cficanonical __attribute__((__cfi_canonical_jump_table__))
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 796935a37e37..d29bda7f6ebd 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -246,6 +246,10 @@ struct ftrace_likely_data {
>  # define __nocfi
>  #endif
>
> +#ifndef __cficanonical
> +# define __cficanonical
> +#endif
> +
>  #ifndef asm_volatile_goto
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
> diff --git a/include/linux/init.h b/include/linux/init.h
> index b3ea15348fbd..045ad1650ed1 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -220,8 +220,8 @@ extern bool initcall_debug;
>         __initcall_name(initstub, __iid, id)
>
>  #define __define_initcall_stub(__stub, fn)                     \
> -       int __init __stub(void);                                \
> -       int __init __stub(void)                                 \
> +       int __init __cficanonical __stub(void);                 \
> +       int __init __cficanonical __stub(void)                  \
>         {                                                       \
>                 return fn();                                    \
>         }                                                       \
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..39684b72db91 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1944,8 +1944,8 @@ enum pci_fixup_pass {
>  #ifdef CONFIG_LTO_CLANG
>  #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,  \
>                                   class_shift, hook, stub)              \
> -       void stub(struct pci_dev *dev);                                 \
> -       void stub(struct pci_dev *dev)                                  \
> +       void __cficanonical stub(struct pci_dev *dev);                  \
> +       void __cficanonical stub(struct pci_dev *dev)                   \
>         {                                                               \
>                 hook(dev);                                              \
>         }                                                               \
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


-- 
Thanks,
~Nick Desaulniers
