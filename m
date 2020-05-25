Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536321E146C
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgEYSih (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgEYSih (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 14:38:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF48C061A0E;
        Mon, 25 May 2020 11:38:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f83so18157670qke.13;
        Mon, 25 May 2020 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23DAPcqB8Q8glew0dfYa48Kx+LlIJmfeo7vNARJB7AA=;
        b=Q9WtkIyUVNd2Pb9MZCAhVASeWTUzdTuaOlGjhMoF5DeQW/jDNjGpXnO+t++hjlAFJJ
         59WDE5JQJGAYs2YLkxr5MG8x5s+krrbxgt8qFVoMyffffrc6LeoEn58Ix+6RC2qVuhnO
         yotWt+uTDHyboglsZ894o2Bpi5P/zWzyQE5eDlaK050+pFIubx2WouJfa972MzBPttri
         CEMNpCuKPnuyJK+A8fAs94UfHupxBxIJGHKv/WDNCmqv7BwptIE5h4qocq1pxYUoD6yZ
         4CiUGM5EW1i+iTHuI0KjbF8QAQ9888ynYxSfGD0SYuY+bW9VCMaNQPryX+Z398ezofRI
         aIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23DAPcqB8Q8glew0dfYa48Kx+LlIJmfeo7vNARJB7AA=;
        b=O3Hd6nH38yMs0C/AgM87Zc6og9jeg1XnJfIZDqKWhJWluD9VCDQ4sjc8mBc1mZ49WN
         CWV0YhNm3LNv/1uFL4cLzoeR14yEuVrGCrYhvxQukEeiiuDN5OyplwsdcHZmKbZijNl+
         4tHXchobATByVF2WiEGQOMhABUQHSEY6ESXmL8W3hTcYS+/mN0lK/5ihG331pRs5q91S
         n54IA28NWfQz/ed3xkre27Lbvk12n/yO66lR9GDLefWJmPdGq5fxqbEpLGHUHdQgYRzM
         eoZdfTPaU7iLfawH4BF/tnLQxEKnxmELR8rveJYbKwr1uw/LxYwSfSIpF1iy8c0GrAA4
         AHaA==
X-Gm-Message-State: AOAM532HPOeoxG83UbFhFcUtVS/QdYoeCFssSnCP2x0Pkb9Tz9R8MeWU
        nUbWB1r6GetzX4+kvN/v9xGdMcxZ2UYYH/P19LE=
X-Google-Smtp-Source: ABdhPJwMfrtH8cPne04OGQ3D5FvI0JVTIXl2dWCVYZjYzhoq2xHZIC8lG2H9sBGAlv+sUgdilK2rysiIBY3caDPWXVo=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr2952336qkl.437.1590431914563;
 Mon, 25 May 2020 11:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <20200525145325.GB2066@tardis>
In-Reply-To: <20200525145325.GB2066@tardis>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 May 2020 11:38:23 -0700
Message-ID: <CAEf4BzYCjbnU=cNyLnYRoZdMPKnBP4w8t+VRkXrC1GW-aFVkEA@mail.gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, Joel Fernandes <joel@joelfernandes.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 25, 2020 at 7:53 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi Andrii,
>
> On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> > > > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > > > Hello!
> > > > > >
> > > > > > Just wanted to call your attention to some pretty cool and pretty serious
> > > > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > > >
> > > > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > I find:
> > > > >
> > > > >         smp_wmb()
> > > > >         smp_store_release()
> > > > >
> > > > > a _very_ weird construct. What is that supposed to even do?
> > > >
> > > > Indeed, it looks like one or the other of those is redundant (depending
> > > > on the context).
> > >
> > > Probably.  Peter instead asked what it was supposed to even do.  ;-)
> >
> > I agree, I think smp_wmb() is redundant here. Can't remember why I thought
> > that it's necessary, this algorithm went through a bunch of iterations,
> > starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some
> > point, and settling on smp_read_acquire/smp_store_release, eventually. Maybe
> > there was some reason, but might be that I was just over-cautious. See reply
> > on patch thread as well ([0]).
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/
> >
>
> While we are at it, could you explain a bit on why you use
> smp_store_release() on consumer_pos? I ask because IIUC, consumer_pos is
> only updated at consumer side, and there is no other write at consumer
> side that we want to order with the write to consumer_pos. So I fail
> to find why smp_store_release() is necessary.
>
> I did the following modification on litmus tests, and I didn't see
> different results (on States) between two versions of litmus tests.
>

This is needed to ensure that producer can reliably detect whether it
needs to trigger poll notification. Basically, consumer caught up at
about same time as producer commits new record, we need to make sure
that:
  - either consumer sees updated producer_pos > consumer_pos, and thus
knows that there is more data to consumer (but producer might not send
notification of new data in this case);
  - or producer sees that consumer already caught up (i.e.,
consumer_pos == producer_pos before currently committed record), and
in such case will definitely send notifications.

This is critical for correctness of epoll notifications.
Unfortunately, litmus tests don't test this notification aspect, as I
haven't originally figured out the invariant that can be defined to
validate this. I'll give it another thought, though, maybe this time
I'll come up with something.

> Regards,
> Boqun
>

[...]
