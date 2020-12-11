Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95BC2D7F8D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394075AbgLKTlb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 14:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394047AbgLKTlP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 14:41:15 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A5C0613CF
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 11:40:35 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id j140so5418716vsd.4
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nS5LJe0V9gmSV6AI/CjiJWRU085g+HSabHeZYnNbME=;
        b=qsqg3dEZdz6yTY0b8lWmwlvvFlCl6x/6RcbpcNM5RjlQi43vCEWHYEvpvNFMgtwSJf
         92LLLXxQ2DMnh4n9P483SaIxEmprkCDc/K+JgapPX/ZZKy6aK5r4eyyfdBCtEQJhwn4x
         ouvYwbD1s6MDLHCs5KHgP2Xw3/OELzfJnu8FvoDrq3GDDw87fJYBXVbaSaOYc+0Nu1UD
         fiQbuk0q8gz7/5IDoWj0ON2iPNs+pAeF9Qty6DbvjfFV/8Wzmt8DsLQLeqTz1ozLVtyQ
         R0+WXz2Fbj8SqfTG7PiaJGfy0Ipx3UtxFa3GxMJFuDwuXo9nyWaQPdc+rxYInzhIXbQ8
         nCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nS5LJe0V9gmSV6AI/CjiJWRU085g+HSabHeZYnNbME=;
        b=k4a4ZMnUP21b8MgunUsz18DSNuFAr6VXsLJhLpbAtRLfeKYy6suvCEvP3cBPtQBxjg
         lGasbsCucEAijAZ+P2stg72R6yafv7vdBPM9n1dMPtqjtpT61i3ZdlJcljsEys8iXzxn
         RPMXWwXb0kVQu7SU7VrWaFq9DBEtsydsYDDyC2a2StduwrEdH7JtmzPwrsHeeiPALwFP
         mXOLSu8o2GhzQIbWRLLeEuF4ttvD+KP0Q5Xy7QucPewqmST2fE1hqR3b7G8Mje++9Ae5
         NY44axI2q7AB0iJgsT+YJjeBCAaE+VkZhX/Dy8HKiZen/bsiaDuaHW+4Hbafy554pH/Q
         4sxg==
X-Gm-Message-State: AOAM5301Lkf+Se69s6yfdcy7kblaQ6qK1OPAl/WIcTUCuuxdGaNL4Ey2
        W6VhTvpiGeug0yxj1Zf7NLNfuValla4sguEXbbYSAg==
X-Google-Smtp-Source: ABdhPJwTNai3fHjKtb9PFnSMalWQiVwNiqLsoEASGl1SfmNeaqyA+50KfMn1XqggqOylimJDfCS3u1qZ+Mz6kJGjBMs=
X-Received: by 2002:a67:80c8:: with SMTP id b191mr15432571vsd.36.1607715634310;
 Fri, 11 Dec 2020 11:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-7-samitolvanen@google.com> <202012111131.E41AFFCDB@keescook>
In-Reply-To: <202012111131.E41AFFCDB@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 11 Dec 2020 11:40:23 -0800
Message-ID: <CABCJKueCJhwRL1T1k6EYpUy_-Rj85K98iz5FO6K+dZLY25z8_Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/16] kbuild: lto: add a default list of used symbols
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 11, 2020 at 11:32 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 11, 2020 at 10:46:23AM -0800, Sami Tolvanen wrote:
> > With CONFIG_LTO_CLANG, LLVM bitcode has not yet been compiled into a
> > binary when the .mod files are generated, which means they don't yet
> > contain references to certain symbols that will be present in the final
> > binaries. This includes intrinsic functions, such as memcpy, memmove,
> > and memset [1], and stack protector symbols [2]. This change adds a
> > default symbol list to use with CONFIG_TRIM_UNUSED_KSYMS when Clang's
> > LTO is used.
> >
> > [1] https://llvm.org/docs/LangRef.html#standard-c-c-library-intrinsics
> > [2] https://llvm.org/docs/LangRef.html#llvm-stackprotector-intrinsic
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> > ---
> >  init/Kconfig                | 1 +
> >  scripts/lto-used-symbollist | 5 +++++
> >  2 files changed, 6 insertions(+)
> >  create mode 100644 scripts/lto-used-symbollist
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 0872a5a2e759..e88c919c1bf1 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -2297,6 +2297,7 @@ config TRIM_UNUSED_KSYMS
> >  config UNUSED_KSYMS_WHITELIST
> >       string "Whitelist of symbols to keep in ksymtab"
> >       depends on TRIM_UNUSED_KSYMS
> > +     default "scripts/lto-used-symbollist" if LTO_CLANG
> >       help
> >         By default, all unused exported symbols will be un-exported from the
> >         build when TRIM_UNUSED_KSYMS is selected.
> > diff --git a/scripts/lto-used-symbollist b/scripts/lto-used-symbollist
> > new file mode 100644
> > index 000000000000..38e7bb9ebaae
> > --- /dev/null
> > +++ b/scripts/lto-used-symbollist
> > @@ -0,0 +1,5 @@
> > +memcpy
> > +memmove
> > +memset
> > +__stack_chk_fail
> > +__stack_chk_guard
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
>
> bikeshed: Should this filename use some kind of extension, like
> lto-user-symbols.txt or .list, to make it more human-friendly?

Sure, I can rename this in the next version. Does anyone have strong
opinions about the name and/or extension?

Sami
