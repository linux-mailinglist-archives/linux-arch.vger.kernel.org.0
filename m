Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32943E2647
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhHFIlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 04:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238955AbhHFIlY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Aug 2021 04:41:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1889660EE8;
        Fri,  6 Aug 2021 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628239269;
        bh=2X17xjmGHGlgrytSaj7r9Rx++xVMsl8LbGTJrxDcYVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guSu2m5Q46GebwXsmOvz75ZiYpZHxyQflS5B1n4Hrnfz7jFFXeHmFtYg0ywOy1Us3
         0i4y9Hzv6mT5wywO/LcsnpYtnmgVyL3uW9s+Z1wBY44GMJOOt4nD18wXPWit4o3e+X
         07zKakiC/AzjL2P2+Ze49RVCaNgzA97L8PjNS0nyhFT9IerEFC7XldeUbvV2mfOM2d
         HBOeYGQBL9FH6aoPZSrvs+/GMQlimZNcD5I6tSisskK1cEoSkvBFzOfiC9MT0XvqcH
         Chbj9FtCClMEg/m24AI3QB10r0RcaAcV6OTFm/D+ccLXRaBtp4blSyrKOQg6VVJtgW
         F3xj2zeaj9C4A==
Date:   Fri, 6 Aug 2021 09:41:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Subject: Re: [PATCH 00/11] ARC atomics update
Message-ID: <20210806084104.GA2015@willie-the-truck>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
 <20210805090209.GA22037@worktop.programming.kicks-ass.net>
 <2c2bed36-1bcf-ae34-0e94-9110c7e2b242@synopsys.com>
 <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 05, 2021 at 07:04:32PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 05, 2021 at 04:18:29PM +0000, Vineet Gupta wrote:
> > On 8/5/21 2:02 AM, Peter Zijlstra wrote:
> > > On Wed, Aug 04, 2021 at 12:15:43PM -0700, Vineet Gupta wrote:
> > > 
> > >> Vineet Gupta (10):
> > >>    ARC: atomics: disintegrate header
> > >>    ARC: atomic: !LLSC: remove hack in atomic_set() for for UP
> > >>    ARC: atomic: !LLSC: use int data type consistently
> > >>    ARC: atomic64: LLSC: elide unused atomic_{and,or,xor,andnot}_return
> > >>    ARC: atomics: implement relaxed variants
> > >>    ARC: bitops: fls/ffs to take int (vs long) per asm-generic defines
> > >>    ARC: xchg: !LLSC: remove UP micro-optimization/hack
> > >>    ARC: cmpxchg/xchg: rewrite as macros to make type safe
> > >>    ARC: cmpxchg/xchg: implement relaxed variants (LLSC config only)
> > >>    ARC: atomic_cmpxchg/atomic_xchg: implement relaxed variants
> > >>
> > >> Will Deacon (1):
> > >>    ARC: switch to generic bitops
> > > 
> > > Didn't see any weird things:
> > > 
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Thx Peter. A lot of this is your code anyways ;-)
> > 
> > Any initial thoughts/comments on patch 06/11 - is there an obvious 
> > reason that generic bitops take signed @nr or the hurdle is need to be 
> > done consistently cross-arch.
> 
> That does indeed seem daft and ready for a cleanup. Will any
> recollection from when you touched this?

I had a patch to fix this but it blew up in the robot and I didn't get round
to reworking it:

https://lore.kernel.org/patchwork/patch/1245555/

Will
