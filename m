Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB287A5948
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 07:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjISFVb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISFVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 01:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F1100
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695100841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yNKPxmsPCL5ZqRqn6QofYHN+lqEoZ/fz5W5giSNC8A=;
        b=L+fiw/FKkBBf6dHxOxfW2PCeBPs8Xtt0GwDL/8hrIfQNuOIdMCAjTAWxnl+61H1aNiqNAB
        NJKaf4BQ7WLbPrsn2W2i+gm3/4tqdhlyu1UQoOiW3NSaFxJBmdhXgrJZYRu6XwgMzzDq9w
        9zkURPota1OsnuYHbiXEJNlYSpXYDf4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-zU68rHTGPL2mB1OsuleJJw-1; Tue, 19 Sep 2023 01:20:36 -0400
X-MC-Unique: zU68rHTGPL2mB1OsuleJJw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-55e16833517so7081342eaf.1
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 22:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695100835; x=1695705635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yNKPxmsPCL5ZqRqn6QofYHN+lqEoZ/fz5W5giSNC8A=;
        b=uLf7WjxcD/jeVPLSypjP8h+u1UMegLJhCLOnbrDokNTPNQyknaGr0sEvDzyOiWsgW2
         FE253wox7Wbsl9h1zJte8yyzDu2rzzSe2nu02KAIAvBw1X51xWhq/MrR7zmvXaCWhsJQ
         McnGMWeqjGNieO80ieVPAIddmWj9bmAb0niURdHbE8w8RWBaLYBkv/6d5j8sn1yvOV+C
         KwQ+dRKd/x5QEy86499gE+TJLorxdfWa9EIEwP0QKnhO9qI9yDwnjNAXXpntCfUpZw39
         AlmjrwL267uLT0CrYH2jfCSajUU1f8LgNPet3jR5c6GdP9Q+AQV7+YSXJMThN9x293db
         8GLw==
X-Gm-Message-State: AOJu0Yzxsrod7fVH37IlC2VTP62DcfTAVKx75LkHjgFflq4mFjGlMLKI
        7vZ42Trjp7BUPGMLpREdkM6C7KLF3tb1VXyC9OwfMLuYLkF5IQrpz7xPuzX5OfHRV30H31XkedP
        eoV7QdwwkmGvCt6bnPTrcmw==
X-Received: by 2002:a4a:2a14:0:b0:576:8bd8:9ab5 with SMTP id k20-20020a4a2a14000000b005768bd89ab5mr11719450oof.1.1695100835321;
        Mon, 18 Sep 2023 22:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyZiDIY8DWM8wmhxxSRadT5FLG918rWzNwRvzpvTFyy8RUOuciOkWDguCBKKGUuOdXuJNGTw==
X-Received: by 2002:a4a:2a14:0:b0:576:8bd8:9ab5 with SMTP id k20-20020a4a2a14000000b005768bd89ab5mr11719421oof.1.1695100835016;
        Mon, 18 Sep 2023 22:20:35 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:677d:42e9:f426:9422:f020])
        by smtp.gmail.com with ESMTPSA id z196-20020a4a49cd000000b005768a6a19f9sm5348310ooa.2.2023.09.18.22.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:20:34 -0700 (PDT)
Date:   Tue, 19 Sep 2023 02:20:24 -0300
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
Message-ID: <ZQkvmMXECwEGxGKv@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-6-guoren@kernel.org>
 <ZQIbejhIev5tx6vl@redhat.com>
 <CAJF2gTSdjgUaUqhkfTPmJg6Mph+8Ej4j8MeDmfBOmFY5gkTpBQ@mail.gmail.com>
 <ZQLVqoCGJ1ExMU3e@redhat.com>
 <CAJF2gTQWUCLOpKMQsybMoJdZrso2FEbBRVYV+2U1veFC=7U8_A@mail.gmail.com>
 <ZQQe9Fa4IPGDF0_f@redhat.com>
 <CAJF2gTTad6HCeE3rpd8+Gr0t9+Ay_4kt3pSjSAE0DaRjM4fJsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTad6HCeE3rpd8+Gr0t9+Ay_4kt3pSjSAE0DaRjM4fJsA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 17, 2023 at 11:02:47PM +0800, Guo Ren wrote:
