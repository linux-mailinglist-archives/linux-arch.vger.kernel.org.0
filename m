Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98D511D4D8
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 19:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfLLSGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 13:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbfLLSGl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 13:06:41 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8834214AF;
        Thu, 12 Dec 2019 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576174000;
        bh=QbYFPcyUbQkcB6fG8/43kB0aA3LyHLLV1x1hYhirNx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONkagQPlYuBVQGWVNonUeKbx415r1LL+qzkuQsGkw33plWbHk8Y/45w/+OuUwoXCm
         a5KjjB7xE5Vn1z36KKIiaXEYfj4X67Sr4VZj4DfY1fCjTA3atFezHXphkDnvLkYhOh
         HUgLBzevlZk67TF8LP5CzctiU32bk+HDC9azTeo4=
Date:   Thu, 12 Dec 2019 18:06:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191212180634.GA19020@willie-the-truck>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 09:41:32AM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > +#ifdef GCC_VERSION < 40800
> 
> Where does that 4.8 version check come from, and why?
> 
> Yeah, I know, but this really wants a comment. Sadly it looks like gcc
> bugzilla is down, so
> 
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> 
> currently gives an "Internal Server Error" for me.
> 
> [ Delete the horrid code we have because of gcc bugs ]
> 
> > +#else /* GCC_VERSION < 40800 */
> > +
> > +#define READ_ONCE_NOCHECK(x)                                           \
> > +({                                                                     \
> > +       typeof(x) __x = *(volatile typeof(x))&(x);                      \
> 
> I think we can/should just do this unconditionally if it helps th eissue.

I'm currently trying to solve the issue by removing volatile from the bitop
function signatures, but it's grotty because there are quite a few callers
to fix up. I'm still trying to do it, because removing volatile fields from
structurs is generally a "good thing", but I'd be keen to simplify
READ_ONCE() as you suggest regardless.

> Maybe add a warning about how gcc < 4.8 might mis-compile the kernel -
> those versions are getting close to being unacceptable for kernel
> builds anyway.
> 
> We could also look at being stricter for the normal READ/WRITE_ONCE(),
> and require that they are
> 
>  (a) regular integer types
> 
>  (b) fit in an atomic word
> 
> We actually did (b) for a while, until we noticed that we do it on
> loff_t's etc and relaxed the rules. But maybe we could have a
> "non-atomic" version of READ/WRITE_ONCE() that is used for the
> questionable cases?

That makes a lot of sense to me, and it would allow us to use
compiletime_assert_atomic_type() as we do for the acquire/release accessors.

Will
