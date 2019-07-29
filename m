Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33878A2E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfG2LJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 07:09:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbfG2LJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 07:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gi7iIytxwOSusKBpP3uzUn+8/N2d51dx02iEWqcYI5M=; b=SLLPaiClwMC18Nq1QTBwvP30k
        YyJhcamnVKRI7yAJ+XWG/FpRaXuKbQXd31bOOgYF9qgZzKE0pW8xN1pjej99z5cllncmQUtC61Vfi
        E2dO1D8gPpdw3I9sJy8dvjgDjv3rfsa2heKpx2h/zwDhV5MS2GVsrSUTbfHjoeS74Qu3PGduZFpev
        NVEBtNYI63seQnLGwQtsRhK1k55GYqZOwUOu84PXMhMLDZIWaRsZd5+QSbyrTBuk1Z9p6+1XiVL6L
        3+maRa07fQD7aoWF4e1PA4I3qI9pGDHXxTZWecArSMtWttaRPgab5KibFYiSGZlUTnJR8W9mR4B+r
        s8xJBHnaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs3Wz-0000wX-UW; Mon, 29 Jul 2019 11:09:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EA6B20B51713; Mon, 29 Jul 2019 13:09:27 +0200 (CEST)
Date:   Mon, 29 Jul 2019 13:09:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched
 clock function
Message-ID: <20190729110927.GC31398@hirez.programming.kicks-ass.net>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <87zhkxksxd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhkxksxd.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
> lantianyu1986@gmail.com writes:
> 
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >
> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
> > to set the sched clock function appropriately.  On x86, this sets
> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
> > scaled and adjusted to be continuous.
> 
> Hypervisor can, in theory, disable TSC page and then we're forced to use
> MSR-based clocksource but using it as sched_clock() can be very slow,
> I'm afraid.
> 
> On the other hand, what we have now is probably worse: TSC can,
> actually, jump backwards (e.g. on migration) and we're breaking the
> requirements for sched_clock().

That (obviously) also breaks the requirements for using TSC as
clocksource.

IOW, it breaks the entire purpose of having TSC in the first place.
