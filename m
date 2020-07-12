Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA11921CABA
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jul 2020 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgGLRfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgGLRfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 13:35:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8FC061794;
        Sun, 12 Jul 2020 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2P9s9WMHjuyrEVlD8c6vf66HLPRFfDPoW3FukDk9Arg=; b=ttG56pHqyraFByXHQtr1//3HmS
        Jk3uOUBePyelh4BatScoFOFkK/APguqbt/FtLC2noBvglqUDMhf47ZvAa5gxxAqjvSYVqlWBMdaYz
        xp6ODW9rUmRaMwsF9R8lcxj2Q02P4FXbFXlDxxOJJDjDJqnmy2Oxy09xvutYcbQEnqB3ZGgHFHAca
        wJrDrqYX6cgzvkqUW0ySg9zPo/8wroo1LAk66uAWkDA4NzbjpUCz7/3gwPfWNxf+PF1ybYHdB9fD0
        mJ6/M0025ALfYVNmHvEBC5IbhChYt9XAtBOxlKdPj2aO7eDmJMDXPJRbUOSQ1KdUACG1VpKM1r4Z8
        U5yv19sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jufsM-00010D-Gg; Sun, 12 Jul 2020 17:34:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B011730047A;
        Sun, 12 Jul 2020 19:34:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3BD4201C9154; Sun, 12 Jul 2020 19:34:52 +0200 (CEST)
Date:   Sun, 12 Jul 2020 19:34:52 +0200
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
Message-ID: <20200712173452.GB10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711182128.29130-3-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 11, 2020 at 02:21:28PM -0400, Waiman Long wrote:
> The previous patch enables native qspinlock to store lock holder cpu
> number into the lock word when the lock is acquired via the slowpath.
> Since PV qspinlock uses atomic unlock, allowing the fastpath and
> slowpath to put different values into the lock word will further slow
> down the performance. This is certainly undesirable.
> 
> The only way we can do that without too much performance impact is to
> make fastpath and slowpath put in the same value. Still there is a slight
> performance overhead in the additional access to a percpu variable in the
> fastpath as well as the less optimized x86-64 PV qspinlock unlock path.
> 
> A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
> distros to decide if they want to enable lock holder cpu information in
> the lock itself for both native and PV qspinlocks across both fastpath
> and slowpath. If this option is not configureed, only native qspinlocks
> in the slowpath will put the lock holder cpu information in the lock
> word.

And this kills it,.. if it doesn't make unconditional sense, we're not
going to do this. It's just too ugly.
