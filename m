Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E691011D855
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 22:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfLLVMN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 16:12:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36621 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLVMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 16:12:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id i4so3501377otr.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBgSBX+BgteTiVIKyAFTeKLIx8W4ON2ZbWr1HbcmNZw=;
        b=kwaUKevD6sBtvubSGOcjMFUrNyqLf9s43G9986p77vdUXpcyCu6+A6nWiLJC0ZzSlh
         WSvkEh+AhTEfds40OsZCnYRQNmk2O8JIBdlgl1KIaHbRAE/t5K0TCGKoDZXyn0O71cWX
         k3fatX5eXPUQb4l23Wryg3gVPCtyQOM4sTPcivy+sn/qkpapIjgMkqEfYbBLKEQp6VIb
         J6xwScQ0D3js4Hf7oXSpKx1o9zqj+C84TE512uCQLoyxOxDtVrmb0pijxBfnOjsr+nHb
         YP0rH432N5T2YRCM8hKarI3ymPB3th0RS7OMs6xfTeWXpjGYC1SBe3KjR5LINHA2jFPb
         zwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBgSBX+BgteTiVIKyAFTeKLIx8W4ON2ZbWr1HbcmNZw=;
        b=BVB2Vd/A9SC0tjZ/r8XJBnqvEe2hVnr4zcM+E8dhP76sSWQcQfeez12hpaN2Kg1E+Z
         9mc2coUqAw+DEpwYwmVjurJbAoA7lMQTiQUauK+uU8KEMFMdjAM3XL4rGvHKZAYlQu4o
         YHOofucfX1uzr0THMuvJanUiA/mw6BycVJT80+rVEUoiRV62sAmVWZhg1N+KbE4E3Pa/
         KF7O9oZDxHNMx/Ufn4LzUSaQBb1Jm4LhLoCjOlIgsJ5ristHpZbFSy9+oT0ToYb2YN11
         K9mv+hf/UqVR2kjy6+mMMcJ2+lncWgjlsj2T7LbTvRcarmeADB58SqF8GHaMA37p4PnH
         lPcQ==
X-Gm-Message-State: APjAAAXZtVDSyL1y+zHcVIKStV4VfxWGXx4me802lM/MvbSAJRv/gNBs
        b5IDPcvy392/XZ5CoceZo/F4W04Z1bfGdu4fB+eM+g==
X-Google-Smtp-Source: APXvYqxIs/KuK0EmztFCq2yliNogKk4/GVICvLJgBw5GIqLe8TH8SR8PWc8X/RtNHrlrFw83iT4wTtXuYhaKE5gAlo4=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr10813196oti.233.1576185131062;
 Thu, 12 Dec 2019 13:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20191126140406.164870-1-elver@google.com> <20191126140406.164870-3-elver@google.com>
 <00ee3b40-0e37-c9ac-3209-d07b233a0c1d@infradead.org> <20191203160128.GC2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191203160128.GC2889@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Dec 2019 22:11:59 +0100
Message-ID: <CANpmjNOvDHoapk1cR5rCAcYgfVwf8NS0wFJncJ-bQrWzCKLPpw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kcsan: Prefer __always_inline for fast-path
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 3 Dec 2019 at 17:01, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Dec 02, 2019 at 09:30:22PM -0800, Randy Dunlap wrote:
> > On 11/26/19 6:04 AM, Marco Elver wrote:
> > > Prefer __always_inline for fast-path functions that are called outside
> > > of user_access_save, to avoid generating UACCESS warnings when
> > > optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
> > > surprises with compiler versions that change the inlining heuristic even
> > > when optimizing for performance.
> > >
> > > Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Thank you, Randy!

Hoped this would have applied by now, but since KCSAN isn't in
mainline yet, should I send a version of this patch rebased on
-rcu/kcsan?
It will just conflict with the style cleanup that is in
-tip/locking/kcsan when another eventual merge happens. Alternatively,
we can delay it for now and just have to remember to apply eventually
(and have to live with things being messy for a bit longer :-)).

The version as-is here applies on -tip/locking/kcsan and -next (which
merged -tip/locking/kcsan).

Thanks,
-- Marco


