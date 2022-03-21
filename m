Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C32E4E2380
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 10:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbiCUJoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345969AbiCUJoN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 05:44:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35001350AC;
        Mon, 21 Mar 2022 02:42:47 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MsIbU-1oLRVM0yOA-00tkvb; Mon, 21 Mar 2022 10:42:46 +0100
Received: by mail-wr1-f41.google.com with SMTP id r10so19861803wrp.3;
        Mon, 21 Mar 2022 02:42:46 -0700 (PDT)
X-Gm-Message-State: AOAM533aeaByClywtDYNhhd7ufOyjhZJouBXHTd6e57pFgsiLd9KkBG8
        vKr0hH1uAs4jc459oVE0NP4JszIqRKZaMwttsdI=
X-Google-Smtp-Source: ABdhPJwkq1FLAD225Eea2kcRUR2sWY4ab1/G2z0OQte1KuaMBsakyF/QdgKdIrAo10lFEv61K8gbZU+EWwJDOvZX33c=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr17324397wrq.192.1647855765838; Mon, 21
 Mar 2022 02:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143130.1026432-1-chenhuacai@loongson.cn> <20220319143130.1026432-7-chenhuacai@loongson.cn>
In-Reply-To: <20220319143130.1026432-7-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 10:42:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0wVKWFASv6cVDOZmX=1h7EeAVyrxLFXmoH5REVaAoNhQ@mail.gmail.com>
Message-ID: <CAK8P3a0wVKWFASv6cVDOZmX=1h7EeAVyrxLFXmoH5REVaAoNhQ@mail.gmail.com>
Subject: Re: [PATCH V8 07/22] LoongArch: Add atomic/locking headers
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cGMrCqph8HJu7ee//vUaC4KO121C4Qvdi45F+lo3pu6si7Hiuyy
 IewIcYpkHv90N1g6JHpCbOhSLTaXlSvMFm4PNPJbTj/RAH9EW8GjyskOkkfUghAjIxBBf/r
 9Us4usFkwgyV1KPFGc1oH0fp9wFN6c1oTmqBQSKuj5WFEgoWt7grgL7PUamQcWzitV2dhHy
 7SVcGMJEn+xLXE+8+kbTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xHfyISuKSXo=:EN1aIqlABHA0g4N2THTWMB
 DbfFSbg2Xv87HVmTfuuhIYVdlTqRtdEPlo7Tm4/u4sKRU9XO98VJSfl1v3pU523sd02mCDkrg
 +OOjRJc7ivVPPOpnrj5ruf7874WO29ykFVYA4BtmPR0Na55pRCMhPflZcWQqgw+UAxltsbVQV
 /pxGjt3m9ye0zkNTZCFLFyrS61z11lwoFHjhM6XCRFIi1xjc/Uj7rSBiTExelQaQncUrWJ1dO
 JyPwgycmvoWU0mJGK8zjd+PuHDnUDlRuaCnoPBnkcuyCDv/NO353utZG6jLEC6J24CvUaJitE
 oTiAa68ZhIkbbgAyWf6Cm9cXYH0y5zz96QnOpOjs6YV1o9DKgY5FUB6BDh4U/4h9inK3rF6ZZ
 HBU26KyTNJMRg2Z6skSWTSbxMZ5Me7KYSjFDTp7Gq6SaF1HZYOScBlJ9h0Sc//Db8yOYPkMhm
 YOf32aI1XQFcs9rtVqQJHJe589Ydm6TaB60TdUbe7lTx91p129ajDOtbf+IZdUZRdrRml5abt
 zV7pPL5QihdzC06TKoC+mL+EQHoY7n399kn7Km2KDhIlb/aa0VxQVQlYLPpakD6N9doQcDJtl
 ojUlBTdHxPX7C0m3rVOr4DBYo5qYUVD3QHn05fmZEXKkcudtCaq4Onjrk0BUCv1R7StmikA56
 /GVkte1bhQLwUaPHNuk6Q1A/J7qOrf6FHw6IZV0F9JqZQreZunM1cVxs1PX/oE8bAjhFPBAUM
 jbqCkwmrKmiAVDa/VKyXyUbfurciEK86cWQyd07WPkvBQjkVU/l4X+DbBOU4XZO18Hig7+WwY
 xC92hsSDKIdq5TRfSP/iYx02ewQ4Ix/ORC9JCCwJ3oidPY0+4A=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 3:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> LoongArch has no native sub-word xchg/cmpxchg instructions now, but
> LoongArch-based CPUs support NUMA (e.g., quad-core Loongson-3A5000
> supports as many as 16 nodes, 64 cores in total). So, we emulate sub-
> word xchg/cmpxchg in software and use qspinlock/qrwlock rather than
> ticket locks.
...
> +extern unsigned long __xchg_small(volatile void *ptr, unsigned long x,
> +                                 unsigned int size);
> +
> +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> +                                  int size)
> +{
> +       switch (size) {
> +       case 1:
> +       case 2:
> +               return __xchg_small(ptr, x, size);
> +

I think it's better to not define the "small" versions at all, since they are
inefficient and probably not safe to use for the few things that try to call
them, such as the qspinlock implementation.

I have an experimental patch set that removes these from the kernel
altogether and makes xchg()/cmpxchg() only work on 32-bit or
64-bit values.

> diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..7cb3476999be
> --- /dev/null
> +++ b/arch/loongarch/include/asm/spinlock.h
> +
> +#include <asm/processor.h>
> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +

There is a patch series from Peter Zijlstra, Palmer Dabbelt and Guo Ren
that is currently under review for risc-v and csky, to add a generic ticket lock
implementation that does not rely on sub-word atomics [1]. I think we
also want to convert mips, xtensa, openrisc, and sparc64 to use that,
since they have the same issue with the lack of 16-bit atomics.

Please coordinate the inclusion of the patches with them and use that
spinlock implementation for the initial merge, to avoid further discussion
on the topic. If at a later point you are able to come up with a qspinlock
implementation that has convincing forward-progress guarantees and
can be shown to be better, we can revisit this.

      Arnd

[1] https://lore.kernel.org/lkml/20220319035457.2214979-1-guoren@kernel.org/
