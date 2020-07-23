Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E222B204
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgGWO7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgGWO7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:59:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640FDC0619DC;
        Thu, 23 Jul 2020 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Gt1hFpE3q2wE3LOCsagXAgF4SokTskzV+hSBzd+h94=; b=YevgOcOaHex/SgwKEBjKklY9ML
        EOz76F9PRoMjWXYbh8Q+m/GbZsxZzpaftQUDGL6i0rkl4d3XOsti2q6zidbbAOdlaQCoDEkMbBo/3
        uibNzMdLQFmkllHyPKj3GT64ohKnBbGPeTcObiayUHZKr6mpih1MPL/xTlmXNwMkbz0YYUTrokLxc
        e+ansIggeKN0bMmp5DAW7L3MyHSOAaMAbgr26KCQ+j5BOGanY609zpdhmuxph9F1tP80dQDAtzqoT
        O61aCCCF81d39djAdwbpYFPQ/yDWx2bIuB8dtmgMTTFEzaQfBByrk9i+tOsYEg/FELh+tePD+S6hu
        wE5r4t3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jycgc-0000Ed-C9; Thu, 23 Jul 2020 14:59:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01DF5983422; Thu, 23 Jul 2020 16:59:04 +0200 (CEST)
Date:   Thu, 23 Jul 2020 16:59:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200723145904.GU5523@worktop.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723114010.GO5523@worktop.programming.kicks-ass.net>
 <1595506730.3mvrxktem5.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595506730.3mvrxktem5.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 11:11:03PM +1000, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
> > On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
> > 
> >> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> >> index 3a0db7b0b46e..35060be09073 100644
> >> --- a/arch/powerpc/include/asm/hw_irq.h
> >> +++ b/arch/powerpc/include/asm/hw_irq.h
> >> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
> >>  #define powerpc_local_irq_pmu_save(flags)			\
> >>  	 do {							\
> >>  		raw_local_irq_pmu_save(flags);			\
> >> -		trace_hardirqs_off();				\
> >> +		if (!raw_irqs_disabled_flags(flags))		\
> >> +			trace_hardirqs_off();			\
> >>  	} while(0)
> >>  #define powerpc_local_irq_pmu_restore(flags)			\
> >>  	do {							\
> >> -		if (raw_irqs_disabled_flags(flags)) {		\
> >> -			raw_local_irq_pmu_restore(flags);	\
> >> -			trace_hardirqs_off();			\
> >> -		} else {					\
> >> +		if (!raw_irqs_disabled_flags(flags))		\
> >>  			trace_hardirqs_on();			\
> >> -			raw_local_irq_pmu_restore(flags);	\
> >> -		}						\
> >> +		raw_local_irq_pmu_restore(flags);		\
> >>  	} while(0)
> > 
> > You shouldn't be calling lockdep from NMI context!
> 
> After this patch it doesn't.

You sure, trace_hardirqs_{on,off}() calls into lockdep. (FWIW they're
also broken vs entry ordering, but that's another story).

> trace_hardirqs_on/off implementation appears to expect to be called in NMI 
> context though, for some reason.

Hurpm, not sure.. I'll have to go grep arch code now :/ The generic NMI
code didn't touch that stuff.

Argh, yes, there might be broken there... damn! I'll go frob around.
