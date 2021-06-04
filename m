Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFFB39BCD0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhFDQQM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:16:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:40701 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhFDQQL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 12:16:11 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154G9uPx023147;
        Fri, 4 Jun 2021 11:09:57 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154G9uR9023146;
        Fri, 4 Jun 2021 11:09:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 11:09:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604160955.GG18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> With optimizing compilers becoming more and more agressive and C so far
> refusing to acknowledge the concept of control-dependencies even while
> we keep growing the amount of reliance on them, things will eventually
> come apart.

Yes, C is still not a portable assembler.

> There have been talks with toolchain people on how to resolve this; one
> suggestion was allowing the volatile qualifier on branch statements like
> 'if', but so far no actual compiler has made any progress on this.

"if" is not a "branch statement".

> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -80,6 +80,19 @@ do {									\
>  	___p1;								\
>  })
>  
> +#ifndef __ASSEMBLY__
> +/* Guarantee a conditional branch that depends on @cond. */
> +static __always_inline bool volatile_cond(bool cond)
> +{
> +	asm_volatile_goto("and. %0,%0,%0; bne %l[l_yes]"
> +			  : : "r" (cond) : "cc", "memory" : l_yes);
> +	return false;
> +l_yes:
> +	return true;
> +}
> +#define volatile_cond volatile_cond
> +#endif

"cmpwi" is ever so slightly better than "and.".  And you can write "cr0"
instead of "cc" more explicitely (it means the same thing though).


I didn't find a description of the expected precise semantics anywhere
in this patch.  This however is the most important thing required here!


Segher
