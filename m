Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF89756C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHUIyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 04:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfHUIyc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 04:54:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31AE32F30D9
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 08:54:32 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k8so905186wrx.19
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 01:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+w6S/d4xE8RPcCnUmNNhlmM38FUwU6Cbxaxoa0JXU/s=;
        b=bCoPNTxT2ezFwu7csejuQtfX1d5BnDx8PR75MQI0PxmQlmlmy4ktO9GvuBoc6B8PBx
         Ruwl7LoUTGp15NpBr2UefgLa2YigGKL7T7O4aMrWjmD7skr2ycj7oPXYPUS65NK5G/Ns
         JXVBF+cXFSIkGP+sjQ0Z7GVuKU37quFTd1VBp173QsAmE/ezrcqMVOyCZ13Fjd4MshcV
         dWXZVfkKQ9qsLFvQgHosMVBleeSkBvIkAoHquIdHsyZ1vbZv/dar2VZ8ftfO5rOct2Fz
         55ssL989NqZUsnnpl/YyGj2Yyp1e3xFEdoLsEdKx6XFWepvvGgszm5HZqVr04X4wgVpz
         FX4Q==
X-Gm-Message-State: APjAAAUoQPN6geq27KkHYiJlRAjs6JoqRMYg0FKzv7XFcER96J7+tYRI
        S3Nki6yi3FStAs420X5Y/C/3Sz51Q+8H8Gtmq6zlBP19TfiAb8wRyJdysPPYevfZlGNKTpVtv4F
        /3Apq7HBRGAWRvCeoVCXKBQ==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr4872143wme.174.1566377670688;
        Wed, 21 Aug 2019 01:54:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJvqD1cl28+sp4QHLw+FNqBWCQTObXkxuvx4NlL/0iLvU5iNtqQtOMuGgDZJYc9msHKi9j9A==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr4872098wme.174.1566377670394;
        Wed, 21 Aug 2019 01:54:30 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id m23sm3103680wml.41.2019.08.21.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 01:54:29 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <lantianyu1986@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger kernel org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <87o90jq99w.fsf@vitty.brq.redhat.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net> <87wog1kpib.fsf@vitty.brq.redhat.com> <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com> <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com> <87sgq5a2hq.fsf@vitty.brq.redhat.com> <DM5PR21MB013730EB79A17AF02C170BD7D7AB0@DM5PR21MB0137.namprd21.prod.outlook.com> <87o90jq99w.fsf@vitty.brq.redhat.com>
Date:   Wed, 21 Aug 2019 10:54:28 +0200
Message-ID: <87imqqrj97.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Michael Kelley <mikelley@microsoft.com> writes:
>
>> I talked to KY Srinivasan for any history about TSC page on 32-bit.  He said
>> there was no technical reason not to implement it, but our focus was always
>> 64-bit Linux, so the 32-bit was much less important.  Also, on 32-bit Linux,
>> the required 64x64 multiply and shift is more complex and takes more
>> more cycles (compare 32-bit implementation of mul_u64_u64_shr vs.
>> the 64-bit implementation), so the win over a MSR read is less.  I
>> don't know of any actual measurements being made to compare vs.
>> MSR read.
>
> VMExit is 1000 CPU cycles or so, I would guess that TSC page
> calculations are better. Let me try to build 32bit kernel and do some
> quick measurements.

So I tried and the difference is HUGE.

For in-kernel clocksource reads (like sched_clock()), the testing code
was:

        before = rdtsc_ordered();
        for (i = 0; i < 1000; i++)
             (void)read_hv_sched_clock_msr();
        after = rdtsc_ordered();
        printk("MSR based clocksource: %d cycles\n", ((u32)(after - before))/1000);

        before = rdtsc_ordered();
        for (i = 0; i < 1000; i++)
            (void)read_hv_sched_clock_tsc();
        after = rdtsc_ordered();
        printk("TSC page clocksource: %d cycles\n", ((u32)(after - before))/1000);

The result (WS2016) is:
[    1.101910] MSR based clocksource: 3361 cycles
[    1.105224] TSC page clocksource: 49 cycles

For userspace reads the absolute difference is even bigger as TSC page
gives us functional vDSO:

Testing code:
	before = rdtsc();
	for (i = 0; i < COUNT; i++)
		clock_gettime(CLOCK_REALTIME, &tp);
	after = rdtsc();
	printf("%d\n", (after - before)/COUNT);

Result:

TSC page:
# ./gettime_cycles 
131

MSR:
# ./gettime_cycles 
5664

With all that I see no reason for us to not enable TSC page on 32bit,
even if the number of users is negligible, this will allow us to get rid
of ugly #ifdef CONFIG_HYPERV_TSCPAGE in the code.

I'll send a patch for discussion.

-- 
Vitaly
