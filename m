Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB29E2107C0
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jul 2020 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGAJLH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jul 2020 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgGAJLG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 05:11:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8856C061755;
        Wed,  1 Jul 2020 02:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6wLa3Z5Tnqc6pIqvd9Kuq9IIUcvVwIhLZPWeRnHbIeA=; b=EBZVsbt8QnQM1/nIz26KitisJv
        1/eDkGMq6rQ6dFjtEOLryOxl9/2R75doGqasl9ZzuMjNGgYkxJYYMHUMNG4E6n09Gm//aQPvahyhB
        p+3C2xeyUEBqpAC1GAkbGnjo0IAVtK9oQpwC/WxxI98dOzpe9P7CUV+ThLIauqvkrm1FWM7+2x2jJ
        c9++4TT1vBaEWdzmoSBQ8OF24E3tQQ2du5JTeEtX0OsuBDeQLQKiztWWKJ979nB8hOz9pI+bYZH6S
        yALNVqqvO3OdagdOb2OGHjX96PwUbqjI5NeBGkEmxGN8jLNiuZipV96hvXOkCQKlrSu67dIaS6kh2
        mX80E9Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqYle-0002ST-A3; Wed, 01 Jul 2020 09:10:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33CD9305B23;
        Wed,  1 Jul 2020 11:10:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 170A4201CB82C; Wed,  1 Jul 2020 11:10:54 +0200 (CEST)
Date:   Wed, 1 Jul 2020 11:10:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200701091054.GW4781@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630203016.GI9247@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 30, 2020 at 01:30:16PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:

> > I'm not convinced C11 memory_order_consume would actually work for us,
> > even if it would work. That is, given:
> > 
> >   https://lore.kernel.org/lkml/20150520005510.GA23559@linux.vnet.ibm.com/
> > 
> > only pointers can have consume, but like I pointed out, we have code
> > that relies on dependent loads from integers.
> 
> I agree that C11 memory_order_consume is not normally what we want,
> given that it is universally promoted to memory_order_acquire.
> 
> However, dependent loads from integers are, if anything, more difficult
> to defend from the compiler than are control dependencies.  This applies
> doubly to integers that are used to index two-element arrays, in which
> case you are just asking the compiler to destroy your dependent loads
> by converting them into control dependencies.

Yes, I'm aware. However, as you might know, I'm firmly in the 'C is a
glorified assembler' camp (as I expect most actual OS people are, out of
necessity if nothing else) and if I wanted a control dependency I
would've bloody well written one.

I think an optimizing compiler is awesome, but only in so far as that
optimization is actually helpful -- and yes, I just stepped into a giant
twilight zone there. That is, any optimization that has _any_
controversy should be controllable (like -fno-strict-overflow
-fno-strict-aliasing) and I'd very much like the same here.

In a larger context, I still think that eliminating speculative stores
is both necessary and sufficient to avoid out-of-thin-air. So I'd also
love to get some control on that.

