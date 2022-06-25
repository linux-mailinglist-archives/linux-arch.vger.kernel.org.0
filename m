Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A726E55A776
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jun 2022 08:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiFYGW6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jun 2022 02:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiFYGW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2022 02:22:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FEB3F
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2022 23:22:54 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1xZX-1ngwuz39vF-012Kaz for <linux-arch@vger.kernel.org>; Sat, 25 Jun
 2022 08:22:52 +0200
Received: by mail-yb1-f181.google.com with SMTP id i15so8025860ybp.1
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2022 23:22:52 -0700 (PDT)
X-Gm-Message-State: AJIora9cQSePPue3k19Y4JHo4OOkjSy8PkzIrB3CQguT+ugaTnEgN90z
        ka5FKKfZrnaKAH8X8/Gk9HcecN9NNUWRMxSdthw=
X-Google-Smtp-Source: AGRyM1vbzJYOdOsmqnsi8jykRo4y3nH6Th1YFXHipTu1WFlK5Hdx1931kSjYlfy/GPrkUdKdpm5h+l9MaGGvwAn8xmU=
X-Received: by 2002:a25:e808:0:b0:669:7fcf:5f82 with SMTP id
 k8-20020a25e808000000b006697fcf5f82mr2879493ybd.550.1656138171567; Fri, 24
 Jun 2022 23:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
 <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
 <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com>
 <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com> <CAJF2gTSzUu5-C76LQs7KzV+U+qC5D1D-RVk4fHexHTJXLK6dqQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSzUu5-C76LQs7KzV+U+qC5D1D-RVk4fHexHTJXLK6dqQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Jun 2022 08:22:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0s3PkeV350puaJ3kPkUQjV3k0c5c3E1m1skUq7n86QMA@mail.gmail.com>
Message-ID: <CAK8P3a0s3PkeV350puaJ3kPkUQjV3k0c5c3E1m1skUq7n86QMA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:J2ikNO+GZYgaRk0GsiMwRKKBA/hLz0I/VEzgYOdUmAgX6ZIz95P
 vJQSeFKZjekHfJEqeBJ6uB43ArWa2WoSYHy7ShxEVEWYjKffu21pQapnL/fPdm5zZNcPCG0
 13LvrrvDbY5Ir7whunbMOvMZNg2eTq1/6ZXeYNiio6UG9y4XPDtECC+Wqc94tM85XqIU4vP
 zAmNS2bQllOTqTqNsOSww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I5CZiPRj1S4=:KGvvjT8HTQCeyVFKFEc3FD
 fBVkbv+J04ulcyRL7pfYbLMIWIhPaX9CyI5rmxLpzeVEJVFx/ZB7nynPrM4iw1RtJgid2wcKN
 Nn3NvMVHHaxyHOqmezvfqQZNBhuBHdfLdoKBWHIQ4FGXKy0QW4igBTYZf+0K0tzXGhx/JS1T3
 ueNfJkE89UoR1LVDbcJC01odeNnXUzmts15c5suKoK6ZgABl5YNeQQN/nyALhuG7brNwW6/7w
 np6ARWbL6MACx9GdDm2Ud3DD1p0MM9XM7cjYeJMcDOLvqg+JDnotR8YEvcouhp1YzTbA2Xzr8
 J+FE4pi2l/teCTW3KRAivj42vymGclDF2ROhxuUXbU2zJVqeBiyNf4TMBNUFYZP2HfGapYtqX
 QGb6/ujca3Lg+FauAjeE9Pae06vFDsOX3ZWxr1YEPxyBD+5v/SFVP9iVlXFvgBQsxNsuLp+a9
 sb9vb5ikq8lpYZ50Dhu7UTCleI2Y4Gsmxu71Qq3A22PbgqkOlpFMJJRXT3v90Jwev3By8Zdm/
 xO0jqXFwW39PIr+AuU3qQ8mhVley8tQ0T6VqbJThCPYLJ4jzqKXo3XIUiB9WUaeBaBnbwrsyF
 5bQ/lMgRyZOlpT1M+u5TXVDSwfUMuBg3/8AzcD/WBo39LofHic5WAxTuAfrfILsXEcoJQcL4O
 I1I3Krek9XbaCUhlnNaerMpo+9YBNjJSHnAFDyWrlcuOoH/msVgv1SSFQo72UjiZ9jHI+3G5/
 FE69usMh2CgU6zrAbT2fOMSVJgk0C1nLhZoBUg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 25, 2022 at 4:42 AM Guo Ren <guoren@kernel.org> wrote:
> > In that case, you probably need a boot-time check for this feature bit
> > to refuse booting a kernel with qspinlock enabled when it has more than
> > one active CPU but does not support the random backoff,
> Do you mean we should combine ticket-lock into qspinlock, and let the
> machine choose during boot-time?

That is not what I meant here. It would be great if it could be done, but
I doubt this is possible without adding excessive complexity.

> From Peter's comment, seems the arch is broken without a strong fwd guarantee.
> https://lore.kernel.org/linux-riscv/YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net/
>
> I'm not sure qspinlock guys would welcome ticket-lock getting into the
> qspinlock data structure (Although ticket-lock is also made by peter).

What I meant is that a kernel that is not safe to run on hardware
without the necessary guarantees should just refuse to boot, the
same way that we tend to warn when the CPU instruction set
version is too old for what the kernel was built against.


         Arnd
