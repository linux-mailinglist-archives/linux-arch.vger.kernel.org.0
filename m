Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E871F33F22B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhCQOEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhCQODu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 10:03:50 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85556C06174A
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 07:03:50 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g27so41067102iox.2
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymhdoDvAaA6o8vodnixc6HMrHcaIQwrg8pqKT9Rq1yc=;
        b=Ir3RU7NOp+s5TcZetRPcl8D02MzIWdNMV55/B88Dvf4euLemwSBgTPRFxnkmYwnXVF
         tCUrjL0cW3YXHUTAPDk7JNsrC0LqlrYlygumAZEQK1oWehd0ppGEHGVfvos1pkJD0OAi
         nbmumPo0HAGP6Q9jkVhIG2TIVq497meWKW72BtZgRKF7cKANWvZHgefWr2Uae42+Mi2U
         Zr2UemCh5AS+1W/WRreVoxPZXTLR3E2YqI8vXPz3ZRphSllFnXTJYcr1N8Zzbc0WbTmS
         PzaR64Pm08GErFbNrPqJnaD9lVdTMyGEGH9CjcUD5nauNbKF/cN/cbvATFNTEzEtWfek
         xXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymhdoDvAaA6o8vodnixc6HMrHcaIQwrg8pqKT9Rq1yc=;
        b=Y0jtqzsr95EUJmI+5JNhBpIex0FY/sbYh/ksEcrowNd/czz1rJiwuG4brmVWVSaMA9
         BKW6rtcO/YZv6q2J9UytBZytgaYTQMZiaz1y5AGylxya1kDK115I5DG/vnwdiKeMZH+C
         exbymyDG9OmzCcq439K2rAOtX61qCeXIz8l2spA7aJuaWARfMwZu3Oa82/fMlhxNIXDz
         GaKkjEpqEelRP/W7hrGbpUPJ39czX/Gcp4D89UeBWiFrDa/Jhh4yfDhKp52ID5tRoBbE
         RobpwBsHimS5p5KJrgnnihjzNmNkLEPv8oVK4tOYPgAdIuw83c4KkPp10pdoqcvTfSSA
         zFQQ==
X-Gm-Message-State: AOAM530FGECrJDddpDgSfvG1cB2QwurPhekv/byUvBPlCadxF71lQIzW
        LL1NO0lD1NBbMu/849ZkrJ30v7+lB4WOk8cGLcpu6BmLI42jtQ==
X-Google-Smtp-Source: ABdhPJwq6upwfkxbY1zmstw9Xn58ItbWNHUF/v2EvLClNUSJv/iQ/DScMgQiL/hgbqvRevw3EX9B1kemWWgBAYt4Qoc=
X-Received: by 2002:a05:6638:238c:: with SMTP id q12mr2937061jat.114.1615989829886;
 Wed, 17 Mar 2021 07:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <cover.1611103406.git.thehajime@gmail.com>
 <d357fbd075319d8b32667323bc545e3e5e8e8a21.camel@sipsolutions.net>
 <m2czvzc2xw.wl-thehajime@gmail.com> <bc30898d6ac14c5c6e7eeeb72e41353a298bdf65.camel@sipsolutions.net>
In-Reply-To: <bc30898d6ac14c5c6e7eeeb72e41353a298bdf65.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Wed, 17 Mar 2021 16:03:38 +0200
Message-ID: <CAMoF9u3q_uhvzT0RJj42fAVQpVf-nnwXM9Zh_qXxYAG8YHcOUQ@mail.gmail.com>
Subject: Re: [RFC v8 00/20] Unifying LKL into UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 11:29 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi,

Hi Johannes,

> > My interpretation of MMU/NOMMU is like this;
> >
> > With (emulated) MMU architecture you will have more smooth integration
> > with other subsystems of kernel tree, because some subsystems/features
> > are written with "#ifdef CONFIG_MMU".  While NOMMU doesn't, it will
> > bring a simplified design with better portability.
> >
> > LKL takes rather to benefit better portability.
>
> I don't think it *matters* so much for portability? I mean, every system
> under the sun is going to allow some kind of "mprotect", right? You
> don't really want to port LKL to systems that don't have even that?
>

One use case where this matters are non OS environments such as
bootloaders [1], running on bare-bone hardware or kernel drivers [2,
3]. IMO it would be nice to keep these properties.

[1] https://www.freelists.org/post/linux-kernel-library/UEFI-LKL-port
[2] https://github.com/lkl/lkl-win-fsd
[3] https://www.haiku-os.org/tags/lkl-haiku-fsd/

