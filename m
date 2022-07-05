Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2350A56687B
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiGEKtb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiGEKt1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 06:49:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45F3BC26;
        Tue,  5 Jul 2022 03:49:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu42so15310lfb.0;
        Tue, 05 Jul 2022 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZrVWfoteR5GrzCoHkSriCPMIPEv5ipRG8Y7JTRl1kw=;
        b=Uyp+2DkuYMDKuMOS0vYpIDMbWkzCj7YOT7vGJ8J7ZBJ6xPONJaHE60xQlzZWpd2THc
         2i77jcDW+7EvQOIPfIQ3LJ8Lo5CW75e4wPfrSarkRgLvblivvSmnINSgNUSPKLEGH5Xv
         0xEzoCRin08WOvm6kmRt0LF4zy7+Y2HVD4jHRw3wwEvBLgtdy874Q9Mkg+bBUSM95NSl
         QoV+36qe3uBrZ2+fSsH2RxpHjQ1n5JpfmL2FwAWslwP/UNYunOL4rK3tDF0MqPAKCbum
         +nXvfCIMHOy7k+4s+ugENntMUbQ+3dmO9m5voxelAmsq5scDbga8fIZlFdtTDOdjVjjW
         xf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZrVWfoteR5GrzCoHkSriCPMIPEv5ipRG8Y7JTRl1kw=;
        b=fjw2jD8ZN/GJtdUEiMLYp4uKkO1vrBi6QrcMm311iZQQ0MBd8rPYRZpvLhMS4mKwDG
         iifdDh2L4IsnIRtY/xpigOXGY9mF2yu2FoiuIvXCbhsCnDVQ3SO497NVSPws8yiZZQe2
         /GDSdz3cIOzP52t9+x+t5DFQw2Ox9cyQ28Gz2V/WWasqkNIWSwV8fpdF/etpHEK4Mtz9
         G4ue8nws6V1pS2hsxbZ7FzQzxaWxyT09wMyG+vHGaooIn1uiJWpARaYeGOVSO8/deWax
         vqPOWFVDmHfEEpdHj/n5rz0UN3vo+ge66dbq0IAlm+2Jlcjle81R8ei9F5zCwHaVzChZ
         j7jw==
X-Gm-Message-State: AJIora8j8sU0cTfgzRsnYxdkiOs3IlgLLzGv8BiBfyTUaBhzjMEbhFvf
        +Vgt5Buh0qPj/Ak2z2JZHvJ00+lYSyn3QGut2fo=
X-Google-Smtp-Source: AGRyM1vYTuygFt3JTMn8nW/7T2k8/9hIoI6+Mnjfaa7nq0cDeG+mciiiBVQPotF7kbD4qDeSCrXqjbYsQZ4mZFdz1GE=
X-Received: by 2002:ac2:59cb:0:b0:483:45c3:8cfc with SMTP id
 x11-20020ac259cb000000b0048345c38cfcmr2425134lfn.274.1657018164101; Tue, 05
 Jul 2022 03:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-5-chenhuacai@loongson.cn> <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
 <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com>
 <CAMZfGtXLxPO3jmkKpF7n9Scb=542yrf1taWHZGdPwK-tZsJXgQ@mail.gmail.com>
 <CAK8P3a14VTkTjRNTWsGmwLDuVm=QPL17_VZ8QkcCYnyQzBjXHA@mail.gmail.com>
 <CAMZfGtU0n_-Bq95X+_rZjcyeK3QhKSq2t5HRvx5Kw5+tR9h+oA@mail.gmail.com> <CAK8P3a1K9fmLK=dh8shHX2y=fOYzr02D9Ek9uQri-u_2MsBXdQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1K9fmLK=dh8shHX2y=fOYzr02D9Ek9uQri-u_2MsBXdQ@mail.gmail.com>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Tue, 5 Jul 2022 18:49:11 +0800
