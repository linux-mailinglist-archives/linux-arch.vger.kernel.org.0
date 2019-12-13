Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA211DBB2
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 02:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfLMBb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 20:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfLMBb3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 20:31:29 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8112A206B7;
        Fri, 13 Dec 2019 01:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576200687;
        bh=oPr5cQKbMUvPoiWxMSN+FfKPbjo8HdSlaHewowx2Am8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H/ST3WYjZwNb7yRtc49+wleBzA3+ZUacYKGaPZVAKHoW+WrRv/C74cIb/Hv+zQ2eY
         nA40PyZwPyBbb4s/tAva9sobp9HASX2zK5qhcwcvb3O7uDh0ktK68ZntiodxaPNZNR
         9ZwaUxiQJmjatsbqXX2/2+5QBYsICYviMTVvlerY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 19AE135227E8; Thu, 12 Dec 2019 17:31:27 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:31:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 3/3] kcsan: Prefer __always_inline for fast-path
Message-ID: <20191213013127.GE2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191126140406.164870-1-elver@google.com>
 <20191126140406.164870-3-elver@google.com>
 <00ee3b40-0e37-c9ac-3209-d07b233a0c1d@infradead.org>
 <20191203160128.GC2889@paulmck-ThinkPad-P72>
 <CANpmjNOvDHoapk1cR5rCAcYgfVwf8NS0wFJncJ-bQrWzCKLPpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOvDHoapk1cR5rCAcYgfVwf8NS0wFJncJ-bQrWzCKLPpw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 10:11:59PM +0100, Marco Elver wrote:
> On Tue, 3 Dec 2019 at 17:01, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Dec 02, 2019 at 09:30:22PM -0800, Randy Dunlap wrote:
> > > On 11/26/19 6:04 AM, Marco Elver wrote:
> > > > Prefer __always_inline for fast-path functions that are called outside
> > > > of user_access_save, to avoid generating UACCESS warnings when
> > > > optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
> > > > surprises with compiler versions that change the inlining heuristic even
> > > > when optimizing for performance.
> > > >
> > > > Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > >
> > > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> >
> > Thank you, Randy!
> 
> Hoped this would have applied by now, but since KCSAN isn't in
> mainline yet, should I send a version of this patch rebased on
> -rcu/kcsan?
> It will just conflict with the style cleanup that is in
> -tip/locking/kcsan when another eventual merge happens. Alternatively,
> we can delay it for now and just have to remember to apply eventually
> (and have to live with things being messy for a bit longer :-)).

Excellent question.  ;-)

The first several commits are in -tip already, so they will go upstream
in their current state by default.  And a bunch of -tip commits have
already been merged on top of them, so it might not be easy to move them.

So please feel free to port the patch to -rcu/ksan and let's see how that
plays out.  If it gets too ugly, then maybe wait until the current set
of patches go upstream.

Another option is to port them to the kcsan merge point in -rcu.  That
would bring in v5.5-rc1.  Would that help?

							Thanx, Paul

