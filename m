Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA135005F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhCaMbY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhCaMbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 08:31:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3BEC061574;
        Wed, 31 Mar 2021 05:31:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1168641pjb.0;
        Wed, 31 Mar 2021 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r0wurEgCXpwLk8V8e0yBHXS1a2Ee8JuUUWzmEE/Af/M=;
        b=HYh87bVhVdS5VrDKKYPgUhVykPRkLtiX6qLzPszCtA/84fkP12rXge+IibQm4nJekx
         siTu2pLi/bDAdAuLX1RZhevc8zPWbB9UM38zuMDDi/jj5sfmyvqNzG3pjCzF82ECILC8
         2CIYpBMZ/903hzzzU7jjx4Ei+cDy05KY614b0g1LqVH2APwryUwpCDRKtuJcYL7HxsYW
         gYJC/ERallREgYeMhxGEBttYuQ6Zi5xKrAyUsLcEbgG+hQPgBWCHTTjyUtmuxeFvCXjv
         JYzjZuCL9V2FrnCuQZvJCSp4jaOqcLHTXRwY9ot+U50D6yI7Qny5PrtmrI1r252xY/Td
         y5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r0wurEgCXpwLk8V8e0yBHXS1a2Ee8JuUUWzmEE/Af/M=;
        b=aIW5KSgI8GOyiZdvZgMJAEtskVITphf0D7kSbYhQE/v3lv+P7ukKgywuzK/tEHFjqi
         b46LasKYU08Sb1zui7UvkB/zf0G1lJG4IeUlf7u0CpDuvX6U4vO5VT8J8xRPKHPFkXJn
         UFq6LfP33zHvzTHvOcaaNx5bXTHyjBHH2oPx3/gaY00sVLGkenVLLXhxcn7B8IEIxCNk
         m4pm4Vy1GYmYMKicYzPk8GKvuZDVXnjIQaCkqFr8zEfoXBdp4uJLpIXaHjrmFvkpOZUM
         ULGTVC3ne5e6e+EZb2gTXF7Jh5Lh3Ynb/3wokChL5Rt3Ml91oLn1eFHda8UuY03XJ1Nj
         8dOg==
X-Gm-Message-State: AOAM530X39xM+RUgtK/og8DGqabktI0K7q6JZbdiQBenbDIJA0REt1rE
        NSt4aNWV0pJCrpHSM2gBYgA=
X-Google-Smtp-Source: ABdhPJyG4a82R/BbIuiJluEQk1BqTadUrv91d79dqwaxsWtGJSEWE5901Qw1cGhEGO+9XsI5urPZDQ==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr3263996pjo.121.1617193870227;
        Wed, 31 Mar 2021 05:31:10 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id r1sm2026366pjo.26.2021.03.31.05.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 05:31:09 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:31:07 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210331123107.GF1171117@lianli.shorne-pla.net>
References: <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
 <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 09:23:27AM +0200, Arnd Bergmann wrote:
> On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > I just want to chime in here, there may be a better spot in the thread to
> > mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
> > which I have on my todo list somwhere to replace the other generic
> > implementations like that in mips.
> >
> >   arch/openrisc/include/asm/cmpxchg.h
> >
> > The idea would be that architectures just implement these methods:
> >
> >   long cmpxchg_u32(*ptr,old,new)
> >   long xchg_u32(*ptr,val)
> >
> > Then the rest of the generic header would implement cmpxchg.
> 
> I like the idea of generalizing it a little further. I'd suggest staying a
> little closer to the existing naming here though, as we already have
> cmpxchg() for the type-agnostic version, and cmpxchg64() for the
> fixed-length 64-bit version.

OK.

> I think a nice interface between architecture-specific and architecture
> independent code would be to have architectures provide
> arch_cmpxchg32()/arch_xchg32() as the most basic version, as well
> as arch_cmpxchg8()/arch_cmpxchg16()/arch_xchg8()/arch_xchg16()
> if they have instructions for those.

Thanks for the name suggestions, it makes it easier for me.

> The common code can then build cmpxchg16()/xchg16() on top of
> either the 16-bit or the 32-bit primitives, and build the cmpxchg()/xchg()
> wrapper around those (or alternatively we can decide to have them
> only deal with fixed-32-bit and long/pointer sized atomics).

Yeah, that was the idea.

-Stafford
