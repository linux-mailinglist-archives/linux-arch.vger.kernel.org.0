Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF047A0099
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbjINJpM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjINJpL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 05:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24F82738
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694684599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbbV7zUbHyFOQqG5sX6JcaC8bYUMhWeBa5xwVhmrkEQ=;
        b=J/1bUqSSNalZYXg0xXrOHEPnLvfdhgVOS76mu+A1QjF0w7Xep/l8rVI6FriHHZOH1SOAaO
        rTzMtWx+JNkpnxb0yoxc26xJNbKWCSG7hYyf6P+6PEc4amjCnFjp2dqHFb82ILhcgPwh5Y
        FNkoboUUu747smXSmX2P6AQaGAFc4II=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-WN-PPh6nOq6sCYBiKj2RDg-1; Thu, 14 Sep 2023 05:43:17 -0400
X-MC-Unique: WN-PPh6nOq6sCYBiKj2RDg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c0f110ee3bso867301a34.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 02:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684596; x=1695289396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbbV7zUbHyFOQqG5sX6JcaC8bYUMhWeBa5xwVhmrkEQ=;
        b=CuqJo6jo9zVAPWLRq9jUp/M3Etr8Ajr/v1944c6OiEZMe30hLUMtr9e3o70RdJbFyE
         y6SMuP5sM/iUz8hIN0T2aZaHs640L8VeI9ibszrWJa4lPYgDgkOexDD7UG20MajAHNTR
         tmirKcdbFgv++CFk2BdAYAKsINcU6TqtYgjLeWDumVDci0DLRG/8t/kyjlGxEuKUV2OX
         mdlL2fOJ0Lk25f5etzoal0S1mPCCa2zUNn2jw+Y18SHfpoFuq520fpfB6SgEz410ZNxJ
         3pFjTfrnFQPsLSnmQGBHjGWgeW2bovpvWQDYS3OApU1PeXskuZqnZh9eXbNeVgZiHC4m
         lf8w==
X-Gm-Message-State: AOJu0Yyy2qqIWTcWY9IIRnOWSFIPP2VCCBvcdWf3o+85AmPZfLOL7luY
        C3d+MVDxeGtmqyMoVnkehIx9W5XMPcusKcqCSOct54E9kVxt6/jqWdGbK7l2GikwUk1bnO7Vxd9
        X93OmYBjD9b/caWRPHYW6oQ==
X-Received: by 2002:a9d:6d8e:0:b0:6b9:b0f6:eab8 with SMTP id x14-20020a9d6d8e000000b006b9b0f6eab8mr6134258otp.5.1694684596498;
        Thu, 14 Sep 2023 02:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3QnDlKzJBDRQlqNhyCyRRuZPKH26ygpP6UVo5h9yyQNDkmSeGchz3nt5E9QfIuxm29/peHg==
X-Received: by 2002:a9d:6d8e:0:b0:6b9:b0f6:eab8 with SMTP id x14-20020a9d6d8e000000b006b9b0f6eab8mr6134245otp.5.1694684596151;
        Thu, 14 Sep 2023 02:43:16 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id v22-20020a05683018d600b006b87f593877sm499860ote.37.2023.09.14.02.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:43:15 -0700 (PDT)
Date:   Thu, 14 Sep 2023 06:43:06 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 05/17] riscv: qspinlock: Add basic queued_spinlock
 support
Message-ID: <ZQLVqoCGJ1ExMU3e@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-6-guoren@kernel.org>
 <ZQIbejhIev5tx6vl@redhat.com>
 <CAJF2gTSdjgUaUqhkfTPmJg6Mph+8Ej4j8MeDmfBOmFY5gkTpBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTSdjgUaUqhkfTPmJg6Mph+8Ej4j8MeDmfBOmFY5gkTpBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 12:46:56PM +0800, Guo Ren wrote:
