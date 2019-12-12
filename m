Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61D511C6C2
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 09:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfLLIBa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 03:01:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfLLIBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 03:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zqWbT6EiHg3ERbPkcWc07MTBuZk581MfKCNd9+8m5rE=; b=X06xtzoHXbVmNMkpdX/RnCwMH
        Bmr3xrgAsNW/zC2cnwEWLqvPg1yNoTZfkNyS30BcfW/CNJCf8Oa9EqcbB+uInw+qeGV4DZcR4vrYv
        Xqb1k7GvsnS+PzTtoxioJ4GPIrAHvRuq9lNj1KlC9XcJQG0CzKeJxA3fpmpJEu9j0VZsr/OD9nNVF
        gERkk9nRzHOd01TO3r8RRZnFX9UhII0ulr3pp5lfaZhykPIRbf4jx89HYmsaNY+VQRX/8DkSalG/U
        6iPAV7dKze56pInYudqpr3bTYraDfYMAdNKh8fx5ttz1jmHNr8m3NyQ5dFmbaP87lH5YMnp4lXPXa
        ux4JTyzuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifJPI-0002jE-CD; Thu, 12 Dec 2019 08:01:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9ACE300F29;
        Thu, 12 Dec 2019 08:59:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20E1D20309147; Thu, 12 Dec 2019 09:01:05 +0100 (CET)
Date:   Thu, 12 Dec 2019 09:01:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@c-s.fr, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191212080105.GV2844@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zimp0ay.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 04:42:13PM +1100, Michael Ellerman wrote:
> [ trimmed CC a bit ]
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Fri, Dec 06, 2019 at 11:46:11PM +1100, Michael Ellerman wrote:
> ...
> > you write:
> >
> >   "Currently bitops-instrumented.h assumes that the architecture provides
> > atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
> > This is true on x86 and s390, but is not always true: there is a
> > generic bitops/non-atomic.h header that provides generic non-atomic
> > operations, and also a generic bitops/lock.h for locking operations."
> >
> > Is there any actual benefit for PPC to using their own atomic bitops
> > over bitops/lock.h ? I'm thinking that the generic code is fairly
> > optimal for most LL/SC architectures.
> 
> Yes and no :)
> 
> Some of the generic versions don't generate good code compared to our
> versions, but that's because READ_ONCE() is triggering stack protector
> to be enabled.

Bah, there's never anything simple, is there :/

> For example, comparing an out-of-line copy of the generic and ppc
> versions of test_and_set_bit_lock():
> 
>    1 <generic_test_and_set_bit_lock>:           1 <ppc_test_and_set_bit_lock>:
>    2         addis   r2,r12,361
>    3         addi    r2,r2,-4240
>    4         stdu    r1,-48(r1)
>    5         rlwinm  r8,r3,29,3,28
>    6         clrlwi  r10,r3,26                   2         rldicl  r10,r3,58,6
>    7         ld      r9,3320(r13)
>    8         std     r9,40(r1)
>    9         li      r9,0
>   10         li      r9,1                        3         li      r9,1
>                                                  4         clrlwi  r3,r3,26
>                                                  5         rldicr  r10,r10,3,60
>   11         sld     r9,r9,r10                   6         sld     r3,r9,r3
>   12         add     r10,r4,r8                   7         add     r4,r4,r10
>   13         ldx     r8,r4,r8
>   14         and.    r8,r9,r8
>   15         bne     34f
>   16         ldarx   r7,0,r10                    8         ldarx   r9,0,r4,1
>   17         or      r8,r9,r7                    9         or      r10,r9,r3
>   18         stdcx.  r8,0,r10                   10         stdcx.  r10,0,r4
>   19         bne-    16b                        11         bne-    8b
>   20         isync                              12         isync
>   21         and     r9,r7,r9                   13         and     r3,r3,r9
>   22         addic   r7,r9,-1                   14         addic   r9,r3,-1
>   23         subfe   r7,r7,r9                   15         subfe   r3,r9,r3
>   24         ld      r9,40(r1)
>   25         ld      r10,3320(r13)
>   26         xor.    r9,r9,r10
>   27         li      r10,0
>   28         mr      r3,r7
>   29         bne     36f
>   30         addi    r1,r1,48
>   31         blr                                16         blr
>   32         nop
>   33         nop
>   34         li      r7,1
>   35         b       24b
>   36         mflr    r0
>   37         std     r0,64(r1)
>   38         bl      <__stack_chk_fail+0x8>
> 
> 
> If you squint, the generated code for the actual logic is pretty similar, but
> the stack protector gunk makes a big mess. It's particularly bad here
> because the ppc version doesn't even need a stack frame.
> 
> I've also confirmed that even when test_and_set_bit_lock() is inlined
> into an actual call site the stack protector logic still triggers.

> If I change the READ_ONCE() in test_and_set_bit_lock():
> 
> 	if (READ_ONCE(*p) & mask)
> 		return 1;
> 
> to a regular pointer access:
> 
> 	if (*p & mask)
> 		return 1;
> 
> Then the generated code looks more or less the same, except for the extra early
> return in the generic version of test_and_set_bit_lock(), and different handling
> of the return code by the compiler.

So given that the function signature is:

static inline int test_and_set_bit_lock(unsigned int nr,
					volatile unsigned long *p)

@p already carries the required volatile qualifier, so READ_ONCE() does
not add anything here (except for easier to read code and poor code
generation).

So your proposed change _should_ be fine. Will, I'm assuming you never
saw this on your ARGH64 builds when you did this code ?

---
diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index dd90c9792909..10264e8808f8 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -35,7 +35,7 @@ static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	if (READ_ONCE(*p) & mask)
+	if (*p & mask)
 		return 1;
 
 	old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
@@ -48,7 +48,7 @@ static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	if (!(READ_ONCE(*p) & mask))
+	if (!(*p & mask))
 		return 0;
 
 	old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae021368f48..9baf0a0055b8 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -22,7 +22,7 @@ static inline int test_and_set_bit_lock(unsigned int nr,
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	if (READ_ONCE(*p) & mask)
+	if (*p & mask)
 		return 1;
 
 	old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
@@ -60,7 +60,7 @@ static inline void __clear_bit_unlock(unsigned int nr,
 	unsigned long old;
 
 	p += BIT_WORD(nr);
-	old = READ_ONCE(*p);
+	old = *p;
 	old &= ~BIT_MASK(nr);
 	atomic_long_set_release((atomic_long_t *)p, old);
 }
