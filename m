Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811C4436654
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJUPe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 11:34:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJUPeZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 11:34:25 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrxfX-1n0JP328RR-00nubH; Thu, 21 Oct 2021 17:32:08 +0200
Received: by mail-wr1-f48.google.com with SMTP id e12so144813wra.4;
        Thu, 21 Oct 2021 08:32:08 -0700 (PDT)
X-Gm-Message-State: AOAM533LIYG8AM0xz57sjpIuBabfsGSLWQICftHr+vEUd4gHuFbMlJhK
        YukEORytZbflpm2SUvHTDymLsg+WBoXxg9fIIrE=
X-Google-Smtp-Source: ABdhPJzHm2YM9grQWPsO7s+9VbY2hH0uDX3eyS0BLSrV4b7iJ7a+z6YKWe2zKAaCfne7uwMOoRlh9ifciSqyUeG2CkU=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr8105105wra.428.1634830328087;
 Thu, 21 Oct 2021 08:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
 <CAK8P3a2+=9jjyqN5dMOb4+bYJy=q5G3CxFaCW+=4xryz-S=zYA@mail.gmail.com> <YXGD5OFbI7TEDFTr@hirez.programming.kicks-ass.net>
In-Reply-To: <YXGD5OFbI7TEDFTr@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Oct 2021 17:31:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a14NUvo40GFY5DfQcF28OO22=BiHJO1TzBTEMK0RAwtHg@mail.gmail.com>
Message-ID: <CAK8P3a14NUvo40GFY5DfQcF28OO22=BiHJO1TzBTEMK0RAwtHg@mail.gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HTUvtPJgueFBIE4yv8Sbj8fKTK/V4xFVbgJl3tZxuxmA+LN6Yc2
 9uAxDNt+1NYSHfBvWjWj2PbOT83oOX+A71i7uGx5fdcRcUObbq0s1ayIOYxE4e5vxVLkpsg
 R1oshw4DQyFes8BfLaqQZy8WiMKgXouYZBNKs6VfB/0iNUFeO4XTqKqtUd1SW5+3AWRDu77
 4WemAFfpT9wvDrAM//qMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sSr0mwAgHN8=:X8MCSTvIdQ6XqiW2GVe43z
 FeJB6S5YKrtmL9+aYfip0eHM/o0cpQikpsS+0ZyW/+T7wNhAsSPjVCbVCXNhdP3Cq7Dszku2A
 HVRaa7YRQoP5SkuVcUmLk2ec/oGAyUpKNkC64odMb0DZT7df3/+a649hRhER4HI9BsZRopSQ5
 nFVGfVqTpKc1Y3cA58gRPNNz9DvmecwCTlgdI8FgIGR2MO+8JYCBaAw29KB+GfgaZCJPQTexc
 NqGvmXEZij4R+0J5GMOYe3up13sNx74WbmsPdyEoO+im0ThhJDFykU36ACCsOJfzQ1LjfSrWg
 DTruTuw7XXnNozaT8Lpju8dgmuYFOxa2RM8npCHGmc40y/ZKXDDu2HI6k5a3G4zJCSurIEa1Z
 hFO1dNSeDwv0QCVCULiBE/jIT+VWIP7ne+bF4wOWS7k+GwXncs1ZNGQaecGsffIr3dWe4Ks40
 HkSb4/1GYi7iujhZO+U3WeiumJuE5boJdMvJPpvgwX7+xCzr526RF4/93WklnWy6bxHMOq0cx
 z/a/AZJGSs/traq33VTOnSwPXDxwT8zajdmrwnZrBOlv74cD1W7zVUTn+6MgDlw/rwWMGXhoX
 fk7G0MWD/remVQVyIGl7EaHDWjLkt5M2Pb0ByWi78DN4MT8X9NfRv7otY/9L+GYwxUMZztGU6
 nUiLjzvj60xg6ZWfM8Zc3ta11eyKp8GmGkjt1FVShx4QKSvLS0rhHR7nJ/5Z5EuBrH8QlHvLM
 qSiFZjICDCKtI2gzwB33KLuLVtyxPKKKTyL9w0w4lV0lZe9ie7hNtBApCs3ndYZq7MjHYFNO0
 1965OG130UcOoYd/e6BYZW3+9kKK2K5CmvreRx4LkW27i3XhyY=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 5:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Oct 21, 2021 at 03:49:51PM +0200, Arnd Bergmann wrote:
> I think for a load-store arch this thing should generate pretty close to
> optimal code. x86 can do ticket_unlock() slightly better using a single
> INCW (or ADDW 1) on the owner subword, where this implementation will to
> separate load-add-store instructions.
>
> If that is actually measurable is something else entirely.

Ok, so I guess such an architecture could take the generic implementation
and override just arch_spin_unlock() or just arch_spin_lock(), if that
makes a difference for them.

Should we perhaps turn your modified openrisc asm/spinlock.h
and asm/spin_lock_types.h the fallback in asm-generic, and
remove the ones for the architectures that have no overrides
at all?

Or possibly a version that can do both based on
CONFIG_ARCH_USE_QUEUED_SPINLOCKS? That would
let us remove even more architecture specific headers, but
it increases the risk of some architecture using qspinlock
when they really should not.

> > or a trivial test-and-set?
>
> If your SMP arch is halfway sane (no fwd progress issues etc..) then
> ticket should behave well and avoid the starvation/variablilty of TaS
> lock.

Ok, and I guess we still need to keep the parisc and sparc32 versions
anyway.

> The big exception there is virtualized architectures, ticket is
> absolutely horrendous for 'guests' (any fair lock is for that matter).

This might be useful information to put into the header, at least
I had no idea about this distinction.

       Arnd
