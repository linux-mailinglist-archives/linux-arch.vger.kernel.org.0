Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2833E083
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCPVaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCPV3p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 17:29:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D207C06174A
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 14:29:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMHFo-00H5tI-O9; Tue, 16 Mar 2021 22:29:28 +0100
Message-ID: <bc30898d6ac14c5c6e7eeeb72e41353a298bdf65.camel@sipsolutions.net>
Subject: Re: [RFC v8 00/20] Unifying LKL into UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Tue, 16 Mar 2021 22:29:27 +0100
In-Reply-To: <m2czvzc2xw.wl-thehajime@gmail.com> (sfid-20210316_021719_580974_E5FDB71E)
References: <cover.1601960644.git.thehajime@gmail.com>
         <cover.1611103406.git.thehajime@gmail.com>
         <d357fbd075319d8b32667323bc545e3e5e8e8a21.camel@sipsolutions.net>
         <m2czvzc2xw.wl-thehajime@gmail.com> (sfid-20210316_021719_580974_E5FDB71E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> First of all, thanks for all the comments to the patchset which has
> been a bit stale.  I'll reply them.

Yeah, sorry. I had it marked unread ("to look at") since you posted it.

> We didn't write down the details, which are already described in the
> LKL's paper (*1).  But I think we can extract/summarize some of
> important information from the paper to the document so that the
> design is more understandable.
> 
> *1 LKL's paper (pointer is also in the cover letter)
> https://www.researchgate.net/profile/Nicolae_Tapus2/publication/224164682_LKL_The_Linux_kernel_library/links/02bfe50fd921ab4f7c000000.pdf

OK, I guess I should take a look. Probably I never did, always thinking
that it was more of an overview than technical details and design
decisions.
> 
> My interpretation of MMU/NOMMU is like this;
> 
> With (emulated) MMU architecture you will have more smooth integration
> with other subsystems of kernel tree, because some subsystems/features
> are written with "#ifdef CONFIG_MMU".  While NOMMU doesn't, it will
> bring a simplified design with better portability.
> 
> LKL takes rather to benefit better portability.

I don't think it *matters* so much for portability? I mean, every system
under the sun is going to allow some kind of "mprotect", right? You
don't really want to port LKL to systems that don't have even that?

> >  * Why pthreads and all? You already require jump_buf, so UML's
> >    switch_threads() ought to be just fine for scheduling? It almost
> >    seems like you're doing this just so you can serialize against "other
> >    threads" (application threads), but wouldn't that trivially be
> >    handled by the application? You could let it hook into switch_to() or
> >    something, but why should a single "LKL" CPU ever require multiple
> >    threads? Seems to me that the userspace could be required to
> >    "lkl_run()" or so (vs. lkl_start()). Heck, you could even exit
> >    lkl_run() every time you switch tasks in the kernel, and leave
> >    scheduling the kernel vs. the application entirely up to the
> >    application? (A trivial application would be simply doing something
> >    like "while (1) { lkl_run(); pause(); }" mimicking the idle loop of
> >    UML.
> 
> There is a description about this design choice in the LKL paper (*1);
> 
>   "implementations based on setjmp - longjmp require usage of a single
>   stack space partitioned between all threads. As the Linux kernel
>   uses deep stacks (especially in the VFS layer), in an environment
>   with small stack sizes (e.g. inside another operating system's
>   kernel) this will place a very low limit on the number of possible
>   threads."
> 
> (from page 2, Section II, 2) Thread Support)
> 
> This is a reason of using pthread as a context primitive.

That impliciation (setjmp doesnt do stacks, so must use pthread) really
isn't true, you also have posix contexts or windows fibers. That would
probably be much easier to understands, since real threads imply that
you have actual concurrency, which _shouldn't_ be true in the case of
Linux emulated as being on a single CPU.

Perhaps that just means you chose the wrong abstraction.

In usfstl (something I've been working on) for example, we have an
abstraction called (execution) "contexts", and they can be implemented
using pthreads, fibers, or posix contexts, and you switch between them.

(see https://github.com/linux-test-project/usfstl/blob/main/src/ctx-common.c)

Using real pthreads implies that you have real threading, but then you
need access to real mutexes, etc.

If your abstraction was instead "switch context" then you could still
implement it using pthreads+mutexes, or you could implement it using
fibers on windows, or posix contexts - but you'd have a significantly
reduced API surface, since you'd only expose __switch_to() or similar,
and maybe a new stack allocation etc.

Additionally, I do wonder how UML does this now, it *does* use setjmp,
so are you saying it doesn't properly use the kernel stacks?

> And instead of manually doing lkl_run() to schedule threads and
> relying on host scheduler, LKL associates each kernel thread with a
> host-provided semaphore so that Linux scheduler has a control of host
> scheduler (prepared by pthread).

Right.

That's in line with what I did in my test framework in
https://github.com/linux-test-project/usfstl/blob/main/src/ctx-pthread.c

but like I said above, I think it's the wrong abstraction. Your
abstraction should be "switch context" (or "switch thread"), not dealing
with pthread, mutexes, etc.


> > And - kind of the theme behind all these questions - why is this not
> > making UML actually be a binary that uses LKL? If the design were like
> > what I'm alluding to above, that should actually be possible? Why should
> > it not be possible? Why would it not be desirable? (I'm actually
> > thinking that might be really useful to some of the things I'm doing.)
> > Yes, if the application actually supports userspace running then it has
> > som limitations on what it can do (in particular wrt. signals etc.), but
> > that could be documented and would be OK?
> 
> Let me try to describe how I think why not just generate liblinux.so
> from current UML.
> 
> Making UML to build a library, which has been a long wanted features,
> can be started;
> 
> 
> I think there are several functions which the library offers;
> 
> - applications can link the library and call functions in the library

Right.

> - the library will be used as a replacement of libc.a for syscall operations

Not sure I see this, is that really useful? I mean, most applications
don't live "standalone" in their own world? Dunno. Maybe it's useful.


> to design that with UML, what we need to do are;
> 
> 1) change Makefile to output liblinux.a

or liblinux.so, I guess, dynamic linking should be ok.

> we faced linker script issue, which is related with generating
> relocatable object in the middle.
> 
> 2) make the linker-script clean with 2-stage build
> we fix the linker issues of (1)
> 
> 3) expose syscall as a function call
> conflicts names (link-time and compile-time conflicts)
> 
> 4) header rename, object localization
> to fix the issue (3)
> 
> This is a common set of modifications to a library of UML.

All of this is just _build_ issues. It doesn't mean you couldn't take
some minimal code + liblinux.a and link it to get a "linux" equivalent
to the current UML?

TBH, I started thinking that it might be _really_ nice to be able to
write an application that's *not quite UML* but has all the properties
of UML built into it, i.e. can run userspace etc.

> Other parts are a choice of design, I believe.
> Because a library is more _reusable_ than an executable (by it means), the
> choice of LKL is to be portable, which the current UML doesn't pursue it
> extensibly (focus on intel platforms).
> 

I don't think this really conflicts.

You could have a liblinux.a/liblinux.so and some code that links it all
together to get "linux" (UML). Having userspace running inside the UML
(liblinux) might only be supported on x86 for now, MMU vs. NOMMU might
be something that's configurable at build time, and if you pick NOMMU
you cannot run userspace either, etc.

But conceptually, why wouldn't it be possible to have a liblinux.so that
*does* build with MMU and userspace support, and UML is a wrapper around
it?

> I hope this makes it a bit clear, but let me know if you found
> anything unclear.

See above, I guess :)

Thanks for all the discussion!

johannes

