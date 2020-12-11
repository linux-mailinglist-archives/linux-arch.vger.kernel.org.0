Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAFF2D7FA6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394300AbgLKTqv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 14:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393948AbgLKTqW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 14:46:22 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F8C061793
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 11:45:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so7825275pga.7
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GVocl/rVAcj1v7+L3CkLflCJiE2AVxirIhrJAn4j9I=;
        b=j6wtErheo/tU7Bgku48rFUp7+QuVUNnuFvm4+WHjLO+i9TITt6lIvVcYuCxCt0D5zr
         wt0AqGeFiL6zD1PZM6gCCXzvqZCmIa/mMNBAdqSFaN90xNjhJxBt3cPjAeI6aGZWyh2J
         aSzsfOJAyVUGu2N9CG5xyUzYwQPoojIjTlLew37TXG9fk7FBD8M0fyRV8SBlrBG4iDLp
         hdt3jr/PR7ND8Pwa0r0z9+teI3oKNpBxdk2hZHnlSZV5SJEzv1YMCqE4WeKDguhdwStR
         TJ0XBRW4A15pEotatZWXTxkVaTA1/Jbuzi5G/kRABz7yIjkZiKyc5NFC2//8p9RdXKpP
         t8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GVocl/rVAcj1v7+L3CkLflCJiE2AVxirIhrJAn4j9I=;
        b=N8InB9MA4AEHCC7vQhW4Bp1I+wexHlF6Ren84hTuG39hddOMPVpZRO4TekNTGDSNjo
         9tHzYGp0oev4HaZwgVnf3IHKaizLbXkNdlEATidcZskOr5ny2a/fP6iPbaPJ5Qmj4k4Y
         opeHNSBwgSsrFn4OPPnbeXKMPoi0DIbXblZ0aaeZa5z/42SsysWWX306aunbkrToHf9U
         cRFoGFH0uULIKn36SppMYkgnbyqh7H54BI1DbLJd3AX4KUl5H5ud7xBfq+MS592RwIIy
         gHABB1SsMp5x9z2OmZZu1bHYlMAc+c8u9zY9ALzUEu9at2tmNiokXCi1P5iJCVimQiWC
         XnTw==
X-Gm-Message-State: AOAM531cmiwr61BTZxaaQLQj0+21XC8E/3DTFq4JdmFN2ZJPeR4UOl/z
        c1muPfWxkJBxyqDjcZZfq9D3EWlckMvivUJb3kGPYA==
X-Google-Smtp-Source: ABdhPJyLi3u5pazCd7AZxoxIsGKooQfv8JjHoQ0mQ2RZg34nU+hpk7lseJFZlqEgqXK4lYT7c3zTsqncnUueyDqfmpM=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr13208868pfy.15.1607715941064; Fri, 11
 Dec 2020 11:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-7-samitolvanen@google.com> <202012111131.E41AFFCDB@keescook>
 <CABCJKueCJhwRL1T1k6EYpUy_-Rj85K98iz5FO6K+dZLY25z8_Q@mail.gmail.com>
In-Reply-To: <CABCJKueCJhwRL1T1k6EYpUy_-Rj85K98iz5FO6K+dZLY25z8_Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Dec 2020 11:45:30 -0800
Message-ID: <CAKwvOdnBQiUeXCH9U9Cc3_4-UtC+jepV_-yD6usJRSMYjpNFrQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/16] kbuild: lto: add a default list of used symbols
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Fri, Dec 11, 2020 at 11:40 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Fri, Dec 11, 2020 at 11:32 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Dec 11, 2020 at 10:46:23AM -0800, Sami Tolvanen wrote:
> > > --- /dev/null
> > > +++ b/scripts/lto-used-symbollist
> > > @@ -0,0 +1,5 @@
> > > +memcpy
> > > +memmove
> > > +memset
> > > +__stack_chk_fail
> > > +__stack_chk_guard
> > > --
> > > 2.29.2.576.ga3fc446d84-goog
> > >
> >
> > bikeshed: Should this filename use some kind of extension, like
> > lto-user-symbols.txt or .list, to make it more human-friendly?
>
> Sure, I can rename this in the next version. Does anyone have strong
> opinions about the name and/or extension?

.txt extension would be fine.

-- 
Thanks,
~Nick Desaulniers
