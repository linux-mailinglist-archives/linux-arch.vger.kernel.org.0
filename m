Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53097A1632
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjIOGeg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 02:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjIOGeg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 02:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78DE42701
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 23:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694759622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6B2vGE/qYo8MCpoCMonhjxP6SK9Wu8X9xpVpnxFZRw=;
        b=Fk9TYlxJet/KVpUlNfPr66nlN9yTYD0AfHD8IEIqv6JOgWECFPOBQVwby/iTzbneXs1iN5
        Pf+3EmnJO3VRQnUsJY6WW4dIpxrM7S9XzrFpP+lAK0NlYPrJLleLbYIZY9qAADs33s1HcJ
        Wb5ze/uHEMJFClRaGfaFhXKI3YJyubI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-rkpreDlbO9WEgx3iZrBxEw-1; Fri, 15 Sep 2023 02:33:39 -0400
X-MC-Unique: rkpreDlbO9WEgx3iZrBxEw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9c82f64b7so1892979a34.3
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 23:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694759618; x=1695364418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6B2vGE/qYo8MCpoCMonhjxP6SK9Wu8X9xpVpnxFZRw=;
        b=pVYlU0WK6owjifBEwvDJjn9x8WgwpWZe1HtrF8XU5zCDBtdl1XK6G8QHLAU6wPjWyK
         yODqRi/oEcInykbvm5MbWch99PfP0XlUTNd/Z3KE2u4ET89nShr56ZLsBxyZS+h7cNk2
         LyMYvPeBDwefEDgdC8ZCSkjG45C8Ug+DOp5VOmNmept0DyWiF51Ci8CBIXqINyCRZQ7k
         1FJrpDQaH5fcYS4ESBjggtheEEwLjmvu/wh9wt09kFtocoTzWyvq9e+mZ3S3QLTpgTRa
         nHjiVV29Z8sC3N7j74xTSDDL4o72JfTYj+EoarMYRTjZaTaYoV8rf+wUe6j/vGm4/fL5
         rLJQ==
X-Gm-Message-State: AOJu0YyG6TYMcQ244nnnbDRLih2JixtLo8F7Fq59gZ29eq7/34Kadpx/
        NzeYEBmbUgSPJ5UBTTDmLYqqC2zHL6A5x8mKiTI+2eUrhV3wCZH/H64FHVOG21K73qatZKqW4QE
        /w1JNI2+POK+UQ/s89k84lg==
X-Received: by 2002:a9d:6c12:0:b0:6bc:f328:696e with SMTP id f18-20020a9d6c12000000b006bcf328696emr645961otq.0.1694759618636;
        Thu, 14 Sep 2023 23:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg2wKTh/3f4h4NZJfBt03fkh0Ht7ue8oylu+n1hmD3VO/kWUY4ohRhbMwCK4nhGQgkzaw/AQ==
X-Received: by 2002:a9d:6c12:0:b0:6bc:f328:696e with SMTP id f18-20020a9d6c12000000b006bcf328696emr645950otq.0.1694759618397;
        Thu, 14 Sep 2023 23:33:38 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id g13-20020a9d618d000000b006b75242d6c3sm1378794otk.38.2023.09.14.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:33:37 -0700 (PDT)
Date:   Fri, 15 Sep 2023 03:33:21 -0300
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
Subject: Re: [PATCH V11 15/17] RISC-V: paravirt: pvqspinlock: Add trace point
 for pv_kick/wait
Message-ID: <ZQP6sby4lnvO0Cad@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-16-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-16-guoren@kernel.org>
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

