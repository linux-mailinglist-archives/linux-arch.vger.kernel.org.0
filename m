Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA84C5E8C
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiB0UX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiB0UXz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 15:23:55 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD4E83E0EC;
        Sun, 27 Feb 2022 12:23:17 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21RKHPMx016218;
        Sun, 27 Feb 2022 14:17:25 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21RKHOOd016217;
        Sun, 27 Feb 2022 14:17:24 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 27 Feb 2022 14:17:24 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator after the loop
Message-ID: <20220227201724.GZ614@gate.crashing.org>
References: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com> <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com> <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com> <20220227010956.GW614@gate.crashing.org> <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com> <20220227113245.GY614@gate.crashing.org> <CANiq72m28WrjVHkcg5Y0LDa51Ur4OCpFbGdcq+v4gqiC0Wi6zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m28WrjVHkcg5Y0LDa51Ur4OCpFbGdcq+v4gqiC0Wi6zg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 07:09:03PM +0100, Miguel Ojeda wrote:
> On Sun, Feb 27, 2022 at 1:09 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > How will you define dividing by zero so that its behaviour is reasonable
> > for every program, for example?
> 
> The solution is to let the developer specify what they need to happen.
> That choice should include the unsafe possibility (i.e. unchecked),
> because sometimes that is precisely what we need.

Requiring to annotate every place that has UB (or *can* have UB!) by the
user is even less friendly than having so much UB is already :-(

I don't see how you will fit this into the C syntax, btw?

> > Invoking an error handler at runtime
> > has most of the same unwanted effects, except is is never silent.  You
> 
> It may not be what it is needed in some cases (thus the necessity to
> be able to choose), but at least one can predict what happens and
> different compilers, versions, flags, inputs, etc. would agree.

You need a VM like Java's to get even *close* to that.  This is not the
C target: it is slower than wanted/expected, it is hosted instead of
embedded, and it comes with a whole host of issues of its own.  One of
the strengths of C is its tiny runtime, a few kB is a lot already!

I completely agree that if you design a new "systems" language, you want
to have much less undefined behaviour than C has.  But it is self-
delusion to think you can eradicate all (or even most).

And there are much bigger problems in any case!  If you think that if
programmers could no longer write programs that invoke undefined
behaviour they will write much better programs, programs with fewer
serious functionality or security problems, even just a factor of two
better, well...


Segher
