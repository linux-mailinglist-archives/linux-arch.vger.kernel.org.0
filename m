Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E9256445
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgH2DFj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 23:05:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34751 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH2DFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 23:05:37 -0400
Received: by mail-io1-f67.google.com with SMTP id w20so1049606iom.1;
        Fri, 28 Aug 2020 20:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7xUaI995Ekm5CK+TxZkIt4YFPavrrAEtoUbXr4ArNs=;
        b=SKfbW6mLkCNVeg3PyztUiSMc+4CdpetkAQHV5x6BnYhm5YYGHdn9RM7TvNEPD/rvAj
         d5s6ODnlYwfQxYwbhjq2HoeRRmjF/Ze5/n/1sV4It4bD7gONXIIvKAF16fBVLxd8WIwp
         51qsQUNPYR0NhqY0/1qkrGj1sBRCNQTfeQTRWs4pIvNM6xYumWNd0/2jy2ygd2c59/Fn
         E8B7N1W+U4Dhnr2Vzb5HfMFXLBOuIpCop+mNtV/xllHTg92jK23SY/Zxlu3cA4bqaf7T
         85StxZz+FujzDeTAWKKg/Zqu5WIr8VQzo5hiaDvYFXMtnUbtSPYBXCgk1V74UhQTriep
         dI/g==
X-Gm-Message-State: AOAM533HaFhSftmSeF6BfoU56THUlRkwlRz77enVx3xPbQv2w5L3ABfh
        qqPjsjTL4pZIHFX5h8dfFNJUqd/ZPjJyQIAnprU=
X-Google-Smtp-Source: ABdhPJzhcslFhvjF32ufDTHkrVrtYDJvqRTYpjO7neI9C50BVG2K5GbfCakoYCM66vEYHeDebELfRjxAztiULqm+WyY=
X-Received: by 2002:a02:840f:: with SMTP id k15mr3841034jah.100.1598670336665;
 Fri, 28 Aug 2020 20:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161237.889877377@infradead.org> <20200827161754.535381269@infradead.org>
 <20200828144650.GF28468@redhat.com> <20200828152946.GG1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200828152946.GG1362448@hirez.programming.kicks-ass.net>
From:   Cameron <cameron@moodycamel.com>
Date:   Fri, 28 Aug 2020 23:05:20 -0400
Message-ID: <CAFCw3dq=L_MYkw-oDgf1Yowc1w0VWkuducnPEZrF9df8s1cvUA@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, will@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> I'm curious whether it is correct to just set the prev->refs to zero and return
> @prev? So that it can remove an unneeded "add()&get()" pair (although in
> an unlikely branch) and __freelist_add() can be folded into freelist_add()
> for tidier code.

That is a very good question. I believe it would be correct, yes, and
would certainly simplify the code. The reference count is zero, so
nobody can increment it again, and REFS_ON_FREELIST is set (the
should-be-on-freelist flag), so instead of adding it to the freelist
to be removed later, it can be returned directly.

> On Fri, Aug 28, 2020 at 04:46:52PM +0200, Oleg Nesterov wrote:
> > 129 lines! And I spent more than 2 hours trying to understand these
> > 129 lines ;) looks correct...

Hahaha. Sorry about that. Some of the most mind-bending code I've ever
written. :-)

> > +                     /*
> > +                      * Hmm, the add failed, but we can only try again when
> > +                      * the refcount goes back to zero.
> > +                      */
> > +                     if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
> > +                             continue;
> Do we really need _release ? Why can't atomic_fetch_add_relaxed() work?

The release is to synchronize with the acquire in the compare-exchange
of try_get. However, I think you're right, between the previous
release-write to the refs and that point, there are no memory effects
that need to be synchronized, and so it could be safely replaced with
a relaxed operation.

> Cosmetic, but why not atomic_fetch_dec() ?

This is just one of my idiosyncrasies. I prefer exclusively using
atomic add, I find it easier to read. Feel free to change them all to
subs!

Cameron


> >
> > Do we the barriers implied by _fetch_? Why can't atomic_sub(2, refs) work?
>
> I think we can, the original has std::memory_order_relaxed here. So I
> should've used atomic_fetch_add_relaxed() but since we don't use the
> return value, atomic_sub() would work just fine too.
>
> > > +           /*
> > > +            * OK, the head must have changed on us, but we still need to decrement
> > > +            * the refcount we increased.
> > > +            */
> > > +           refs = atomic_fetch_add(-1, &prev->refs);
> >
> > Cosmetic, but why not atomic_fetch_dec() ?
>
> The original had that, I didn't want to risk more bugs by 'improving'
> things. But yes, that can definitely become dec().
