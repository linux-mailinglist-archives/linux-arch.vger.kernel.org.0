Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82F3EC834
	for <lists+linux-arch@lfdr.de>; Sun, 15 Aug 2021 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhHOI46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Aug 2021 04:56:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47537 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhHOI46 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Aug 2021 04:56:58 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mkn8B-1mwoTt3Xsl-00mKv2 for <linux-arch@vger.kernel.org>; Sun, 15 Aug 2021
 10:56:26 +0200
Received: by mail-wr1-f50.google.com with SMTP id k29so19226038wrd.7
        for <linux-arch@vger.kernel.org>; Sun, 15 Aug 2021 01:56:26 -0700 (PDT)
X-Gm-Message-State: AOAM531Tfrju2oJskTyoTARNwqMqOB1KNqXOMvJRwTOV/+3Bo2vNaFNu
        42bys5rCzGD4JwvIdaHkZrJ1bwVXY7AE3DUlIWg=
X-Google-Smtp-Source: ABdhPJxa92Ev1eM3KBFN/x6/DK+6q/cpuL7KxmsautXVb9NB2GYg+3CeMlkcx2uViVbP0TWhjTISi3DPIEeoetn4amg=
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr12764709wrx.105.1629017786497;
 Sun, 15 Aug 2021 01:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
 <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
 <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com> <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com>
In-Reply-To: <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 15 Aug 2021 10:56:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com>
Message-ID: <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D0KFhKU5P32pIOXgsZXRuDUbFCWnxylonS8Czh2ZqkzIdcme7HM
 A+B4zT02N872klwWGMOyGen/pKriIohWmdeyXkBpsOmLGvMD4OsyVH0MbO1HwqaeXTQCeUW
 I1chBTARfX5td/1kH9aMgVABfBoDMFGzTMvkrinCVLq3OZCDoOhmS0L/lR6mKk5uE1yqWx7
 8XAGtzWYbEEAO5zbHJDSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T1UAIID5yLY=:gCz8BFg+3dQ5T2x/gMSr6c
 RHGAWDtDyDLz+DwiEE5ZisUewlwpL57MgoRPlw9vW0mwQsVLbQWQs/5oJ1QlBDtfRu/8WVd1B
 aVNADmr72Xc3frLjN2sGiKr2OeW6sSR0cB5k0+wIuTFgqTQe4ZT+zXZKrOMkbSObnRLaxr+LY
 gL5ZX+cJkhdFqbAKdWgqI95rNIJ3TcMvsDUQTjuwlRzPPeUgTdYy0nW9Sj0NqlQrrdcrGqfud
 20GP5bGq7ub8qwcxemjmoC+TJolbKR/Ks3rQle+4EZRYpRMkk5kZRGehw+xxugNCnl3cyaPpD
 HL2haPAoNQ1ELMDSxqF1gsAcOQ5jJpc3PgtA7xAChpG0JJ+wZYVG/UXKbUp9giv01iFi2c8Pl
 92y/r7bPp6nfdIc+hzOtZT8PK3Ux+ChO/2y3kTyabBY48Uma0qzHMiknCojlRDL6ulCFJyYyr
 IIBL0uN+g8CnmuJtZ4cjmJQvdJ9lRw+P35TcycpQ8A77oIMTtg4m3d7El6nKEVLhoec9EGckR
 k4Qvr/Ijh+Cjpe3dmMU/522uKfrP8Gk13icJNSQhKF8lAFaaZYNQUO3EVqn5DBiLzOtNcwoSk
 SyPISIgD832RbJY/VEAc9kWlmr2Q9huY/ZaXIdMUCWazBVRY5x8B4ZDObgsgAVHVsL7JAkwFW
 KM/MTdUyMj5QzNKdZBwR/i/wjDWpLaQQ2NPdb1WED20+pOUXfHUAl27VpyrDJhZx4I2rvPMCN
 LHwTN5/A1HEron17/5WdctS0ihzRr7TLDCm3/bB+qhQTM0TSmrjPecT5OnxKBPpixdO8ivLd9
 A31557VWJZA+xu7a7bzx3YSMeqd1v2AnBL1N2cuCPmzA20xVcZi1i64RxGnQ5rMsiWk96qh
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 14, 2021 at 4:50 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Fri, Aug 13, 2021 at 5:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> After some thinking, I found that ARM64 is "define kernel VABITS
> depends on page table layout", and MIPS (also LoongArch) is "define
> page table layout depends on kernel VABITS". So you can see:
>
> #ifdef CONFIG_VA_BITS_40
> #ifdef CONFIG_PAGE_SIZE_4KB
> #define PGD_ORDER               1
> #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> #define PMD_ORDER               0
> #define PTE_ORDER               0
> #endif

I have no idea what aieeee_attempt_to_allocate_pud means, but
this part seems fine.

> #ifdef CONFIG_PAGE_SIZE_16KB
> #define PGD_ORDER               0
> #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> #define PMD_ORDER               0
> #define PTE_ORDER               0
> #endif

This doesn't seem to make sense at all however: it looks like you have
three levels of 16KB page tables, so you get 47 bits, not 40. This
means you waste 99% of the available address space when you
run this kernel on a CPU that is able to access the entire space.

> #ifdef CONFIG_PAGE_SIZE_64KB
> #define PGD_ORDER               0
> #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> #define PMD_ORDER               aieeee_attempt_to_allocate_pmd
> #define PTE_ORDER               0
> #endif
> #endif

Similarly, here it seems you get 42 bits.

> #ifdef CONFIG_VA_BITS_48
> #ifdef CONFIG_PAGE_SIZE_4KB
> #define PGD_ORDER               0
> #define PUD_ORDER               0
> #define PMD_ORDER               0
> #define PTE_ORDER               0
> #endif
> #ifdef CONFIG_PAGE_SIZE_16KB
> #define PGD_ORDER               1
> #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> #define PMD_ORDER               0
> #define PTE_ORDER               0
> #endif

This again looks reasonable, though I don't see why you care about
having the extra pgd_order here, instead of just going with
47 bits.

> #ifdef CONFIG_PAGE_SIZE_64KB
> #define PGD_ORDER               0
> #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> #define PMD_ORDER               0
> #define PTE_ORDER               0
> #endif
> #endif

I suppose you can't ever have more than 48 bits? Otherwise this option
would give you 55 bits of address space.

> Since 40 and 48 is the most popular VABITS of LoongArch hardware, and
> LoongArch has a software-managed TLB, it seems "define page table
> layout depends on kernel VABITS" is more natural for LoongArch.

How common are Loongarch64 CPUs that limit the virtual address space
to 40 bits instead of the full 48 bits? What is the purpose of limiting the
CPU this way?

       Arnd
