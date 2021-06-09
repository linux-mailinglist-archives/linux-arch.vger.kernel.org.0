Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0923A14C4
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 14:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFIMr3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 08:47:29 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40912 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhFIMr2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 08:47:28 -0400
Received: by mail-ot1-f51.google.com with SMTP id l13-20020a9d708d0000b02903fca0eacd15so844185otj.7
        for <linux-arch@vger.kernel.org>; Wed, 09 Jun 2021 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yJJiLIio1keCrN3sS6SLKCpX1mujUdD6B7dJpQDmZw=;
        b=ClaMFpHvFaLfrDBK3kLKjFrPN25oDeFJ8tj4sFgK8pktGD85GvHUBtvOEsfyTrqG+I
         X43sS+oC0NRnqBvv8fR1xouf7sOrSY40TyPaku3k/CIFeBOer4oWe3WdkZs3Y87sDPi1
         nwgQ20qYboPzcGIJAvt5TjOrlRETQHfZEUR7OltE3NHxr3c9RcnfZ3cmaJf/dPCYX3ef
         fMHflwpyJCzqjK1hMUJMR9iwk1xuXRiFUVpKHGOUwyUgHq/A6y5pIbcT6NAUY4R14aqL
         ifxOAIMzLy60OeGyhY9jogUi7U8CrYZT4aUt6xV0uk0KViOaVef+3MfdSSup8dQZllAj
         1xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yJJiLIio1keCrN3sS6SLKCpX1mujUdD6B7dJpQDmZw=;
        b=Oi8PO6HBOSFoIvSxyrPaarvtNadljfvDkff0nI7ohDDtKe7STzzIYW8taEIqZElaSQ
         D+ZwkD/ABIzxDtciaWIXELLf3Wpo4MW/EyFuWtUdBNjI3xpfWgQ4/XSlZ+WRe47SP/9K
         QLjRJxVrYhp3sRane02rZWKMlvj9PqEkKed8GHlrD7/crAWeVuy8c08PObxwJSHoev1i
         ERF+kvLFNY9sthFv8dtTarhxWGmn6vWQRwCfuy3BWKtNl62uqKqUT0kp1eM4k9/RtN6l
         LEoyWcSmpg0nef1G7d3VW2kTGZsWCbvxi01BdF2B6UEfjPGQNtdgFvITfVuEV4OcOwqg
         b3SA==
X-Gm-Message-State: AOAM5302F2XzmntEzu7sbUgKCUkKeO7SpTQdy+aoSS721iXo4t+7boAG
        xSnFIy2WhcICOWrOTTJA+hki6XKMTSW4PdSoIStyjQ==
X-Google-Smtp-Source: ABdhPJxBngznJ5I05L+XqEpGWWmBHExE9k9EYf3tqXEM9hX0sUuoP3RiU+g6XBrDr9Ttmz3Cfu1d39mD+4FznXHJW8c=
X-Received: by 2002:a05:6830:1c7b:: with SMTP id s27mr8892653otg.233.1623242660230;
 Wed, 09 Jun 2021 05:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com>
 <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
 <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org>
In-Reply-To: <20210608152851.GX18427@gate.crashing.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Jun 2021 14:44:08 +0200
Message-ID: <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Jun 2021 at 17:30, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Tue, Jun 08, 2021 at 01:22:58PM +0200, Peter Zijlstra wrote:
> > Works for me; and note how it mirrors how we implemented volatile_if()
> > in the first place, by doing an expression wrapper.
> >
> > __builtin_ctrl_depends(expr) would have to:
> >
> >  - ensure !__builtin_const_p(expr)    (A)
>
> Why would it be an error if __builtin_constant_p(expr)?  In many
> programs the compiler can figure out some expression does never change.
> Having a control dependency on sometthing like that is not erroneous.
>
> >  - imply an acquire compiler fence    (B)
> >  - ensure cond-branch is emitted      (C)
>
> (C) is almost impossible to do.  This should be reformulated to talk
> about the effect of the generated code, instead.
>
> > *OR*
> >
> >  - ensure !__builtin_const_p(expr);           (A)
> >  - upgrade the load in @expr to load-acquire  (D)
>
> So that will only work if there is exactly one read from memory in expr?
> That is problematic.
>
> This needs some work.

There is a valid concern that something at the level of the memory
model requires very precise specification in terms of language
semantics and not generated code. Otherwise it seems difficult to get
compiler folks onboard. And coming up with such a specification may
take a while, especially if we have to venture in the realm of the
C11/C++11 memory model while still trying to somehow make it work for
the LKMM. That seems like a very tricky maze we may want to avoid.

An alternative design would be to use a statement attribute to only
enforce (C) ("__attribute__((mustcontrol))" ?). The rest can be
composed through existing primitives I think (the compiler barriers
need optimizing though), which should give us ctrl_depends().

At least for Clang, it should be doable: https://reviews.llvm.org/D103958

Thanks,
-- Marco
