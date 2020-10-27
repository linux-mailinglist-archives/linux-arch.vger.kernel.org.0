Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D185529A9BB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 11:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898396AbgJ0Kdj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 06:33:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898319AbgJ0Kcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 06:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bAP5ayvWdzkYR+dK0w03op1mBdrMVm+Mr+bLt75W8ao=; b=AbcQ4yxQc4zeJwE1YJSauIUYM0
        0jcWGzzf/9sepuc/B5nr/O4lwAK53LmXcUPvQE5GX/6HIZa2cgVSnpFWM6Deg89O5EqAEQ/PUZz3f
        tCSJKc6q/k5m7iakn7Kst0kfCjbzQ1eGxFvEitx+lvXQx7P2N+4Sud2QG5GN3SrsD9oj1H/LBxe7i
        Ped6cJB1O9t/59LlP/R0VEf/dN5mOATxEi49ST3VwitIlr2yUuPwfdktJyff7gdwMZZCFduSQHqct
        x2XpRoF9iwH5Qh0UaCcciWZHfuOXmRlmvUcBsfduhUqwsdEAzXcoVMvxozVT+/MhCuyaJn0S5Kxmd
        4ES6S0gA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXMHO-0006RG-Nl; Tue, 27 Oct 2020 10:32:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A5EF3060F2;
        Tue, 27 Oct 2020 11:32:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8974C20C299F5; Tue, 27 Oct 2020 11:32:36 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:32:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
Message-ID: <20201027103236.GZ2611@hirez.programming.kicks-ass.net>
References: <20201026165807.3724647-1-arnd@kernel.org>
 <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
 <20201027074726.GX2611@hirez.programming.kicks-ass.net>
 <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 09:33:32AM +0100, Arnd Bergmann wrote:
> On Tue, Oct 27, 2020 at 8:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Oct 26, 2020 at 02:03:06PM -0400, Waiman Long wrote:
> > > On 10/26/20 12:57 PM, Arnd Bergmann wrote:
> > > Yes, it shouldn't really matter if the value is defined as int or u32.
> > > However, the only caveat that I see is queued_spin_lock_slowpath() is
> > > expecting a u32 argument. Maybe you should cast it back to (u32) when
> > > calling it.
> >
> > No, we're not going to confuse the code. That stuff is hard enough as it
> > is. This warning is garbage and just needs to stay off.
> 
> Ok, so the question then becomes: should we drop -Wpointer-sign from
> W=2 and move it to W=3, or instead disable it locally. I could add
> __diag_ignore(GCC, 4, "-Wpointer-sign") in the couple of header files
> that produce this kind of warning if there is a general feeling that it
> still helps to have this for drivers.

What is an actual geniune bug that this warning helps find?

Note that the kernel relies on -fno-strict-overflow to get rid of the
signed UB that is otherwise present in C.

If you add that __diag_ignore() it should go in atomic.h I suppose,
because all of atomic hard relies on this, and then the question becomes
how much code is left that doesn't include that header and consequently
doesn't ignore that warning.

So, is it useful to begin with in finding actual problems? and given we
have to annotate away a bucket-load, how much coverage will there remain
if we squish the known false-positives?
