Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1497E1760FD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBR0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 12:26:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44746 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBR0O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 12:26:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so11037907oia.11
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaTSpHFt5MftmtYSad2hy72pa4qDj42XRRqq+4ZzagY=;
        b=NKuXIOmW6Kp0pimikekP7b6UVUrv8Ao4Ih3ThTYwqXs3GTDmpWRxxoRjBApBQP1/Nd
         uB8VieSU3E9sg6JuCKG27NvNMcIGzT6j7RK9vRU4FAVNpQ8wO6miysv7di6vR5w5IAKz
         4VcolKDLzzq3JGIaEKKmO0X6IaasU+onNZo3ejuYTP1NcePjVqcVLUHxpgc8MuhZDWUX
         HM4+u2Cr7UI09iut8dZJuMRPwAjyWQzu/Z7kvGshW48WLBsCU10OjKESE/8oVchrUltq
         UFS/Fb3G9W8oEzX1VGdkNpV5dvPvw0EoOAIWLeiXFFoWjC6VYE+yyjAjrIGYPnvNRK99
         X9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaTSpHFt5MftmtYSad2hy72pa4qDj42XRRqq+4ZzagY=;
        b=YjwUSpfYUPmZVMb9vIU6eLvw2aKaN0yXDCEfBshd50wIU7yw2ImkiVDu+X+4l+s5CY
         ThP0Y00KoZqQhATTb0uMRjD0YPvcz6clmKttbhI9168qOIvkI7Ac2A1lqtlc17oOqEoD
         3Sp3oTPGazqmm2hGhSp/CaG7WwzIKi1e++896NjMAfMmXEni6PnJI8RVbeVyO1p19ESI
         hj5unCGjfishFyOHLjKZ+SZMGOKpxFmF8Hhyp0hhbjURxqHbachysj+O6/wjwokmZXaT
         atHrnxnLOvX+yS/l/sRKMOSBetPVpwC5adFhbfTxOK9WNT8nKsW0w0HhKTm8N9b9Virx
         5qlA==
X-Gm-Message-State: ANhLgQ33oT7hIXE1oFnxSZym3iuLl1DqIY8c8dMK4x95Wg2kztXG2UZn
        x2snvLnejMjEaxtO3mUyPySrabqEIAwXz6ChwcHBSg==
X-Google-Smtp-Source: ADFU+vuzdmbsyQ7A/wZpIbN3I4xIuHRBw+o6xIZWogCdM+JXhx55nlFMOyS+sSzpeoos8f+VxD88eidDyh1YfrUYWyo=
X-Received: by 2002:a54:4510:: with SMTP id l16mr138926oil.70.1583169972647;
 Mon, 02 Mar 2020 09:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20200302141819.40270-1-elver@google.com> <Pine.LNX.4.44L0.2003021134360.1555-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2003021134360.1555-100000@iolanthe.rowland.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Mar 2020 18:26:01 +0100
