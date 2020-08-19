Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8096624A32C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgHSPdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHSPdA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 11:33:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79EAC061757;
        Wed, 19 Aug 2020 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YJV9BkFVGMxl/HraYnlFDH2emG8P8Ef5qIQCvx8D9FA=; b=Lla9qbXU3/MRuj5sJ+off9OYhe
        ayU/X2t5eHzmG5+ig4Ex5eq2Kqa/K6J7YZCF7dpYLsR1AMsmtwAgaG7gQ4wqWt6kfIZGP1c11Foi+
        0wlFCkEGGe/s4jAGqsjgKx+SEfqt9eLe2jo39WKBsONziH152nJBL6mmLJ5hpEftB8T0kYDjxTexs
        vVI4eKRd7DmN2cPYzINi5DWsg4E76ZrZJLfWQUheBSH6ZsDlvudON+DF2NTyG1mGC4a8HpS44PRr/
        UDZnCPFL216/Wt7/xoB0mcOsDopdAWtNcdcHyzFqGGyt6vFSbh+Zxi9GmYkJqFsS3Jc3Q6Ky9TVMk
        qUUR6vhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Q55-0001ZO-Le; Wed, 19 Aug 2020 15:32:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43A01301A7A;
        Wed, 19 Aug 2020 17:32:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2934F2BEB7F3B; Wed, 19 Aug 2020 17:32:50 +0200 (CEST)
Date:   Wed, 19 Aug 2020 17:32:50 +0200
From:   peterz@infradead.org
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200819153250.GF2674@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200807111126.GI2674@hirez.programming.kicks-ass.net>
 <1597220073.mbvcty6ghk.astroid@bobo.none>
 <20200812103530.GL2674@hirez.programming.kicks-ass.net>
 <1597735273.s0usqkrlsk.astroid@bobo.none>
 <20200818154143.GT2674@hirez.programming.kicks-ass.net>
 <1597793862.l8c4pmmzpq.astroid@bobo.none>
 <7fadb5ab-9869-396d-ff5d-c0adb6fc0b35@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fadb5ab-9869-396d-ff5d-c0adb6fc0b35@ozlabs.ru>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 08:39:13PM +1000, Alexey Kardashevskiy wrote:

> > or current upstream?
> 
> The upstream 18445bf405cb (13 hours old) also shows the problem. Yours
> 1/2 still fixes it.

Afaict that just reduces the window.

Isn't the problem that:

arch/powerpc/kernel/exceptions-64e.S

	START_EXCEPTION(perfmon);
	NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
				PROLOG_ADDITION_NONE)
	EXCEPTION_COMMON(0x260)
	INTS_DISABLE
#	  RECONCILE_IRQ_STATE
#	    TRACE_DISABLE_INTS
#	      TRACE_WITH_FRAME_BUFFER(trace_hardirqs_off)
#
# but we haven't done nmi_enter() yet... whoopsy

	CHECK_NAPPING()
	addi	r3,r1,STACK_FRAME_OVERHEAD
	bl	performance_monitor_exception
#	 perf_irq()
#          perf_event_interrupt
#	     __perf_event_interrupt
#	      nmi_enter()



That is, afaict your entry code is buggered.