> > >  * Why pthreads and all? You already require jump_buf, so UML's
> > >    switch_threads() ought to be just fine for scheduling? It almost
> > >    seems like you're doing this just so you can serialize against "other
> > >    threads" (application threads), but wouldn't that trivially be
> > >    handled by the application? You could let it hook into switch_to() or
> > >    something, but why should a single "LKL" CPU ever require multiple
> > >    threads? Seems to me that the userspace could be required to
> > >    "lkl_run()" or so (vs. lkl_start()). Heck, you could even exit
> > >    lkl_run() every time you switch tasks in the kernel, and leave
> > >    scheduling the kernel vs. the application entirely up to the
> > >    application? (A trivial application would be simply doing something
> > >    like "while (1) { lkl_run(); pause(); }" mimicking the idle loop of
> > >    UML.
> >
> > There is a description about this design choice in the LKL paper (*1);
> >
> >   "implementations based on setjmp - longjmp require usage of a single
> >   stack space partitioned between all threads. As the Linux kernel
> >   uses deep stacks (especially in the VFS layer), in an environment
> >   with small stack sizes (e.g. inside another operating system's
> >   kernel) this will place a very low limit on the number of possible
> >   threads."
> >
> > (from page 2, Section II, 2) Thread Support)
> >
> > This is a reason of using pthread as a context primitive.
>
> That impliciation (setjmp doesnt do stacks, so must use pthread) really
> isn't true, you also have posix contexts or windows fibers. That would
> probably be much easier to understands, since real threads imply that
> you have actual concurrency, which _shouldn't_ be true in the case of
> Linux emulated as being on a single CPU.
>
> Perhaps that just means you chose the wrong abstraction.
>
> In usfstl (something I've been working on) for example, we have an
> abstraction called (execution) "contexts", and they can be implemented
> using pthreads, fibers, or posix contexts, and you switch between them.
>
> (see https://github.com/linux-test-project/usfstl/blob/main/src/ctx-common.c)
>
> Using real pthreads implies that you have real threading, but then you
> need access to real mutexes, etc.
>
> If your abstraction was instead "switch context" then you could still
> implement it using pthreads+mutexes, or you could implement it using
> fibers on windows, or posix contexts - but you'd have a significantly
> reduced API surface, since you'd only expose __switch_to() or similar,
> and maybe a new stack allocation etc.
>

You are right. When I started the implementation for ucontext it was
obvious that it would be much simpler to have abstractions closer to
what Linux has (alloc, free and switch threads). But I never got to
finish that and then things went into a different direction.

> Additionally, I do wonder how UML does this now, it *does* use setjmp,
> so are you saying it doesn't properly use the kernel stacks?
>

To clarify a bit the statement in the paper, the context there was
that we should push the thread implementation to the
application/environment we run rather than providing "LKL" threads.
This was particularly important for running LKL in other OSes kernel
drivers. But you are right, we can use the switch abstraction and
implement it with threads and mutexes for those environments where it
helps.

> > to design that with UML, what we need to do are;
> >
> > 1) change Makefile to output liblinux.a
>
> or liblinux.so, I guess, dynamic linking should be ok.
>
> > we faced linker script issue, which is related with generating
> > relocatable object in the middle.
> >
> > 2) make the linker-script clean with 2-stage build
> > we fix the linker issues of (1)
> >
> > 3) expose syscall as a function call
> > conflicts names (link-time and compile-time conflicts)
> >
> > 4) header rename, object localization
> > to fix the issue (3)
> >
> > This is a common set of modifications to a library of UML.
>
> All of this is just _build_ issues. It doesn't mean you couldn't take
> some minimal code + liblinux.a and link it to get a "linux" equivalent
> to the current UML?
>
> TBH, I started thinking that it might be _really_ nice to be able to
> write an application that's *not quite UML* but has all the properties
> of UML built into it, i.e. can run userspace etc.
>
> > Other parts are a choice of design, I believe.
> > Because a library is more _reusable_ than an executable (by it means), the
> > choice of LKL is to be portable, which the current UML doesn't pursue it
> > extensibly (focus on intel platforms).
> >
>
> I don't think this really conflicts.
>
> You could have a liblinux.a/liblinux.so and some code that links it all
> together to get "linux" (UML). Having userspace running inside the UML
> (liblinux) might only be supported on x86 for now, MMU vs. NOMMU might
> be something that's configurable at build time, and if you pick NOMMU
> you cannot run userspace either, etc.
>
> But conceptually, why wouldn't it be possible to have a liblinux.so that
> *does* build with MMU and userspace support, and UML is a wrapper around
> it?
>

This is an interesting idea. Conceptually I think it is possible.
There are lots of details to be figured out before we do this. I think
that having a NOMMU version could be a good step in the right
direction, especially since I think a liblinux.so has more NOMMU
usecases than MMU usecases - but I haven't given too much thought to
the MMU usecases.
