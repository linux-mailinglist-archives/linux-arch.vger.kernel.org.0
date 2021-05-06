Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83237532B
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhEFLq4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 07:46:56 -0400
Received: from foss.arm.com ([217.140.110.172]:33622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhEFLq4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 May 2021 07:46:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE987101E;
        Thu,  6 May 2021 04:45:57 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810253F73B;
        Thu,  6 May 2021 04:45:55 -0700 (PDT)
Date:   Thu, 6 May 2021 12:45:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v3 2/2] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
Message-ID: <20210506114542.GA34537@C02TD0UTHF1T.local>
References: <1619009626-93453-2-git-send-email-guoren@kernel.org>
 <mhng-7181822d-02c1-4ef4-b1be-83c1034d79ba@palmerdabbelt-glaptop>
 <CAJF2gTRR2SAA_qfxyeRX5MTJDiVNa1aRDTpX7UJfxR3yjC1T9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRR2SAA_qfxyeRX5MTJDiVNa1aRDTpX7UJfxR3yjC1T9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 06, 2021 at 05:42:32PM +0800, Guo Ren wrote:
> Hi Palmer,
> 
> On Thu, May 6, 2021 at 2:03 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >
> > On Wed, 21 Apr 2021 05:53:46 PDT (-0700), guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The linux/atomic-arch-fallback.h has been there for a while, but
> > > only x86 & arm64 support it. Let's make riscv follow the
> > > linux/arch/* development trendy and make the codes more readable
> > > and maintainable.
> > >
> > > This patch also cleanup some codes:
> > >  - Add atomic_andnot_* operation
> > >  - Using amoswap.w.rl & amoswap.w.aq instructions in xchg
> > >  - Remove cmpxchg_acquire/release unnecessary optimization
> >
> > Thanks.  I haven't gotten the time to review this properly yet, but I
> > don't really see any issues.  Regardless, it was too late for this merge
> > window anyway -- these sorts of things are a bit subtle and require a
> > proper look, right at the end of the cycle things are just a bit too
> > hectic.
> >
> > I'll take a look once things calm down a bit, there's still some fixes
> > out that I'd like to look at first.
> >
> > I'm also only getting patch 2, and your lore link points to a different
> > patch set.
> Mark Rutland is preparing a new patchset to let ARCH_ATOMIC become the
> default for all arch. I'm waiting for his patchset and atop my
> modification on it.
> https://lore.kernel.org/linux-riscv/CAJF2gTS9y1QZx-8pu2NW22xs1Gky0y4Hs31Wrn7gZg3FiAq8NA@mail.gmail.com/
> 
> So, please abandon the patch, I'll send a new version patchset based
> on Mark's work.

For context, the series is basically ready now, but I'm intending to
rebase it atop v5.13-rc1 before posting (e.g. since s390 just moved to
ARCH_ATOMIC), and plan to post that early next week.

If you want an early look, my atomics/arch-atomic branch on kernel.org
has the WIP (atop v5.12):

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/arch-atomic
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic

.. and the riscv-specific changes are just renames:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/arch-atomic&id=3f7f7201eb4f4548cfb609019e7110b30ae598fc

Thanks,
Mark.