> On Thu, Sep 14, 2023 at 4:29 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Sun, Sep 10, 2023 at 04:28:59AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The requirements of qspinlock have been documented by commit:
> > > a8ad07e5240c ("asm-generic: qspinlock: Indicate the use of mixed-size
> > > atomics").
> > >
> > > Although RISC-V ISA gives out a weaker forward guarantee LR/SC, which
> > > doesn't satisfy the requirements of qspinlock above, it won't prevent
> > > some riscv vendors from implementing a strong fwd guarantee LR/SC in
> > > microarchitecture to match xchg_tail requirement. T-HEAD C9xx processor
> > > is the one.
> > >
> > > We've tested the patch on SOPHGO sg2042 & th1520 and passed the stress
> > > test on Fedora & Ubuntu & OpenEuler ... Here is the performance
> > > comparison between qspinlock and ticket_lock on sg2042 (64 cores):
> > >
> > > sysbench test=threads threads=32 yields=100 lock=8 (+13.8%):
> > >   queued_spinlock 0.5109/0.00
> > >   ticket_spinlock 0.5814/0.00
> > >
> > > perf futex/hash (+6.7%):
> > >   queued_spinlock 1444393 operations/sec (+- 0.09%)
> > >   ticket_spinlock 1353215 operations/sec (+- 0.15%)
> > >
> > > perf futex/wake-parallel (+8.6%):
> > >   queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
> > >   ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)
> > >
> > > perf futex/requeue (+4.2%):
> > >   queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
> > >   ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)
> > >
> > > System Benchmarks (+6.4%)
> > >   queued_spinlock:
> > >     System Benchmarks Index Values               BASELINE       RESULT    INDEX
> > >     Dhrystone 2 using register variables         116700.0  628613745.4  53865.8
> > >     Double-Precision Whetstone                       55.0     182422.8  33167.8
> > >     Execl Throughput                                 43.0      13116.6   3050.4
> > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    7762306.2  19601.8
> > >     File Copy 256 bufsize 500 maxblocks            1655.0    3417556.8  20649.9
> > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    7427995.7  12806.9
> > >     Pipe Throughput                               12440.0   23058600.5  18535.9
> > >     Pipe-based Context Switching                   4000.0    2835617.7   7089.0
> > >     Process Creation                                126.0      12537.3    995.0
> > >     Shell Scripts (1 concurrent)                     42.4      57057.4  13456.9
> > >     Shell Scripts (8 concurrent)                      6.0       7367.1  12278.5
> > >     System Call Overhead                          15000.0   33308301.3  22205.5
> > >                                                                        ========
> > >     System Benchmarks Index Score                                       12426.1
> > >
> > >   ticket_spinlock:
> > >     System Benchmarks Index Values               BASELINE       RESULT    INDEX
> > >     Dhrystone 2 using register variables         116700.0  626541701.9  53688.2
> > >     Double-Precision Whetstone                       55.0     181921.0  33076.5
> > >     Execl Throughput                                 43.0      12625.1   2936.1
> > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    6553792.9  16550.0
> > >     File Copy 256 bufsize 500 maxblocks            1655.0    3189231.6  19270.3
> > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    7221277.0  12450.5
> > >     Pipe Throughput                               12440.0   20594018.7  16554.7
> > >     Pipe-based Context Switching                   4000.0    2571117.7   6427.8
> > >     Process Creation                                126.0      10798.4    857.0
> > >     Shell Scripts (1 concurrent)                     42.4      57227.5  13497.1
> > >     Shell Scripts (8 concurrent)                      6.0       7329.2  12215.3
> > >     System Call Overhead                          15000.0   30766778.4  20511.2
> > >                                                                        ========
> > >     System Benchmarks Index Score                                       11670.7
> > >
> > > The qspinlock has a significant improvement on SOPHGO SG2042 64
> > > cores platform than the ticket_lock.
> > >
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > ---
> > >  arch/riscv/Kconfig                | 16 ++++++++++++++++
> > >  arch/riscv/include/asm/Kbuild     |  3 ++-
> > >  arch/riscv/include/asm/spinlock.h | 17 +++++++++++++++++
> > >  3 files changed, 35 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 2c346fe169c1..7f39bfc75744 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -471,6 +471,22 @@ config NODES_SHIFT
> > >         Specify the maximum number of NUMA Nodes available on the target
> > >         system.  Increases memory reserved to accommodate various tables.
> > >
> > > +choice
> > > +     prompt "RISC-V spinlock type"
> > > +     default RISCV_TICKET_SPINLOCKS
> > > +
> > > +config RISCV_TICKET_SPINLOCKS
> > > +     bool "Using ticket spinlock"
> > > +
> > > +config RISCV_QUEUED_SPINLOCKS
> > > +     bool "Using queued spinlock"
> > > +     depends on SMP && MMU
> > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > +     help
> > > +       Make sure your micro arch LL/SC has a strong forward progress guarantee.
> > > +       Otherwise, stay at ticket-lock.
> > > +endchoice
> > > +
> > >  config RISCV_ALTERNATIVE
> > >       bool
> > >       depends on !XIP_KERNEL
> > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > > index 504f8b7e72d4..a0dc85e4a754 100644
> > > --- a/arch/riscv/include/asm/Kbuild
> > > +++ b/arch/riscv/include/asm/Kbuild
> > > @@ -2,10 +2,11 @@
> > >  generic-y += early_ioremap.h
> > >  generic-y += flat.h
> > >  generic-y += kvm_para.h
> > > +generic-y += mcs_spinlock.h
> > >  generic-y += parport.h
> > > -generic-y += spinlock.h
> >
> > IIUC here you take the asm-generic/spinlock.h (which defines arch_spin_*())
> > and include the asm-generic headers of mcs_spinlock and qspinlock.
> >
> > In this case, the qspinlock.h will provide the arch_spin_*() interfaces,
> > which seems the oposite of the above description (ticket spinlocks being
> > the standard).
> >
> > Shouldn't ticket-spinlock.h also get included here?
> > (Also, I am probably missing something, as I dont' see the use of
> > mcs_spinlock here.)
> No, because asm-generic/spinlock.h:
> ...
> #include <asm-generic/ticket_spinlock.h>
> ...
> 

