Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C927EFF5
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgI3RLB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3RLB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 13:11:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF6C061755
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 10:11:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j11so3985429ejk.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqedzlGX8MsdvOmncyCbTeaSpoiIv6tQfCYOfAGCm1I=;
        b=sE8WZ6lfb33YbXSwicY08Buxu2+BclRjKlsf3vmfKYC0cOkGjIdkfWlcD3vKlvxBtD
         oJvOI0Me7W22ashUodxRg8si+zJpy2Cbj36q0/8yWyYhzL0LsEuNIm7mCi4bt0ydDxiP
         q2wgS9BmhahiQ+5AI274iqgwQFVzecBus9MZf563ErBkJT7H8HSacjGdi407Qm2FFScB
         UKBxyo4CmvhG4OhR92jBXUX4a8bOh0QyXvaZZAv6dW3JDWi42Xlo+4DGLRhZ05mHElhm
         akH0k3vLqe2e1OlNqWiJM/8E0bIvbsaLFvn/nLJrGgZiuIkxYeAIludqN2wsfPhdmkyE
         UahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqedzlGX8MsdvOmncyCbTeaSpoiIv6tQfCYOfAGCm1I=;
        b=AuwkprgiDEXJPUvUqrP8TNgyZiNyNegxMXRKcq6ieC5KOdT8S/egijZQYpKMNwdF4A
         EVY1BY72jQWi0nTC+xFapInCnuYEAmxHPMrl7tdFm3R23LLgGDgFiiAAkhA+Ot24knBN
         WlLs8xHN4MZHUUI8PFablwujgQRvRNmMjq+4VbYM4tLm3ap8V26Zaiz85THLbVbwi4mE
         ijHT9lIdMevGa82qF1REdG0R8J2dJSd10IS0rW8u3mV4tsFIKLhYVTiEV0sLfkfmgy6y
         TKv6S3VW5Q9VDGDmuITa11qs79G2ctIIAktwoGOSmCseZeezPgaF7RJevuErR6XBgK1K
         PhNA==
X-Gm-Message-State: AOAM531dky+H3jqqfr81YObbtuZ+AJuE3il55sicU2t5mfKmufxl4+ze
        wixyvautYhtMZXMQt7Ojge2xUcVSugO4RjTN/dfdGA==
X-Google-Smtp-Source: ABdhPJxx5zeY+5dc3dMhmlhIH9uf8zM/HMP0iLgIAwPYaEmmMHjXLZ0lmUCgiQV067mtUVMz2xbTNNo7KUcZkaJ7L2A=
X-Received: by 2002:a17:906:a256:: with SMTP id bi22mr3767975ejb.375.1601485859067;
 Wed, 30 Sep 2020 10:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
 <20200929214631.3516445-10-samitolvanen@google.com> <20200930095850.GA68612@C02TD0UTHF1T.local>
In-Reply-To: <20200930095850.GA68612@C02TD0UTHF1T.local>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 30 Sep 2020 10:10:47 -0700
Message-ID: <CABCJKuegb4MzniWOk2+R3FngZpdWuSEAZuj=arRm0mE6HQ9anw@mail.gmail.com>
Subject: Re: [PATCH v4 09/29] arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

On Wed, Sep 30, 2020 at 2:59 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Sami,
>
> On Tue, Sep 29, 2020 at 02:46:11PM -0700, Sami Tolvanen wrote:
> > Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to disable
> > recordmcount when DYNAMIC_FTRACE_WITH_REGS is selected.
>
> Could you please add an explanation as to /why/ this is necessary in the
> commit message? I couldn't figure this out form the commit message
> alone, and reading the cover letter also didn't help.

Sorry about that, I'll add a better explanation in the next version.

Note that without LTO, this change is not strictly necessary as
there's no harm in running recordmcount even if it's not needed. It
might slow down the build slightly, but I suspect a few thousand
invocations of the program won't take that long. However, with LTO we
need to disable recordmcount because it doesn't understand LLVM
bitcode.

> If the minimum required GCC version supports patchable-function-entry
> I'd be happy to make that a requirement for dynamic ftrace on arm64, as
> then we'd only need to support one mechanism, and can get rid of some
> redundant code. We already default to it when present anyhow.

That would be great, but Documentation/process/changes.rst suggests
the minimum gcc version is 4.9, and according to Godbolt we would need
gcc >= 8 for -fpatchable-function-entry:

  https://godbolt.org/z/jdzcMW

> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6d232837cbee..ad522b021f35 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -155,6 +155,8 @@ config ARM64
> >       select HAVE_DYNAMIC_FTRACE
> >       select HAVE_DYNAMIC_FTRACE_WITH_REGS \
> >               if $(cc-option,-fpatchable-function-entry=2)
> > +     select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
> > +             if DYNAMIC_FTRACE_WITH_REGS
>
> This doesn't look quite right to me. Presumably we shouldn't allow
> DYNAMIC_FTRACE_WITH_REGS to be selected if HAVE_DYNAMIC_FTRACE_WITH_REGS
> isn't.

This won't allow DYNAMIC_FTRACE_WITH_REGS to be selected without
HAVE_DYNAMIC_FTRACE_WITH_REGS. Testing with a compiler that does
support -fpatchable-function-entry, I get the following, as expected:

$ grep -E '(DYNAMIC_FTRACE|MCOUNT_USE)' .config
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY=y

And if the compiler doesn't support -fpatchable-function-entry, we
would end up with the following:

$ grep -E '(DYNAMIC_FTRACE|MCOUNT_USE)' .config
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT=y

Sami
