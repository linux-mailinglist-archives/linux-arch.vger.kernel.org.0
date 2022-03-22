Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C84E4813
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 22:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiCVVIZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 17:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCVVIZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 17:08:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487B3E5F9;
        Tue, 22 Mar 2022 14:06:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e5so4762633pls.4;
        Tue, 22 Mar 2022 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VqKe7hI7FJvdE8Xfvk2XUbpj3DCkNeOgE/n2lG3V58M=;
        b=l6Lj5tunNDJYVXRRFlmjLK9y2r5Jtsm6eTf4WyR4vCW9d1v3e8JWl3ivVczi5PMKsp
         GIR1Sg6+0/bKw/9nBJUQcybRUIvkvFjdJJ0H0oR7fHFEyu+XupEKYEm3OQQKjDn7iyj4
         bNbaob5ScTg/vx318Dqxax8e6cOPbpYL7m1deZjm6slVSnoWf5Ur5VGgVNHRCj/wYRXl
         FZkBtOUZMTDLIAjt6SX0LD19WvVYwc6XpjnWcEAjC12kt/wlb9ILb3PgmRJw5Vi2J0YA
         n2oNcjFY7X3/mjlom/Y0MchhJrHJt4RxsRJWIcPs/y3pdKU0A9kr1SA7zWjclEkJd+OK
         17sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqKe7hI7FJvdE8Xfvk2XUbpj3DCkNeOgE/n2lG3V58M=;
        b=6m/KmI7ZYLoNe5UNQyjxCm6q7C2cvlHNwLMEEcdMJEMSrSbaF32ZjE/lP9i1sBW6o+
         A2l4hkcEZnkc9VR1Aqo//xgc2kSAEhn+Eq0rNWmQeqDqUcfYAYb/vofyZt/N8Aire4UG
         a2xjwo6VQ2UJVuJmIRMu2ONEA5cDIDJ7HpEloX/rhpmyrm8CjNxxsqsEPgvXkx5/5wI5
         5Gm1tCkW2bfGQsOeBSIXCqterWj730HtuF5VKctcjLQwhCFa3z/bPv88tF0Jw4C2PDxw
         jup7IJI4JMo8u3p2FvbzjtDE9KLLTWnGlWaJWBL6ZLDtm7upZKHoVqGqyHJN5H3K7V+1
         8Tzg==
X-Gm-Message-State: AOAM531n2wKUmrU466lU2AkPkwCZmUyOLcsLoF780xlL2OL1MOHwinCQ
        dnLoXwwqGAORl/r6efXcXNc=
X-Google-Smtp-Source: ABdhPJyu21bjBOSUqHlZN0IdeZqf053AvJ2Yx8yrrk0KLxSnLOPWMTq9b2/meIZSuiNdlmy9jXWyOg==
X-Received: by 2002:a17:902:d643:b0:153:97c3:c8e5 with SMTP id y3-20020a170902d64300b0015397c3c8e5mr20078217plh.76.1647983215902;
        Tue, 22 Mar 2022 14:06:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k12-20020a056a00134c00b004fabc8fa42esm3345559pfu.87.2022.03.22.14.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:06:54 -0700 (PDT)
