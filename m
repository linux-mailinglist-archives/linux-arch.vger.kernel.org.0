Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026AA4E3269
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 22:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiCUVrb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 17:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCUVra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 17:47:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FAD3A0E8B;
        Mon, 21 Mar 2022 14:42:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v75so17716759oie.1;
        Mon, 21 Mar 2022 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yfL5LeF6JfPCL0schiZdmyWW7c787PjB4OtVneDCy3c=;
        b=QhAWgb+/5JdbSBoLdH7esy8uG93AEHe0BHi15RUZLTvr16o/lrpZsqzU/LUwnszd4m
         Gwii0x8PzhQYgztwYNKNwt9mShLBku+glqAY+stlLpvyb/2z2eHokbyVOqWV7fZgcU72
         jh62NsG9ViL9N/GGyLROzk82FLbf+/QmqhOIVYkn33bZY4ZS8z9OjiD0ovmxGTeR6x4a
         Wtq3tvZovdF4bRLgd8yedPRMPGVDD3SO/kJtIjT5Q6IDc3J9dunrMe08+QNM3pX5sTey
         2a994whC/jzsVWPJC6j7bSqBF/87YCr84BiQEDgYY7Dj4QtShmrWYxszHfY/MFB+V/1J
         nvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfL5LeF6JfPCL0schiZdmyWW7c787PjB4OtVneDCy3c=;
        b=DyQjujGOLCkIEIUwSFEaFoPe7meq2mMBSoLR0NB6f7eomMXwuaSwZH80AKhBrrXkO1
         oXCwdN8Hifufvo8ybkuG8rYACrvHlIPHG2Xyt8Nd13iQzupWwuY42Zr3aeClrjvto+Qk
         KTlapepxYYSNYHttHdm8JPUuzl2VpvXJaCRV014C/O0R9OT9J3BWDSgoTEZkH87uZ9Ix
         RD6ULxIveb2xEcHmOIdsR9bewXqAKHvAMA9fcrinNRwyTh3KiBpfWN7DM2E4jQzfk58P
         HScuXBmKLl6aFRqLbcra5HsyP+puI+9olLqepmBilvpFt7ixg5Fko+Vx2D76nVuz0UTx
         s9rA==
X-Gm-Message-State: AOAM531K/jUbvGEwFTINRp87ZR3H5SBqlAwQEpd+9DF5/ZZodcYUHqOo
        Jmpef+oyS+d6qScBiIc7ogG34OQ/V59O3w==
X-Google-Smtp-Source: ABdhPJz6u4FytOk5yk0PMbnP4+YRKP6yRDpS687V5wmoHiqna7r44cXJVLkVo3FJIYxARw+3CpcLsw==
X-Received: by 2002:a17:90b:1d0e:b0:1bf:2a24:2716 with SMTP id on14-20020a17090b1d0e00b001bf2a242716mr1184969pjb.60.1647898173687;
        Mon, 21 Mar 2022 14:29:33 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b001c735089cc2sm341034pjn.54.2022.03.21.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:29:33 -0700 (PDT)
Date:   Tue, 22 Mar 2022 06:29:29 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, peterz@infradead.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/5] openrisc: Move to ticket-spinlock
Message-ID: <YjjuOZMzQlnqfLDJ@antec>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-4-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316232600.20419-4-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> We have no indications that openrisc meets the qspinlock requirements,
> so move to ticket-spinlock as that is more likey to be correct.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> ---
> 
> I have specifically not included Peter's SOB on this, as he sent his
> original patch
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> without one.
> ---
>  arch/openrisc/Kconfig                      | 1 -
>  arch/openrisc/include/asm/Kbuild           | 5 ++---
>  arch/openrisc/include/asm/spinlock.h       | 3 +--
>  arch/openrisc/include/asm/spinlock_types.h | 2 +-
>  4 files changed, 4 insertions(+), 7 deletions(-)

Hello,

This series breaks SMP support on OpenRISC.  I haven't traced it down yet, it
seems trivial but I have a few places to check.

I replied to this on a kbuild warning thread, but also going to reply here with
more information.

 https://lore.kernel.org/lkml/YjeY7CfaFKjr8IUc@antec/#R

So far this is what I see:

  * ticket_lock is stuck trying to lock console_sem
  * it is stuck on atomic_cond_read_acquire
    reading lock value: returns 0    (*lock is 0x10000)
    ticket value: is 1
  * possible issues:
    - OpenRISC is big endian, that seems to impact ticket_unlock, it looks
      like we are failing on the first call to ticket_lock though

Backtrace:
    (gdb) target remote :10001
    Remote debugging using :10001
    ticket_lock (lock=0xc049e078 <console_sem>) at include/asm-generic/ticket-lock.h:39
    39              atomic_cond_read_acquire(lock, ticket == (u16)VAL);
    (gdb) bt
    #0  ticket_lock (lock=0xc049e078 <console_sem>) at include/asm-generic/ticket-lock.h:39
    #1  do_raw_spin_lock (lock=0xc049e078 <console_sem>) at include/linux/spinlock.h:185
    #2  __raw_spin_lock_irqsave (lock=0xc049e078 <console_sem>) at include/linux/spinlock_api_smp.h:111
    #3  _raw_spin_lock_irqsave (lock=0xc049e078 <console_sem>) at kernel/locking/spinlock.c:162
    Backtrace stopped: Cannot access memory at address 0xc0491ee8

