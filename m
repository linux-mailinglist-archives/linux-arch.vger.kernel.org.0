Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E041AB1F2
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441834AbgDOTnN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441830AbgDOTnM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 15:43:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAFD2076D;
        Wed, 15 Apr 2020 19:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586979791;
        bh=C7hZgIRoKst4X+y/++GrHJwRRSQ7OvedPg60SJqboFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFRqC/O0DuUglBIAyPY/lyaMAN3dod1/uybVd3q53qYLQJx/5KvR5i22UFFkA+BiV
         vMuPLC0kcjVlZJE/HgVqyENMCHe78GIcXGN8cnI0CU83YTL7oNe8xwMK+hjckDvUjC
         sA/HB3EF+zX9ap0MIHe2X2qf8nuqIrf+RCJyXSWk=
Date:   Wed, 15 Apr 2020 20:43:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
Message-ID: <20200415194305.GB21804@willie-the-truck>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
 <CAK8P3a0x10bCQMC=iGm+fU2G1Vc=Zo-4yjaX4Jwso6rgazVzYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0x10bCQMC=iGm+fU2G1Vc=Zo-4yjaX4Jwso6rgazVzYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 15, 2020 at 08:42:16PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 15, 2020 at 7:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Apr 15, 2020 at 05:52:11PM +0100, Will Deacon wrote:
> > > do_csum() over-reads the source buffer and therefore abuses
> > > READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> > > READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> > > '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> > > and fall back to normal loads.
> >
> > I'm confused by this. The whole point of READ_ONCE_NOCHECK() is that it
> > isn't checked by KASAN, so if that semantic is removed it has no reason
> > to exist.
> >
> > Changing that will break the unwind/stacktrace code across multiple
> > architectures. IIRC they use READ_ONCE_NOCHECK() for two reasons:
> >
> > 1. Races with concurrent modification, as might happen when a thread's
> >    stack is corrupted. Allowing the unwinder to bail out after a sanity
> >    check means the resulting report is more useful than a KASAN splat in
> >    the unwinder. I made the arm64 unwinder robust to this case.
> >
> > 2. I believe that the frame record itself /might/ be poisoned by KASAN,
> >    since it's not meant to be an accessible object at the C langauge
> >    level. I could be wrong about this, and would have to check.
> 
> I thought the main reason was deadlocks when a READ_ONCE()
> is called inside of code that is part of the KASAN handling. If
> READ_ONCE() ends up recursively calling itself, the kernel
> tends to crash once it overflows its stack.

That was also my understanding.

> > I would like to keep the unwinding robust in the first case, even if the
> > second case doesn't apply, and I'd prefer to not mark the entirety of
> > the unwinding code as unchecked as that's sufficiently large an subtle
> > that it could have nasty bugs.
> >
> > Is there any way we keep something like READ_ONCE_NOCHECK() around even
> > if we have to give it reduced functionality relative to READ_ONCE()?
> >
> > I'm not enirely sure why READ_ONCE_NOCHECK() had to go, so if there's a
> > particular pain point I'm happy to take a look.
> 
> As I understood, only this particular instance was removed, not all of
> them.

Right, but the problem is that whether the NOCHECK version gets checked
or not now depends on the caller, since it's all just a macro. If we want
to fix this, then we could force the nocheck variant to return unsigned
long, which simplifies things a lot (completely untested):


#define READ_ONCE(x)							\
({									\
	compiletime_assert_rwonce_type(x);				\
	__READ_ONCE_SCALAR(x);						\
})

unsigned long __no_sanitise_address
kasan_nocheck_read_once_ul(const volatile void *p)
{
	return READ_ONCE(*p);
}

/* Please don't use this */
#define READ_ONCE_NOCHECK(x)	kasan_nocheck_read_once_ul(&x)


which would make sense for the unwinders, where there is concurrency
involved, but I'd be inclined to have them call kasan_nocheck_read_once_ul()
directly and ditch READ_ONCE_NOCHECK() so that it doesn't get used for
single-threaded code as a convenience to avoid annotation.

What do you think?

Will
