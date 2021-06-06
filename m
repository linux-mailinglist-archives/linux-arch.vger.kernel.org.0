Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD639D1FD
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFFWsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 18:48:38 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:41835 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 18:48:38 -0400
Received: by mail-lf1-f52.google.com with SMTP id v8so22957912lft.8
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtTe+bW9CJrIIoUl0y1d11JaP4RsQBfOevBdp08DRug=;
        b=OxInyRJVkqQCmKRmT6KGFE8qM7XAfQzY8nbQmo5qsLIenPiuQZPigbSL/hrNiuh00j
         Fiyq6WXUnbySLjjZhVoY4ZVWT2wgI8gyhocnD0Acawt0/u24ZMB8KiorrZ5u8WVzW5Mp
         bJ3imPB0o2E2dsaZWR8zv/W4ByDxPBlNuhDHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtTe+bW9CJrIIoUl0y1d11JaP4RsQBfOevBdp08DRug=;
        b=CfMo9tS6FLK34bC6W5F7w3e36mN5FPM1LmGhgPTI3caqz9Q3YYK7JqA2e1pi3Jayce
         JxjBMhs6Ot9nYJOH2ZKOnSIZJkdM1jfK/DuHvoWLPzM2t2VgeR3qfSfjfH6lqKFYVGle
         Tp2MXHOzbKu2+D18YOyUnl5tZCA03ZH0+ECWeJBIgbMt/brUOIkHO4aHaQiFC+qsxgBv
         /hdkTc0X3vm94dpZeozlBhAQpW4/hSLJ2jALITgdnerupRouw4jwBfpt5FK3KqKEqM/X
         HmbN9MnBbC7l0JTsp6K8vo7ujQ5CHeK5hhzXXQhRVRgpqqr+d45k2lMTAE/b1CiDjmGO
         IZvg==
X-Gm-Message-State: AOAM5308iD1iF6GWBXwG1hVFq6Q+B51ArC+K0Hd9oR9qn1KVhI/ZJPGw
        E5+9K+77mQJCwenIYq4nk0oIH2AN02EE9aQl1pQ=
X-Google-Smtp-Source: ABdhPJwWhzxLd5ySW/hy7QGOtMiNT/tiUcvaaaRkyIAzU603Y2qkDABRVYFIm5ElTxG8NFJbfbBJkw==
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr10549909lfb.268.1623019530422;
        Sun, 06 Jun 2021 15:45:30 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p9sm1273592lfo.276.2021.06.06.15.45.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 15:45:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id v8so22957876lft.8
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 15:45:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr9598539lfa.421.1623019102844;
 Sun, 06 Jun 2021 15:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 15:38:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
Message-ID: <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Jakub Jelinek <jakub@redhat.com>,
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

On Sun, Jun 6, 2021 at 2:19 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> > So yeah, that seems like a nice solution to the issue, and should make
> > the barriers all unique to the compiler.
>
> It also plants a nice LTO time-bomb (__COUNTER__ values will be unique
> only within each LTO input unit, not across all of them).

That could be an issue in other circumstances, but for at least
volatile_if() that doesn't much matter. The decision there is purely
local, and it's literally about the two sides of the conditional not
being merged.

Now, an optimizing linker or assembler can of course do anything at
all in theory: and if that ends up being an issue we'd have to have
some way to actually propagate the barrier from being just a compiler
thing. Right now gcc doesn't even output the barrier in the assembly
code, so it's invisible to any optimizing assembler/linker thing.

But I don't think that's an issue with what _currently_ goes on in an
assembler or linker - not even a smart one like LTO.

And such things really are independent of "volatile_if()". We use
barriers for other things where we need to force some kind of
operation ordering, and right now the only thing that re-orders
accesses etc is the compiler.

Btw, since we have compiler people on line, the suggested 'barrier()'
isn't actually perfect for this particular use:

   #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")

in the general barrier case, we very much want to have that "memory"
clobber, because the whole point of the general barrier case is that
we want to make sure that the compiler doesn't cache memory state
across it (ie the traditional use was basically what we now use
"cpu_relax()" for, and you would use it for busy-looping on some
condition).

In the case of "volatile_if()", we actually would like to have not a
memory clobber, but a "memory read". IOW, it would be a barrier for
any writes taking place, but reads can move around it.

I don't know of any way to express that to the compiler. We've used
hacks for it before (in gcc, BLKmode reads turn into that kind of
barrier in practice, so you can do something like make the memory
input to the asm be a big array). But that turned out to be fairly
unreliable, so now we use memory clobbers even if we just mean "reads
random memory".

Example: variable_test_bit(), which generates a "bt" instruction, does

                     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");

and the memory clobber is obviously wrong: 'bt' only *reads* memory,
but since the whole reason we use it is that it's not just that word
at address 'addr', in order to make sure that any previous writes are
actually stable in memory, we use that "memory" clobber.

It would be much nicer to have a "memory read" marker instead, to let
the compiler know "I need to have done all pending writes to memory,
but I can still cache read values over this op because it doesn't
_change_ memory".

Anybody have ideas or suggestions for something like that?

                 Linus
