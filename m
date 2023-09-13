Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3179F2E0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjIMU3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjIMU3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 16:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D3651BC8
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694636935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWfSi/Oh0HZxZDE9tCJBSd53XsFmWhDfyXRPjUbLnKo=;
        b=PK9oHqXF3eHztpEjbMY+PxnYGmInUR17kATRJFHUa/YLjfe9Kv2V46oIPg9YLtBbAqmfNh
        DMYDa1jyX/MRFYIAJZbsbjtmJp+1uvtYLqEAkeNdFJPUWKFg2/gwcSUN8m19bXT65WjiNC
        3Z/5tb9rjaiRroXcOxyQqZrMBq9kBzA=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-xm1JM0BGN7GtYwf5N8Ufrw-1; Wed, 13 Sep 2023 16:28:54 -0400
X-MC-Unique: xm1JM0BGN7GtYwf5N8Ufrw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d55b99f7e8so1698115fac.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 13:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694636933; x=1695241733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWfSi/Oh0HZxZDE9tCJBSd53XsFmWhDfyXRPjUbLnKo=;
        b=W8q+eZNItyvX/LtS8dlUL08RssaA6/dngfIf8LX9fTBckWEmBcOQxvMwnEKq6BkjtF
         qWBBRIeMroDfiZe/03J5FuoMj8neMoem9flRNduVRR+sy2XvYgVYG/WBdm+f3sExIZLP
         yQ7KudSmHIiwIVRqoaknoRcdgAKgm4uzrhiYMJM8bxOZtxwFn0DIFMA/ndrbLsddjCP0
         B5oheLQ38l83WQxqWRTXEn3RFoul6U4sGQ5ZD6wOkKfA//Fu0k0xaMH0Qp+1uE6WdSWZ
         BUZNAPIA9fcua+F1yGFGBeqU2EMs+oQgrhgrviNomMrcRGi1c0WkJ6maGFu4VWKo65ef
         K3CQ==
X-Gm-Message-State: AOJu0Yxut4Q+lcnzbaVBeN40KLWNRV0npFbl2uj7gRi1L2zjQ5zWP0sw
        grBjP3qh2iEKvxM5ruahBETL7i/lDF+8h+JUNAWjMYtBbu3VHQFMep/yXfVAmY9bOAFn97xE45Z
        C0dPg4YH7gNhE7Snqx2sIdsbl6d5law==
X-Received: by 2002:a05:6870:d58e:b0:1a6:cfcc:befd with SMTP id u14-20020a056870d58e00b001a6cfccbefdmr2460131oao.5.1694636933262;
        Wed, 13 Sep 2023 13:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEosvqU1OmLV+VJSPzBQB9wJjlW4Hu8XnlJnqgJRY8LGsur+q00iHnUVagueksTtX/wtOrk+g==
