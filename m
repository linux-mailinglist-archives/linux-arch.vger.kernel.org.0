Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B05147914
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgAXHxX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 02:53:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHxX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 02:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yuA59Cq86QbpEr2GrOS1my19i2Wm0DAniBfPEadru+E=; b=WE2DXd5VdOovwJVSYxSxfE6QZ
        n8413ndR5tjBKdTrfkMnM1yGlzr/9L1/JgTH7UQVY4LLbgWeYruwww37tzvLPwLtIE9vPisE2Yv4c
        DANqteyAoXxYNXLvTzGTavbTIzem6CUyASrfJ9n6t86d4eSHxE3WmmxVxMsHoHnSjzareP2xR3Qn9
        fiLecZ8TgJvMBrimrxxWmNfEUXgpFK3FtGPOUR8zXXCleY8JD+iISEOLUgOw7pOdZa+01SK07b0oP
        VzZUunaCiW0otMSA818I140pkS8tKQVFzYpHEwLZ3ydHTofSySmjR0BuAwoxWFtszk4/eJZWVe1z5
        X0FXVJN3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iutlf-0001Zl-48; Fri, 24 Jan 2020 07:52:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4165F300677;
        Fri, 24 Jan 2020 08:50:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC2352B716B08; Fri, 24 Jan 2020 08:52:35 +0100 (CET)
Date:   Fri, 24 Jan 2020 08:52:35 +0100
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
Message-ID: <20200124075235.GX14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 04:33:54PM -0500, Alex Kogan wrote:
> Let me put this question to you. What do you think the number should be?

I think it would be very good to keep the inter-node latency below 1ms.

But to realize that we need data on the lock hold times. Specifically
for the heavily contended locks that make CNA worth it in the first
place.

I don't see that data, so I don't see how we can argue about this let
alone call something reasonable.