Message-ID: <CANpmjNPeRibmjpNfWEcfayPsEqKJ0uwU7=7w4CGuyWMdhdPrrg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model/Documentation: Fix "conflict" definition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2 Mar 2020 at 17:47, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 2 Mar 2020, Marco Elver wrote:
>
> > Alan: I think this needs your Signed-off-by, since I added you as
> > Co-developed-by.
>
> Here you go:
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>
> > Let me know if this works for you.
>
> See below.
>
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> >
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
> >
> > The LKMM as well as the C11 memory model are adaptations of
> > data-race-free, which are based on the work in [2]. Necessarily, we need
> > both conflicting data operations (plain) and synchronization operations
> > (marked). For example, C11's definition is based on [3], which defines a
> > "data race" as: "Two memory operations conflict if they access the same
> > memory location, and at least one of them is a store, atomic store, or
> > atomic read-modify-write operation. In a sequentially consistent
> > execution, two memory operations from different threads form a type 1
> > data race if they conflict, at least one of them is a data operation,
> > and they are adjacent in <T (i.e., they may be executed concurrently)."
> >
> > [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
> >     Programs that Share Memory", 1988.
> >       URL: http://snir.cs.illinois.edu/listed/J21.pdf
> >
> > [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
> >     Multiprocessors", 1993.
> >       URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> >
> > [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
> >     Model", 2008.
> >       URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > ---
> > v2:
> > * Apply Alan's suggested version.
> >   - Move "from different CPUs (or threads)" from "conflict" to "data
> >     race" definition. Update "race candidate" accordingly.
> > * Add citations to commit message.
> >
> > v1: http://lkml.kernel.org/r/20200228164621.87523-1-elver@google.com
> > ---
> >  .../Documentation/explanation.txt             | 77 +++++++++----------
> >  1 file changed, 38 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > index e91a2eb19592a..7a59cadc2f4ca 100644
> > --- a/tools/memory-model/Documentation/explanation.txt
> > +++ b/tools/memory-model/Documentation/explanation.txt
> > @@ -1987,28 +1987,28 @@ outcome undefined.
> >
> >  In technical terms, the compiler is allowed to assume that when the
> >  program executes, there will not be any data races.  A "data race"
> > -occurs when two conflicting memory accesses execute concurrently;
> > -two memory accesses "conflict" if:
> > +occurs when two conflicting memory accesses from different CPUs (or
> > +different threads on the same CPU) execute concurrently, and at least
> > +one of them is plain.  Two memory accesses "conflict" if:
> >
> >       they access the same location,
> >
> > -     they occur on different CPUs (or in different threads on the
> > -     same CPU),
> > -
> > -     at least one of them is a plain access,
> > -
> >       and at least one of them is a store.
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
> > +We'll say that two accesses from different threads are "race
> > +candidates" if they conflict and at least one of them is plain.
> > +Whether or not two candidates actually do race in a given execution
> > +then depends on whether they are concurrent.  The LKMM tries to
> > +determine whether a program contains race candidates which may execute
> > +concurrently; if it does then the LKMM says there is a potential data
> > +race and makes no predictions about the program's outcome.
>
> Hmmm.  Although the content is okay, I don't like the organization very
> much.  What do you think of this for the above portion of the patch)?

Thanks, looks good to me. Applied in v3:
http://lkml.kernel.org/r/20200302172101.157917-1-elver@google.com

-- Marco

> Alan Stern
>
>
>
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -1987,28 +1987,36 @@ outcome undefined.
>
>  In technical terms, the compiler is allowed to assume that when the
>  program executes, there will not be any data races.  A "data race"
> -occurs when two conflicting memory accesses execute concurrently;
> -two memory accesses "conflict" if:
> +occurs when there are two memory accesses such that:
>
> -       they access the same location,
> +1.     they access the same location,
>
> -       they occur on different CPUs (or in different threads on the
> -       same CPU),
> +2.     at least one of them is a store,
> +
> +3.     at least one of them is plain,
>
> -       at least one of them is a plain access,
> +4.     they occur on different CPUs (or in different threads on the
> +       same CPU), and
>
> -       and at least one of them is a store.
> +5.     they execute concurrently.
>
> -The LKMM tries to determine whether a program contains two conflicting
> -accesses which may execute concurrently; if it does then the LKMM says
> -there is a potential data race and makes no predictions about the
> +In the literature, two accesses are said to "conflict" if they satisfy
> +1 and 2 above.  We'll go a little farther and say that two accesses
> +are "race candidates" if they satisfy 1 - 4.  Thus, whether or not two
> +race candidates actually do race in a given execution depends on
> +whether they are concurrent.
> +
> +The LKMM tries to determine whether a program contains two race
> +candidates which may execute concurrently; if it does then the LKMM
> +says there is a potential data race and makes no predictions about the
>  program's outcome.
>
> -Determining whether two accesses conflict is easy; you can see that
> -all the concepts involved in the definition above are already part of
> -the memory model.  The hard part is telling whether they may execute
> -concurrently.  The LKMM takes a conservative attitude, assuming that
> -accesses may be concurrent unless it can prove they cannot.
> +Determining whether two accesses are race candidates is easy; you can
> +see that all the concepts involved in the definition above are already
> +part of the memory model.  The hard part is telling whether they may
> +execute concurrently.  The LKMM takes a conservative attitude,
> +assuming that accesses may be concurrent unless it can prove they
> +are not.
>
>  If two memory accesses aren't concurrent then one must execute before
>  the other.  Therefore the LKMM decides two accesses aren't concurrent
>
>