Message-ID: <CACWXhKn6QxFB4kYrj_6xxcq5oR_0wnprGiw38pEGSY9wDpSLvg@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 5 Jul 2022 at 16:45, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 5, 2022 at 10:38 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > On Tue, Jul 5, 2022 at 4:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 5, 2022 at 9:51 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > How about including the static key header in the scope of
> > CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP?
>
> That helps a little, but it means we still pay for it on x86 and
> arm64, which are the
> most common architectures.
>

Hi, Arnd,

It seems that arm64 and x86 include static_key.h or jump_label.h in some
more basic header files, otherwise they would not compile successfully
when they including page-flags.h.

In file included from ./arch/arm64/include/asm/lse.h:13,
from ./arch/arm64/include/asm/cmpxchg.h:14,
from ./arch/arm64/include/asm/atomic.h:16,
from ./include/linux/atomic.h:7,
from ./include/asm-generic/bitops/atomic.h:5,
from ./arch/arm64/include/asm/bitops.h:25,
from ./include/linux/bitops.h:33,
from ./include/linux/log2.h:12,
from kernel/bounds.c:13:
./include/linux/jump_label.h:5:2: error: #error "Hi"
5 | #error "Hi"

In file included from ./arch/x86/include/asm/nospec-branch.h:6,
from ./arch/x86/include/asm/paravirt_types.h:40,
from ./arch/x86/include/asm/ptrace.h:97,
from ./arch/x86/include/asm/math_emu.h:5,
from ./arch/x86/include/asm/processor.h:13,
from ./arch/x86/include/asm/cpufeature.h:5,
from ./arch/x86/include/asm/thread_info.h:53,
from ./include/linux/thread_info.h:60,
from ./arch/x86/include/asm/preempt.h:7,
from ./include/linux/preempt.h:78,
from ./include/linux/spinlock.h:55,
from ./include/linux/mmzone.h:8,
from ./include/linux/gfp.h:6,
from ./include/linux/slab.h:15,
from ./include/linux/crypto.h:20,
from arch/x86/kernel/asm-offsets.c:9:
./include/linux/static_key.h:3:2: error: #error "Hi"
#error "Hi"
^~~~~
In file included from ./include/linux/tracepoint-defs.h:12,
from ./arch/x86/include/asm/msr.h:58,
from ./arch/x86/include/asm/processor.h:22,
from ./arch/x86/include/asm/cpufeature.h:5,
from ./arch/x86/include/asm/thread_info.h:53,
from ./include/linux/thread_info.h:60,
from ./arch/x86/include/asm/preempt.h:7,
from ./include/linux/preempt.h:78,
from ./include/linux/spinlock.h:55,
from ./include/linux/mmzone.h:8,
from ./include/linux/gfp.h:6,
from ./include/linux/slab.h:15,
from ./include/linux/crypto.h:20,
from arch/x86/kernel/asm-offsets.c:9:
./include/linux/static_key.h:3:2: error: #error "Hi"
#error "Hi"
^~~~~
In file included from ./include/linux/kasan-enabled.h:5,
from ./include/linux/kasan.h:6,
from ./include/linux/slab.h:140,
from ./include/linux/crypto.h:20,
from arch/x86/kernel/asm-offsets.c:9:
./include/linux/static_key.h:3:2: error: #error "Hi"
#error "Hi"
^~~~~
In file included from ./include/linux/kasan.h:8,
from ./include/linux/slab.h:140,
from ./include/linux/crypto.h:20,
from arch/x86/kernel/asm-offsets.c:9:
./include/linux/static_key.h:3:2: error: #error "Hi"
#error "Hi"
^~~~~
In file included from ./include/linux/context_tracking_state.h:6,
from ./include/linux/hardirq.h:5,
from arch/x86/kernel/asm-offsets.c:12:
./include/linux/static_key.h:3:2: error: #error "Hi"
#error "Hi"
^~~~~
In file included from ./include/linux/vmstat.h:10,
from ./include/linux/mm.h:1771,
from ./include/linux/memcontrol.h:20,
from ./include/linux/swap.h:9,
from ./include/linux/suspend.h:5,
from arch/x86/kernel/asm-offsets.c:13:
./include/linux/static_key.h:3:2: error: #error "Hi"
#error "Hi"

Thanks,
Feiyang

>        Arnd
>
