Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1617C39D07C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFFSqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFFSqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:46:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C91C061766
        for <linux-arch@vger.kernel.org>; Sun,  6 Jun 2021 11:44:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n17so1771193ljg.2
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88Yv/LYvp60VsQk9yOiDgKMCUDAIuykorj8GNoJ/U0E=;
        b=UHdEpFrtLxWVtrXy7kwuDY+KGS8bjCNedLu9LKPhKeT+VdP43ZkshBzIfgHgQ7Uecc
         3NDhoA+WN2XsJl8bZdWK6GlNvsxfaHcZTojLAg9NHSNrEL1TZ4poA5OROApD2h5ZYcDD
         JiC1es9r3QTWi2XYEJzOu4SCKuo0wFc2///20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88Yv/LYvp60VsQk9yOiDgKMCUDAIuykorj8GNoJ/U0E=;
        b=st316YkP3h3XkZTaWK0FXs8BcifyfAjSghaZN0ooqTLBQe+L8530dCzoYVo8UjwdU5
         e7VELQ2530nwZ7RsAtP2rkOmcKw4O4Tpun/0b64pBN9Wbdd1CCgUh8weGZMBqcnXuIqz
         9DEUWFXUxDX/7cetMTG6TD5pw7hU1EiSQ2evKa+GFETR32AnJe75Ss+mxANKAbK4SjaL
         7EwUsRPdEFXgioZuCljJO3jmOiEJUTOS5tN8qqr+cd8JJGDCB6r5DK5cB3qukNoNXfJG
         AqlxQI3s3rcpeqGBJspJjhJmfHyhBUmwnRvqLhMLyt3TvhPUSjvhmbnih//2RQQPHsVX
         XRMA==
X-Gm-Message-State: AOAM532MjbovFGD+XunVhMEq3kSH4Xs37yCgomjj2c+UhVokcpf4mjF5
        4I5pZNCz9vdxUUKmwnghilBpcBetuoUDcR5XfDc=
X-Google-Smtp-Source: ABdhPJzsvQ+mFSdPTRMUx8znsz2SaqLfFFIQ/5zOvOE/cqzz0HWLh2lhPjx+G26MoTvIZBy04OCYoQ==
X-Received: by 2002:a2e:3e16:: with SMTP id l22mr12304966lja.336.1623005040225;
        Sun, 06 Jun 2021 11:44:00 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o22sm1075362lji.122.2021.06.06.11.43.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:43:58 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e2so18946741ljk.4
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:43:58 -0700 (PDT)
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr4013689ljp.220.1623005038268;
 Sun, 06 Jun 2021 11:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606182213.GA1741684@rowland.harvard.edu>
In-Reply-To: <20210606182213.GA1741684@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:43:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
Message-ID: <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
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

On Sun, Jun 6, 2021 at 11:22 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> To be fair, the same argument applies even without the asm code.  The
> compiler will translate

Yes, yes.

But that is literally why the asm exists in the first place.

It's supposed to be the barrier that makes sure that doesn't happen.

So your point that "but this would happen without the asm" is missing
the whole point. This is exactly the thing that the asm is supposed to
avoid.

And it actually works fine when just one side has the barrier, because
then no merging can take place, because there is nothing to merge.

That's why my suggested fix for "volatile_if()" was this #define

    #define barrier_true() ({ barrier(); 1; })
    #define volatile_if(x) if ((x) && barrier_true())

because now code like

    volatile_if (READ_ONCE(a))
        WRITE_ONCE(b, 1);
    else
        WRITE_ONCE(b, 1);

would force that branch. And it's actually fine to merge the
"WRITE(b,1)", as loing as the branch exists, so the above can (and
does) compile to

    LD A
    BEQ over
    "empty asm"
over:
    ST $1,B

and the above is actually perfectly valid code and actually solves the
problem, even if it admittedly looks entirely insane.

With that crazy "conditional jump over nothing" the store to B is
ordered wrt the load from A on real machines.

And again: I do not believe we actually have this kind of code in the
kernel. I could imagine some CPU turning "conditional branch over
nothing" into a nop-op internally, and losing the ordering. And that's
ok, exactly because the above kind of code that *only* does the
WRITE_ONCE() and nothing else is crazy and stupid.

So don't get hung up on the "branch over nothing", that's just for
this insane unreal example.

But I *could* see us having something where both branches do end up
writing to "B", and it might even be the first thing both branches end
up doing. Not the *only* thing they do, but "B" might be a flag for "I
am actively working on this issue", and I could see a situation where
we care that the read of "A" (which might be what specifies *what* the
issue is) would need to be ordered with regards to that "I'm working
on it" flag.

IOW, another CPU might want to know *what* somebody is working on, and do

    /* Is somebody working on this */
    if (READ_ONCE(B)) {
        smp_rmb();
        READ_ONCE(A); <- this is what they are working on

and the ordering requirement in this all is that B has to be written
after A has been read.

So while the example code is insane and pointless (and you shouldn't
read *too* much into it), conceptually the notion of that pattern of

    if (READ_ONCE(a)) {
        WRITE_ONCE(b,1);
        .. do something ..
    } else {
        WRITE_ONCE(b,1);
        .. do something else ..
    }

is not insane or entirely unrealistic - the WRITE_ONCE() might
basically be an ACK for "I have read the value of A and will act on
it".

Odd? Yes. Unusual? Yes. Do we do this now? No. But it does worry me
that we don't seem to have a good way to add that required barrier.

Adding it on one side is good, and works, but what if somebody then does

    volatile_if (READ_ONCE(a))
        WRITE_ONCE(b, 1);
    else {
        barrier();
        WRITE_ONCE(b, 1);
    }

and now we end up with it on both sides again, and then the second
barrier basically undoes the first one..

              Linus
