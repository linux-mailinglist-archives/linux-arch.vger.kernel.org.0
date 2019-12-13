Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB111E504
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLMN4c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 08:56:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:56555 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfLMN4c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Dec 2019 08:56:32 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBDDrto1009834;
        Fri, 13 Dec 2019 07:53:55 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id xBDDrrmP009833;
        Fri, 13 Dec 2019 07:53:53 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 13 Dec 2019 07:53:53 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@c-s.fr, linux-arch@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191213135353.GN3152@gate.crashing.org>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net> <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net> <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net> <87pngso2ck.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pngso2ck.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Fri, Dec 13, 2019 at 11:07:55PM +1100, Michael Ellerman wrote:
> I tried this:
> 
> > @@ -295,6 +296,23 @@ void __write_once_size(volatile void *p, void *res, int size)
> >   */
> >  #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
> >  
> > +#else /* GCC_VERSION < 40800 */
> > +
> > +#define READ_ONCE_NOCHECK(x)						\
> > +({									\
> > +	typeof(x) __x = *(volatile typeof(x))&(x);			\
> 
> Didn't compile, needed:
> 
> 	typeof(x) __x = *(volatile typeof(&x))&(x);			\
> 
> 
> > +	smp_read_barrier_depends();					\
> > +	__x;
> > +})
> 
> 
> And that works for me. No extra stack check stuff.
> 
> I guess the question is does that version of READ_ONCE() implement the
> read once semantics. Do we have a good way to test that?
> 
> The only differences are because of the early return in the generic
> test_and_set_bit_lock():

No, there is another difference:

>   30         ld      r10,560(r9)
>   31         std     r10,104(r1)
>   32         ld      r10,104(r1)
>   33         andi.   r10,r10,1
>   34         bne     <ext4_resize_begin_generic+0xd0>       29         bne     <ext4_resize_begin_ppc+0xd0>

The stack var is volatile, so it is read back immediately after writing
it, here.  This is a bad idea for performance, in general.


Segher
