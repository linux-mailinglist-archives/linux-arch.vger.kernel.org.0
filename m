Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF9500C4F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiDNLn5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbiDNLn4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 07:43:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9209F53E09;
        Thu, 14 Apr 2022 04:41:31 -0700 (PDT)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mnq4Q-1oH5wx3Dq6-00pNtq; Thu, 14 Apr 2022 13:41:29 +0200
Received: by mail-wr1-f51.google.com with SMTP id g18so6495999wrb.10;
        Thu, 14 Apr 2022 04:41:27 -0700 (PDT)
X-Gm-Message-State: AOAM530lsz7qu7JrhcQrSVUm+lY5oqOj72y+Br0tngOpP1f0at7J6mTx
        Kn9IH5VnpKG/T3fF4JJfxYLqrGELB7OTymIL1sA=
X-Google-Smtp-Source: ABdhPJxDkbKKBQkTpfl/Oj838rv2VbzeElx6+NcSFuTvJBfQ5J//st0GmYuZABtNrIuj+4aYSg8U+Kt7cb2jJl5ZcKQ=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr1676626wrg.219.1649936487384; Thu, 14
 Apr 2022 04:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220412231508.32629-1-libo.chen@oracle.com> <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org> <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org> <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org> <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
 <8eb6f58a-2621-0977-1b67-b2c58e4d5fba@infradead.org> <c2e6bb8b-c9d9-ad39-7a8e-3df6849b2fb2@oracle.com>
 <CAK8P3a3wgbYPY6CxbkkFkEboXYLWREaL3oUmHyet5wPYpc4Vng@mail.gmail.com> <ce420ed3-4a36-122f-460d-8cccd0310033@oracle.com>
In-Reply-To: <ce420ed3-4a36-122f-460d-8cccd0310033@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Apr 2022 13:41:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0uy8JcHP_G_ebz61AMB-Mx6jr5+vuzJHmWbDCajTdTfQ@mail.gmail.com>
Message-ID: <CAK8P3a0uy8JcHP_G_ebz61AMB-Mx6jr5+vuzJHmWbDCajTdTfQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
To:     Libo Chen <libo.chen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
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
X-Provags-ID: V03:K1:Y7bjTG5yZhKSo0QonGX0bjrqMCV8FqCn2Jc/gpu9j2TXS37tuEO
 BsIiZ4BZNvTNt3uzFLgJmA8czEw6WM4HOxMsyMinuRUWTaiR3RjjgsT5cdWzfOrFldN0Vee
 n1hj4S2GZ5L1NZlkSgHlxKnJxgOK/meswZDx1TcQtRtX7Io3YXXqfNh0p4St2r37C/7/6lr
 lPqD22Ms77jBo7mprkeFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T3O8cO2vhA4=:mkttKl+5Zwfmc0W5nvAZUV
 uOXYKowyLJD1OMsdExf7wHc7GYnDPvXMrAIGHU4rR9JXbPiHRWNuTL4elvflyp4w6cBBm25rs
 ERAUXp0NX8nAsNqmnC6f1d1/JRQMtXlsCSDO44B6t5+gs0U+/3U3AgwMdu49vq5OdQ02zwJxF
 UbcYTMjp5yUPN7eYGHHk05PO/euvy5411NxYcQu8wlONf9uiPxV9tfDEQuJEp1Gvf2PNPHifM
 JH2WxgoW6aZunT97R7Yras0K20Uz8BOHqY5Eca6EU7c4itA6fRncAToEiFCWmRU6+RRdfEOGV
 6gTqpHULbtUtJ0YXDSFGWFZGOSJ0UL0hNfKAP2M07OaSJigsuifhsOHh86sqPwXsulHu0E5js
 YNL9IbKWMdO3V4ORkBiUxCUkOe2z/VvdaJBgiBVMELrxLAFLYrhpgxmVV9tYXtAXJESV75g7O
 N9o2S6mnWmINmL4UkiVuSWcGtrvf3pXPQ/nmnjuRzewfy1WdYPvXn/dyL/MDwD7XKwsvgzomx
 SgHx2rYBbno3F2zSef4vQhv6QyK9YiQnlyJ4AQGn6ZQuJv8q0hA5bpr607fhAdmHJZ/5H3qom
 +RpYteJe8AkPdx1NhQo7QKtPbJmG40lyWAkH5V/RYc57un7mfmZBn+a158wSEc3p1YFL3WDuP
 zwJ63bsnaAdHeK5FVLjR6Lz7a03A/IHLusR01Y8Hy/VkCKvtx96Fv8dXR3LevJEUPfSNAxzUd
 0vohc3fwuhkjjMbOo0K3Z6YoSqUzj+B4lkYO7af+w2beJ7EOuLLTKnrrtM8H3Tletes5j/9C5
 NMKzytmJXEdE1lcSBo/FTYnL1QDXHMqs8eqeAUQ+5kgCN9q5Uk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 13, 2022 at 11:50 PM Libo Chen <libo.chen@oracle.com> wrote:
