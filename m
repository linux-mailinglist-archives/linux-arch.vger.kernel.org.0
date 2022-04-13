Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18275500048
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 22:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiDMUzF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 13 Apr 2022 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiDMUzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 16:55:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AAC51E54;
        Wed, 13 Apr 2022 13:52:36 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Myb8P-1nsx2d3BBV-00yvqp; Wed, 13 Apr 2022 22:52:34 +0200
Received: by mail-wr1-f53.google.com with SMTP id p18so3497398wru.5;
        Wed, 13 Apr 2022 13:52:34 -0700 (PDT)
X-Gm-Message-State: AOAM532MGznbL9PtJVRpWYbGAZndxNBeukYfaIEqqVzDKOWc+OEpBtWK
        swVjmukK9ZZY1U7/z7dDRWGR9kb10rlwvOhRmEA=
X-Google-Smtp-Source: ABdhPJynu15Qh4m64m6MCTm6s/j+h8e1vmj+aJfNr9VpL8mSRgOjnnzV2VPGWedaGnH1lm+Ss0TxNMi1x244N7pKMes=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr462036wrh.407.1649883154251; Wed, 13 Apr
 2022 13:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220412231508.32629-1-libo.chen@oracle.com> <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org> <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org> <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org> <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
 <8eb6f58a-2621-0977-1b67-b2c58e4d5fba@infradead.org> <c2e6bb8b-c9d9-ad39-7a8e-3df6849b2fb2@oracle.com>
In-Reply-To: <c2e6bb8b-c9d9-ad39-7a8e-3df6849b2fb2@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Apr 2022 22:52:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wgbYPY6CxbkkFkEboXYLWREaL3oUmHyet5wPYpc4Vng@mail.gmail.com>
Message-ID: <CAK8P3a3wgbYPY6CxbkkFkEboXYLWREaL3oUmHyet5wPYpc4Vng@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
To:     Libo Chen <libo.chen@oracle.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:An3chnDGr1I8GidqyoHMbUplRNrokioKZVAGUfv66V3JMecg+No
 sNolDVZPTC/ZVyhJUrj19SvIf1xEDrFAShmWPhA/y6jmjw1qJcwZKq6fpqCgmaYpIApRuNQ
 fnXgt/lSyOrtfTLak9FxaoHI4chxAkrRsCS8dyIQCdqCQeqSnz5X+ZbdW6qnsvO4v+0CVJR
 qLjxUzh/DtCeoEEXhpLuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZaJVOHwGEHc=:qYZPjyFXn97Lj6M0vBV557
 v5UkizLwpjBfYdpvonA9+0JiH9z1HRVAJpcIrFntInR8ckzX/JNULkvBccLJa3nWbz7mL3KPI
 PKwnwUIWBEeJrB1FMxoCmEl4z48hM406OJgS0KKWMELL53Xk7d7/AdKWzZBym7fp6YmzR2+Y3
 ZoCOrVlVmJpMb9nVOREPaFo3LwCqNk2ri067LuEpsoObFMJQHxjbrA8bx5oDn9ub89TmnY2gP
 6zFZrZ8PfzMLtAAmzUSMw/V47IoS/R3dfHuQf60lOYLsi5DAnV9xj+WM5r9pcBm3x1IJyjUNU
 iVi2sh0ce9OF+mNc2Nu8F9hGqlC4lGcw7eRUZ51EFiQKQFLxb5DA7U+10M6uoaoZftz7Jz8vL
 TowPbbLIQIgPfMPNB9YG0SQKDOZeCvemDZnXRBh1+9aBgShMkDc9jU3RBencE7pd2Hl+diXsc
 mqRyRLp7AIi/YgpMdSx9gbKXwKPMmWMv0GVKHdGcKkRRn+KSGk6K+ec7PyzZLbrWMaFCaiqxJ
 hR37tX1T/gCDNoWAP5Svngf8MjxMSJMAYIZ67+YkOwOREzeqBYCTpRlPVB132zfpa/7Zgy/8n
 u0h/BiVSMTy6j+Xdy9hiOz9bFpNi5TK9BWNHvGPsH8ZJZG6bsNSoCGyWKx+JkqgIQZrm89oIV
 oEAfJOkcY4n4Hs3aNyYbEz26FPzGsE1XqPaXqHyFOCVa6IZo7rEwAJsQ/FILGMNhyD5wtJqAN
 +New10xZ6/tS5A/b6TghVexmE4ujumqYrQGdyjoCxDFp7oag9J+xoErJi4nVjxrtBRv5hWeoP
 a0PK4JJ4i1IzQpGfVtdHC5qD/nZPh16wOYVT+QXl0JPQbBhcoQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 13, 2022 at 9:28 PM Libo Chen <libo.chen@oracle.com> wrote:
> On 4/13/22 08:41, Randy Dunlap wrote:
> > On 4/12/22 23:56, Libo Chen wrote:
> >>> --- a/lib/Kconfig
> >>> +++ b/lib/Kconfig
> >>> @@ -511,7 +511,8 @@ config CHECK_SIGNATURE
> >>>        bool
> >>>      config CPUMASK_OFFSTACK
> >>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> >>> +    bool "Force CPU masks off stack"
> >>> +    depends on DEBUG_PER_CPU_MAPS
> >> This forces every arch to enable DEBUG_PER_CPU_MAPS if they want to enable CPUMASK_OFFSTACK, it's even stronger than "if". My whole argument is CPUMASK_OFFSTACK should be enable/disabled independent of DEBUG_PER_CPU_MASK
> >>>        help
> >>>          Use dynamic allocation for cpumask_var_t, instead of putting
> >>>          them on the stack.  This is a bit more expensive, but avoids
> >>>
> >>>
> >>> As I said earlier, the "if" on the "bool" line just controls the prompt message.
> >>> This patch make CPUMASK_OFFSTACK require DEBUG_PER_CPU_MAPS -- which might be overkill.
> >>>
> >> Okay I understand now "if" on the "boot" is not a dependency and it only controls the prompt message, then the question is why we cannot enable CPUMASK_OFFSTACK without DEBUG_PER_CPU_MAPS if it only controls prompt message? Is it not the behavior we expect?
> > Yes, it is. I don't know that the problem is...
> Masahiro explained that CPUMASK_OFFSTACK can only be configured by
> options not users if DEBUG_PER_CPU_MASK is not enabled. This doesn't
> seem to be what we want.

I think the correct way to do it is to follow x86 and powerpc, and tying
CPUMASK_OFFSTACK to "large" values of CONFIG_NR_CPUS.
For smaller values of NR_CPUS, the onstack masks are obviously
cheaper, we just need to decide what the cut-off point is.

In x86, the onstack masks can be selected for normal SMP builds with
up to 512 CPUs, while CONFIG_MAXSMP=y raises the limit to 8192
CPUs while selecting CPUMASK_OFFSTACK.
PowerPC does it the other way round, selecting CPUMASK_OFFSTACK
implicitly whenever NR_CPUS is set to 8192 or more.

I think we can easily do the same as powerpc on arm64. With the
ApacheBench test you cite in the patch description, what is the
value of NR_CPUS at which you start seeing a noticeable
benefit for offstack masks? Can you do the same test for
NR_CPUS=1024 or 2048?

           Arnd
