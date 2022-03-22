Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2157D4E3786
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 04:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiCVDay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 23:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiCVDay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 23:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663E1AAFDF;
        Mon, 21 Mar 2022 20:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E26061121;
        Tue, 22 Mar 2022 03:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E61AC340F5;
        Tue, 22 Mar 2022 03:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647919765;
        bh=2reRjUCDWBKIKQ9r743f4tM9pbRgwgnhUMM5zFY+LEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H7XFUSagBQn7QH++TZ1SSs5aRyqm6Kp+BNZS0HirTPq/FfKNo39JLOz9hlV0fVisF
         0pE49+9Icqa7YWXNH/nRa+Df36k0J9W5Oc9TEODEsbQt3ICuQMGxPeMKfh1G2nfDcx
         BMgA0toHsVJI7SkS6bZI2LrxHnXIo/3kzBoBS4G7XGqsffaqJuwrwjGVJ4QADUb85a
         pBiJ1GKEFO0iIx9ZsYooGLo34TTYcOxFUARzykTtcLW9aODhKbEfGNdwv1QZaunK+S
         jv6fsswe8B0ZyY/90FdXEnjyS7E4/W7HCpMhp9N+Z+KAgL97rgLD2buT2P4q249gPv
         OqcZPmlsJKjxw==
Received: by mail-vk1-f175.google.com with SMTP id w128so8959288vkd.3;
        Mon, 21 Mar 2022 20:29:25 -0700 (PDT)
X-Gm-Message-State: AOAM533GglCjEYPOBXbScQU4rJzXky0fq0T1zousupUqgA+LuyOfhhFw
        vjzomemkgrqkRhLn+EmTqA3IyPQYgJ1i54j5l+s=
X-Google-Smtp-Source: ABdhPJzlVjzSkexS3Jmw/nlLWOIlE6PbraqyMcSMooBy6h5NQ0jNR3Wgsf3Qz5imTUEKnnD6cwO7KVVG5CCcYNGypUQ=
X-Received: by 2002:a1f:fc87:0:b0:33f:5e3e:921b with SMTP id
 a129-20020a1ffc87000000b0033f5e3e921bmr339152vki.2.1647919764384; Mon, 21 Mar
 2022 20:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232600.20419-1-palmer@rivosinc.com> <20220316232600.20419-4-palmer@rivosinc.com>
 <YjjuOZMzQlnqfLDJ@antec>
In-Reply-To: <YjjuOZMzQlnqfLDJ@antec>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 22 Mar 2022 11:29:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
Message-ID: <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
Subject: Re: [PATCH 3/5] openrisc: Move to ticket-spinlock
To:     Stafford Horne <shorne@gmail.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 7:23 AM Stafford Horne <shorne@gmail.com> wrote:
>
> On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > We have no indications that openrisc meets the qspinlock requirements,
> > so move to ticket-spinlock as that is more likey to be correct.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > ---
> >
> > I have specifically not included Peter's SOB on this, as he sent his
> > original patch
> > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> > without one.
> > ---
> >  arch/openrisc/Kconfig                      | 1 -
> >  arch/openrisc/include/asm/Kbuild           | 5 ++---
> >  arch/openrisc/include/asm/spinlock.h       | 3 +--
> >  arch/openrisc/include/asm/spinlock_types.h | 2 +-
> >  4 files changed, 4 insertions(+), 7 deletions(-)
>
> Hello,
>
> This series breaks SMP support on OpenRISC.  I haven't traced it down yet, it
> seems trivial but I have a few places to check.
>
> I replied to this on a kbuild warning thread, but also going to reply here with
> more information.
>
>  https://lore.kernel.org/lkml/YjeY7CfaFKjr8IUc@antec/#R
>
> So far this is what I see:
>
>   * ticket_lock is stuck trying to lock console_sem
>   * it is stuck on atomic_cond_read_acquire
>     reading lock value: returns 0    (*lock is 0x10000)
>     ticket value: is 1
>   * possible issues:
>     - OpenRISC is big endian, that seems to impact ticket_unlock, it looks
All csky & riscv are little-endian, it seems the series has a bug with
big-endian. Is that all right for qemu? (If qemu was all right, but
real hardware failed.)

