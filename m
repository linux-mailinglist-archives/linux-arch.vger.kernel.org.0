Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FD219E9E
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGILDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGILDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 07:03:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3013FC061A0B;
        Thu,  9 Jul 2020 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kAodoJjxw+oZcu/SKU1xNGXdBrfnaoxdi6oL3ywEXIs=; b=ReiXtoRsWHjtkeuJwfJ+pv7m8c
        OuLBP5TSleXNRejXhR9wm2UuDuubf7xh1g4UYohYbfkJlVm4/MXRjgfMrrhYKvbCbS/Gqx7nob/K5
        XoI4rXaic5OCSP5fs9eDY5PVQzXOxnWusnm8iax+jqgAhz/i0+I4XWWlT2v1mTX6FBa34CO6EazeR
        RDQ0761FLfwnhc58i8tnjZlCpPF0VCSuQDnRlU5Rg0ZPAB4Rppuob2IL/G0yLfSJLwywfJyYMnTer
        60Wsm2Z8V0hT+4lzqGp2aC9xfRSJ3QzzSGaG9LYJemIPpx53CQYLtmoEVi1ePHIVbwT8Fa8vUEpDV
        IfjXd6Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtUKX-00059M-Ah; Thu, 09 Jul 2020 11:03:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 017CC30047A;
        Thu,  9 Jul 2020 13:03:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3C8F235B3D19; Thu,  9 Jul 2020 13:03:03 +0200 (CEST)
Date:   Thu, 9 Jul 2020 13:03:03 +0200
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
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200709110303.GS597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kqhvu1v.fsf@mpe.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 08:53:16PM +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
> >  arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
> >  arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
> >  arch/powerpc/platforms/pseries/Kconfig        |  5 ++
> >  arch/powerpc/platforms/pseries/setup.c        |  6 +-
> >  include/asm-generic/qspinlock.h               |  2 +
> 
> Another ack?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
