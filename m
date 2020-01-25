Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5550214951E
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgAYLQp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 06:16:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 06:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0K7FHm/jXt3sYjxl/BYCvfq5e9RGc0mSngX+VselMGs=; b=cav0QDGILCdG7ehnLk00deKdT
        5xrXMDWMCZgSFXHw29IlP4xxsGvztiH09Fhn/OVzxM+oJiW+NySEwNwcVp79cOfwHh1G/EoxhtkH8
        K0xz+edL99zobCb1bgmOj3Q6Pc2R2TC6JqVkk5ESw3bDyXKCkamepneg1LcB3mqP8jem76Stb5jsL
        Evu9GhKDlUFEWyXniG9UQqIzWCjgan+yKRkk4lxKv91GxrqbTyTM6221BoZRLMwVbCCHzrTMFPvc4
        aVSpcOzixOvlaQ9n/GlI7lWPJScrM7o38qYfkJGFWejeu+53wHU4dj8gyiC+yiHO0SkV9xzP9wlPS
        tbLTEhiLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivJQG-00032F-LC; Sat, 25 Jan 2020 11:16:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8AFF980BB0; Sat, 25 Jan 2020 12:16:07 +0100 (CET)
Date:   Sat, 25 Jan 2020 12:16:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
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
Message-ID: <20200125111607.GV11457@worktop.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 11:46:53AM -0500, Waiman Long wrote:
> I also thought about that. As you said, it can be hard to guarantee that
> reliable time value can be retrieved in a timely manner across all the
> archs.

Rememer that this code is limited to 64bit archs that have NUMA, my
quick grep says that is limited to:

  alpha, arm64, ia64, mips, powerpc, s390, sparc, x86

afaict, x86 is the one with the worst clocks between the lot of them
(with exception of ia64, which has been completely buggered for a while
and nobody cares).

> Even if we can do that, we will introduce latency to important
> tasks or contexts. I like the first approach better.

In general, the kernel has no clues what is actually important.

