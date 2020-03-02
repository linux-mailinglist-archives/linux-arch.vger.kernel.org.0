Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09004175CD1
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCBOVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 09:21:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38101 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCBOVW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 09:21:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id i14so2741361otp.5
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 06:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42gWKv1rkhmMzg4bqOpxUUGQ9UCFpi1Ui3MOzmb5OYQ=;
        b=NREOJWWXFC84U1eR6WxIhwa8aMpgKEZe6g0rSTXcTS9qi2T1ZH9oE66qb864DbQyzE
         Mg/ympkW6Y4/g/27vf7vYpFFXd+ImCN96HkpoJuBADbxhXf/DJow5/kMqw9KhLGZ2X2y
         A9kg463iOYaGyMcXqV5l5n3Bax5OC8HdjkRLDSiJ+ZrT4korFZCpDmKZlZ+JUB4Iu07u
         YWM5Omo/3T3BT7NhS1GjYO2o39fiQEdtOG/mmJyRPiRVHMxzVdvfvnl/LC+hOFw2t30G
         4lzjI/FalBUlKK/dp6SqexaHL8ed5Lqr9CgeKu27kTA3V3ahkt8wHuJ8lz786bMl2jjm
         T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42gWKv1rkhmMzg4bqOpxUUGQ9UCFpi1Ui3MOzmb5OYQ=;
        b=RRLu4VRXmigFjXqmaIFaEKSnLigAS++EPb5qVo8RsESKJlxYsF9m8iWNK//m111l5B
         hVqbaVcp3UCZPtE9QeUKHAfp60jiPR+QjJephWaPNaqPsz6+fdAxNDZc9220PZ5/rk8h
         +YKGyTkT8tacDkRfbYp85u/azohIkTfgJGl4TAZPDsxhroMQJ30kuKx48q/CZLWuYXeq
         Zvy6CWpGRBHevvT7C7Zp7sL/VGx6zcRYqhozwV/+pajTrgMENMaWA0kTz22lKxQveawI
         6YW+gsp73FHr59ZYLXRktF3jKegozTfVNzY8ogl/8jzgppPFk8XXE71bjkRrgo3iQbHG
         TjTA==
X-Gm-Message-State: APjAAAVM2OUCOdaiRXR4eOOtiCxblLOh1Jq1XyL40q/83MbTy8XOUbMr
        tH8kku/PCWv1djh/Pj3b1kqz7vuD9pOfJxzvC4n02A==
X-Google-Smtp-Source: APXvYqxgARlH1Gwb+QumB5wY2plkxXrZfd0teC0HTRpFXaOJspIIuO+nTylCUSHv3hWqax0YfcAYJNVkL1na9cMsfxE=
X-Received: by 2002:a9d:906:: with SMTP id 6mr10404522otp.251.1583158878702;
 Mon, 02 Mar 2020 06:21:18 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMOmirPRKbjX9=V+eZD-YsEvfhUU8r6EDefkOJTBLDYNQ@mail.gmail.com>
 <Pine.LNX.4.44L0.2002281424410.1599-100000@iolanthe.rowland.org> <CANpmjNOzh2S1fvKa+5agFoE+0ZUVUe=K2hgw3i_hj6F48Ga0Gw@mail.gmail.com>