>                                                         Thanx, Paul
>
> > Thanks.
> >
> > > ---
> > > Rebased on: locking/kcsan branch of tip tree.
> > > ---
> > >  kernel/kcsan/atomic.h   |  2 +-
> > >  kernel/kcsan/core.c     | 16 +++++++---------
> > >  kernel/kcsan/encoding.h | 14 +++++++-------
> > >  3 files changed, 15 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> > > index 576e03ddd6a3..a9c193053491 100644
> > > --- a/kernel/kcsan/atomic.h
> > > +++ b/kernel/kcsan/atomic.h
> > > @@ -18,7 +18,7 @@
> > >   * than cast to volatile. Eventually, we hope to be able to remove this
> > >   * function.
> > >   */
> > > -static inline bool kcsan_is_atomic(const volatile void *ptr)
> > > +static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
> > >  {
> > >     /* only jiffies for now */
> > >     return ptr == &jiffies;
> > > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > > index 3314fc29e236..c616fec639cd 100644
> > > --- a/kernel/kcsan/core.c
> > > +++ b/kernel/kcsan/core.c
> > > @@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
> > >   */
> > >  static DEFINE_PER_CPU(long, kcsan_skip);
> > >
> > > -static inline atomic_long_t *find_watchpoint(unsigned long addr,
> > > -                                        size_t size,
> > > -                                        bool expect_write,
> > > -                                        long *encoded_watchpoint)
> > > +static __always_inline atomic_long_t *
> > > +find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
> > >  {
> > >     const int slot = watchpoint_slot(addr);
> > >     const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> > > @@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
> > >   * 2. the thread that set up the watchpoint already removed it;
> > >   * 3. the watchpoint was removed and then re-used.
> > >   */
> > > -static inline bool
> > > +static __always_inline bool
> > >  try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
> > >  {
> > >     return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
> > > @@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
> > >     return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
> > >  }
> > >
> > > -static inline struct kcsan_ctx *get_ctx(void)
> > > +static __always_inline struct kcsan_ctx *get_ctx(void)
> > >  {
> > >     /*
> > >      * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
> > > @@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
> > >     return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
> > >  }
> > >
> > > -static inline bool is_atomic(const volatile void *ptr)
> > > +static __always_inline bool is_atomic(const volatile void *ptr)
> > >  {
> > >     struct kcsan_ctx *ctx = get_ctx();
> > >
> > > @@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
> > >     return kcsan_is_atomic(ptr);
> > >  }
> > >
> > > -static inline bool should_watch(const volatile void *ptr, int type)
> > > +static __always_inline bool should_watch(const volatile void *ptr, int type)
> > >  {
> > >     /*
> > >      * Never set up watchpoints when memory operations are atomic.
> > > @@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
> > >     this_cpu_write(kcsan_skip, skip_count);
> > >  }
> > >
> > > -static inline bool kcsan_is_enabled(void)
> > > +static __always_inline bool kcsan_is_enabled(void)
> > >  {
> > >     return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
> > >  }
> > > diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> > > index b63890e86449..f03562aaf2eb 100644
> > > --- a/kernel/kcsan/encoding.h
> > > +++ b/kernel/kcsan/encoding.h
> > > @@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
> > >                   (addr & WATCHPOINT_ADDR_MASK));
> > >  }
> > >
> > > -static inline bool decode_watchpoint(long watchpoint,
> > > -                                unsigned long *addr_masked,
> > > -                                size_t *size,
> > > -                                bool *is_write)
> > > +static __always_inline bool decode_watchpoint(long watchpoint,
> > > +                                         unsigned long *addr_masked,
> > > +                                         size_t *size,
> > > +                                         bool *is_write)
> > >  {
> > >     if (watchpoint == INVALID_WATCHPOINT ||
> > >         watchpoint == CONSUMED_WATCHPOINT)
> > > @@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
> > >  /*
> > >   * Return watchpoint slot for an address.
> > >   */
> > > -static inline int watchpoint_slot(unsigned long addr)
> > > +static __always_inline int watchpoint_slot(unsigned long addr)
> > >  {
> > >     return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
> > >  }
> > >
> > > -static inline bool matching_access(unsigned long addr1, size_t size1,
> > > -                              unsigned long addr2, size_t size2)
> > > +static __always_inline bool matching_access(unsigned long addr1, size_t size1,
> > > +                                       unsigned long addr2, size_t size2)
> > >  {
> > >     unsigned long end_range1 = addr1 + size1 - 1;
> > >     unsigned long end_range2 = addr2 + size2 - 1;
> > >
> >
> >
> > --
> > ~Randy
> >
