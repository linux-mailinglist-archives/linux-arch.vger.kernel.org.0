Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10034219DE6
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 12:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGIKds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIKdr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 06:33:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917A5C061A0B;
        Thu,  9 Jul 2020 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IvpXUYK9H+QnmAsI+N7Y+NJkZMFkfZkklbiU2ToyVQs=; b=ysIolg+CeRhNjk4NEZhTj9mj5g
        ca828lNtjuaGV9NHITlG2ZDPtxGhXNhk3KrvudsXjUJmb8J4XG/OF1nzUOwI//gHDtqE0EANnpbE+
        bbiBnPXo5VHSiHumhpr2Qu+akcJEqpES74jCyTShVPKFLAmD/sBzeRgZb/ORaBfu5DUyt8R+5OLWf
        GfezKgB7POj5RVO9xyLQJYa4YqvWXnYTcjZguHbo5tiN+wTk/yxkJo9dnoBBMvOLBeJh/GXmNplaB
        k6UuaBO7U4dpxgXLgt+GyuZ9p/eO25EDL03UeJAkSn2ViIUTHUSjhhYACWMO+fCLOzes7hYXYC/zl
        7sbP7/LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtTs4-0007rF-9q; Thu, 09 Jul 2020 10:33:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66F76300739;
        Thu,  9 Jul 2020 12:33:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53455235B3D17; Thu,  9 Jul 2020 12:33:38 +0200 (CEST)
Date:   Thu, 9 Jul 2020 12:33:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 4/6] powerpc/64s: implement queued spinlocks and
 rwlocks
Message-ID: <20200709103338.GQ597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-5-npiggin@gmail.com>
 <877dvdvvkm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dvdvvkm.fsf@mpe.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 08:20:25PM +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> > These have shown significantly improved performance and fairness when
> > spinlock contention is moderate to high on very large systems.
> >
> >  [ Numbers hopefully forthcoming after more testing, but initial
> >    results look good ]
> 
> Would be good to have something here, even if it's preliminary.
> 
> > Thanks to the fast path, single threaded performance is not noticably
> > hurt.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/Kconfig                      | 13 ++++++++++++
> >  arch/powerpc/include/asm/Kbuild           |  2 ++
> >  arch/powerpc/include/asm/qspinlock.h      | 25 +++++++++++++++++++++++
> >  arch/powerpc/include/asm/spinlock.h       |  5 +++++
> >  arch/powerpc/include/asm/spinlock_types.h |  5 +++++
> >  arch/powerpc/lib/Makefile                 |  3 +++
> 
> >  include/asm-generic/qspinlock.h           |  2 ++
> 
> Who's ack do we need for that part?

Mine I suppose would do, as discussed earlier, it probably isn't
required anymore, but I understand the paranoia of not wanting to change
too many things at once :-)


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