> On Fri, Sep 15, 2023 at 5:08 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 10:10:25AM +0800, Guo Ren wrote:
> > > On Thu, Sep 14, 2023 at 5:43 PM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 14, 2023 at 12:46:56PM +0800, Guo Ren wrote:
> > > > > On Thu, Sep 14, 2023 at 4:29 AM Leonardo Bras <leobras@redhat.com> wrote:
> > > > > >
> > > > > > On Sun, Sep 10, 2023 at 04:28:59AM -0400, guoren@kernel.org wrote:
> > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > >
> > > > > > > The requirements of qspinlock have been documented by commit:
> > > > > > > a8ad07e5240c ("asm-generic: qspinlock: Indicate the use of mixed-size
> > > > > > > atomics").
> > > > > > >
> > > > > > > Although RISC-V ISA gives out a weaker forward guarantee LR/SC, which
> > > > > > > doesn't satisfy the requirements of qspinlock above, it won't prevent
> > > > > > > some riscv vendors from implementing a strong fwd guarantee LR/SC in
> > > > > > > microarchitecture to match xchg_tail requirement. T-HEAD C9xx processor
> > > > > > > is the one.
> > > > > > >
> > > > > > > We've tested the patch on SOPHGO sg2042 & th1520 and passed the stress
> > > > > > > test on Fedora & Ubuntu & OpenEuler ... Here is the performance
> > > > > > > comparison between qspinlock and ticket_lock on sg2042 (64 cores):
> > > > > > >
> > > > > > > sysbench test=threads threads=32 yields=100 lock=8 (+13.8%):
> > > > > > >   queued_spinlock 0.5109/0.00
> > > > > > >   ticket_spinlock 0.5814/0.00
> > > > > > >
> > > > > > > perf futex/hash (+6.7%):
> > > > > > >   queued_spinlock 1444393 operations/sec (+- 0.09%)
> > > > > > >   ticket_spinlock 1353215 operations/sec (+- 0.15%)
> > > > > > >
> > > > > > > perf futex/wake-parallel (+8.6%):
> > > > > > >   queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
> > > > > > >   ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)
> > > > > > >
> > > > > > > perf futex/requeue (+4.2%):
> > > > > > >   queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
> > > > > > >   ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)
> > > > > > >
> > > > > > > System Benchmarks (+6.4%)
> > > > > > >   queued_spinlock:
> > > > > > >     System Benchmarks Index Values               BASELINE       RESULT    INDEX
> > > > > > >     Dhrystone 2 using register variables         116700.0  628613745.4  53865.8
> > > > > > >     Double-Precision Whetstone                       55.0     182422.8  33167.8
> > > > > > >     Execl Throughput                                 43.0      13116.6   3050.4
> > > > > > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    7762306.2  19601.8
> > > > > > >     File Copy 256 bufsize 500 maxblocks            1655.0    3417556.8  20649.9
> > > > > > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    7427995.7  12806.9
> > > > > > >     Pipe Throughput                               12440.0   23058600.5  18535.9
> > > > > > >     Pipe-based Context Switching                   4000.0    2835617.7   7089.0
> > > > > > >     Process Creation                                126.0      12537.3    995.0
> > > > > > >     Shell Scripts (1 concurrent)                     42.4      57057.4  13456.9
> > > > > > >     Shell Scripts (8 concurrent)                      6.0       7367.1  12278.5
> > > > > > >     System Call Overhead                          15000.0   33308301.3  22205.5
> > > > > > >                                                                        ========
> > > > > > >     System Benchmarks Index Score                                       12426.1
> > > > > > >
> > > > > > >   ticket_spinlock:
> > > > > > >     System Benchmarks Index Values               BASELINE       RESULT    INDEX
> > > > > > >     Dhrystone 2 using register variables         116700.0  626541701.9  53688.2
> > > > > > >     Double-Precision Whetstone                       55.0     181921.0  33076.5
> > > > > > >     Execl Throughput                                 43.0      12625.1   2936.1
> > > > > > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    6553792.9  16550.0
> > > > > > >     File Copy 256 bufsize 500 maxblocks            1655.0    3189231.6  19270.3
> > > > > > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    7221277.0  12450.5
> > > > > > >     Pipe Throughput                               12440.0   20594018.7  16554.7
> > > > > > >     Pipe-based Context Switching                   4000.0    2571117.7   6427.8
> > > > > > >     Process Creation                                126.0      10798.4    857.0
> > > > > > >     Shell Scripts (1 concurrent)                     42.4      57227.5  13497.1
> > > > > > >     Shell Scripts (8 concurrent)                      6.0       7329.2  12215.3
> > > > > > >     System Call Overhead                          15000.0   30766778.4  20511.2
> > > > > > >                                                                        ========
> > > > > > >     System Benchmarks Index Score                                       11670.7
> > > > > > >
> > > > > > > The qspinlock has a significant improvement on SOPHGO SG2042 64
> > > > > > > cores platform than the ticket_lock.
> > > > > > >
> > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  arch/riscv/Kconfig                | 16 ++++++++++++++++
> > > > > > >  arch/riscv/include/asm/Kbuild     |  3 ++-
> > > > > > >  arch/riscv/include/asm/spinlock.h | 17 +++++++++++++++++
> > > > > > >  3 files changed, 35 insertions(+), 1 deletion(-)
> > > > > > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > > > > > >
> > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > index 2c346fe169c1..7f39bfc75744 100644
> > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > @@ -471,6 +471,22 @@ config NODES_SHIFT
> > > > > > >         Specify the maximum number of NUMA Nodes available on the target
> > > > > > >         system.  Increases memory reserved to accommodate various tables.
> > > > > > >
> > > > > > > +choice
> > > > > > > +     prompt "RISC-V spinlock type"
> > > > > > > +     default RISCV_TICKET_SPINLOCKS
> > > > > > > +
> > > > > > > +config RISCV_TICKET_SPINLOCKS
> > > > > > > +     bool "Using ticket spinlock"
> > > > > > > +
> > > > > > > +config RISCV_QUEUED_SPINLOCKS
> > > > > > > +     bool "Using queued spinlock"
> > > > > > > +     depends on SMP && MMU
> > > > > > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > > > > > +     help
> > > > > > > +       Make sure your micro arch LL/SC has a strong forward progress guarantee.
> > > > > > > +       Otherwise, stay at ticket-lock.
> > > > > > > +endchoice
> > > > > > > +
> > > > > > >  config RISCV_ALTERNATIVE
> > > > > > >       bool
> > > > > > >       depends on !XIP_KERNEL
> > > > > > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > > > > > > index 504f8b7e72d4..a0dc85e4a754 100644
> > > > > > > --- a/arch/riscv/include/asm/Kbuild
> > > > > > > +++ b/arch/riscv/include/asm/Kbuild
> > > > > > > @@ -2,10 +2,11 @@
> > > > > > >  generic-y += early_ioremap.h
> > > > > > >  generic-y += flat.h
> > > > > > >  generic-y += kvm_para.h
> > > > > > > +generic-y += mcs_spinlock.h
> > > > > > >  generic-y += parport.h
> > > > > > > -generic-y += spinlock.h
> > > > > >
> > > > > > IIUC here you take the asm-generic/spinlock.h (which defines arch_spin_*())
> > > > > > and include the asm-generic headers of mcs_spinlock and qspinlock.
> > > > > >
> > > > > > In this case, the qspinlock.h will provide the arch_spin_*() interfaces,
> > > > > > which seems the oposite of the above description (ticket spinlocks being
> > > > > > the standard).
> > > > > >
> > > > > > Shouldn't ticket-spinlock.h also get included here?
> > > > > > (Also, I am probably missing something, as I dont' see the use of
> > > > > > mcs_spinlock here.)
> > > > > No, because asm-generic/spinlock.h:
> > > > > ...
> > > > > #include <asm-generic/ticket_spinlock.h>
> > > > > ...
> > > > >
> > > >
> > > > But aren't you removing asm-generic/spinlock.h below ?
> > > > -generic-y += spinlock.h
> > > Yes, current is:
> > >
> > > arch/riscv/include/asm/spinlock.h -> include/asm-generic/spinlock.h ->
> > > include/asm-generic/ticket_spinlock.h
> >
> > I did a little reading on how generic-y works (which I was unaware):
> >
> > "If an architecture uses a verbatim copy of a header from
> > include/asm-generic then this is listed in the file
> > arch/$(SRCARCH)/include/asm/Kbuild [...] During the prepare phase of the
> > build a wrapper include file is generated in the directory [...]"
> >
> > Oh, so you are removing the asm-generic/spinlock.h because it's link
> > was replaced by a new asm/spinlock.h.
> >
> > You add qspinlock.h to generic-y because it's new in riscv, and add
> > mcs_spinlock.h because it's needed by qspinlock.h.
> >
> > Ok, it makes sense now.
> >
> > Sorry about this noise.
> > I was unaware of how generic-y worked, and (wrongly)
> > assumed it was about including headers automatically in the build.
> >
> >
> > >
> > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > +#include <asm/qspinlock.h>
> > > +#include <asm/qrwlock.h>
> > > +#else
> > > +#include <asm-generic/spinlock.h>
> > > +#endif
> > >
> > > So, you want me:
> > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > +#include <asm/qspinlock.h>
> > > +#else
> > > +#include <asm-generic/ticket_spinlock.h>
> > > +#endif
> > >
> > > +#include <asm/qrwlock.h>
> > >
> > > Right?
> >
> > No, I didn't mean that.
> > I was just worried about the arch_spin_*() interfaces, but they should be
> > fine.
> >
> > BTW, according to kernel doc on generic-y, shouldn't be a better idea to
> > add 'ticket_spinlock.h' to generic-y, and include above as
> > asm/ticket_spinlock.h?
> >
> > Or is generic-y reserved only for stuff which is indirectly included by
> > other headers?
> It's okay to add generic-y for ticket_spinlock.h, and I'm okay with
> the following:
> 
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
> +#else
> +#include <asm/ticket_spinlock.h>
> +#endif
> 
> +#include <asm/qrwlock.h>