Date:   Wed, 23 Mar 2022 06:06:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        boqun.feng@gmail.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [OpenRISC] [PATCH V2 1/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
Message-ID: <Yjo6bI+DWolVT/bQ@antec>
References: <20220319035457.2214979-1-guoren@kernel.org>
 <20220319035457.2214979-2-guoren@kernel.org>
 <Yjk+LGwhc50zvsk2@antec>
 <54d6221d-0c4f-9329-042d-4f74c4ea288f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d6221d-0c4f-9329-042d-4f74c4ea288f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 11:54:37AM -0400, Waiman Long wrote:
> On 3/21/22 23:10, Stafford Horne wrote:
> > Hello,
> > 
> > There is a problem with this patch on Big Endian machines, see below.
> > 
> > On Sat, Mar 19, 2022 at 11:54:53AM +0800, guoren@kernel.org wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > This is a simple, fair spinlock.  Specifically it doesn't have all the
> > > subtle memory model dependencies that qspinlock has, which makes it more
> > > suitable for simple systems as it is more likely to be correct.
> > > 
> > > [Palmer: commit text]
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > 
> > > --
> > > 
> > > I have specifically not included Peter's SOB on this, as he sent his
> > > original patch
> > > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> > > without one.
> > > ---
> > >   include/asm-generic/spinlock.h          | 11 +++-
> > >   include/asm-generic/spinlock_types.h    | 15 +++++
> > >   include/asm-generic/ticket-lock-types.h | 11 ++++
> > >   include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
> > >   4 files changed, 120 insertions(+), 3 deletions(-)
> > >   create mode 100644 include/asm-generic/spinlock_types.h
> > >   create mode 100644 include/asm-generic/ticket-lock-types.h
> > >   create mode 100644 include/asm-generic/ticket-lock.h
> > > 
> > > diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
> > > new file mode 100644
> > > index 000000000000..59373de3e32a
> > > --- /dev/null
> > > +++ b/include/asm-generic/ticket-lock.h
> > ...
> > 
> > > +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> > > +{
> > > +	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> > As mentioned, this patch series breaks SMP on OpenRISC.  I traced it to this
> > line.  The above `__is_defined(__BIG_ENDIAN)`  does not return 1 as expected
> > even on BIG_ENDIAN machines.  This works:
> > 
> > 
> > diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
> > index 59373de3e32a..52b5dc9ffdba 100644
> > --- a/include/asm-generic/ticket-lock.h
> > +++ b/include/asm-generic/ticket-lock.h
> > @@ -26,6 +26,7 @@
> >   #define __ASM_GENERIC_TICKET_LOCK_H
> >   #include <linux/atomic.h>
> > +#include <linux/kconfig.h>
> >   #include <asm-generic/ticket-lock-types.h>
> >   static __always_inline void ticket_lock(arch_spinlock_t *lock)
> > @@ -51,7 +52,7 @@ static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
> >   static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> >   {
> > -       u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> > +       u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> >          u32 val = atomic_read(lock);
> >          smp_store_release(ptr, (u16)val + 1);
> > 
> > 
> > > +	u32 val = atomic_read(lock);
> > > +
> > > +	smp_store_release(ptr, (u16)val + 1);
> > > +}
> > > +
> 
> __BIG_ENDIAN is defined in <linux/kconfig.h>. I believe that if you include
> <linux/kconfig.h>, the second hunk is not really needed and vice versa.

I thought so too, but it doesn't seem to work.  I think __is_defined is not
doing what we think in this context.  It looks like __is_defined works when a
macro is defined as 1, in this case we have __BIG_ENDIAN 4321.

With just the first hunk, we can see we still get 0 for the lock offset as per
below:

diff --git a/include/asm-generic/ticket-lock.h
b/include/asm-generic/ticket-lock.h
index 59373de3e32a..769561fb6997 100644
--- a/include/asm-generic/ticket-lock.h
+++ b/include/asm-generic/ticket-lock.h
@@ -26,6 +26,7 @@
 #define __ASM_GENERIC_TICKET_LOCK_H

 #include <linux/atomic.h>
+#include <linux/kconfig.h>
 #include <asm-generic/ticket-lock-types.h>

 static __always_inline void ticket_lock(arch_spinlock_t *lock)

--

 make ARCH=openrisc simple_smp_defconfig
 make ARCH=openrisc CROSS_COMPILE=or1k-linux- kernel/locking/spinlock.i
 grep -C3 'lock +' kernel/locking/spinlock.i

    static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((__no_instrument_function__)) __attribute__((__always_inline__)) void
    ticket_unlock(arch_spinlock_t *lock)
    {
     u16 *ptr = (u16 *)lock + 0;

     u32 val = atomic_read(lock);

-Stafford
