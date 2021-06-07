Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A639D75F
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGIal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 04:30:41 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:38597 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhFGIa1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 04:30:27 -0400
Received: by mail-oo1-f43.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so3935498ooa.5
        for <linux-arch@vger.kernel.org>; Mon, 07 Jun 2021 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hJoek+dH6lRvIIEvtmpn8nrUNfH1I0O0qNY3ghdb8Q=;
        b=LOIHafCIFA0IyhxDKrZXKOLD3XN7IJWm1jCQ89b3C8PBWRM0EWPXMpK+bU8j8FHAmx
         zBCy3YmZZUZ0fh1b2Z5aX0OYihxljb5HWbZlX4ssC1etg2xnuwIyBZFo3x6KPeep+/Wd
         SnRHtQ8wY7o3OjrI1m0igZ3dC/oE0Br9IevO15JvfcPCWzzX3kqULNHoI1FkxVckZK32
         rLYr0klqfNunFl8K/I0SpyWocYXGUjbHb+0pc86I3lso8POqgvokDcwgGd59MRXOw6I5
         vZ0BOFL85Empou7cWfk/hbPTnfuWqAQrZu4pefLvNpgya2FMLrMQrywZNbG33VKJY1cE
         bQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hJoek+dH6lRvIIEvtmpn8nrUNfH1I0O0qNY3ghdb8Q=;
        b=doMpyw52tMG/KKne6+0arJYjM1gSxp39haXUd7i8ls8McX+Hb9A9GFeO2HjmQDY82/
         cplFoFLN3KYM/ylmHgMaV/Ei5z1UAZi7eh2FKVDmfO74HzinC+6ajpJhmhA8w9V6soN8
         ZAHePmMBHZDtCAZblsr0IRjL1/GWZdLAdmCNmdFmoY2W49w4+XOmD0km6y2kdSttZGzW
         xWW5r4YqJDnDtlPPYSsQDaKuhBMlz53jKEZN9Npt4p8nfrD6Fvuw574JpfgU/h1Ah4AX
         /eg/7ep64K5pZfw4fe3NAJOiArUSuDfDKxRaaHHuZgUWv1IjDYdaIR7dk07FgNwIqAV7
         maOA==
X-Gm-Message-State: AOAM531OQKdkSu2TWNCKN7tnzldejKIYzmOtVatSSn/mZi829yAXcWw2
        C2SzACX+q6aKVSOpWSNmNdEt8pQebtC55MMjWZVJbQ==
X-Google-Smtp-Source: ABdhPJwhAqSuRQaCfX2Zb3geQjaQVw22GWcI4D506b+J4A3lSdAExBnrgHThzMCaxjPiiDa1vckJdt5mZ70A9Xmoo0Y=
X-Received: by 2002:a4a:1145:: with SMTP id 66mr12558163ooc.14.1623054443861;
 Mon, 07 Jun 2021 01:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Jun 2021 10:27:10 +0200
Message-ID: <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, 7 Jun 2021 at 10:02, Alexander Monakov <amonakov@ispras.ru> wrote:
> On Sun, 6 Jun 2021, Linus Torvalds wrote:
[...]
> > On Sun, Jun 6, 2021 at 2:19 PM Alexander Monakov <amonakov@ispras.ru> wrote:
[...]
> > Btw, since we have compiler people on line, the suggested 'barrier()'
> > isn't actually perfect for this particular use:
> >
> >    #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> >
> > in the general barrier case, we very much want to have that "memory"
> > clobber, because the whole point of the general barrier case is that
> > we want to make sure that the compiler doesn't cache memory state
> > across it (ie the traditional use was basically what we now use
> > "cpu_relax()" for, and you would use it for busy-looping on some
> > condition).
> >
> > In the case of "volatile_if()", we actually would like to have not a
> > memory clobber, but a "memory read". IOW, it would be a barrier for
> > any writes taking place, but reads can move around it.
> >
> > I don't know of any way to express that to the compiler. We've used
> > hacks for it before (in gcc, BLKmode reads turn into that kind of
> > barrier in practice, so you can do something like make the memory
> > input to the asm be a big array). But that turned out to be fairly
> > unreliable, so now we use memory clobbers even if we just mean "reads
> > random memory".
>
> So the barrier which is a compiler barrier but not a machine barrier is
> __atomic_signal_fence(model), but internally GCC will not treat it smarter
> than an asm-with-memory-clobber today.

FWIW, Clang seems to be cleverer about it, and seems to do the optimal
thing if I use a __atomic_signal_fence(__ATOMIC_RELEASE):
https://godbolt.org/z/4v5xojqaY

Thanks,
-- Marco
