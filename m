Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D352F33F285
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 15:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhCQOYc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhCQOY2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 10:24:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0BC06174A
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 07:24:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMX5q-00HNpD-U3; Wed, 17 Mar 2021 15:24:15 +0100
Message-ID: <8c6f4ba994831b55ce7893f7e8e71a614474b907.camel@sipsolutions.net>
Subject: Re: [RFC v8 00/20] Unifying LKL into UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Date:   Wed, 17 Mar 2021 15:24:14 +0100
In-Reply-To: <CAMoF9u3q_uhvzT0RJj42fAVQpVf-nnwXM9Zh_qXxYAG8YHcOUQ@mail.gmail.com> (sfid-20210317_150351_779146_168D64BD)
References: <cover.1601960644.git.thehajime@gmail.com>
         <cover.1611103406.git.thehajime@gmail.com>
         <d357fbd075319d8b32667323bc545e3e5e8e8a21.camel@sipsolutions.net>
         <m2czvzc2xw.wl-thehajime@gmail.com>
         <bc30898d6ac14c5c6e7eeeb72e41353a298bdf65.camel@sipsolutions.net>
         <CAMoF9u3q_uhvzT0RJj42fAVQpVf-nnwXM9Zh_qXxYAG8YHcOUQ@mail.gmail.com>
         (sfid-20210317_150351_779146_168D64BD)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> One use case where this matters are non OS environments such as
> bootloaders [1], running on bare-bone hardware or kernel drivers [2,
> 3]. IMO it would be nice to keep these properties.

OK, that makes sense. Still, it seems it could be a compile-time
decision, and doesn't necessarily mean LKL has to be NOMMU, just that it
could support both?

I'm really trying to see if we can't get UML to be a user of LKL. IMHO
that would be good for the code, and even be good for LKL since then
it's maintained as part of UML as well, not "just" as its own use case.

> > If your abstraction was instead "switch context" then you could still
> > implement it using pthreads+mutexes, or you could implement it using
> > fibers on windows, or posix contexts - but you'd have a significantly
> > reduced API surface, since you'd only expose __switch_to() or similar,
> > and maybe a new stack allocation etc.
> 
> You are right. When I started the implementation for ucontext it was
> obvious that it would be much simpler to have abstractions closer to
> what Linux has (alloc, free and switch threads). But I never got to
> finish that and then things went into a different direction.

OK, sounds like you came to the same conclusion, more or less.

> > Additionally, I do wonder how UML does this now, it *does* use setjmp,
> > so are you saying it doesn't properly use the kernel stacks?
> > 
> 
> To clarify a bit the statement in the paper, the context there was
> that we should push the thread implementation to the
> application/environment we run rather than providing "LKL" threads.
> This was particularly important for running LKL in other OSes kernel
> drivers. But you are right, we can use the switch abstraction and
> implement it with threads and mutexes for those environments where it
> helps.

Right - like I pointed to USFSTL framework, you could have posix
ucontext, fiber and pthread at least, and obviously other things in
other environments (ThreadX anyone? ;-) )

> > But conceptually, why wouldn't it be possible to have a liblinux.so that
> > *does* build with MMU and userspace support, and UML is a wrapper around
> > it?
> > 
> 
> This is an interesting idea. Conceptually I think it is possible.
> There are lots of details to be figured out before we do this. I think
> that having a NOMMU version could be a good step in the right
> direction, especially since I think a liblinux.so has more NOMMU
> usecases than MMU usecases - but I haven't given too much thought to
> the MMU usecases.

Yeah, maybe UML would be the primary use case. I have been thinking that
there would be cases where you could combine kunit and having userspace
though, or unit-style testing but not with kunit which is "inside" the
kernel, but instead having the test code more "outside" the test kernel.
That's all kind of handwaving though and not really that crystallized in
my mind.

That said, I'm not entirely sure NOMMU would be the right path towards
this - if we do want to go this route it'll probably need changes in
both LKL and UML to converge to this point, and at least build it into
the abstractions.

For example the "idle" abstraction discussed elsewhere (is it part of
the app or part of the kernel?), or the thread discussion above (it is
part of the app but how is it implemented?) etc.

johannes