> The version as-is here applies on -tip/locking/kcsan and -next (which
> merged -tip/locking/kcsan).
> 
> Thanks,
> -- Marco
> 
> 
> >                                                         Thanx, Paul
> >
> > > Thanks.
> > >
> > > > ---
> > > > Rebased on: locking/kcsan branch of tip tree.
> > > > ---
> > > >  kernel/kcsan/atomic.h   |  2 +-
> > > >  kernel/kcsan/core.c     | 16 +++++++---------
> > > >  kernel/kcsan/encoding.h | 14 +++++++-------
> > > >  3 files changed, 15 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> > > > index 576e03ddd6a3..a9c193053491 100644
> > > > --- a/kernel/kcsan/atomic.h
> > > > +++ b/kernel/kcsan/atomic.h
> > > > @@ -18,7 +18,7 @@
> > > >   * than cast to volatile. Eventually, we hope to be able to remove this
> > > >   * function.
> > > >   */
> > > > -static inline bool kcsan_is_atomic(const volatile void *ptr)
> > > > +static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
> > > >  {
> > > >     /* only jiffies for now */
> > > >     return ptr == &jiffies;
> > > > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > > > index 3314fc29e236..c616fec639cd 100644
> > > > --- a/kernel/kcsan/core.c
> > > > +++ b/kernel/kcsan/core.c
> > > > @@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
> > > >   */
> > > >  static DEFINE_PER_CPU(long, kcsan_skip);
> > > >
> > > > -static inline atomic_long_t *find_watchpoint(unsigned long addr,
> > > > -                                        size_t size,
> > > > -                                        bool expect_write,
> > > > -                                        long *encoded_watchpoint)
> > > > +static __always_inline atomic_long_t *
> > > > +find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
> > > >  {
> > > >     const int slot = watchpoint_slot(addr);
> > > >     const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> > > > @@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
> > > >   * 2. the thread that set up the watchpoint already removed it;
> > > >   * 3. the watchpoint was removed and then re-used.
> > > >   */
> > > > -static inline bool
> > > > +static __always_inline bool
> > > >  try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
> > > >  {
> > > >     return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
> > > > @@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
> > > >     return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
> > > >  }
> > > >
> > > > -static inline struct kcsan_ctx *get_ctx(void)
> > > > +static __always_inline struct kcsan_ctx *get_ctx(void)
> > > >  {
> > > >     /*
> > > >      * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
> > > > @@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
> > > >     return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> > > >  }
> > > >
> > > > -static inline bool is_atomic(const volatile void *ptr)
> > > > +static __always_inline bool is_atomic(const volatile void *ptr)
> > > >  {
> > > >     struct kcsan_ctx *ctx = get_ctx();
> > > >
> > > > @@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
> > > >     return kcsan_is_atomic(ptr);
> > > >  }
> > > >
> > > > -static inline bool should_watch(const volatile void *ptr, int type)
> > > > +static __always_inline bool should_watch(const volatile void *ptr, int type)
> > > >  {
> > > >     /*
> > > >      * Never set up watchpoints when memory operations are atomic.
> > > > @@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
> > > >     this_cpu_write(kcsan_skip, skip_count);
> > > >  }
> > > >
> > > > -static inline bool kcsan_is_enabled(void)
> > > > +static __always_inline bool kcsan_is_enabled(void)
> > > >  {
> > > >     return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
> > > >  }
> > > > diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> > > > index b63890e86449..f03562aaf2eb 100644
> > > > --- a/kernel/kcsan/encoding.h
> > > > +++ b/kernel/kcsan/encoding.h
> > > > @@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
> > > >                   (addr & WATCHPOINT_ADDR_MASK));
> > > >  }
> > > >
> > > > -static inline bool decode_watchpoint(long watchpoint,
> > > > -                                unsigned long *addr_masked,
> > > > -                                size_t *size,
> > > > -                                bool *is_write)
> > > > +static __always_inline bool decode_watchpoint(long watchpoint,
> > > > +                                         unsigned long *addr_masked,
> > > > +                                         size_t *size,
> > > > +                                         bool *is_write)
> > > >  {
> > > >     if (watchpoint == INVALID_WATCHPOINT ||
> > > >         watchpoint == CONSUMED_WATCHPOINT)
> > > > @@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
> > > >  /*
> > > >   * Return watchpoint slot for an address.
> > > >   */
> > > > -static inline int watchpoint_slot(unsigned long addr)
> > > > +static __always_inline int watchpoint_slot(unsigned long addr)
> > > >  {
> > > >     return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
> > > >  }
> > > >
> > > > -static inline bool matching_access(unsigned long addr1, size_t size1,
> > > > -                              unsigned long addr2, size_t size2)
> > > > +static __always_inline bool matching_access(unsigned long addr1, size_t size1,
> > > > +                                       unsigned long addr2, size_t size2)
> > > >  {
> > > >     unsigned long end_range1 = addr1 + size1 - 1;
> > > >     unsigned long end_range2 = addr2 + size2 - 1;
> > > >
> > >
> > >
> > > --
> > > ~Randy
> > >
