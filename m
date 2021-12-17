Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93E47915B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhLQQWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 11:22:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57834 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbhLQQWf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 11:22:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0910622DD;
        Fri, 17 Dec 2021 16:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1454C36AE1;
        Fri, 17 Dec 2021 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639758154;
        bh=zDKOA3xfyePxWIFvNh9DTwQIsyV3ekI3atL+Efr3sEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpMCbsdnqmVNs33nSCHT7BnZGqnYxG0QzS5ylgnKs3RkL3A7og9bvmkmUs6t+HMBs
         ztZlziMazw/I305rYW8L/nT8Zm+ERrJu8HSMlpXdfIjqpVj5ieo1yygVrPkskxG276
         +qMxK8UT+iLLcmoc4K8+OEWboDQL0LaOGwGP3Rq0=
Date:   Fri, 17 Dec 2021 17:22:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/43] kmsan: add KMSAN runtime core
Message-ID: <Yby5Rwr0jgAcK4th@kroah.com>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-14-glider@google.com>
 <YbjHerrHit/ZqXYs@kroah.com>
 <CAG_fn=XX3vbuo=cyG8C1Syv_JXiQ1rnfoffKqEc-N8uLei5T2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XX3vbuo=cyG8C1Syv_JXiQ1rnfoffKqEc-N8uLei5T2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 16, 2021 at 11:33:56AM +0100, Alexander Potapenko wrote:
> On Tue, Dec 14, 2021 at 5:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Dec 14, 2021 at 05:20:20PM +0100, Alexander Potapenko wrote:
> > > This patch adds the core parts of KMSAN runtime and associated files:
> > >
> > >   - include/linux/kmsan-checks.h: user API to poison/unpoison/check
> > >     the kernel memory;
> > >   - include/linux/kmsan.h: declarations of KMSAN hooks to be referenced
> > >     outside of KMSAN runtime;
> > >   - lib/Kconfig.kmsan: CONFIG_KMSAN and related declarations;
> > >   - Makefile, mm/Makefile, mm/kmsan/Makefile: boilerplate Makefile code;
> > >   - mm/kmsan/annotations.c: non-inlineable implementation of KMSAN_INIT();
> > >   - mm/kmsan/core.c: core functions that operate with shadow and origin
> > >     memory and perform checks, utility functions;
> > >   - mm/kmsan/hooks.c: KMSAN hooks for kernel subsystems;
> > >   - mm/kmsan/init.c: KMSAN initialization routines;
> > >   - mm/kmsan/instrumentation.c: functions called by KMSAN instrumentation;
> > >   - mm/kmsan/kmsan.h: internal KMSAN declarations;
> > >   - mm/kmsan/shadow.c: routines that encapsulate metadata creation and
> > >     addressing;
> > >   - scripts/Makefile.kmsan: CFLAGS_KMSAN
> > >   - scripts/Makefile.lib: KMSAN_SANITIZE and KMSAN_ENABLE_CHECKS macros
> >
> >
> > That's an odd way to write a changelog, don't you think?
> 
> Agreed. I'll try to concentrate on the functionality instead. Sorry about that.
> 
> > You need to describe what you are doing here and why you are doing it.
> > Not a list of file names, we can see that in the diffstat.
> >
> > Also, you don't mention you are doing USB stuff here at all.  And why
> > are you doing it here?  That should be added in a later patch.
> 
> You are right, USB is a good example of a stand-alone feature that can
> be moved to a separate patch.
> 
> > Break this up into smaller, logical, pieces that add the infrastructure
> > and build on it.  Don't just chop your patches up on a logical-file
> > boundry, as you are adding stuff in this patch that you do not need for
> > many more later on, which means it was not needed here.
> 
> Just to make sure I don't misunderstand - for example for "kmsan: mm:
> call KMSAN hooks from SLUB code", would it be better to pull the code
> in mm/kmsan/core.c implementing kmsan_slab_alloc() and
> kmsan_slab_free() into that patch?

Yes.

> I thought maintainers would prefer to have patches to their code
> separated from KMSAN code, but if it's not true, I can surely fix
> that.

As a maintainer, I want to know what the function call that you just
added to my subsystem to call does.  Wouldn't you?  Put it all in the
same patch.

Think about submitting a patch series as telling a story.  You need to
show the progression forward of the feature so that everyone can
understand what is going on.  To just throw tiny snippets at us is
impossible to follow along with what your goal is.

You want reviewers to be able to easily see if the things you describe
being done in the changelog actually are implemented in the diff.
Dividing stuff up by files does not show that at all.

thanks,

greg k-h