In-Reply-To: <CANpmjNOzh2S1fvKa+5agFoE+0ZUVUe=K2hgw3i_hj6F48Ga0Gw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Mar 2020 15:21:07 +0100
Message-ID: <CANpmjNPoz8=gTodu1wbUa9bt1k4eskuvmpVLy748s0Q6+9c4xA@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix "conflict" definition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Feb 2020 at 21:31, Marco Elver <elver@google.com> wrote:
>
> On Fri, 28 Feb 2020 at 21:20, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 28 Feb 2020, Marco Elver wrote:
> >
> > > On Fri, 28 Feb 2020 at 19:54, Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Fri, 28 Feb 2020 at 18:24, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Fri, 28 Feb 2020, Marco Elver wrote:
> > > > >
> > > > > > For language-level memory consistency models that are adaptations of
> > > > > > data-race-free, the definition of "data race" can be summarized as
> > > > > > "concurrent conflicting accesses, where at least one is non-sync/plain".
> > > > > >
> > > > > > The definition of "conflict" should not include the type of access nor
> > > > > > whether the accesses are concurrent or not, which this patch addresses
> > > > > > for explanation.txt.
> > > > >
> > > > > Why shouldn't it?  Can you provide any references to justify this
> > > > > assertion?
> > > >
> > > > The definition of "conflict" as we know it and is cited by various
> > > > papers on memory consistency models appeared in [1]: "Two accesses to
> > > > the same variable conflict if at least one is a write; two operations
> > > > conflict if they execute conflicting accesses."
> > > >
> > > > The LKMM as well as C11 are adaptations of data-race-free, which are
> > > > based on the work in [2]. Necessarily, we need both conflicting data
> > > > operations (plain) and synchronization operations (marked). C11's
> > > > definition is based on [3], which defines a "data race" as:  "Two
> > > > memory operations conflict if they access the same memory location,
> > > > and at least one of them is a store, atomic store, or atomic
> > > > read-modify-write operation. In a sequentially consistent execution,
> > > > two memory operations from different threads form a type 1 data race
> > > > if they conflict, at least one of them is a data operation, and they
> > > > are adjacent in <T (i.e., they may be executed concurrently)."
> > > >
> > > > [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
> > > > Programs that Share Memory", 1988.
> > > >       URL: http://snir.cs.illinois.edu/listed/J21.pdf
> > > >
> > > > [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
> > > > Multiprocessors", 1993.
> > > >       URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> > > >
> > > > [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
> > > > Model", 2008.
> > > >      URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> >
> > Okay, very good.  Please include at least one of these citations in the
> > description of the next version of your patch.
> >
> > > > > Also, note two things: (1) The existing text does not include
> > > > > concurrency in the definition of "conflict".  (2) Your new text does
> > > > > include the type of access in the definition (you say that at least one
> > > > > of the accesses must be a write).
> > > >
> > > > Yes, "conflict" is defined in terms of "access to the same memory
> > > > location and at least one performs a write" (can be any operation that
> > > > performs a write, including RMWs etc.). It should not include
> > > > concurrency. We can have conflicting operations that are not
> > > > concurrent, but these will never be data races.
> > > >
> > > > > > The definition of "data race" remains unchanged, but the informal
> > > > > > definition for "conflict" is restored to what can be found in the
> > > > > > literature.
> > > > >
> > > > > It does not remain unchanged.  You removed the portion that talks about
> > > > > accesses executing on different CPUs or threads.  Without that
> > > > > restriction, you raise the nonsensical possibility that a single thread
> > > > > may by definition have a data race with itself (since modern CPUs use
> > > > > multiple-instruction dispatch, in which several instructions can
> > > > > execute at the same time).
> > > >
> > > > Andrea raised the point that "occur on different CPUs (or in different
> > > > threads on the same CPU)" can be interpreted as "in different threads
> > > > [even if they are serialized via some other synchronization]".
> > > >
> > > > Arguably, no sane memory model or abstract machine model permits
> > > > observable intra-thread concurrency of instructions in the same
> > > > thread. At the abstract machine level, whether or not there is true
> > > > parallelism shouldn't be something that the model concerns itself
> > > > with. Simply talking about "concurrency" is unambiguous, unless the
> > > > model says intra-thread concurrency is a thing.
> > > >
> > > > I can add it back if it helps make this clearer, but we need to mention both.
> >
> > Then by all means, let's mention both.
> >
> > > > > > Signed-by: Marco Elver <elver@google.com>
> > > > > > ---
> > > > > >  tools/memory-model/Documentation/explanation.txt | 15 ++++++---------
> > > > > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > > > > > index e91a2eb19592a..11cf89b5b85d9 100644
> > > > > > --- a/tools/memory-model/Documentation/explanation.txt
> > > > > > +++ b/tools/memory-model/Documentation/explanation.txt
> > > > > > @@ -1986,18 +1986,15 @@ violates the compiler's assumptions, which would render the ultimate
> > > > > >  outcome undefined.
> > > > > >
> > > > > >  In technical terms, the compiler is allowed to assume that when the
> > > > > > -program executes, there will not be any data races.  A "data race"
> > > > > > -occurs when two conflicting memory accesses execute concurrently;
> > > > > > -two memory accesses "conflict" if:
> > > > > > +program executes, there will not be any data races. A "data race"
> > > > >
> > > > > Unnecessary (and inconsistent with the rest of the document) whitespace
> > > > > change.
> > > >
> > > > Reverted.
> > > >
> > > > > > +occurs if:
> > > > > >
> > > > > > -     they access the same location,
> > > > > > +     two concurrent memory accesses "conflict";
> > > > > >
> > > > > > -     they occur on different CPUs (or in different threads on the
> > > > > > -     same CPU),
> > > > > > +     and at least one of the accesses is a plain access;
> > > > > >
> > > > > > -     at least one of them is a plain access,
> > > > > > -
> > > > > > -     and at least one of them is a store.
> > > > > > +     where two memory accesses "conflict" if they access the same
> > > > > > +     memory location, and at least one performs a write;
> > > > > >
> > > > > >  The LKMM tries to determine whether a program contains two conflicting
> > > > > >  accesses which may execute concurrently; if it does then the LKMM says
> > > > >
> > > > > To tell the truth, the only major change I can see here (apart from the
> > > > > "differenct CPUs" restriction) is that you want to remove the "at least
> > > > > one is plain" part from the definition of "conflict" and instead make
> > > > > it a separate requirement for a data race.  That's fine with me in
> > > > > principle, but there ought to be an easier way of doing it.
> > > >
> > > > Yes pretty much. The model needs to be able to talk about "conflicting
> > > > synchronization accesses" where all accesses are marked. Right now the
> > > > definition of conflict doesn't permit that.
> > > >
> > > > > Furthermore, this section of explanation.txt goes on to use the words
> > > > > "conflict" and "conflicting" in a way that your patch doesn't address.
> > > > > For example, shortly after this spot it says "Determining whether two
> > > > > accesses conflict is easy"; you should change it to say "Determining
> > > > > whether two accesses conflict and at least one of them is plain is
> > > > > easy" -- but this looks pretty ungainly.  A better approach might be to
> > > > > introduce a new term, define it to mean "conflicting accesses at least
> > > > > one of which is plain", and then use it instead throughout.
> > > >
> > > > The definition of "conflict" as used in the later text is synonymous
> > > > with "data race".
> > >
> > > Correction: it's "data race" minus "concurrent" which makes things
> > > more difficult. In which case, fixing this becomes more difficult.
> > >
> > > > > Alternatively, you could simply leave the text as it stands and just
> > > > > add a parenthetical disclaimer pointing out that in the CS literature,
> > > > > the term "conflict" is used even when both accesses are marked, so the
> > > > > usage here is somewhat non-standard.
> > > >
> > > > The definition of what a "conflict" is, is decades old [1, 2]. I
> > > > merely thought we should avoid changing fundamental definitions that
> > > > have not changed in decades, to avoid confusing people. The literature
> > > > on memory models is confusing enough, so fundamental definitions that
> > > > are "common ground" shouldn't be changed if it can be avoided. I think
> > > > here it is pretty trivial to avoid.
> >
> > All right.  Here is my suggestion for a patch that does more or less
> > what you want.  Fiddle around with it until you like the end result and
> > let's see what you get.
>
> Great, thank you!  I'll go through it and send v2 soon (won't get to
> it today though).

