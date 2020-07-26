Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0D22DED5
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jul 2020 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGZL7z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZL7z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 07:59:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B39C0619D2;
        Sun, 26 Jul 2020 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Ulcv+XYXDsbe/gQ1QFaymA76fUaf73Ogbakhyf58ME=; b=ismlg70EGIrI2GcxeAyrDWqIpb
        ERntESs/K7v8oLSLDAyAEvckbFbKb5gDNBysO72uyFZ8Iv9LllqLYbcQq7cYbMNeZdfgEeofsaEr0
        dOMiZHBiYdzAXlTvErQKqCJLbaJAYj42ZODd6CzzYbBFv1kovJA8FMzXYXQ9RdAh7is1fK6Tj8WYz
        gIWoY29VXIgaLtBs88qi1Dn1cJYY6dLu93ubtTpChQWEwu7+zMp2SHol91o/Op4GE2ng0AvfW4ozw
        csLZIUPXqGeS6rK4DmgbMKFKvLwqTQIBR6PCvlLCMET4DGwcyC6C4zs8Id+3T+qrwgXJEv98xYrLZ
        nFHyab/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzfJj-0006ih-6B; Sun, 26 Jul 2020 11:59:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E7704304D58;
        Sun, 26 Jul 2020 13:59:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33A6D284D5CC2; Sun, 26 Jul 2020 13:59:44 +0200 (CEST)
Date:   Sun, 26 Jul 2020 13:59:44 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200726115944.GB119549@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200725202617.GI10769@hirez.programming.kicks-ass.net>
 <1595735694.b784cvipam.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595735694.b784cvipam.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 26, 2020 at 02:14:34PM +1000, Nicholas Piggin wrote:
> > Now, x86, and at least arm64 call nmi_enter() before
> > trace_hardirqs_off(), but AFAICT Power never did that, and that's part
> > of the problem. nmi_enter() does lockdep_off() and that _used_ to also
> > kill IRQ tracking.
> 
> Power does do nmi_enter -- __perf_event_interrupt()
> 
>         nmi = perf_intr_is_nmi(regs);
>         if (nmi)
>                 nmi_enter();
>         else
>                 irq_enter();

That's _waaaay_ too late, you've done the trace_hardirqs_{off,on} in
arch/powerpc/kernel/exceptions-64e.S, you need to _first_ do nmi_enter()
and _then_ trace_hardirqs_off(), or rather, that's still broken, but
then we get into the details of entry ordering.