But aren't you removing asm-generic/spinlock.h below ?
-generic-y += spinlock.h

> >
> > >  generic-y += spinlock_types.h
> > >  generic-y += qrwlock.h
> > >  generic-y += qrwlock_types.h
> > > +generic-y += qspinlock.h
> > >  generic-y += user.h
> > >  generic-y += vmlinux.lds.h
> > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > new file mode 100644
> > > index 000000000000..c644a92d4548
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/spinlock.h
> > > @@ -0,0 +1,17 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > +#define __ASM_RISCV_SPINLOCK_H
> > > +
> > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > +#define _Q_PENDING_LOOPS     (1 << 9)
> > > +#endif
> >
> > Any reason the above define couldn't be merged on the ifdef below?
> Easy for the next patch to modify. See Waiman's comment:
> 
> https://lore.kernel.org/linux-riscv/4cc7113a-0e4e-763a-cba2-7963bcd26c7a@redhat.com/
> 
> > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > index c644a92d4548..9eb3ad31e564 100644
> > --- a/arch/riscv/include/asm/spinlock.h
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -7,11 +7,94 @@
> >   #define _Q_PENDING_LOOPS (1 << 9)
> >   #endif
> >
> 
> I see why you separated the _Q_PENDING_LOOPS out.
> 

I see, should be fine then.

Thanks!
Leo

> 
> >
> > > +
> > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > +#include <asm/qspinlock.h>
> > > +#include <asm/qrwlock.h>
> > > +#else
> > > +#include <asm-generic/spinlock.h>
> > > +#endif
> > > +
> > > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > > --
> > > 2.36.1
> > >
> >
> > Thanks!
> > Leo
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

