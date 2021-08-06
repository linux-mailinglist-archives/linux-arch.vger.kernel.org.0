Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39F3E2BC1
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbhHFNnH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 09:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344347AbhHFNnF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Aug 2021 09:43:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A806160C41;
        Fri,  6 Aug 2021 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628257369;
        bh=tz8ZRLoD2biYu7ZxhJ7U45RlqyfpQkBmhi9D2jv7cy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBmuahBBtWrCYnT6vHz1KFHrh8kUlPrkcF2F0+YfvpONFUlGG6LG2J9CLH89c8T03
         k5MZu76bsBL3hShaERTnLZD6Btzkc9851Cqhui0THxE3RJCxUTA/rEQuU0WISMETGL
         kMJdY6J9aCHAgLIu1S0CFtc++bYCnTwbAgT4t6yCHpLN5eHjXgzsLzfaoTdDOXfskj
         sC8sL8czYCBRSHGRSbMnsOnpari7wxeXudo79aF3tMxzqE0mGL/pBj6YK8MnZ9c2rI
         JH5N0fJU8yP7rOWYBc9kEW+rxKlcef1Ow1G7VGCGPWkPdL/a01OfqO/00If2Q9zLzA
         lE8LJJWGc50gA==
Date:   Fri, 6 Aug 2021 14:42:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: Re: [RFC] bitops/non-atomic: make @nr unsigned to avoid any DIV
Message-ID: <20210806134244.GA2901@willie-the-truck>
References: <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
 <20210805191408.2003237-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805191408.2003237-1-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 05, 2021 at 12:14:08PM -0700, Vineet Gupta wrote:
> signed math causes generation of costlier instructions such as DIV when
> they could be done by barrerl shifter.
> 
> Worse part is this is not caught by things like bloat-o-meter since
> instruction length / symbols are typically same size.
> 
> e.g.
> 
> stock (signed math)
> __________________
> 
> 919b4614 <test_taint>:
> 919b4614:	div	r2,r0,0x20
>                 ^^^
> 919b4618:	add2	r2,0x920f6050,r2
> 919b4620:	ld_s	r2,[r2,0]
> 919b4622:	lsr	r0,r2,r0
> 919b4626:	j_s.d	[blink]
> 919b4628:	bmsk_s	r0,r0,0
> 919b462a:	nop_s
> 
> (patched) unsigned math
> __________________
> 
> 919b4614 <test_taint>:
> 919b4614:	lsr	r2,r0,0x5  @nr/32
>                 ^^^
> 919b4618:	add2	r2,0x920f6050,r2
> 919b4620:	ld_s	r2,[r2,0]
> 919b4622:	lsr	r0,r2,r0     #test_bit()
> 919b4626:	j_s.d	[blink]
> 919b4628:	bmsk_s	r0,r0,0
> 919b462a:	nop_s

Just FYI, but on arm64 the existing codegen is alright as we have both
arithmetic and logical shifts.

> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
> This is an RFC for feeback, I understand this impacts every arch,
> but as of now it is only buld/run tested on ARC.
> ---
> ---
>  include/asm-generic/bitops/non-atomic.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

We should really move test_bit() into the atomic header, but I failed to fix
the resulting include mess last time I tried that.

Will
