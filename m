Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04CD261670
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgIHRLC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgIHRK7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 13:10:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99896C061757
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 10:10:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so11469752pfc.12
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+LDeT2lt9SUcFTCT7BGDtz2er/OFG3MBH42fF3G6h68=;
        b=EDOnxu3/tWXDEbO6aDonCpKCXjFECgrh/c5YRnWtoQ+SHvbswr+J9cGbiv4XUvNfrd
         Em65A52BYE3J8f195qPDI06udLHV8qdKzyftN/XsuICT3JOpkkrJjXA8SwRBW6SJFwIJ
         EzxA2KlhnfS8sc+kRLjxSmT8aJqg9Kgl+vhsMjNmF1fUU2hFGI+XhHju5+YlFt8CwMyV
         icqzwB0Hg81zggur22jiAbr8aGH6mP0aCauFgvoMG6dJURct0IpkkJdXcpVm7v0ecqQb
         mRk0w7ZSMxbIICPrnpndkBSn/Os7FI8G732QR5xMmeo6/XrIMdRBOK6LfscZl2uqp309
         p9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+LDeT2lt9SUcFTCT7BGDtz2er/OFG3MBH42fF3G6h68=;
        b=cN+rMETYER35gaXOYa3lxyQMxQeSHXwOc1DeIeVp9OwvY35/JHmV4BH2hONSKSLJdb
         FSGtMSmX41jzX+PoWivz/D5vBOeRb0vEHy+WcI1cIsBr/afcB0RcM9Azm78ovuMM25cJ
         NsLGuestyvjvDXQUACD4GWJnSA7+bpurDOxwq5OMMmrrJtoIYdgylSImN5jPvJ/0B1T1
         GlXKLYfGna6Z4OgxCcJ7vQpEtflqJU0FnHiTuR8ed+Q2i+rIgG78rmrcE4JIxp9g2UXI
         i9RqnAMbiOGKgQpQwkmIfpQKbB7dCXIf5wTeeJXrZZLLSbgjwJr8TGChzwGPnmNWnGJA
         Dbrg==
X-Gm-Message-State: AOAM533oVG1gI6TJScocAzfrdn1rSt/8O5qXEWB8Ts63jalmtPQ0paJe
        k4qnZhTZqSbg0mWWVs0mu7kFxEC4NqaXrQ==
X-Google-Smtp-Source: ABdhPJzypUk2kaMSsozZWu2eOHXNN4ZkXvherqbpQHodcqeZRg4Fd5ulTMlytF6eoxCVBPUWtIX41g==
X-Received: by 2002:a62:3812:0:b029:13e:d13d:a062 with SMTP id f18-20020a6238120000b029013ed13da062mr30916pfa.40.1599585058742;
        Tue, 08 Sep 2020 10:10:58 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id l141sm25676pfd.47.2020.09.08.10.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:10:57 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:10:52 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
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
Subject: Re: [PATCH v2 09/28] kbuild: add support for Clang LTO
Message-ID: <20200908171052.GB2743468@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-10-samitolvanen@google.com>
 <CAK7LNAQ40LGvfjca9DASXjyUgRbjFNDWZXgFtMXJ54Xmi6vwkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ40LGvfjca9DASXjyUgRbjFNDWZXgFtMXJ54Xmi6vwkg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 06, 2020 at 04:36:32AM +0900, Masahiro Yamada wrote:
> On Fri, Sep 4, 2020 at 5:31 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This change adds build system support for Clang's Link Time
> > Optimization (LTO). With -flto, instead of ELF object files, Clang
> > produces LLVM bitcode, which is compiled into native code at link
> > time, allowing the final binary to be optimized globally. For more
> > details, see:
> >
> >   https://llvm.org/docs/LinkTimeOptimization.html
> >
> > The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
> > which defaults to LTO being disabled.
> 
> What is the reason for doing this in a choice?
> To turn off LTO_CLANG for compile-testing?
> 
> I would rather want to give LTO_CLANG more chances
> to be enabled/tested.

It's a choice to prevent LTO from being enabled by default with
allyesconfig and allmodconfig. It would take hours to build these even on a
fast computer, and probably days on older hardware.

> > +ifdef CONFIG_LTO_CLANG
> > +ifdef CONFIG_THINLTO
> > +CC_FLAGS_LTO_CLANG := -flto=thin -fsplit-lto-unit
> > +KBUILD_LDFLAGS += --thinlto-cache-dir=.thinlto-cache
> 
> 
> I think this would break external module builds
> because it would create cache files in the
> kernel source tree.
> 
> External module builds should never ever touch
> the kernel tree, which is usually located under
> the read-only /usr/src/ in distros.
> 
> 
> .thinlto-cache should be created in the module tree
> when it is built with M=.

Thanks for pointing this out, I'll fix the path in v3.

> >  # Directories & files removed with 'make distclean'
> > -DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
> > +DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS .thinlto-cache
> 
> 
> 
> This was suggested in v1, but I could not understand
> why doing this in distclean was appropriate.
> 
> Is keeping cache files of kernel objects
> useful for external module builds?

No, the cache only speeds up incremental kernel builds.

> Also, please clean up .thinlto-cache for external module builds.

Ack.

Sami
