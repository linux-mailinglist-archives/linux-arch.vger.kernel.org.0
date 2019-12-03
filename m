Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9F1101B6
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2019 17:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLCQBe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Dec 2019 11:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfLCQBd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Dec 2019 11:01:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6C42068E;
        Tue,  3 Dec 2019 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575388891;
        bh=Y+MBcXzqSPjcu7EEBe36mxmMjTUX3DFU30w9Jm3s2Po=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H3l95Tad2MSTXLcwU+pOLxsNROWo7kCb3sgXXiwaxM/uiiJ5a94D8sQQ2gU9dkDvt
         epfVYP+b45K4mHVjkvwwBotAPyXksLcr1zPY90xtRCF7odLK1kProRLTFNsqB7WvGT
         WA0bRBwjVV5M8Ex+3e9KCZfHWZssAf3WcC1yngu8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D2EF3522780; Tue,  3 Dec 2019 08:01:28 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:01:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Marco Elver <elver@google.com>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de,
        dvyukov@google.com, linux-arch@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 3/3] kcsan: Prefer __always_inline for fast-path
Message-ID: <20191203160128.GC2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191126140406.164870-1-elver@google.com>
 <20191126140406.164870-3-elver@google.com>
 <00ee3b40-0e37-c9ac-3209-d07b233a0c1d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ee3b40-0e37-c9ac-3209-d07b233a0c1d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 02, 2019 at 09:30:22PM -0800, Randy Dunlap wrote:
> On 11/26/19 6:04 AM, Marco Elver wrote:
> > Prefer __always_inline for fast-path functions that are called outside
> > of user_access_save, to avoid generating UACCESS warnings when
> > optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
> > surprises with compiler versions that change the inlining heuristic even
> > when optimizing for performance.
> > 
> > Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thank you, Randy!

							Thanx, Paul

> Thanks.
> 
> > ---
> > Rebased on: locking/kcsan branch of tip tree.
> > ---
> >  kernel/kcsan/atomic.h   |  2 +-
> >  kernel/kcsan/core.c     | 16 +++++++---------
> >  kernel/kcsan/encoding.h | 14 +++++++-------
> >  3 files changed, 15 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> > index 576e03ddd6a3..a9c193053491 100644
> > --- a/kernel/kcsan/atomic.h
> > +++ b/kernel/kcsan/atomic.h
> > @@ -18,7 +18,7 @@
> >   * than cast to volatile. Eventually, we hope to be able to remove this
> >   * function.
> >   */
> > -static inline bool kcsan_is_atomic(const volatile void *ptr)
> > +static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
> >  {
> >  	/* only jiffies for now */
> >  	return ptr == &jiffies;
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 3314fc29e236..c616fec639cd 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
> >   */
> >  static DEFINE_PER_CPU(long, kcsan_skip);
> >  
> > -static inline atomic_long_t *find_watchpoint(unsigned long addr,
> > -					     size_t size,
> > -					     bool expect_write,
> > -					     long *encoded_watchpoint)
> > +static __always_inline atomic_long_t *
> > +find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
> >  {
> >  	const int slot = watchpoint_slot(addr);
> >  	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> > @@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
> >   *	2. the thread that set up the watchpoint already removed it;
> >   *	3. the watchpoint was removed and then re-used.
> >   */
> > -static inline bool
> > +static __always_inline bool
> >  try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
> >  {
> >  	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
> > @@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
> >  	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
> >  }
> >  
> > -static inline struct kcsan_ctx *get_ctx(void)
> > +static __always_inline struct kcsan_ctx *get_ctx(void)
> >  {
> >  	/*
> >  	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
> > @@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
> >  	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> >  }
> >  
> > -static inline bool is_atomic(const volatile void *ptr)
> > +static __always_inline bool is_atomic(const volatile void *ptr)
> >  {
> >  	struct kcsan_ctx *ctx = get_ctx();
> >  
> > @@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
> >  	return kcsan_is_atomic(ptr);
> >  }
> >  
> > -static inline bool should_watch(const volatile void *ptr, int type)
> > +static __always_inline bool should_watch(const volatile void *ptr, int type)
> >  {
> >  	/*
> >  	 * Never set up watchpoints when memory operations are atomic.
> > @@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
> >  	this_cpu_write(kcsan_skip, skip_count);
> >  }
> >  
> > -static inline bool kcsan_is_enabled(void)
> > +static __always_inline bool kcsan_is_enabled(void)
> >  {
> >  	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
> >  }
> > diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> > index b63890e86449..f03562aaf2eb 100644
> > --- a/kernel/kcsan/encoding.h
> > +++ b/kernel/kcsan/encoding.h
> > @@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
> >  		      (addr & WATCHPOINT_ADDR_MASK));
> >  }
> >  
> > -static inline bool decode_watchpoint(long watchpoint,
> > -				     unsigned long *addr_masked,
> > -				     size_t *size,
> > -				     bool *is_write)
> > +static __always_inline bool decode_watchpoint(long watchpoint,
> > +					      unsigned long *addr_masked,
> > +					      size_t *size,
> > +					      bool *is_write)
> >  {
> >  	if (watchpoint == INVALID_WATCHPOINT ||
> >  	    watchpoint == CONSUMED_WATCHPOINT)
> > @@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
> >  /*
> >   * Return watchpoint slot for an address.
> >   */
> > -static inline int watchpoint_slot(unsigned long addr)
> > +static __always_inline int watchpoint_slot(unsigned long addr)
> >  {
> >  	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
> >  }
> >  
> > -static inline bool matching_access(unsigned long addr1, size_t size1,
> > -				   unsigned long addr2, size_t size2)
> > +static __always_inline bool matching_access(unsigned long addr1, size_t size1,
> > +					    unsigned long addr2, size_t size2)
> >  {
> >  	unsigned long end_range1 = addr1 + size1 - 1;
> >  	unsigned long end_range2 = addr2 + size2 - 1;
> > 
> 
> 
> -- 
> ~Randy
> 
