Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A047C34F848
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 07:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCaFdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 01:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCaFdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 01:33:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A04C061574;
        Tue, 30 Mar 2021 22:33:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso629404pjb.3;
        Tue, 30 Mar 2021 22:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXgyDK8HaAZ+Nc4iB+GC6jvOWWlR3QxAnX+r+74mycw=;
        b=WojBFC/jd/BJWPXfRIuEsMiF5Z1TVSvCgju7IUpBWGuzOlLkM6KdCcNrD1HvwbeVLU
         sHIyEO45ILd6GHJt0ZxsOfxbhz5BqEaQBMMMTrnGwHSE/QJa8kqLTqCVmYVleuYDu60g
         gJfSK57NpaFWngP+Wcg7zcbhfWA/61MXwOy1wLiAMSRsr9maNjwR0nkAMOb9WHzEg3Be
         jko8RNKLNRZUtLaVuSVNB1CQZKj3yiL0sFZNoSw9Mfpo9dbLL1R4jicLEIGycw0vwbFu
         hhiB0VxcLzn4czYME/gnOEHaVGJknQgqiYWbflUwMRl+lntt8PLoFv201e+yf/3gDxCQ
         CkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FXgyDK8HaAZ+Nc4iB+GC6jvOWWlR3QxAnX+r+74mycw=;
        b=VFU6DF66r6twcCzhEGFEAZRsawWZxw+7ITLGepFMxIDe9S/2p5YsnbmV5HVwlx+tHC
         iPlWYviIn9NUICbDqiL33nfxhss4ltGF6kI4IScqPFFT3zPJ8Xp03X+nBrldHEj3fayp
         QdJgr4Dj+L+ahXQxFcpNCWhKiuX7+v/0qSuV9cTKMuilldFHLyoBP4htdW40ZFdNw6u4
         XiJirTFkqlGjOs+4GxdjnmMbGUuP0W27JPK7WWa+roKQHTfpeSI/ufiwJpiV/CEKbK6d
         uYg1C9MT6tXNnVM92E6mLnarv3KA48y5SGsasozrN4UkmPzlT4JtHt7CO85SqspNadLN
         VanA==
X-Gm-Message-State: AOAM533mHtfNe26Bzfu+aQhpWL3976tjz+V68H0BFbPUMZ8IoIKYGbH1
        C6uFlFqrCS1hhgKVwV9gP4A=
X-Google-Smtp-Source: ABdhPJyCJ2tQgtsy3Hs4dSWT7ZLW7WoOXoxU9abeyHdakOvY7DeC47ipXFHFloPMfMWmgniWXjoEyA==
X-Received: by 2002:a17:90a:fe93:: with SMTP id co19mr1810470pjb.142.1617168795740;
        Tue, 30 Mar 2021 22:33:15 -0700 (PDT)
Received: from rata.localnet (fred.taniwha.com. [203.86.204.69])
        by smtp.gmail.com with ESMTPSA id y66sm974623pgb.78.2021.03.30.22.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 22:33:15 -0700 (PDT)
From:   Paul Campbell <taniwha@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Wed, 31 Mar 2021 18:33:07 +1300
Message-ID: <1706037.TLkxdtWsSY@rata>
Organization: Moonbase Otago
In-Reply-To: <CAJF2gTSGLn7katm6YAtkKWJcQRqw36_yqn+aK1pKUSRM5V1zUg@mail.gmail.com>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org> <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com> <CAJF2gTSGLn7katm6YAtkKWJcQRqw36_yqn+aK1pKUSRM5V1zUg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday, 31 March 2021 5:18:56 PM NZDT Guo Ren wrote:
> > > [1]
> > > https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a2fcc
> > > 52afd0fcbf88> > 
> > > > It also seems that the current "amoswap" based implementation
> > > > would be reliable independent of RsrvEventual/RsrvNonEventual.
> > > 
> > > Yes, the hardware implementation of AMO could be different from LR/SC.
> > > AMO could use ACE snoop holding to lock the bus in hw coherency
> > > design, but LR/SC uses an exclusive monitor without locking the bus.
> > > 
> > > RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
> > > think LR/SC would be slower than CAS, and CAS is just good for code
> > > size.
> > 
> > What I meant here is that the current spinlock uses a simple amoswap,
> > which presumably does not suffer from the lack of forward process you
> > described.
> 
> Does that mean we should prevent using LR/SC (if RsrvNonEventual)?

Let me provide another data-point, I'm working on a high-end highly 
speculative implementation with many concurrent instructions in flight - from 
my point of view  both sorts of AMO (LR/SC and swap/add/etc) require me to 
grab a cache line in an exclusive modifiable state (so no difference there).

More importantly both sorts of AMO instructions  (unlike most loads and 
stores) can't be speculated (not even LR because it changes hidden state, I 
found this out the hard way bringing up the kernel).

This means that both LR AND SC individually can't be executed until all 
speculation is resolved (that means that they happen really late in the 
execute path and block the resolution of the speculation of subsequent 
instructions) - equally a single amoswap/add/etc instruction can't happen 
until late in the execute path - so both require the same cache line state, 
but one of these sorts of events is better than two of them.

Which in short means that amoswap/add/etc is better for small things - small 
buzzy lock loops, while LR/SC is better for more complex things with actual 
processing between the LR and SC.

----

Another issue here is to consider is what happens when you hit one of these 
tight spinlocks when the branch target cache is empty and they fail (ie loop 
back and try again) - the default branch prediction, and resulting 
speculation, is (very) likely to be looping back, while hopefully most locks 
are not contended when you hit them and that speculation would be wrong - a 
spinlock like this may not be so good:

	li a0, 1
loop: 
	amoswap	a1, a0, (a2)
	beqz	a1, loop
	..... subsequent code

In my world with no BTC info the pipe fills with dozens of amoswaps, rather 
than  the 'subsequent code'. While (in my world) code like this:

	li a0, 1
loop: 
	amoswap	a1, a0, (a2)
	bnez	a1, 1f
	.... subsequent code

1:	j loop

would actually be better (in my world unconditional jump instructions are 
folded early and never see execution so they're sort of free, though they mess 
with the issue/decode rate). Smart compilers could move the "j loop" out of 
the way, while the double branch on failure is not a big deal since either the 
lock is still held (and you don't care if it's slow) or it's been released in 
which case the cache line has been stolen and the refetch of that cache line 
is going to dominate the next time around the loop

I need to stress here that this is how my architecture works, other's will of 
course be different though I expect that other heavily speculative 
architectures to have similar issues :-)

	Paul Campbell
	Moonbase Otago