X-Received: by 2002:a05:6870:d58e:b0:1a6:cfcc:befd with SMTP id u14-20020a056870d58e00b001a6cfccbefdmr2460120oao.5.1694636932964;
        Wed, 13 Sep 2023 13:28:52 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id ee23-20020a056870c81700b001cd20f30898sm52574oab.24.2023.09.13.13.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 13:28:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:28:42 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     guoren@kernel.org
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
Message-ID: <ZQIbejhIev5tx6vl@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-6-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-6-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 04:28:59AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The requirements of qspinlock have been documented by commit:
> a8ad07e5240c ("asm-generic: qspinlock: Indicate the use of mixed-size
> atomics").
> 
> Although RISC-V ISA gives out a weaker forward guarantee LR/SC, which
> doesn't satisfy the requirements of qspinlock above, it won't prevent
> some riscv vendors from implementing a strong fwd guarantee LR/SC in
> microarchitecture to match xchg_tail requirement. T-HEAD C9xx processor
> is the one.
> 
> We've tested the patch on SOPHGO sg2042 & th1520 and passed the stress
> test on Fedora & Ubuntu & OpenEuler ... Here is the performance
> comparison between qspinlock and ticket_lock on sg2042 (64 cores):
> 
> sysbench test=threads threads=32 yields=100 lock=8 (+13.8%):
>   queued_spinlock 0.5109/0.00
>   ticket_spinlock 0.5814/0.00
> 
> perf futex/hash (+6.7%):
>   queued_spinlock 1444393 operations/sec (+- 0.09%)
>   ticket_spinlock 1353215 operations/sec (+- 0.15%)
> 
> perf futex/wake-parallel (+8.6%):
>   queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
>   ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)
> 
> perf futex/requeue (+4.2%):
>   queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
>   ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)
> 
> System Benchmarks (+6.4%)
>   queued_spinlock:
>     System Benchmarks Index Values               BASELINE       RESULT    INDEX
>     Dhrystone 2 using register variables         116700.0  628613745.4  53865.8
>     Double-Precision Whetstone                       55.0     182422.8  33167.8
>     Execl Throughput                                 43.0      13116.6   3050.4
>     File Copy 1024 bufsize 2000 maxblocks          3960.0    7762306.2  19601.8
>     File Copy 256 bufsize 500 maxblocks            1655.0    3417556.8  20649.9
>     File Copy 4096 bufsize 8000 maxblocks          5800.0    7427995.7  12806.9
>     Pipe Throughput                               12440.0   23058600.5  18535.9
>     Pipe-based Context Switching                   4000.0    2835617.7   7089.0
>     Process Creation                                126.0      12537.3    995.0
>     Shell Scripts (1 concurrent)                     42.4      57057.4  13456.9
>     Shell Scripts (8 concurrent)                      6.0       7367.1  12278.5
>     System Call Overhead                          15000.0   33308301.3  22205.5
>                                                                        ========
>     System Benchmarks Index Score                                       12426.1
> 
>   ticket_spinlock:
>     System Benchmarks Index Values               BASELINE       RESULT    INDEX
>     Dhrystone 2 using register variables         116700.0  626541701.9  53688.2
>     Double-Precision Whetstone                       55.0     181921.0  33076.5
>     Execl Throughput                                 43.0      12625.1   2936.1
>     File Copy 1024 bufsize 2000 maxblocks          3960.0    6553792.9  16550.0
>     File Copy 256 bufsize 500 maxblocks            1655.0    3189231.6  19270.3
>     File Copy 4096 bufsize 8000 maxblocks          5800.0    7221277.0  12450.5
>     Pipe Throughput                               12440.0   20594018.7  16554.7
>     Pipe-based Context Switching                   4000.0    2571117.7   6427.8
>     Process Creation                                126.0      10798.4    857.0
>     Shell Scripts (1 concurrent)                     42.4      57227.5  13497.1
>     Shell Scripts (8 concurrent)                      6.0       7329.2  12215.3
>     System Call Overhead                          15000.0   30766778.4  20511.2
>                                                                        ========
>     System Benchmarks Index Score                                       11670.7
> 
> The qspinlock has a significant improvement on SOPHGO SG2042 64
> cores platform than the ticket_lock.
> 
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/Kconfig                | 16 ++++++++++++++++
>  arch/riscv/include/asm/Kbuild     |  3 ++-
>  arch/riscv/include/asm/spinlock.h | 17 +++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/spinlock.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2c346fe169c1..7f39bfc75744 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -471,6 +471,22 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> +choice
> +	prompt "RISC-V spinlock type"
> +	default RISCV_TICKET_SPINLOCKS
> +
> +config RISCV_TICKET_SPINLOCKS
> +	bool "Using ticket spinlock"
> +
> +config RISCV_QUEUED_SPINLOCKS
> +	bool "Using queued spinlock"
> +	depends on SMP && MMU
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
> +	  Otherwise, stay at ticket-lock.
> +endchoice
> +
>  config RISCV_ALTERNATIVE
>  	bool
>  	depends on !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 504f8b7e72d4..a0dc85e4a754 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -2,10 +2,11 @@
>  generic-y += early_ioremap.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> +generic-y += mcs_spinlock.h
>  generic-y += parport.h
> -generic-y += spinlock.h

IIUC here you take the asm-generic/spinlock.h (which defines arch_spin_*()) 
and include the asm-generic headers of mcs_spinlock and qspinlock. 

In this case, the qspinlock.h will provide the arch_spin_*() interfaces, 
which seems the oposite of the above description (ticket spinlocks being 
the standard).

Shouldn't ticket-spinlock.h also get included here?
(Also, I am probably missing something, as I dont' see the use of 
mcs_spinlock here.)

>  generic-y += spinlock_types.h
>  generic-y += qrwlock.h
>  generic-y += qrwlock_types.h
> +generic-y += qspinlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..c644a92d4548
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#define _Q_PENDING_LOOPS	(1 << 9)
> +#endif

Any reason the above define couldn't be merged on the ifdef below?

> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +#else
> +#include <asm-generic/spinlock.h>
> +#endif
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */
> -- 
> 2.36.1
> 

Thanks!
Leo

