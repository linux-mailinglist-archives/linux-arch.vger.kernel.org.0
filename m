Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB6229EEF
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGVSH1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgGVSH1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 14:07:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACADC0619E1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 11:07:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so2359659edm.4
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdyJ3zCjPfmLPOxt0EpbJoGI3z0Dst2ftnMjMBs721s=;
        b=VQOOnqg73U7x3eQrsDW5P6NHQpsRTrBV6mDqQ35Y7KbR5dxMVHVEhlOpBKgbC4YauI
         hKoPoQogS3yVaVz+cHKlmtCp41T1+KI57s1dNmREFvPgWO9LQa1Md2XUbvuoYp7xcDOD
         uJkxpr/ugST6O4YCQmPPrAz4f1LYvrnmu4TBkKKzuhd7zdw95+t6HeiJXKW9A6c8pPUy
         XRNlbkclQcCrxbPIAZrisC31UWn7W4GKg1hOvR+OFZqdAhucXRldSHGUkEO+NbUB9S9S
         XaVu2nmp3aY/+8g9/c/Kskh84nH4FtiosOyHuJCZKQY+DsufHyQlBrv/tBuyO6TpzdFa
         UM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdyJ3zCjPfmLPOxt0EpbJoGI3z0Dst2ftnMjMBs721s=;
        b=Ji49elU7yIMVYPA4ODvKGW3PZ93xlaUx9/Pnv4hU6nyrMlcLg0IrPgowjZx2ab3lJe
         LT/DL6Eo0ZvmOANsmqbcqw7SCy2G6y73FNiqvZAsAIdzDDqort3r4XOpoc1J3z/cmD1o
         wQEhz2Zyl04og7o5ohkfzfcHUsZUlQi8t8SxwthFG+pqY4hVXm5cVE1ldT6R8zDDnBrq
         LKA8LzLfL1JJDHGst0k+s8dqxA2dMPPh6uIGgCYXeEG9YZ1cvoAgP3mxOK9CkhvuW/cA
         9idaObjkB4zfY299KJsYMMpcPPe4U1geK6eHBFUCSWW2lJNaFpYISE3FhPjmUVMoy2DK
         jo+w==
X-Gm-Message-State: AOAM533PxFrvC0qPsIw3IOynK3nqdXWVLP3IGH1Di/mKANdgizd2YbnX
        eAow2OoOOwRcGYtqvlV0y7/fq12A+mXIiROkUe6YJQ==
X-Google-Smtp-Source: ABdhPJwcnL9bpNsR0ioOLFXQ9M3j8q0lz48Fhhhje9z+wnEe4/R/foPMYkXV+6IoYiAKnIEt8CMey3jrAzyf6UdUmaI=
X-Received: by 2002:a05:6402:542:: with SMTP id i2mr682149edx.318.1595441245286;
 Wed, 22 Jul 2020 11:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com> <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com> <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com> <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com> <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <CABCJKucSM7gqWmUtiBPbr208wB0pc25afJXc6yBQzJDZf4LSWA@mail.gmail.com>
 <20200717133645.7816c0b6@oasis.local.home> <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
 <20200717140545.6f008208@oasis.local.home> <CABCJKucDrS9wNZLjtmN5qMbZBTHLvB1Z7WqTwT3b11-K4kNcyg@mail.gmail.com>
 <20200722135829.7ca6fbc5@oasis.local.home>
In-Reply-To: <20200722135829.7ca6fbc5@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 22 Jul 2020 11:07:13 -0700
Message-ID: <CABCJKucn5o+PgMnKwHOGRnhTdVk9Dnd2QZwy54wXYwQYNUNjBw@mail.gmail.com>
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

On Wed, Jul 22, 2020 at 10:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 20 Jul 2020 09:52:37 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > > Does x86 have a way to differentiate between the two that record mcount
> > > can check?
> >
> > I'm not sure if looking at the relocation alone is sufficient on x86,
> > we might also have to decode the instruction, which is what objtool
> > does. Did you have any thoughts on Peter's patch, or my initial
> > suggestion, which adds a __nomcount attribute to affected functions?
>
> There's a lot of code in this thread. Can you give me the message-id of
> Peter's patch in question.

Sure, I was referring to the objtool patch in this message:

https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/

Sami