>       like we are failing on the first call to ticket_lock though
>
> Backtrace:
>     (gdb) target remote :10001
>     Remote debugging using :10001
>     ticket_lock (lock=0xc049e078 <console_sem>) at include/asm-generic/ticket-lock.h:39
>     39              atomic_cond_read_acquire(lock, ticket == (u16)VAL);
>     (gdb) bt
>     #0  ticket_lock (lock=0xc049e078 <console_sem>) at include/asm-generic/ticket-lock.h:39
>     #1  do_raw_spin_lock (lock=0xc049e078 <console_sem>) at include/linux/spinlock.h:185
>     #2  __raw_spin_lock_irqsave (lock=0xc049e078 <console_sem>) at include/linux/spinlock_api_smp.h:111
>     #3  _raw_spin_lock_irqsave (lock=0xc049e078 <console_sem>) at kernel/locking/spinlock.c:162
>     Backtrace stopped: Cannot access memory at address 0xc0491ee8
>
> Code:
>
>     31      static __always_inline void ticket_lock(arch_spinlock_t *lock)
>     32      {
>     33              u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
>     34              u16 ticket = val >> 16;
>     35
>     36              if (ticket == (u16)val)
>     37                      return;
>     38
>     39              atomic_cond_read_acquire(lock, ticket == (u16)VAL); <--- stuck here
>     40      }
>
> Assembly:
>
>     c04232ac <_raw_spin_lock_irqsave>:
>     c04232ac:       9c 21 ff f0     l.addi r1,r1,-16
>     c04232b0:       d4 01 10 08     l.sw 8(r1),r2
>     c04232b4:       9c 41 00 10     l.addi r2,r1,16
>     c04232b8:       d4 01 80 00     l.sw 0(r1),r16
>     c04232bc:       d4 01 90 04     l.sw 4(r1),r18
>     c04232c0:       d4 01 48 0c     l.sw 12(r1),r9
>     c04232c4:       07 ef 8b 35     l.jal c0005f98 <arch_local_save_flags>
>     c04232c8:       e2 03 18 04     l.or r16,r3,r3
>     c04232cc:       18 60 00 00     l.movhi r3,0x0
>     c04232d0:       07 ef 8b 3c     l.jal c0005fc0 <arch_local_irq_restore>
>     c04232d4:       e2 4b 58 04     l.or r18,r11,r11
>     c04232d8:       1a 60 00 01     l.movhi r19,0x1
> atomic_fetch_add:
>     c04232dc:       6e 30 00 00     l.lwa r17,0(r16)
>     c04232e0:       e2 31 98 00     l.add r17,r17,r19
>     c04232e4:       cc 10 88 00     l.swa 0(r16),r17
>     c04232e8:       0f ff ff fd     l.bnf c04232dc <_raw_spin_lock_irqsave+0x30>
>     c04232ec:       15 00 00 00      l.nop 0x0
> u16 ticket = val >> 16;
>     c04232f0:       ba 71 00 50     l.srli r19,r17,0x10
>     c04232f4:       a6 31 ff ff     l.andi r17,r17,0xffff
>     c04232f8:       e4 13 88 00     l.sfeq r19,r17
>     c04232fc:       10 00 00 0e     l.bf c0423334 <_raw_spin_lock_irqsave+0x88>
>     c0423300:       e1 72 90 04      l.or r11,r18,r18
> if (ticket == (u16)val):
>     c0423304:       86 30 00 00     l.lwz r17,0(r16)
>     c0423308:       a6 31 ff ff     l.andi r17,r17,0xffff
>     c042330c:       e4 11 98 00     l.sfeq r17,r19
>     c0423310:       10 00 00 07     l.bf c042332c <_raw_spin_lock_irqsave+0x80>
>     c0423314:       15 00 00 00      l.nop 0x0
> atomic_cond_read_acquire:
>     c0423318:       86 30 00 00     l.lwz r17,0(r16)
>     c042331c:       a6 31 ff ff     l.andi r17,r17,0xffff
>     c0423320:       e4 33 88 00     l.sfne r19,r17
>     c0423324:       13 ff ff fd     l.bf c0423318 <_raw_spin_lock_irqsave+0x6c>
>     c0423328:       15 00 00 00      l.nop 0x0
>     c042332c:       22 00 00 00     l.msync
>     c0423330:       e1 72 90 04     l.or r11,r18,r18
>     c0423334:       86 01 00 00     l.lwz r16,0(r1)
>     c0423338:       86 41 00 04     l.lwz r18,4(r1)
>     c042333c:       84 41 00 08     l.lwz r2,8(r1)
>     c0423340:       85 21 00 0c     l.lwz r9,12(r1)
>     c0423344:       44 00 48 00     l.jr r9
>     c0423348:       9c 21 00 10     l.addi r1,r1,16
>
>
> -Stafford
>
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index f724b3f1aeed..f5fa226362f6 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -30,7 +30,6 @@ config OPENRISC
> >       select HAVE_DEBUG_STACKOVERFLOW
> >       select OR1K_PIC
> >       select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> > -     select ARCH_USE_QUEUED_SPINLOCKS
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select OMPIC if SMP
> >       select ARCH_WANT_FRAME_POINTERS
> > diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> > index ca5987e11053..cb260e7d73db 100644
> > --- a/arch/openrisc/include/asm/Kbuild
> > +++ b/arch/openrisc/include/asm/Kbuild
> > @@ -1,9 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  generic-y += extable.h
> >  generic-y += kvm_para.h
> > -generic-y += mcs_spinlock.h
> > -generic-y += qspinlock_types.h
> > -generic-y += qspinlock.h
> > +generic-y += ticket-lock.h
> > +generic-y += ticket-lock-types.h
> >  generic-y += qrwlock_types.h
> >  generic-y += qrwlock.h
> >  generic-y += user.h
> > diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
> > index 264944a71535..40e4c9fdc349 100644
> > --- a/arch/openrisc/include/asm/spinlock.h
> > +++ b/arch/openrisc/include/asm/spinlock.h
> > @@ -15,8 +15,7 @@
> >  #ifndef __ASM_OPENRISC_SPINLOCK_H
> >  #define __ASM_OPENRISC_SPINLOCK_H
> >
> > -#include <asm/qspinlock.h>
> > -
> > +#include <asm/ticket-lock.h>
> >  #include <asm/qrwlock.h>
> >
> >  #define arch_spin_relax(lock)        cpu_relax()
> > diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
> > index 7c6fb1208c88..58ea31fa65ce 100644
> > --- a/arch/openrisc/include/asm/spinlock_types.h
> > +++ b/arch/openrisc/include/asm/spinlock_types.h
> > @@ -1,7 +1,7 @@
> >  #ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
> >  #define _ASM_OPENRISC_SPINLOCK_TYPES_H
> >
> > -#include <asm/qspinlock_types.h>
> > +#include <asm/ticket-lock-types.h>
> >  #include <asm/qrwlock_types.h>
> >
> >  #endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
> > --
> > 2.34.1
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
