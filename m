Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7D2CC5FC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 19:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbgLBSyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 13:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388020AbgLBSyw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 13:54:52 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD5C0617A6
        for <linux-arch@vger.kernel.org>; Wed,  2 Dec 2020 10:54:12 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m5so1467878pjv.5
        for <linux-arch@vger.kernel.org>; Wed, 02 Dec 2020 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0+bgE4T7KwQd0o1rvb3kJK3SimQlgs22CmXZhVLCKg=;
        b=QROM0g6hLow6GZ7V4UDEra8QnuXAyNQydFYd8tPdysSPgI/afRnHzMYcjQDJs2MPB5
         4FHG2f99kdxwjDywXRoVakgANSW9WNU9vfancQ5ol/JYM0ZhkZcqC6lujqrqP2v+MmPf
         J2cFUpIzUbXWhObQk0kvkRk5lgSkJmlLPa0ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0+bgE4T7KwQd0o1rvb3kJK3SimQlgs22CmXZhVLCKg=;
        b=ApBr8PnIY8z4kT7FWTYY19B+nEAaxQl2E69Bqa+uPiZO/x24cCgLjTJOvx5pb7tu8k
         4B5sLR25yw7IrEdVSHlnInmnnRQQsKI5LE2oLU5XzqqnV/chQ3oS1dTLfk5EDvrwwKzB
         zsISaEEBd9FrQ+adGt7wHlRfmIMUw69dVX+7ynHDiBU4sp8ucMZnjkTqXQ4uaYRu0uq6
         D2w4Ct7alLxXeXikwOWXVscn4oX83ag3zgG0/+XvAJ8GLOn3LHdAkBSSDB//0BFxLa+l
         XrIkSAf8fM2EjPLIz9t2Ogd9o8KCEU50aht1BV0fFF3R4snElOnMiClL48fbiT6AGxLs
         XZDg==
X-Gm-Message-State: AOAM5318Ewc/n9DmwVeFISr6z3fOVghM/z94/z8rGLn3elseRuZK4HsX
        AXt1dpT1/3AzNvpx1SSOiUkN3g==
X-Google-Smtp-Source: ABdhPJyXCkgyp1gKYUQlD8LDgoMFvwqHsxFF5beeKPp+ajldaiiTSe5K5j/sXDeIE9XjSAHHC0sgfQ==
X-Received: by 2002:a17:902:b207:b029:d8:fdf3:af30 with SMTP id t7-20020a170902b207b02900d8fdf3af30mr3838177plr.31.1606935251732;
        Wed, 02 Dec 2020 10:54:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z17sm346946pjn.46.2020.12.02.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:54:10 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:54:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
Message-ID: <202012021042.A76E8F06@keescook>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201130120130.GF24563@willie-the-truck>
 <202012010929.3788AF5@keescook>
 <CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 11:42:21AM +0900, Masahiro Yamada wrote:
> On Wed, Dec 2, 2020 at 2:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 12:01:31PM +0000, Will Deacon wrote:
> > > Hi Sami,
> > >
> > > On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > > > This patch series adds support for building the kernel with Clang's
> > > > Link Time Optimization (LTO). In addition to performance, the primary
> > > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > > > be used in the kernel. Google has shipped millions of Pixel devices
> > > > running three major kernel versions with LTO+CFI since 2018.
> > > >
> > > > Most of the patches are build system changes for handling LLVM bitcode,
> > > > which Clang produces with LTO instead of ELF object files, postponing
> > > > ELF processing until a later stage, and ensuring initcall ordering.
> > > >
> > > > Note that v7 brings back arm64 support as Will has now staged the
> > > > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > > > on fixing the remaining objtool warnings [2].
> > >
> > > Sounds like you're going to post a v8, but that's the plan for merging
> > > that? The arm64 parts look pretty good to me now.
> >
> > I haven't seen Masahiro comment on this in a while, so given the review
> > history and its use (for years now) in Android, I will carry v8 (assuming
> > all is fine with it) it in -next unless there are objections.
> 
> 
> What I dislike about this implementation is
> it cannot drop any unreachable function/data.
> (and it is completely different from GCC LTO)

This seems to be an orthogonal concern: the kernel doesn't have GCC LTO
support either (though much of Sami's work is required for GCC LTO too).

> This is not real LTO.

I don't know what you're defining as "real LTO", but this is, very much,
Link Time Optimization: the compiler has access to the entire code at
once, and it is therefore in a position to perform many manipulations to
the code. As Sami mentioned, perhaps you're thinking specifically of
dead code elimination? That's a specific optimization.

> [thread[1] merging]
> This help document is misleading.
> People who read the document would misunderstand how great this feature would.
> 
> This should be added in the commit log and Kconfig help:
> 
>            In contrast to the example in the documentation, Clang LTO
>            for the kernel cannot remove any unreachable function or data.
>            In fact, this results in even bigger vmlinux and modules.

Which LTO passes are happening, how optimization are being performed,
etc, are endlessly tunable, but we can't work on that tuning without
the infrastructure to perform an LTO build in the first place. We need
to land the support, and go from there. As written, it works very well
for arm64 (which is what v8 targets specifically) and the results have
been running on millions of Android phones for years now. If further
tuning needs to happen for other architectures, config combinations, etc,
those can and will be developed. (For example, x86 is around the corner,
once some false positive warnings from objtool get hammered out, etc.)

I still want this in -next so we can build on it and improve it -- it
has been stuck in limbo for too long.

-Kees

[1] https://lore.kernel.org/kernel-hardening/CAK7LNASMh1KysAB4+gU7_iuTW+5GT2_yMDevwpLwx0iqjxwmWw@mail.gmail.com/

-- 
Kees Cook
