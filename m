Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0139C9D1
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFEQ1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEQ1P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jun 2021 12:27:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A3C061766
        for <linux-arch@vger.kernel.org>; Sat,  5 Jun 2021 09:25:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 131so15733975ljj.3
        for <linux-arch@vger.kernel.org>; Sat, 05 Jun 2021 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZa60s0glSdUWznibN+YHUgSL+wdhz/USRVQvcTkA3k=;
        b=BQz+fRxwJrPzucEkOtxliKpTSWvi9EIwmF3SEXReAICeTz89zVE9OFvV9GV5MbYLsD
         QawgOFSMA9wi0wj0NsKxUp4FAEdi/eYMeMPeXWixE0CcQUC8xKaX/e2LoWw17Q6irdME
         KbDwe5zlt7LgNv46Z7UaR5DlXbYzZPGo7YHlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZa60s0glSdUWznibN+YHUgSL+wdhz/USRVQvcTkA3k=;
        b=NXZc+9/nSs1BSyv2PeMQwPLGBSB4VPq+i9JXGM6j/VWKqrtc2+5/IDAoom4+MRvyyY
         90Tj1U9WJPWgLjRVTK1AUAASIeB/Vll5IXNAgEgDDxTgum2mf730l8jpLzdG62NKO1Cn
         GaRzeq0YDkf+LOiPShCrxmyIbUkoSuoCor1j/QW09tT+2+qyWoalWIz5eFnQh3mL92+A
         Jws9n74/l2Y5iK6MgNu2u1XlcXZWNXXecbjZjn5FdDUWB8OgehxSSwN4yGrpswtnW5WU
         gxy4pGebgv0NzrYFMy0l5oza3vssIUzuNHZ/rG72enuOvMNWYsjtde1MGUKsnhcvtRSC
         ah/g==
X-Gm-Message-State: AOAM530J0Us4zFHU4r2k+XZKMOPMgx1NHORFBPJQffT4PBIhcYdnNBGH
        aQtI6cvHpKOgpIqmuR4hWxMvVyndDAFSnpPCqFs=
X-Google-Smtp-Source: ABdhPJy0WG2Iyly1CMYexKxcwbFodAyoRpcn3q5iWOzr0LFPv24a5x76QLiOL+WWxBNuHJdm9QECqQ==
X-Received: by 2002:a2e:390b:: with SMTP id g11mr7666176lja.505.1622910312524;
        Sat, 05 Jun 2021 09:25:12 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h21sm316471lja.23.2021.06.05.09.25.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 09:25:11 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r5so18804453lfr.5
        for <linux-arch@vger.kernel.org>; Sat, 05 Jun 2021 09:25:10 -0700 (PDT)
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr6239078lft.41.1622910310532;
 Sat, 05 Jun 2021 09:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck> <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck> <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net> <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net> <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com> <20210605031403.GA1701165@rowland.harvard.edu>
In-Reply-To: <20210605031403.GA1701165@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jun 2021 09:24:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFRjQZB9QckY=CCcgrWMMRqbxntF4aLnDf=HqhDj-2AQ@mail.gmail.com>
Message-ID: <CAHk-=whFRjQZB9QckY=CCcgrWMMRqbxntF4aLnDf=HqhDj-2AQ@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Fri, Jun 4, 2021 at 8:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> >
> > then I could in theory see teh compiler doing that WRITE_ONCE() as
> > some kind of non-control dependency.
>
> This may be a minor point, but can that loophole be closed as follows?

Note that it's actually entirely sufficient to have the barrier just
on one side.

I brought it up mainly as an oddity, and that it can result in the
compiler generating different code for the two different directions.

The reason that it is sufficient is that with the barrier in place (on
either side), the compiler really can't do much. It can't join either
of the sides, because it has to do that barrier on one side before any
common code.

In fact, even if the compiler decides to first do a conditional call
just around the barrier, and then do any common code (and then do
_another_ conditional branch), it still did that conditional branch
first, and the problem is solved. The CPU doesn't care, it will have
to resolve the branch before any subsequent stores are finalized.

Of course, if the compiler creates a conditional call just around the
barrier, and the barrier is empty (like we do now), and the compiler
leaves no mark of it in the result (like it does seem to do for empty
asm stataments), I could imagine some optimizing assembler (or linker)
screwing things up for us, and saying "a conditional branch to the
next instruction can just be removed).

At that point, we've lost again, and it's a toolchain issue. I don't
think that issue can currently happen, but it's an example of yet
another really subtle problem that *could* happen even if *we* do
everything right.

I also do not believe that any of our code that has this pattern would
have that situation where the compiler would generate a branch over
just the barrier. It's kind of similar to Paul's example in that
sense. When we use volatile_if(), the two sides are very very
different entirely regardless of the barrier, so in practice I think
this is all entirely moot.

              Linus
