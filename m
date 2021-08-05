Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875843E19E8
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhHEREz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhHEREy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 13:04:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5FC061765;
        Thu,  5 Aug 2021 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=04CagU5EAbNrLiuUdGw8amWt7aWpnxKksRF0oFOax3Q=; b=lwo4gDq0fIYCO+T+z3kf+zBidA
        uYdhe1Qfs/OqSQis3rmaZ5T3FyeZePaFsfSK9l3/wU0HqXYdESB49J0N178X/97zQABIR/pYQlbW9
        QFhV7NNqTqOjJl9WevN8lr39j5r4AevHiZ2+JBiUd6grkM2elRGqACy457XvU0tGFRu1Akj6IvxpN
        LDbx2nlhH64DMx88GmKFzKG/eVI5sb81NgyhNJnUd/jhPt8+RciEDhSyy+6Te/XACN2u82k65EoLG
        AJHMrT07NeWpg9l5FQzlH8z3R4/qO7zuoVOpOiojZu7EQt+bsS2zunwIkyQvNcZcc6M12fbTfuZko
        UKaedd9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBgnJ-0067e2-CW; Thu, 05 Aug 2021 17:04:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D76E300084;
        Thu,  5 Aug 2021 19:04:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E5FF2C9EB240; Thu,  5 Aug 2021 19:04:32 +0200 (CEST)
Date:   Thu, 5 Aug 2021 19:04:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Subject: Re: [PATCH 00/11] ARC atomics update
Message-ID: <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
 <20210805090209.GA22037@worktop.programming.kicks-ass.net>
 <2c2bed36-1bcf-ae34-0e94-9110c7e2b242@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c2bed36-1bcf-ae34-0e94-9110c7e2b242@synopsys.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 05, 2021 at 04:18:29PM +0000, Vineet Gupta wrote:
> On 8/5/21 2:02 AM, Peter Zijlstra wrote:
> > On Wed, Aug 04, 2021 at 12:15:43PM -0700, Vineet Gupta wrote:
> > 
> >> Vineet Gupta (10):
> >>    ARC: atomics: disintegrate header
> >>    ARC: atomic: !LLSC: remove hack in atomic_set() for for UP
> >>    ARC: atomic: !LLSC: use int data type consistently
> >>    ARC: atomic64: LLSC: elide unused atomic_{and,or,xor,andnot}_return
> >>    ARC: atomics: implement relaxed variants
> >>    ARC: bitops: fls/ffs to take int (vs long) per asm-generic defines
> >>    ARC: xchg: !LLSC: remove UP micro-optimization/hack
> >>    ARC: cmpxchg/xchg: rewrite as macros to make type safe
> >>    ARC: cmpxchg/xchg: implement relaxed variants (LLSC config only)
> >>    ARC: atomic_cmpxchg/atomic_xchg: implement relaxed variants
> >>
> >> Will Deacon (1):
> >>    ARC: switch to generic bitops
> > 
> > Didn't see any weird things:
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thx Peter. A lot of this is your code anyways ;-)
> 
> Any initial thoughts/comments on patch 06/11 - is there an obvious 
> reason that generic bitops take signed @nr or the hurdle is need to be 
> done consistently cross-arch.

That does indeed seem daft and ready for a cleanup. Will any
recollection from when you touched this?

AFAICT bitops/atomic.h is consistently 'unsigned int nr', but
bitops/non-atomic.h is 'int nr' while bitops/instrumented-non-atomic.h
is consistently 'long nr'.

I'm thinking 'unsigned int nr' is the most sensible allround, but I've
not gone through all the cases.