v2 here: http://lkml.kernel.org/r/20200302141819.40270-1-elver@google.com

Alan: I think this needs your Signed-off-by, since I added you as
Co-developed-by.

Let me know if this works for you.

Many thanks,
-- Marco

> Thanks,
> -- Marco
>
> > Alan
> >
> >
> > Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> > +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> > @@ -1987,28 +1987,30 @@ outcome undefined.
> >
> >  In technical terms, the compiler is allowed to assume that when the
> >  program executes, there will not be any data races.  A "data race"
> > -occurs when two conflicting memory accesses execute concurrently;
> > -two memory accesses "conflict" if:
> > +occurs when two conflicting memory accesses execute concurrently and
> > +at least one of them is plain.  Two memory accesses "conflict" if:
> >
> >         they access the same location,
> >
> >         they occur on different CPUs (or in different threads on the
> >         same CPU),
> >
> > -       at least one of them is a plain access,
> > -
> >         and at least one of them is a store.
> >
> > -The LKMM tries to determine whether a program contains two conflicting
> > -accesses which may execute concurrently; if it does then the LKMM says
> > -there is a potential data race and makes no predictions about the
> > -program's outcome.
> > -
> > -Determining whether two accesses conflict is easy; you can see that
> > -all the concepts involved in the definition above are already part of
> > -the memory model.  The hard part is telling whether they may execute
> > -concurrently.  The LKMM takes a conservative attitude, assuming that
> > -accesses may be concurrent unless it can prove they cannot.
> > +We'll say that two accesses are "race candidates" if they conflict and
> > +at least one of them is plain.  Whether or not two candidates actually
> > +do race in a given execution then depends on whether they are
> > +concurrent.  The LKMM tries to determine whether a program contains
> > +two race candidates which may execute concurrently; if it does then
> > +the LKMM says there is a potential data race and makes no predictions
> > +about the program's outcome.
> > +
> > +Determining whether two accesses are race candidates is easy; you can
> > +see that all the concepts involved in the definition above are already
> > +part of the memory model.  The hard part is telling whether they may
> > +execute concurrently.  The LKMM takes a conservative attitude,
> > +assuming that accesses may be concurrent unless it can prove they
> > +are not.
> >
> >  If two memory accesses aren't concurrent then one must execute before
> >  the other.  Therefore the LKMM decides two accesses aren't concurrent
> > @@ -2171,8 +2173,8 @@ again, now using plain accesses for buf:
> >         }
> >
> >  This program does not contain a data race.  Although the U and V
> > -accesses conflict, the LKMM can prove they are not concurrent as
> > -follows:
> > +accesses are race candidates, the LKMM can prove they are not
> > +concurrent as follows:
> >
> >         The smp_wmb() fence in P0 is both a compiler barrier and a
> >         cumul-fence.  It guarantees that no matter what hash of
> > @@ -2326,12 +2328,11 @@ could now perform the load of x before t
> >  a control dependency but no address dependency at the machine level).
> >
> >  Finally, it turns out there is a situation in which a plain write does
> > -not need to be w-post-bounded: when it is separated from the
> > -conflicting access by a fence.  At first glance this may seem
> > -impossible.  After all, to be conflicting the second access has to be
> > -on a different CPU from the first, and fences don't link events on
> > -different CPUs.  Well, normal fences don't -- but rcu-fence can!
> > -Here's an example:
> > +not need to be w-post-bounded: when it is separated from the other
> > +race-candidate access by a fence.  At first glance this may seem
> > +impossible.  After all, to be race candidates the two accesses must
> > +be on different CPUs, and fences don't link events on different CPUs.
> > +Well, normal fences don't -- but rcu-fence can!  Here's an example:
> >
> >         int x, y;
> >
> > @@ -2367,7 +2368,7 @@ concurrent and there is no race, even th
> >  isn't w-post-bounded by any marked accesses.
> >
> >  Putting all this material together yields the following picture.  For
> > -two conflicting stores W and W', where W ->co W', the LKMM says the
> > +race-candidate stores W and W', where W ->co W', the LKMM says the
> >  stores don't race if W can be linked to W' by a
> >
> >         w-post-bounded ; vis ; w-pre-bounded
> > @@ -2380,8 +2381,8 @@ sequence, and if W' is plain then they a
> >
> >         w-post-bounded ; vis ; r-pre-bounded
> >
> > -sequence.  For a conflicting load R and store W, the LKMM says the two
> > -accesses don't race if R can be linked to W by an
> > +sequence.  For race-candidate load R and store W, the LKMM says the
> > +two accesses don't race if R can be linked to W by an
> >
> >         r-post-bounded ; xb* ; w-pre-bounded
> >
> > @@ -2413,20 +2414,20 @@ is, the rules governing the memory subsy
> >  satisfy a load request and its determination of where a store will
> >  fall in the coherence order):
> >
> > -       If R and W conflict and it is possible to link R to W by one
> > -       of the xb* sequences listed above, then W ->rfe R is not
> > -       allowed (i.e., a load cannot read from a store that it
> > +       If R and W are race candidates and it is possible to link R to
> > +       W by one of the xb* sequences listed above, then W ->rfe R is
> > +       not allowed (i.e., a load cannot read from a store that it
> >         executes before, even if one or both is plain).
> >
> > -       If W and R conflict and it is possible to link W to R by one
> > -       of the vis sequences listed above, then R ->fre W is not
> > -       allowed (i.e., if a store is visible to a load then the load
> > -       must read from that store or one coherence-after it).
> > -
> > -       If W and W' conflict and it is possible to link W to W' by one
> > -       of the vis sequences listed above, then W' ->co W is not
> > -       allowed (i.e., if one store is visible to a second then the
> > -       second must come after the first in the coherence order).
> > +       If W and R are race candidates and it is possible to link W to
> > +       R by one of the vis sequences listed above, then R ->fre W is
> > +       not allowed (i.e., if a store is visible to a load then the
> > +       load must read from that store or one coherence-after it).
> > +
> > +       If W and W' are race candidates and it is possible to link W
> > +       to W' by one of the vis sequences listed above, then W' ->co W
> > +       is not allowed (i.e., if one store is visible to a second then
> > +       the second must come after the first in the coherence order).
> >
> >  This is the extent to which the LKMM deals with plain accesses.
> >  Perhaps it could say more (for example, plain accesses might
> >