It does look more intuitive, so I am glad it works for you :)

FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thanks!
Leo

> 
> >
> > Thanks!
> > Leo
> >
> > >
> > > >
> > > > > >
> > > > > > >  generic-y += spinlock_types.h
> > > > > > >  generic-y += qrwlock.h
> > > > > > >  generic-y += qrwlock_types.h
> > > > > > > +generic-y += qspinlock.h
> > > > > > >  generic-y += user.h
> > > > > > >  generic-y += vmlinux.lds.h
> > > > > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..c644a92d4548
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > > > > @@ -0,0 +1,17 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > +
> > > > > > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > > > > > +#define __ASM_RISCV_SPINLOCK_H
> > > > > > > +
> > > > > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > > > +#define _Q_PENDING_LOOPS     (1 << 9)
> > > > > > > +#endif
> > > > > >
> > > > > > Any reason the above define couldn't be merged on the ifdef below?
> > > > > Easy for the next patch to modify. See Waiman's comment:
> > > > >
> > > > > https://lore.kernel.org/linux-riscv/4cc7113a-0e4e-763a-cba2-7963bcd26c7a@redhat.com/
> > > > >
> > > > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > > > > index c644a92d4548..9eb3ad31e564 100644
> > > > > > --- a/arch/riscv/include/asm/spinlock.h
> > > > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > > > @@ -7,11 +7,94 @@
> > > > > >   #define _Q_PENDING_LOOPS (1 << 9)
> > > > > >   #endif
> > > > > >
> > > > >
> > > > > I see why you separated the _Q_PENDING_LOOPS out.
> > > > >
> > > >
> > > > I see, should be fine then.
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > > > +#include <asm/qspinlock.h>
> > > > > > > +#include <asm/qrwlock.h>
> > > > > > > +#else
> > > > > > > +#include <asm-generic/spinlock.h>
> > > > > > > +#endif
> > > > > > > +
> > > > > > > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > > > > > > --
> > > > > > > 2.36.1
> > > > > > >
> > > > > >
> > > > > > Thanks!
> > > > > > Leo
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards
> > > > >  Guo Ren
> > > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

