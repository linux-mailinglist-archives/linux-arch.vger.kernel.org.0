Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720F521D2AC
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGMJV4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJV4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 05:21:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B5C061755;
        Mon, 13 Jul 2020 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P/bW5/nprUcxPT3l7Gpx8eG76PtPDRhEsmWS6Xfaf74=; b=Zwj5RIHxYYDF0P/F8xkgcDLK/R
        vHSnMafKuEB7KReKLmzAE/RZ76JPXiM/CTH4Q/dgMswpIW13wpAyUP5vGqzlkUmk2ma1k4HZunRh9
        S2zo/UXptc3oKvzwkKEUAAt/yQcCCD93dsd0a0v2GDXWGlvbzj6dMOX3AuvvD1jppbF+un5yi5qXf
        kidPV315rMgO86C0AyYnOJv96BsgORXu0UyFlME+mPjOcytvrU8nSGRpFqrLFBCilPHWYzlNugrAX
        z0hP8GpK1z6JwliCORWDsYhDbIWdGQti/oEqVg6jmICjGIV/gVduKO5eB9XZOIBNsG+AxoAAkQI9v
        WNHinH7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juuea-0006nD-Aj; Mon, 13 Jul 2020 09:21:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 934E03007CD;
        Mon, 13 Jul 2020 11:21:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8213720D27AA0; Mon, 13 Jul 2020 11:21:35 +0200 (CEST)
Date:   Mon, 13 Jul 2020 11:21:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder
 cpu into lock
Message-ID: <20200713092135.GC10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed22603-e347-8bff-f586-072a18987946@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 12, 2020 at 07:05:36PM -0400, Waiman Long wrote:
> On 7/12/20 1:34 PM, Peter Zijlstra wrote:

> > And this kills it,.. if it doesn't make unconditional sense, we're not
> > going to do this. It's just too ugly.
> > 
> You mean it has to be unconditional, no option config if we want to do it.
> Right?

Yeah, the very last thing we need in this code is spurious complexity.