On Sun, Sep 10, 2023 at 04:29:09AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add trace point for pv_kick/wait, here is the output:
> 
>  entries-in-buffer/entries-written: 33927/33927   #P:12
> 
>                                 _-----=> irqs-off/BH-disabled
>                                / _----=> need-resched
>                               | / _---=> hardirq/softirq
>                               || / _--=> preempt-depth
>                               ||| / _-=> migrate-disable
>                               |||| /     delay
>            TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>               | |         |   |||||     |         |
>              sh-100     [001] d..2.    28.312294: pv_wait: cpu 1 out of wfi
>          <idle>-0       [000] d.h4.    28.322030: pv_kick: cpu 0 kick target cpu 1
>              sh-100     [001] d..2.    30.982631: pv_wait: cpu 1 out of wfi
>          <idle>-0       [000] d.h4.    30.993289: pv_kick: cpu 0 kick target cpu 1
>              sh-100     [002] d..2.    44.987573: pv_wait: cpu 2 out of wfi
>          <idle>-0       [000] d.h4.    44.989000: pv_kick: cpu 0 kick target cpu 2
>          <idle>-0       [003] d.s3.    51.593978: pv_kick: cpu 3 kick target cpu 4
>       rcu_sched-15      [004] d..2.    51.595192: pv_wait: cpu 4 out of wfi
> lock_torture_wr-115     [004] ...2.    52.656482: pv_kick: cpu 4 kick target cpu 2
> lock_torture_wr-113     [002] d..2.    52.659146: pv_wait: cpu 2 out of wfi
> lock_torture_wr-114     [008] d..2.    52.659507: pv_wait: cpu 8 out of wfi
> lock_torture_wr-114     [008] d..2.    52.663503: pv_wait: cpu 8 out of wfi
> lock_torture_wr-113     [002] ...2.    52.666128: pv_kick: cpu 2 kick target cpu 8
> lock_torture_wr-114     [008] d..2.    52.667261: pv_wait: cpu 8 out of wfi
> lock_torture_wr-114     [009] .n.2.    53.141515: pv_kick: cpu 9 kick target cpu 11
> lock_torture_wr-113     [002] d..2.    53.143339: pv_wait: cpu 2 out of wfi
> lock_torture_wr-116     [007] d..2.    53.143412: pv_wait: cpu 7 out of wfi
> lock_torture_wr-118     [000] d..2.    53.143457: pv_wait: cpu 0 out of wfi
> lock_torture_wr-115     [008] d..2.    53.143481: pv_wait: cpu 8 out of wfi
> lock_torture_wr-117     [011] d..2.    53.143522: pv_wait: cpu 11 out of wfi
> lock_torture_wr-117     [011] ...2.    53.143987: pv_kick: cpu 11 kick target cpu 8
> lock_torture_wr-115     [008] ...2.    53.144269: pv_kick: cpu 8 kick target cpu 7
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/qspinlock_paravirt.c        |  8 +++
>  .../kernel/trace_events_filter_paravirt.h     | 60 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 arch/riscv/kernel/trace_events_filter_paravirt.h
> 
> diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
> index 571626f350be..5d298e989b99 100644
> --- a/arch/riscv/kernel/qspinlock_paravirt.c
> +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> @@ -9,10 +9,16 @@
>  #include <asm/qspinlock_paravirt.h>
>  #include <asm/sbi.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include "trace_events_filter_paravirt.h"
> +
>  void pv_kick(int cpu)
>  {
>  	sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
>  		  cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);
> +
> +	trace_pv_kick(smp_processor_id(), cpu);
> +
>  	return;
>  }
>  
> @@ -28,6 +34,8 @@ void pv_wait(u8 *ptr, u8 val)
>  		goto out;
>  
>  	wait_for_interrupt();
> +
> +	trace_pv_wait(smp_processor_id());
>  out:
>  	local_irq_restore(flags);
>  }
> diff --git a/arch/riscv/kernel/trace_events_filter_paravirt.h b/arch/riscv/kernel/trace_events_filter_paravirt.h
> new file mode 100644
> index 000000000000..9ff5aa451b12
> --- /dev/null
> +++ b/arch/riscv/kernel/trace_events_filter_paravirt.h
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c), 2023 Alibaba Cloud
> + * Authors:
> + *	Guo Ren <guoren@linux.alibaba.com>
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM paravirt
> +
> +#if !defined(_TRACE_PARAVIRT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PARAVIRT_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(pv_kick,
> +	TP_PROTO(int cpu, int target),
> +	TP_ARGS(cpu, target),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +		__field(int, target)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->target = target;
> +	),
> +
> +	TP_printk("cpu %d kick target cpu %d",
> +		__entry->cpu,
> +		__entry->target
> +	)
> +);
> +
> +TRACE_EVENT(pv_wait,
> +	TP_PROTO(int cpu),
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +	),
> +
> +	TP_printk("cpu %d out of wfi",
> +		__entry->cpu
> +	)
> +);
> +
> +#endif /* _TRACE_PARAVIRT_H || TRACE_HEADER_MULTI_READ */
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH ../../../arch/riscv/kernel/
> +#define TRACE_INCLUDE_FILE trace_events_filter_paravirt
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 2.36.1
> 

LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thanks!
Leo