> On 4/13/22 13:52, Arnd Bergmann wrote:
> >>> Yes, it is. I don't know that the problem is...
> >> Masahiro explained that CPUMASK_OFFSTACK can only be configured by
> >> options not users if DEBUG_PER_CPU_MASK is not enabled. This doesn't
> >> seem to be what we want.
> > I think the correct way to do it is to follow x86 and powerpc, and tying
> > CPUMASK_OFFSTACK to "large" values of CONFIG_NR_CPUS.
> > For smaller values of NR_CPUS, the onstack masks are obviously
> > cheaper, we just need to decide what the cut-off point is.
>
> I agree. It appears enabling CPUMASK_OFFSTACK breaks kernel builds on
> some architectures such as parisc and nios2 as reported by kernel test
> robot. Maybe it makes sense to use DEBUG_PER_CPU_MAPS as some kind of
> guard on CPUMASK_OFFSTACK.

NIOS2 does not support SMP builds at all, so it should never be possible to
select CPUMASK_OFFSTACK there. We may want to guard
DEBUG_PER_CPU_MAPS by adding a 'depends on SMP' in order to
prevent it from getting selected.

For PARISC, the largest configuration is 32-way SMP, so CPUMASK_OFFSTACK
is clearly pointless there as well, even though it should technically
be possible
to support. What is the build error on parisc?

> > In x86, the onstack masks can be selected for normal SMP builds with
> > up to 512 CPUs, while CONFIG_MAXSMP=y raises the limit to 8192
> > CPUs while selecting CPUMASK_OFFSTACK.
> > PowerPC does it the other way round, selecting CPUMASK_OFFSTACK
> > implicitly whenever NR_CPUS is set to 8192 or more.
> >
> > I think we can easily do the same as powerpc on arm64. With the
> I am leaning more towards x86's way because even NR_CPUS=160 is too
> expensive for 4-core arm64 VMs according to apachebench. I highly doubt
> that there is a good cut-off point to make everybody happy (or not unhappy).

It seems surprising that you would see any improvement for offstack masks
when using NR_CPUS=160, that is just three 64-bit words worth of data, but
it requires allocating the mask dynamically, which takes way more memory
to initialize.

> > ApacheBench test you cite in the patch description, what is the
> > value of NR_CPUS at which you start seeing a noticeable
> > benefit for offstack masks? Can you do the same test for
> > NR_CPUS=1024 or 2048?
>
> As mentioned above, a good cut-off point moves depends on the actual
> number of CPUs. But yeah I can do the same test for 1024 or even smaller
> NR_CPUs values on the same 64-core arm64 VM setup.

If you see an improvement for small NR_CPUS values using offstack masks,
it's possible that the actual difference is something completely
different and we
can just make the on-stack case faster, possibly the cause is something about
cacheline alignment or inlining decisions using your specific kernel config.

Are you able to compare the 'perf report' output between runs with either
size to see where the extra time gets spent?

        Arnd
