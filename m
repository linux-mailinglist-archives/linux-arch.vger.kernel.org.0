Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4671E88A2
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 22:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2UKk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 16:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgE2UKj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 16:10:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624BFC03E969;
        Fri, 29 May 2020 13:10:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j32so2984458qte.10;
        Fri, 29 May 2020 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTI+bPrikel4e2yw8UDcOLej9VIV8OWKqemk6J1A/Ik=;
        b=r7Y4xy19sm3YA1LRehOBwZXC2Kwhcltc5fqxaybFfWA6lHYTgv/39SsOwxNdcMfPsJ
         2nbsLefRN1I+rbE9t3GAQ1QtvgyNv/M7TrTAO6HwNsubHw2bbQ5J9QCb4wlmIkTung5b
         8MNZrZvDjj3T76H9/3m2sHmoL48UVZeCefin/1gO15NKS1QRoUFbyPlSpbLio6hjIe49
         Poz4rA823RzIJds7lmE5u4tjm0A2WinarnVZchIFjjESMYvymdtInunL2v96FnDLI0BB
         l5Muz6TbnC5qEQxZVm/aLDVOW0PvjayW7RMMouAaR2OTkhkBBPWfbQ6sjU2UTBkYWLPN
         bn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTI+bPrikel4e2yw8UDcOLej9VIV8OWKqemk6J1A/Ik=;
        b=DcU4Zp4keet+ksDyqC0SoRDihV2VOe4T9ZfYXmfUUEZMk0gaFWOT2klxIqdgZFm7Xv
         jx6GiH42rGVYSk7evv2gfxQQqiMaWN+isY7Ln3kJsIRAMgm5HhCOdkJw75/d4gHe+3mS
         2Ij2y5sJVVhIkztAZBqdR3qQ9la7KaH37DNUGmbabpO4oBkKgvKTqQ4axn9sLRTF8E+s
         LI5XFBXDM/zdS5NwVtxIhPQeGyyjt7R17yqFrH9J8oAdg78jNajqKr5gnjHq4UCgAD5v
         p10azVWOCGSIXJ3KfUgQyazxUXRvFqFh5OcEyRWG79pC9aBk3liNyDil0IiCm0D2owuz
         EGMw==
X-Gm-Message-State: AOAM5303+FEURqf7KfYvEWs+OPt3UqAFovbUT8SbHZPimyE+A2AdBM1X
        3rIE9v5A1WnggDze3UwBR/gf2JOQ6uaMIpSl6zA=
X-Google-Smtp-Source: ABdhPJyx43vNEBrBrZuXxRTTCoBZil+htWYqxHCeEVNfGiJFvheCtia/wx0I9Gwr2Ctu0gaOHr6wCXt29g8be2bfVlY=
X-Received: by 2002:ac8:4b63:: with SMTP id g3mr2434928qts.171.1590783038547;
 Fri, 29 May 2020 13:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <20200525145325.GB2066@tardis>
 <CAEf4BzYCjbnU=cNyLnYRoZdMPKnBP4w8t+VRkXrC1GW-aFVkEA@mail.gmail.com>
 <20200528214823.GA211369@google.com> <CAEf4BzbzyA0mn7O-+x2peGa9WUuaGSi0+Gpyy-6t5iJwVLYf5A@mail.gmail.com>
 <20200529172301.GB196085@google.com>
In-Reply-To: <20200529172301.GB196085@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 May 2020 13:10:27 -0700
Message-ID: <CAEf4BzaV6SMHUCd9tJh6vh619xJW5TWKwvSt75LeB93+A6FC+w@mail.gmail.com>
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

