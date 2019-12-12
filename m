Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33C511D821
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfLLUyO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 15:54:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43398 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbfLLUyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 15:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HBHzOqueNtH+ssOdsRD8zcTYEQlTe6HFVq8El7WjNb0=; b=1DvaJyLXzd4+WcJoPgRVXM5Bp
        plm+iR073nzyuInoVL2P5XI6uOfap7UFGgTybaX8UZtjYf8vQCV8QGKFRJDlsElcmnKJ+bm1Z7QvW
        D5BamErHBSX9fNXxAdNhttTlFYKyxnz454Zt0hacv7YPvWD/tDMo2XTUSve+91Mourry1ICaa95S2
        zLtTCY7s/BTcK+5/3EK4+S22erSDjA6g632Cg9m35sHN5mmqiZLTBF07tEVvCQZs/NBeISHkMUj1P
        KB6y7aWGWc6UIzfD6Z0Y3rPb/gnmDA4MCC/j9wljuFCgwH2cIMzSVe6eniB9VumjCYiidRWYBzb6S
        JDJcSoWHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifVSv-00082P-PB; Thu, 12 Dec 2019 20:53:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6275F980CCD; Thu, 12 Dec 2019 21:53:38 +0100 (CET)
Date:   Thu, 12 Dec 2019 21:53:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20191212205338.GB11802@worktop.programming.kicks-ass.net>
References: <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212202157.GD11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 09:21:57PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 07:34:01PM +0000, Will Deacon wrote:
> > void ool_store_release(volatile unsigned long *ptr, unsigned long val)
> > {
> > 	smp_store_release(ptr, val);
> > }
> > 
> > 0000000000000000 <ool_store_release>:
> >    0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
> >    4:   90000002        adrp    x2, 0 <__stack_chk_guard>
> >    8:   91000042        add     x2, x2, #0x0
> >    c:   910003fd        mov     x29, sp
> >   10:   f9400043        ldr     x3, [x2]
> >   14:   f9000fa3        str     x3, [x29, #24]
> >   18:   d2800003        mov     x3, #0x0                        // #0
> >   1c:   c89ffc01        stlr    x1, [x0]
> >   20:   f9400fa1        ldr     x1, [x29, #24]
> >   24:   f9400040        ldr     x0, [x2]
> >   28:   ca000020        eor     x0, x1, x0
> >   2c:   b5000060        cbnz    x0, 38 <ool_store_release+0x38>
> >   30:   a8c27bfd        ldp     x29, x30, [sp], #32
> >   34:   d65f03c0        ret
> >   38:   94000000        bl      0 <__stack_chk_fail>
> > 
> > It's a mess, and fixing READ_ONCE() doesn't help this case, which is why
> > I was looking at getting rid of volatile where it's not strictly needed.
> > I'm certainly open to other suggestions, I just haven't managed to think
> > of anything else.
> 
> We could move the kernel to C++ and write:
> 
> 	std::remove_volatile<typeof(p)>::type __p = (p);
> 
> /me runs like hell...

Also, the GCC __auto_type thing strips _Atomic and const qualifiers but
for some obscure raisin forgets to strip volatile :/

  https://gcc.gnu.org/ml/gcc-patches/2013-11/msg01378.html

Now, looking at the current GCC source:

  https://github.com/gcc-mirror/gcc/blob/97d7270f894395e513667a031a0c309d1819d05e/gcc/c/c-parser.c#L3707

it seems that __typeof__() is supposed to strip all qualifiers from
_Atomic types. That lead me to try:

	typeof(_Atomic typeof(p)) __p = (p);

But alas, I still get the same junk you got for ool_store_release() :/
