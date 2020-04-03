Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392F019DFDB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgDCUwb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 16:52:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41138 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 16:52:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKTIL-009rSy-AY; Fri, 03 Apr 2020 20:52:05 +0000
Date:   Fri, 3 Apr 2020 21:52:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to
 user_full_access_begin/end()
Message-ID: <20200403205205.GK23230@ZenIV.linux.org.uk>
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
 <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 03, 2020 at 11:01:10AM -0700, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 12:21 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> >
> > Now we have user_read_access_begin() and user_write_access_begin()
> > in addition to user_access_begin().
> 
> I realize Al asked for this, but I don't think it really adds anything
> to the series.
> 
> The "full" makes the names longer, but not really any more legible.
> 
> So I like 1-4, but am unconvinced about 5 and would prefer that to be
> dropped. Sorry for the bikeshedding.
> 
> And I like this series much better without the cookie that was
> discussed, and just making the hard rule be that they can't nest.
> 
> Some architecture may obviously use a cookie internally if they have
> some nesting behavior of their own, but it doesn't look like we have
> any major reason to expose that as the actual interface.
> 
> The only other question is how to synchronize this? I'm ok with it
> going through the ppc tree, for example, and just let others build on
> that.  Maybe using a shared immutable branch with 5.6 as a base?

I can do a 5.7-rc1-based branch with that; depending upon what we end
up doing for arm and s390 we can always change the calling conventions
come next cycle ;-/

My impressions after digging through arm side of things:

1) the only instance of nesting I'd found there (so far) is a mistake.
The rule should be "no fucking nesting, TYVM".

2) I'm really unhappy about the uaccess_with_memcpy thing.  Besides
being fucking ugly, it kills any hope of lifting user_access_begin/end
out of raw_copy_to_user() - the things done in that bastard are
obviously *NOT* fit for uaccess block.  Including the wonders like
        /* the mmap semaphore is taken only if not in an atomic context */
        atomic = faulthandler_disabled();

        if (!atomic)
                down_read(&current->mm->mmap_sem);
which, IMO, deserves to be taken out and shot.  Not that pin_page_for_write()
in the same file (arch/arm/lib/uaccess_with_memcpy.c) did not deserve the
same treatment...  As far as I can tell, the whole point of that thing
is that well, memcpy() is optimized better than raw_copy_to_user()...
So what's wrong with taking the damn optimized memcpy and using it for
raw_copy_to_user() instead?

Is that the lack of STRT analogue that would store several registers?
Because AFAICS commit f441882a5229ffaef61a47bccd4518f7e2749cbc
Author: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri Nov 9 10:09:48 2018 +0100
    ARM: 8812/1: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS
makes for much saner solution...  I realize that it's v6+ and this
thing is specifically for a v5 variant, but...

3) how much do we need to keep the old DACR value in a register for
uaccess_restore()?  AFAICS, if we prohibit nesting it becomes
a function of USER_DS/KERNEL_DS setting (and that - only for
CPU_USE_DOMAINS), doesn't it?  And we had to have fetched it
recently, back when access_ok() had been done, so shouldn't
it be in cache?