Code:

    31      static __always_inline void ticket_lock(arch_spinlock_t *lock)
    32      {
    33              u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
    34              u16 ticket = val >> 16;
    35
    36              if (ticket == (u16)val)
    37                      return;
    38
    39              atomic_cond_read_acquire(lock, ticket == (u16)VAL); <--- stuck here
    40      }

Assembly:

    c04232ac <_raw_spin_lock_irqsave>:
    c04232ac:       9c 21 ff f0     l.addi r1,r1,-16
    c04232b0:       d4 01 10 08     l.sw 8(r1),r2
    c04232b4:       9c 41 00 10     l.addi r2,r1,16
    c04232b8:       d4 01 80 00     l.sw 0(r1),r16
    c04232bc:       d4 01 90 04     l.sw 4(r1),r18
    c04232c0:       d4 01 48 0c     l.sw 12(r1),r9
    c04232c4:       07 ef 8b 35     l.jal c0005f98 <arch_local_save_flags>
    c04232c8:       e2 03 18 04     l.or r16,r3,r3
    c04232cc:       18 60 00 00     l.movhi r3,0x0
    c04232d0:       07 ef 8b 3c     l.jal c0005fc0 <arch_local_irq_restore>
    c04232d4:       e2 4b 58 04     l.or r18,r11,r11
    c04232d8:       1a 60 00 01     l.movhi r19,0x1
atomic_fetch_add:
    c04232dc:       6e 30 00 00     l.lwa r17,0(r16)
    c04232e0:       e2 31 98 00     l.add r17,r17,r19
    c04232e4:       cc 10 88 00     l.swa 0(r16),r17
    c04232e8:       0f ff ff fd     l.bnf c04232dc <_raw_spin_lock_irqsave+0x30>
    c04232ec:       15 00 00 00      l.nop 0x0
u16 ticket = val >> 16;
    c04232f0:       ba 71 00 50     l.srli r19,r17,0x10
    c04232f4:       a6 31 ff ff     l.andi r17,r17,0xffff
    c04232f8:       e4 13 88 00     l.sfeq r19,r17
    c04232fc:       10 00 00 0e     l.bf c0423334 <_raw_spin_lock_irqsave+0x88>
    c0423300:       e1 72 90 04      l.or r11,r18,r18
if (ticket == (u16)val):
    c0423304:       86 30 00 00     l.lwz r17,0(r16)
    c0423308:       a6 31 ff ff     l.andi r17,r17,0xffff
    c042330c:       e4 11 98 00     l.sfeq r17,r19
    c0423310:       10 00 00 07     l.bf c042332c <_raw_spin_lock_irqsave+0x80>
    c0423314:       15 00 00 00      l.nop 0x0
atomic_cond_read_acquire:
    c0423318:       86 30 00 00     l.lwz r17,0(r16)
    c042331c:       a6 31 ff ff     l.andi r17,r17,0xffff
    c0423320:       e4 33 88 00     l.sfne r19,r17
    c0423324:       13 ff ff fd     l.bf c0423318 <_raw_spin_lock_irqsave+0x6c>
    c0423328:       15 00 00 00      l.nop 0x0
    c042332c:       22 00 00 00     l.msync
    c0423330:       e1 72 90 04     l.or r11,r18,r18
    c0423334:       86 01 00 00     l.lwz r16,0(r1)
    c0423338:       86 41 00 04     l.lwz r18,4(r1)
    c042333c:       84 41 00 08     l.lwz r2,8(r1)
    c0423340:       85 21 00 0c     l.lwz r9,12(r1)
    c0423344:       44 00 48 00     l.jr r9
    c0423348:       9c 21 00 10     l.addi r1,r1,16


-Stafford

> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index f724b3f1aeed..f5fa226362f6 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -30,7 +30,6 @@ config OPENRISC
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> -	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select OMPIC if SMP
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index ca5987e11053..cb260e7d73db 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += mcs_spinlock.h
> -generic-y += qspinlock_types.h
> -generic-y += qspinlock.h
> +generic-y += ticket-lock.h
> +generic-y += ticket-lock-types.h
>  generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
> diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
> index 264944a71535..40e4c9fdc349 100644
> --- a/arch/openrisc/include/asm/spinlock.h
> +++ b/arch/openrisc/include/asm/spinlock.h
> @@ -15,8 +15,7 @@
>  #ifndef __ASM_OPENRISC_SPINLOCK_H
>  #define __ASM_OPENRISC_SPINLOCK_H
>  
> -#include <asm/qspinlock.h>
> -
> +#include <asm/ticket-lock.h>
>  #include <asm/qrwlock.h>
>  
>  #define arch_spin_relax(lock)	cpu_relax()
> diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
> index 7c6fb1208c88..58ea31fa65ce 100644
> --- a/arch/openrisc/include/asm/spinlock_types.h
> +++ b/arch/openrisc/include/asm/spinlock_types.h
> @@ -1,7 +1,7 @@
>  #ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
>  #define _ASM_OPENRISC_SPINLOCK_TYPES_H
>  
> -#include <asm/qspinlock_types.h>
> +#include <asm/ticket-lock-types.h>
>  #include <asm/qrwlock_types.h>
>  
>  #endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
> -- 
> 2.34.1
> 