On Fri, May 29, 2020 at 10:23 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, May 28, 2020 at 09:38:35PM -0700, Andrii Nakryiko wrote:
> > On Thu, May 28, 2020 at 2:48 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, May 25, 2020 at 11:38:23AM -0700, Andrii Nakryiko wrote:
> > > > On Mon, May 25, 2020 at 7:53 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > >
> > > > > Hi Andrii,
> > > > >
> > > > > On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > > > > > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > > > > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> > > > > > > > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > > > > > > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > > > > > > > Hello!
> > > > > > > > > >
> > > > > > > > > > Just wanted to call your attention to some pretty cool and pretty serious
> > > > > > > > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > > > > > > >
> > > > > > > > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > > > > > > > >
> > > > > > > > > > Thoughts?
> > > > > > > > >
> > > > > > > > > I find:
> > > > > > > > >
> > > > > > > > >         smp_wmb()
> > > > > > > > >         smp_store_release()
> > > > > > > > >
> > > > > > > > > a _very_ weird construct. What is that supposed to even do?
> > > > > > > >
> > > > > > > > Indeed, it looks like one or the other of those is redundant (depending
> > > > > > > > on the context).
> > > > > > >
> > > > > > > Probably.  Peter instead asked what it was supposed to even do.  ;-)
> > > > > >
> > > > > > I agree, I think smp_wmb() is redundant here. Can't remember why I thought
> > > > > > that it's necessary, this algorithm went through a bunch of iterations,
> > > > > > starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some
> > > > > > point, and settling on smp_read_acquire/smp_store_release, eventually. Maybe
> > > > > > there was some reason, but might be that I was just over-cautious. See reply
> > > > > > on patch thread as well ([0]).
> > > > > >
> > > > > >   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/
> > > > > >
> > > > >
> > > > > While we are at it, could you explain a bit on why you use
> > > > > smp_store_release() on consumer_pos? I ask because IIUC, consumer_pos is
> > > > > only updated at consumer side, and there is no other write at consumer
> > > > > side that we want to order with the write to consumer_pos. So I fail
> > > > > to find why smp_store_release() is necessary.
> > > > >
> > > > > I did the following modification on litmus tests, and I didn't see
> > > > > different results (on States) between two versions of litmus tests.
> > > > >
> > > >
> > > > This is needed to ensure that producer can reliably detect whether it
> > > > needs to trigger poll notification.
> > >
> > > Boqun's question is on the consumer side though. Are you saying that on the
> > > consumer side, the loads prior to the smp_store_release() on the consumer
> > > side should have been seen by the consumer?  You are already using
> > > smp_load_acquire() so that should be satisified already because the
> > > smp_load_acquire() makes sure that the smp_load_acquire()'s happens before
> > > any future loads and stores.
> >
> > Consumer is reading two things: producer_pos and each record's length
> > header, and writes consumer_pos. I re-read this paragraph many times,
> > but I'm still a bit confused on what exactly you are trying to say.
>
> This is what I was saying in the other thread. I think you missed that
> comment. If you are adding litmus documentation, at least it should be clear
> what memory ordering is being verified. Both me and Boqun tried to remove a
> memory barrier each and the test still passes. So what exactly are you
> verifying from a memory consistency standpoint? I know you have those various
> rFail things and conditions - but I am assuming the goal here is to verify
> memory consistency as well. Or are we just throwing enough memory barriers at
> the problem to make sure the test passes, without understanding exactly what
> ordering is needed?

High-level goal was to verify that producers and consumer don't see
intermediate states they are not supposed to and overall the flow of
records is correct. It wasn't an explicit goal for me to find the
absolute minimal/weakest memory ordering that make this work. I did my
best to write invariants in such a way as to capture violations, but
I'm sure it won't catch 100% of possible problems unfortunately. E.g.,
if busy bit (len = -1 part) ordering is buggy, I didn't find a perfect
way to differentiate between consumer being stuck because record is
"busy" or because consumer (which is in no way serialized with
producers) "ran sooner" and just didn't see the record being committed
yet. But on the other hand, it did capture few subtle issues, which
made writing these litmus tests worthwhile nevertheless :)

I'm sure litmus tests can be improved and expanded, but I tried to
strike a balance between practicality and perfection.

>
> > Can you please specify in each case release()/acquire() of which
> > variable you are talking about?
>
> I don't want to speculate and confuse the thread more. I am afraid the burden
> of specifying what the various release/acquire orders is on the author of the
> code introducing the memory barriers ;-). That is, IMHO you should probably add
> code comments in the test about why a certain memory barrier is needed.

Sure, I'll follow up with more comments clarifying this. I was
genuinely trying to understand all those ordering implications you
were trying to describe, it's a tricky business, unfortunately.

>
> That said, I need to do more diligence and read the actual BPF ring buffer
> code to understand what you're modeling. I will try to make time to do that.

Great, thanks!

>
> thanks!
>
>  - Joel
>
