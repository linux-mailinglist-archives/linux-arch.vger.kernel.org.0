Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C03F00B1
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhHRJjW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 05:39:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhHRJjS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Aug 2021 05:39:18 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N2Dks-1nCyHk23jC-013cPv for <linux-arch@vger.kernel.org>; Wed, 18 Aug 2021
 11:38:42 +0200
Received: by mail-wr1-f53.google.com with SMTP id q10so2504038wro.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Aug 2021 02:38:42 -0700 (PDT)
X-Gm-Message-State: AOAM531uJ/I4WMSj/C4i260T9MwRkVMceglZK1dgIqZBbHV3JVU/E+Wi
        uAjlodvWUDnGW9BzBcBU10AfZA2C8D5teaPJGrk=
X-Google-Smtp-Source: ABdhPJxTxHKAX2unhNHO4ybczrtTqS8ClS+7dRKaPktGvZzqdahQsYngyAclCyCQVblExLoPyxheh+ix56DRPtx/A14=
X-Received: by 2002:adf:f202:: with SMTP id p2mr9695041wro.361.1629279522052;
 Wed, 18 Aug 2021 02:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
 <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
 <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
 <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com>
 <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com> <CAAhV-H6rPc1qyoE6FRpUQs1GS_K+xASHu_q5o-yT13eu7DKzVQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6rPc1qyoE6FRpUQs1GS_K+xASHu_q5o-yT13eu7DKzVQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Aug 2021 11:38:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LMY+KschuMfLoXB1qXMcTLVWeP+s41sCfQMFdRujQjQ@mail.gmail.com>
Message-ID: <CAK8P3a1LMY+KschuMfLoXB1qXMcTLVWeP+s41sCfQMFdRujQjQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:ZJyMxdHY1g5L3I0L876tvgS1zc7ZDg/MEq2fwD2/Sr/WTQfj8pu
 64YG1Eq73pE73eVzS9q7gaPy/7rg86V3VECYFGH7kuixIrwwnekTnDvDXkNKYb+BbPsZs/9
 W18T8PlISjQZLfXEoujlcTWPvXcbK160g/EHagZUm8kf7tYGih7sLTpNSsgvzPHFVzKclVt
 xXzOFIWHAk13br9hrU7VA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jndulHgmzOg=:/A/Id6DEoabe5RbgaTkFoU
 QsfutYGuofX3U2UZ9+2FuWP9EwdJTHcguoTOsLLwAS2Rwa6dvu6U2BqrpgeY2nEdHBMGa/qzQ
 yyHqZSH6raDLMzaNvD6PeHzDnVD0go9v2IkQMGlAnMXZeX8ny1GY+bMftlI6MXj6FdHYQilv7
 YM7q+CZDm70jLqcc3AubaLx82r+SZqW/fUFxnfniPqN9apQ6iURwAzJxa33EXTQicXVDltbb+
 f18rhIE76OJvibK4t3tmPRy3qBR78YgNL4jQGMfXRK7NxLwgnDeBpofAdfOkBOAKp+RNtA8f6
 I1hMEqqzT4eOxlpP7p6NcMW5gMSreIXblWMrfVR0pfuhLjtx2/bfZkoyM+K8vj2SCAL+lZjYo
 Wejuu053nlhSJwVFruxsRgZ/yLBMXHZO6Y31F70x2V4EUNDzcl+V7errDsD1i3dwp4y06All2
 Y/9BDTWuxvf3l6o4aBFeXxgDCyiP2A0aXj5BaueMzJQ+ht18INDrWPSqfyHNOXr5ixXwn2Q3h
 bpW3mXfMCKOKJvnWh0zSM8fZE76+nQQgYT+oKAjm17ZIKdvQsPIx3YDgMs3LweOypLXb5liJd
 RvbAGkZjRThNBZOtmkEFs6ymy2O1ywQsuYcbNx+8lANt/3LDTL15xn9Ru9w/DQ3IEBLRf3YsH
 DS7tE0/CcsaL9bA463hqJf5GU+8wZxUwMA1E11F3woKmevfnrscaew05U51PWeHOR1VGm7Pev
 oJn/RHWOyVgGTNIjmGVjd8634SmQxG/VFU/y7rlk3nZZFV2W83sVhJsQIp2VGK3xM1aZINoy5
 /sqGKaZCcTiyQWNjd/7sP2spE+XBjlneqm9rcpT/SssnYZOn0OwU1+KFE5uVAW3wnquGNUtF8
 BleFVY0Zr7iusM7VPo2YONeh+XcmScWqiSpmp7yq25PfXNz1e2j80MEgaGJSkZujfzY/sMS/4
 6ZAc+dbhm9jM5g8Z6HeGwsi/FZGdwnIcRmTq4kcFNVEhKzUa1vsCx
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 16, 2021 at 6:10 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Sun, Aug 15, 2021 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:

> > > #ifdef CONFIG_PAGE_SIZE_16KB
> > > #define PGD_ORDER               0
> > > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > > #define PMD_ORDER               0
> > > #define PTE_ORDER               0
> > > #endif
> >
> > This doesn't seem to make sense at all however: it looks like you have
> > three levels of 16KB page tables, so you get 47 bits, not 40. This
> > means you waste 99% of the available address space when you
> > run this kernel on a CPU that is able to access the entire space.
> Emm, this "waste" seems harmless. :)

It's not actively harmful, just silly to offer the 4/11/11/14 option that is
never the ideal choice given the alternatives of

* 11/11/11/14: normal 16K 3level, but up to 47 bits if supported by CPU
* 11/11/14: 16K 2level, just dropping the top level for 36-bit TASK_SIZE
* 13/13/14: 16K 2level, fewer levels with larger PGD/PMD
* 10/9/9/12: normal 4K 3level, same # of levels, better memory usage

> > > #ifdef CONFIG_PAGE_SIZE_64KB
> > > #define PGD_ORDER               0
> > > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > > #define PMD_ORDER               0
> > > #define PTE_ORDER               0
> > > #endif
> > > #endif
> >
> > I suppose you can't ever have more than 48 bits? Otherwise this option
> > would give you 55 bits of address space.
>
> We will have 56bits CPU in future, and then we will add a VA_BITS_56 config.

Right, so same as above: why not make this VA_BITS_55 already and fall
back to 40 or 48 bits on current CPUs

> > > Since 40 and 48 is the most popular VABITS of LoongArch hardware, and
> > > LoongArch has a software-managed TLB, it seems "define page table
> > > layout depends on kernel VABITS" is more natural for LoongArch.
> >
> > How common are Loongarch64 CPUs that limit the virtual address space
> > to 40 bits instead of the full 48 bits? What is the purpose of limiting the
> > CPU this way?
> We have some low-end 64bits CPU whose VA is 40bits, this can reduce
> the internal address bus width, so save some hardware cost and
> complexity.

Ok. So I could understand making CONFIG_VA_BITS_40 hardcode the
VA size at compile time, but if you always support the fallback to any
size at runtime, just allow using the high addresses.

       Arnd
