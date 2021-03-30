Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3C34F455
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhC3Wfw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhC3WfS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 18:35:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C0C061574;
        Tue, 30 Mar 2021 15:35:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so8487932pjf.4;
        Tue, 30 Mar 2021 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MIKmUtb8xO+Dq6yKmOyCR/vq4cKBspfYEllac90t9ag=;
        b=u7XY8xoVgbo8DgwHawUEw/3qA/7IKbnKlWt2hjLE7MtthU8JObswEgN2cDtIX89igu
         UFK/ZOQwBENrZIH3xfFYVhXUCz4yRASvQOOaLFjaxHjXZJ2Twn/zgR0DDpGv/pG6w5M7
         slD9Sc9vt5A1uiHNm64YralGtKOZ9mgov1MEdGTdmo58K+i/OudXj5gpQa0wXILTk5gp
         8NIXyPBtIhKuIJj4zDqsqMNBjSWys1s0jknABPSDMKoPnKFPLjzZ6Ak1TpIlgcC+nCdw
         nCKwHJ8Xa8vTgufrtKp3xnHcO0IIxI5f2uDnJVhIpIvzfDOwv+v4prtROYXsoCZbXaCl
         H/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIKmUtb8xO+Dq6yKmOyCR/vq4cKBspfYEllac90t9ag=;
        b=BA2iEaGuJHYvhpw8BAW4EzdC21R19+WZDXJ3veT8pjYg/dJ15iRddeeLCv5m0Fca/L
         dQhg6ACGDNYYNy1mTmuB99pYUPZFmH9WLmLejzDIcfon4FdmHAz67BAVHT5C/KB6UoIm
         TbEJeBMsKA0t2Uh1ltW1x0+yY3//4fasnTENgKt7mova3l9SyeBxzvnhCNhPR+jGRbZi
         5OsrZvAwzymLFSP7PRI21fSlSA23bAIDjEy6aXBlajWhqpH2rSbKIulktnycbKIFyio0
         xG0TIJKQ+CMQqLqdqxlKMqxqE24WySfaCWzmTiPfx3ysTtFomYCsgFRY4aG3ZiyU6jS9
         q+2g==
X-Gm-Message-State: AOAM5325bJ5BmL2IdVbe/mhPWNzFO5ocob7ZBheoThuvmd8GJJVeHZFV
        jtqFkgKGrnxrTwq/w2BDZ/8=
X-Google-Smtp-Source: ABdhPJxqxS2YDuahl9PNg4VAillcg0SzefNJodUtgbgZj+qPO8g6vAlXW4UHUCHopV7NROqeoTUwOw==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr511004pjt.144.1617143717745;
        Tue, 30 Mar 2021 15:35:17 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id w5sm218189pge.55.2021.03.30.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:35:16 -0700 (PDT)
Date:   Wed, 31 Mar 2021 07:35:14 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210330223514.GE1171117@lianli.shorne-pla.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 06:08:40PM +0200, Peter Zijlstra wrote:
> On Tue, Mar 30, 2021 at 11:13:55AM +0800, Guo Ren wrote:
> > On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> > > > u32 a = 0x55aa66bb;
> > > > u16 *ptr = &a;
> > > >
> > > > CPU0                       CPU1
> > > > =========             =========
> > > > xchg16(ptr, new)     while(1)
> > > >                                     WRITE_ONCE(*(ptr + 1), x);
> > > >
> > > > When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
> > >
> > > Then I think your LL/SC is broken.
> > >
> > > That also means you really don't want to build super complex locking
> > > primitives on top, because that live-lock will percolate through.
> 
> > Do you mean the below implementation has live-lock risk?
> > +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > +{
> > +       u32 old, new, val = atomic_read(&lock->val);
> > +
> > +       for (;;) {
> > +               new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> > +               old = atomic_cmpxchg(&lock->val, val, new);
> > +               if (old == val)
> > +                       break;
> > +
> > +               val = old;
> > +       }
> > +       return old;
> > +}
> 
> That entirely depends on the architecture (and cmpxchg() impementation).
> 
> There are a number of cases:
> 
>  * architecture has cmpxchg() instruction (x86, s390, sparc, etc.).
> 
>   - architecture provides fwd progress (x86)
>   - architecture requires backoff for progress (sparc)
> 
>  * architecture does not have cmpxchg, and implements it using LL/SC.
> 
>   and here things get *really* interesting, because while an
>   architecture can have LL/SC fwd progress, that does not translate into
>   cmpxchg() also having the same guarantees and all bets are off.
> 
> The real bummer is that C can do cmpxchg(), but there is no way it can
> do LL/SC. And even if we'd teach C how to do LL/SC, it couldn't be
> generic because architectures lacking it can't emulate it using
> cmpxchg() (there's a fun class of bugs there).
> 
> So while the above code might be the best we can do in generic code,
> it's really up to the architecture to make it work.

I just want to chime in here, there may be a better spot in the thread to
mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
which I have on my todo list somwhere to replace the other generic
implementations like that in mips.

  arch/openrisc/include/asm/cmpxchg.h

The idea would be that architectures just implement these methods:

  long cmpxchg_u32(*ptr,old,new)
  long xchg_u32(*ptr,val)

Then the rest of the generic header would implement cmpxchg.

-Stafford
