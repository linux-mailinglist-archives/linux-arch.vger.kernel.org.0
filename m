Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D671E753A
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 07:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgE2FOe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 01:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2FOd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 01:14:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A44C08C5C6;
        Thu, 28 May 2020 22:14:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so1182868qka.4;
        Thu, 28 May 2020 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tg5+TcCm6QNV2OPAv532ciWBLdBm392xLd7vnlNNWYg=;
        b=rkqmUI+qUByunzA1ZP1hJzA5a/3shMd9H6A8mlXNa7h5wPDtsVM01uYPl7A2deaxN4
         pL60QomkW89QfHSMVq4yfJVp3x49WPKcb8IY6kPCMfJdt2KLOGvAJptl3t6RAyFJfzjR
         HhFwVpVFoZVhfKVieixaMqHVFLqsLqtjjkIAsEbYWphRWhTVo+XsFJY6mRPwoIF8+ls1
         m5ipphp573Qhi5OhFXeYRxnOz9dxNGxH8lL7LFiAjxvGSFRlIOKQF1+cELWYiMd6SaOa
         LroA8JHxqPyuWeWMNA5bVSRvz6quKa9HJk+FeI4ieiCMQMD6MiCJxnN0ai3VFAFqLx7C
         HUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg5+TcCm6QNV2OPAv532ciWBLdBm392xLd7vnlNNWYg=;
        b=kXMlhxy3lofMOgjZA+G22xGPtTg/vFqWkTFM0195BzaJlPYfLyQFwhJcR/e+FkPvOM
         R2pO4lbiZ9a7tL+6lDKvDOn90fG2F26CFGbf5pgSzMVTKfhi2ZTi8RU/4iifEXTlv+nX
         UezHIttcNwHGxiQzDleT/wRec6wlSlMG9uUSlCUxG6UpIPZunF7Ev72VtxgJ9oTg0zOg
         Ksh4CWFs1d0vRipCOscSUR1dzjbEmlKqOpnT136iIh+AAFWic58G0Ehw25XvA5dxv8tR
         P5ABxj0VjvV7uLvCEHEUKreM9s1L1lV7lhfsbB6reIx9Pu4xNDp2dBw/8UhHOBvB8L8N
         b5dw==
X-Gm-Message-State: AOAM530LjTXZhaulUQgDjGX33fGVvkG8eiimcx0iG5y2xHjLa450PNnb
        Uck4ZepZFg7eVKsBb5mYNcQx45+8yo9HZ/O4UEU=
X-Google-Smtp-Source: ABdhPJxsz2Q98YaknWIgWYhmOvgRsuMnXDtm8aEBREL4WHnhJWqdasWcw2Z5aegERXwEZX2eQZmbgGkefPOkElF7EKg=
X-Received: by 2002:a37:4595:: with SMTP id s143mr6768210qka.449.1590729272407;
 Thu, 28 May 2020 22:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72> <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72> <20200528220047.GB211369@google.com>
 <20200528221659.GS2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200528221659.GS2483@worktop.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 May 2020 22:14:21 -0700
Message-ID: <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>,
        dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 3:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 28, 2020 at 06:00:47PM -0400, Joel Fernandes wrote:
>
> > Any idea why this choice of locking-based ring buffer implementation in BPF?
> > The ftrace ring buffer can support NMI interruptions as well for writes.
> >
> > Also, is it possible for BPF to reuse the ftrace ring buffer implementation
> > or does it not meet the requirements?
>
> Both perf and ftrace are per-cpu, which, according to the patch
> description is too much memory overhead for them. Neither have ever
> considered anything else, atomic ops are expensive.

Right, as mentioned in commit description to [0], desire to use shared
ring buffer across multiple CPUs to save memory and absorb bigger
spikes with overall lower memory use was one of main motivations.
Ordered events was another one. Both perf buffer and ftrace buffer use
strictly per-CPU buffers, which in practice makes a lot of developers
make hard and non-obvious choice between using too much memory or
losing too much events due to running out of space in a buffer.

  [0] https://patchwork.ozlabs.org/project/netdev/patch/20200526063255.1675186-2-andriin@fb.com/

>
> On top of that, they want multi-producer support. Yes, doing that gets
> interesting really fast, but using spinlocks gets you a trainwreck like
> this.
>
> This thing so readily wanting to drop data on the floor should worry

It's true that *in NMI context*, if spinlock is already taken,
reservation will fail, so under high contention there will be
potentially high number of drops. So for such cases perfbuf might be a
better approach and BPF applications will have to deal with higher
memory usage. In practice, though, most BPF programs are not running
in NMI context, so there won't be any drop due to spinlock usage.
Having both perfbuf and this new BPF ringbuf gives people choice and
more options to tailor to their needs.

There is another cluster of applications which are unnecessarily more
complicated just for the fact that there is no ordering between
correlated events that happen on different CPUs. Per-CPU buffers are
not well suited for such cases, unfortunately.

> people, but apparently they've not spend enough time debugging stuff
> with partial logs yet. Of course, bpf_prog_active already makes BPF
> lossy, so maybe they went with that.

Not sure which "partial logs" you mean, I'll assume dropped samples?
All production BPF applications are already designed to handle data
loss, because it could and does happen due to running out of buffer
space. Of course, amount of such drops is minimized however possible,
but applications still need to be able to handle that.

Now, though, there will be more options. Now it's not just a question
of whether to allocate a tiny 64KB per-CPU buffer on 80 core server
and use reasonable 5MB for perfbuf overall, but suffer high and
frequent data loss whenever a burst of incoming events happen. Or bump
it up to, say, 256KB (or higher) and use 20MB+ now, which most of the
time will be completely unused, but be able to absorb 4x more events.
Now it might be more than enough to just allocate a single shared 5MB
buffer and be able to absorb much higher spikes (of course, assuming
not all CPUs will be spiking at the same time, in which case nothing
can really help you much w.r.t. data loss).

So many BPF users are acutely aware of data loss and care a lot, but
there are other constraints that they have to take into account.

As for expensiveness of spinlock and atomics, a lot of applications we
are seeing do not require huge throughput that per-CPU data structures
provide, so such overhead is acceptable. Even under high contention,
BPF ringbuf performance is pretty reasonable and will satisfy a lot of
applications, see [1].

  [1] https://patchwork.ozlabs.org/project/netdev/patch/20200526063255.1675186-5-andriin@fb.com/

>
> All reasons why I never bother with BPF, aside from it being more
> difficult than hacking up a kernel in the first place.

It's not my goal to pitch BPF here, but for a lot of real-world use
cases, hacking kernel is not an option at all, for many reasons. One
of them is that kernel upgrades across huge fleet of servers take a
long time, which teams can't afford to wait. In such cases, BPF is a
perfect solution, which can't be beaten, as evidenced by a wide
variety of BPF applications solving real problems.
