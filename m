Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72FB151F6E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBDR2W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 12:28:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBDR2W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 12:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wIR1JmS32XVeu+2C/XC7L3WcQePaYVm9hH5KSatXCuo=; b=bEm/6aE4sqW1LJuLN6dMteKKUi
        b16MZzrJWPB9ORIQwqteL1I9gba3XXD59uuHIzVSocXXyLmLRLxRki2g3SxtRb1Ki5Bzu9RJM/l0R
        8tG/j320Aplp/SdcH5NtO6JknLF1R7ajXPWDwao5FFikcHo3AJFCbacvDN7o9euGervBgKRfYNsiW
        CUIMGhY8lkN77XlHp3jiEIiWOvGIi+ORBS3cD6fEu9OIt8ygPi5sedCUk5NLHQ19V5yi/KcODiEkN
        HD+ZW9QttqLwt//+CD2XvnaYPQlv1n7Ud7izxmSJxASlEnPiimnpjfhdpydiVTatN0GoYqnwpg/6d
        uvOip6aQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iz1zV-0004bg-IN; Tue, 04 Feb 2020 17:28:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76EA0304C21;
        Tue,  4 Feb 2020 18:26:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 162D52B4C428E; Tue,  4 Feb 2020 18:27:58 +0100 (CET)
Date:   Tue, 4 Feb 2020 18:27:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200204172758.GF14879@hirez.programming.kicks-ass.net>
References: <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
 <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
 <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 04, 2020 at 11:54:02AM -0500, Alex Kogan wrote:
> > On Feb 3, 2020, at 10:47 AM, Waiman Long <longman@redhat.com> wrote:
> > 
> > On 2/3/20 10:28 AM, Peter Zijlstra wrote:
> >> On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
> >>> On 2/3/20 8:45 AM, Peter Zijlstra wrote:
> >>>> Presumably you have a workload where CNA is actually a win? That is,
> >>>> what inspired you to go down this road? Which actual kernel lock is so
> >>>> contended on NUMA machines that we need to do this?

> There are quite a few actually. files_struct.file_lock, file_lock_context.flc_lock
> and lockref.lock are some concrete examples that get very hot in will-it-scale
> benchmarks. 

Right, that's all a variant of banging on the same resources across
nodes. I'm not sure there's anything fundamental we can fix there.

> And then there are spinlocks in __futex_data.queues, 
> which get hot when applications have contended (pthread) locks — 
> LevelDB is an example.

A numa aware rework of futexes has been on the todo list for years :/

> Our initial motivation was based on an observation that kernel qspinlock is not 
> NUMA-aware. So what, you may ask. Much like people realized in the past that
> global spinning is bad for performance, and they switched from ticket lock to
> locks with local spinning (e.g., MCS), I think everyone would agree these days that
> bouncing a lock (and cache lines in general) across numa nodes is similarly bad.
> And as CNA demonstrates, we are easily leaving 2-3x speedups on the table by
> doing just that with the current qspinlock.

Actual benchmarks with performance numbers are required. It helps
motivate the patches as well as gives reviewers clues on how to
reproduce / inspect the claims made.
