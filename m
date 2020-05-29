Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5D1E74F3
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 06:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgE2Eis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 00:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgE2Eir (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 00:38:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A41C08C5C8;
        Thu, 28 May 2020 21:38:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c14so101563qka.11;
        Thu, 28 May 2020 21:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzpvcK97J0D1+TcM3X1DAvVz8kK/R/1ly5kgckWGCHc=;
        b=jZBNX51sgrlxGr+sNsJVDZ2EFe3nEZ82oqUb1kRrrq6z2c7fe+g3kAWvJcuEB/E8Lx
         WvZNgisr2luzg458j5tEXQd/aQf5PdOAFtClNFaGOHwl/RWrwoEJ71PndOdNQHDCj0Au
         CvhF2x+vM2+DSIvsF19UxFYsRLY5tjt59iLYEsBFc7TaUgwTeUqYYMCY5gARyd0fjngL
         Wkk4VX+yDecV2ajFAYKQDZZnnOtB9SZ5Ve3ntuB++rS4ob1tKKJDE6mpsbP3P7hDsKoa
         d+MP96Lrv3TR3SPZf28ip8yZ0iNn6FSjkDCcCmFUexrJauUpcOU8x/9Eb6gnkVXxNDOX
         9j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzpvcK97J0D1+TcM3X1DAvVz8kK/R/1ly5kgckWGCHc=;
        b=WIMDRT+2bOAB5s22VrdHFGFauHNB+6tpcJpQPdPpc8VSRtByC89zc/GX4EF7Hob17H
         5cWRapcdS0utVrSF0Zt7h/gNE0294LkF+KqljtZR+iQ4cGsbREPGcJQs2TQAWuoDTLwD
         l8Cw6LwojioUMbQHCS3ElAv/J6i9MOg3tuuVMzg3/XUqHthWul99Kipm1eDlDnmtkwrD
         zXM6HWNUPmMFitXjd7UC1LBbyCsLmwogFGbmmsRUlq7PiApzcoFgHW2wo1w/mKUdrtZN
         SlUWjtdyyAzHZIhku8ykTPDAycpthYsgquI3rbJoeGPcxrblEUO2ny4shcLxUMZ8KGVt
         ftJA==
X-Gm-Message-State: AOAM531uQ0vXOrPn/pA4+04RRSCL68W0CEZ2TE5ugF5i7ZPrzXehx1Ao
        BY49GUYvTJShMqAPzjC4eL0u9BLjRBbfeGSQZN0=
X-Google-Smtp-Source: ABdhPJxfiLQM43XKstMLPBa0eb83BaGHxniFZ8ebtIJHVqu7NJX9gIye6HGX6FjTIlFitHc+P92QF3M3oj/ipC2Jr3s=
X-Received: by 2002:a37:6508:: with SMTP id z8mr6132596qkb.39.1590727126180;
 Thu, 28 May 2020 21:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <20200525145325.GB2066@tardis>
 <CAEf4BzYCjbnU=cNyLnYRoZdMPKnBP4w8t+VRkXrC1GW-aFVkEA@mail.gmail.com> <20200528214823.GA211369@google.com>
In-Reply-To: <20200528214823.GA211369@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 May 2020 21:38:35 -0700
Message-ID: <CAEf4BzbzyA0mn7O-+x2peGa9WUuaGSi0+Gpyy-6t5iJwVLYf5A@mail.gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 2:48 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, May 25, 2020 at 11:38:23AM -0700, Andrii Nakryiko wrote:
> > On Mon, May 25, 2020 at 7:53 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > Hi Andrii,
> > >
> > > On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > > > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> > > > > > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > > > > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > > > > > Hello!
> > > > > > > >
> > > > > > > > Just wanted to call your attention to some pretty cool and pretty serious
> > > > > > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > > > > > >
> > > > > > > > Thoughts?
> > > > > > >
> > > > > > > I find:
> > > > > > >
> > > > > > >         smp_wmb()
> > > > > > >         smp_store_release()
> > > > > > >
> > > > > > > a _very_ weird construct. What is that supposed to even do?
> > > > > >
> > > > > > Indeed, it looks like one or the other of those is redundant (depending
> > > > > > on the context).
> > > > >
> > > > > Probably.  Peter instead asked what it was supposed to even do.  ;-)
> > > >
> > > > I agree, I think smp_wmb() is redundant here. Can't remember why I thought
> > > > that it's necessary, this algorithm went through a bunch of iterations,
> > > > starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some
> > > > point, and settling on smp_read_acquire/smp_store_release, eventually. Maybe
> > > > there was some reason, but might be that I was just over-cautious. See reply
> > > > on patch thread as well ([0]).
> > > >
> > > >   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/
> > > >
> > >
> > > While we are at it, could you explain a bit on why you use
> > > smp_store_release() on consumer_pos? I ask because IIUC, consumer_pos is
> > > only updated at consumer side, and there is no other write at consumer
> > > side that we want to order with the write to consumer_pos. So I fail
> > > to find why smp_store_release() is necessary.
> > >
> > > I did the following modification on litmus tests, and I didn't see
> > > different results (on States) between two versions of litmus tests.
> > >
> >
> > This is needed to ensure that producer can reliably detect whether it
> > needs to trigger poll notification.
>
> Boqun's question is on the consumer side though. Are you saying that on the
> consumer side, the loads prior to the smp_store_release() on the consumer
> side should have been seen by the consumer?  You are already using
> smp_load_acquire() so that should be satisified already because the
> smp_load_acquire() makes sure that the smp_load_acquire()'s happens before
> any future loads and stores.

Consumer is reading two things: producer_pos and each record's length
header, and writes consumer_pos. I re-read this paragraph many times,
but I'm still a bit confused on what exactly you are trying to say.
Can you please specify in each case release()/acquire() of which
variable you are talking about?

>
> > Basically, consumer caught up at
> > about same time as producer commits new record, we need to make sure
> > that:
> >   - either consumer sees updated producer_pos > consumer_pos, and thus
> > knows that there is more data to consumer (but producer might not send
> > notification of new data in this case);
> >   - or producer sees that consumer already caught up (i.e.,
> > consumer_pos == producer_pos before currently committed record), and
> > in such case will definitely send notifications.
>
> Could you set a variable on the producer side to emulate a notification, and
> check that in the conditions at the end?

Setting notification flag is easy, but determining when it has to or
shouldn't happen is the hard part and depends on exact interleaving of
memory operations. I haven't figured out reliable way to express
this... If you have a good idea, please post a snippet of code.

>
> thanks,
>
>  - Joel
>
> >
> > This is critical for correctness of epoll notifications.
> > Unfortunately, litmus tests don't test this notification aspect, as I
> > haven't originally figured out the invariant that can be defined to
> > validate this. I'll give it another thought, though, maybe this time
> > I'll come up with something.
> >
> > > Regards,
> > > Boqun
> > >
> >
> > [...]
