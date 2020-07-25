Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385CC22D8EB
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jul 2020 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGYR0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jul 2020 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGYR0t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jul 2020 13:26:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B13C08C5C0;
        Sat, 25 Jul 2020 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7SRpwoL15MtwcU8wbHwQcUF2uHBMY5fJRBYQrQ9053Y=; b=IYNVHfAHG5lpuAIueljasDi0oa
        Du5FVq5sa5MBLzFTzDkALOkYTPbrWp+rPmZ49KvQiDoqMERlml1qgQDzXOWd9wJJUAqpv5z/KMH8q
        jEXc7o3zrIfO5GWST7gOXHKqoICiOWrtLHPTp25XxoYQPCKYOo3l8etKJ9b7O7ZMKacWEckk/xv+9
        m7fRAOGPr3/6uLPu135C3GbMy7l3GoowiIKV33kjTJEJ12Ww0hRSIsoue6YoyX1FmOkJt374qooD5
        YAAVcRYciUuV3iaqNnTf0TbSoY9YxM47y4xSiXqeoGXuk530lxCfga9DOXa1LMsJCASUDAFsFtBba
        RlnJdyfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzNwO-0001Ol-2h; Sat, 25 Jul 2020 17:26:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A0E0301179;
        Sat, 25 Jul 2020 19:26:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E6062B8AA3CC; Sat, 25 Jul 2020 19:26:30 +0200 (CEST)
Date:   Sat, 25 Jul 2020 19:26:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200725172630.GF10769@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
 <20200724081647.GA16642@willie-the-truck>
 <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 03:10:59PM -0400, Waiman Long wrote:
> On 7/24/20 4:16 AM, Will Deacon wrote:
> > On Thu, Jul 23, 2020 at 08:47:59PM +0200, peterz@infradead.org wrote:
> > > On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
> > > > BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
> > > > I will have to update the patch to fix the reported 0-day test problem, but
> > > > I want to collect other feedback before sending out v3.
> > > I want to say I hate it all, it adds instructions to a path we spend an
> > > aweful lot of time optimizing without really getting anything back for
> > > it.
> > > 
> > > Will, how do you feel about it?
> > I can see it potentially being useful for debugging, but I hate the
> > limitation to 256 CPUs. Even arm64 is hitting that now.
> 
> After thinking more about that, I think we can use all the remaining bits in
> the 16-bit locked_pending. Reserving 1 bit for locked and 1 bit for pending,
> there are 14 bits left. So as long as NR_CPUS < 16k (requirement for 16-bit
> locked_pending), we can put all possible cpu numbers into the lock. We can
> also just use smp_processor_id() without additional percpu data.

That sounds horrific, wouldn't that destroy the whole point of using a
byte for pending?

> > Also, you're talking ~1% gains here. I think our collective time would
> > be better spent off reviewing the CNA series and trying to make it more
> > deterministic.
> 
> I thought you guys are not interested in CNA. I do want to get CNA merged,
> if possible. Let review the current version again and see if there are ways
> we can further improve it.

It's not a lack of interrest. We were struggling with the fairness
issues and the complexity of the thing. I forgot the current state of
matters, but at one point UNLOCK was O(n) in waiters, which is, of
course, 'unfortunate'.

I'll have to look up whatever notes remain, but the basic idea of
keeping remote nodes on a secondary list is obviously breaking all sorts
of fairness. After that they pile on a bunch of hacks to fix the worst
of them, but it feels exactly like that, a bunch of hacks.

One of the things I suppose we ought to do is see if some of the ideas
of phase-fair locks can be applied to this.

That coupled with a chronic lack of time for anything :-(
