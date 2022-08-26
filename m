Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34C85A1DDD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 02:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiHZA5q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 20:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHZA5p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 20:57:45 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B5C2DC888B
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 17:57:44 -0700 (PDT)
Received: (qmail 21882 invoked by uid 1000); 25 Aug 2022 20:57:43 -0400
Date:   Thu, 25 Aug 2022 20:57:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
Message-ID: <YwgahzfAlk9Jwaws@rowland.harvard.edu>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 05:03:40PM -0400, Mikulas Patocka wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> There are several places in the kernel where wait_on_bit is not followed
> by a memory barrier (for example, in drivers/md/dm-bufio.c:new_read). On
> architectures with weak memory ordering, it may happen that memory
> accesses that follow wait_on_bit are reordered before wait_on_bit and they
> may return invalid data.
> 
> Fix this class of bugs by introducing a new function "test_bit_acquire"
> that works like test_bit, but has acquire memory ordering semantics.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

...

> --- linux-2.6.orig/include/asm-generic/bitops/generic-non-atomic.h
> +++ linux-2.6/include/asm-generic/bitops/generic-non-atomic.h
> @@ -4,6 +4,7 @@
>  #define __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
>  
>  #include <linux/bits.h>
> +#include <asm/barrier.h>
>  
>  #ifndef _LINUX_BITOPS_H
>  #error only <linux/bitops.h> can be included directly
> @@ -127,6 +128,18 @@ generic_test_bit(unsigned long nr, const
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
>  
> +/**
> + * generic_test_bit - Determine whether a bit is set with acquire semantics

Trivial: Name in the kerneldoc isn't the same as the actual function name.

(Also, "with acquire semantics" is supposed to modify "Determine", not 
"is set" -- we don't set bits using acquire semantics.  You could change 
this to "Determine, with acquire semantics, whether a bit is set".)

Alan Stern

> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + */
> +static __always_inline bool
> +generic_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
> +{
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
> +}
