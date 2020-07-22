Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD122A075
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgGVUD0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 16:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732777AbgGVUDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 16:03:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A66C0619E3
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 13:03:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id br7so3618696ejb.5
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5uho8c111Sif1rjA6es7LKqax+bTf/baHAxUzEgiBs=;
        b=PPTfc7ofS2HU2+xEOjMWN0IYf6fcp270Om5s7QJSfrzzNXmADk8v71ZGdMdkkRTAax
         NVRK3DHJsdFwMwSaAys3u2BAf0La4VMtXlTOgADR6wEvMjklDRaoFIIB6Xum7WpF7uMQ
         ypktKp91IyG4RD00YrogGN1sYM6Y8KY9L91rR0XwVxsd0mRtoQ39Rx8npPbZlXihy3El
         gQYTvwonVqPerONvAG74ahVIgSQWcPvCwjduf5+9xHV+7YMEbE4BqNZBDUUsFY0g/lAi
         Fhhu/daQvEaSVXc8eCAcO9yxTSxiStt0pOyIX7T+9RbyWTUKOKqDIxXbNEB2Xr4GLpHV
         BD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5uho8c111Sif1rjA6es7LKqax+bTf/baHAxUzEgiBs=;
        b=muMebd2uEfnAvSqjQkzChqAHoaHjTanaNxIs0lXV2TeLws5eWpv2uiURWIYdvLs/F4
         gbC/v8tdmYQdFJE3I5SScpUFT4H8RhnZKdaM2fgEGUw0o9BIXyu41wwBI0x5Hnd3JA2U
         CKkL5QQO+kptRSa0nR/G1+Z1XNe9cw1q7FZE09ogKehtakZEMtWrzgca0nG+zD4GUFGR
         AGAMkNA52zB9MjelrBMfnGET8ZDHu0ALvg/oHze2/NAEEvaNQO+w+kGuEn2WI7rOzSW2
         xVXXvzjaNHO5WZCI3P/Rt3/cti5dIHcHkNwlrBNKaIhY4XrFPM9n8KL1NSB8aSXq2rnd
         b/eg==
X-Gm-Message-State: AOAM531gQigj7+t4uvVDae8zMRGl/lhkTHTb1FVpvUKk6lpjBTRzk3Qd
        GcZ9PTutkpu78eE2PPt6ssFsQ+5/g0gKTAZB+xo5fw==
X-Google-Smtp-Source: ABdhPJyF1/TvRtGDiGqtJCE9/ZaqS8MWqJmh/44/JnQk8HhLwq5VDQLuH1PjTPWAuAmpVNS/nDZZEqrEYVoucPXQbvA=
X-Received: by 2002:a17:906:6959:: with SMTP id c25mr1128516ejs.375.1595448203126;
 Wed, 22 Jul 2020 13:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com> <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com> <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com> <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com> <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <20200722135542.41127cc4@oasis.local.home> <20200722184137.GP10769@hirez.programming.kicks-ass.net>
 <20200722150943.53046592@oasis.local.home>
In-Reply-To: <20200722150943.53046592@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 22 Jul 2020 13:03:12 -0700
Message-ID: <CABCJKufW8rYG-R7b=ad8E5oRd+1xrVknWcTd2VFuvE7=SPtoTA@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
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
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 12:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 22 Jul 2020 20:41:37 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > That said, Andi Kleen added an option to gcc called -mnop-mcount which
> > > will have gcc do both create the mcount section and convert the calls
> > > into nops. When doing so, it defines CC_USING_NOP_MCOUNT which will
> > > tell ftrace to expect the calls to already be converted.
> >
> > That seems like the much easier solution, then we can forget about
> > recordmcount / objtool entirely for this.
>
> Of course that was only for some gcc compilers, and I'm not sure if
> clang can do this.
>
> Or do you just see all compilers doing this in the future, and not
> worrying about record-mcount at all, and bothering with objtool?

Clang appears to only support -mrecord-mcount and -mnop-mcount for
s390, so we still need recordmcount / objtool for x86.

Sami
