Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3077557569
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiFWI0y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWI0y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 04:26:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0748883
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 01:26:53 -0700 (PDT)
Received: from mail-oi1-f170.google.com ([209.85.167.170]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q4e-1o6V631tXs-002FFm for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022
 10:26:51 +0200
Received: by mail-oi1-f170.google.com with SMTP id k24so24403473oij.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 01:26:51 -0700 (PDT)
X-Gm-Message-State: AJIora8jy289XgM7zEm3ru+19eRvRUggh1CzJFJ5NfRVGzUxcCIYzVM9
        DplzPI3lZAPnOZp4ghQOK8L4I2WmJoEn1zI1/q0=
X-Google-Smtp-Source: AGRyM1u9pqhopZfdeBwO5Xx/VVhkNHcq295BMkoofP9ZNnYY2D6jA3KH7S/W8w1wfJ7YkyJ8w4hAFE87FHJq0iNcABM=
X-Received: by 2002:a05:6808:1147:b0:32f:1a3a:2210 with SMTP id
 u7-20020a056808114700b0032f1a3a2210mr1518557oiu.155.1655972810216; Thu, 23
 Jun 2022 01:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
In-Reply-To: <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 10:26:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
Message-ID: <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add qspinlock support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FSJoDUQHkrTpSM5H7abW4Ci2qtv38CTn+MyagRNUuZiMDMuEkfv
 t0EURiQ15AlhO08GHO52ubHI5OOHxbEsE66PeQ5e2Jo0nK6ukhaoqIlHUAxYGjIohG/0/ud
 9//4XUHp8//EWqzMYtimPdkNATbTkMY+FaIJr4OvRuHPG8OnTe7jARM4fm3IMT2qXX34AXi
 4+pC2JQyra9VR170aga6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hOzdtNTGXv4=:55yVEcBgfw4qwp2ocEkitm
 diRCzXo9qqynJwT7qCr8tccdymv24Jy+eym6d5hzWxlcKc+LJ7LS+IP2VhmPUA3atQ/xSDKBK
 AYZAEHpYWRO3YR5P/TxeN8Rv2iekGIU3cbdHLdE1LtGTIIMxm+2CvMxA2Ub5n9OfkENjGyu0e
 hMTB+n9T1hAMHnOk2CWReqjx897G0+y6XVcMn20ZqMFuz482X9Judm9zBJAa/2WsY7dCiczro
 2LR/wCe+XxQSYjYVzxn/o1zwUW497ry01fOTKZu5F+3Nc8j2rv6SDvl02uYPTgblPK80FibCH
 wWksYBTF+ubh2McdE/H8k4izsHWpOxVcUTOKGfgNGzdyPIeopY3Y+0WEMqQhjTEg12Vou5Gx1
 lCgeuKfB6XWrRssNkYjIc0+TP5zE+DxTw5TM5mq1HWhYm4UJhpt5d73Iax29hvA3jxrP03Dc9
 xye5pJEd+H2zQD3VevzR+QZpnspVrlz9Bd6ij1VbrCs1asKEym2TxhGpySPi4wAO3Ow3cX+lB
 Jp0FW6I+6Ws9qyIMVFSfu0WhnAZ/AkwVbc/077flJCRM71Dt0mwUJnwZ+J2MrEXoEUXfZi9lF
 uVDx9wuYSuWniY/SBfekAoSPH7qZhZpIGS1WJsLrMF2raxBAhiAjB3/py66pDHsatP310AE9A
 eCWFiXWCdIXif4jk3rmqSZY/Td76BavZZbSKg7MoxdBcylugbkmjWoVIf9m7SoEkpu8S0J6wg
 Kvbwalz+UCg+UwcfkPlE267VsRa7WDTiEZcn7C23HgQLdkr9uHs3PqSvbFT9Lvh+LDgvC26Vy
 IwqI/VCd0A++uRm5YfXU6dbI5IkG6LSL5RgfbL2UGmBrcINwSeYqOY37EUE46AYr9qi2+fl17
 q+MXuaGXvg9uLQ1XYLRg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 23, 2022 at 9:56 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Thu, Jun 23, 2022 at 1:45 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > On NUMA system, the performance of qspinlock is better than generic
> > > spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> > > per node, 32 cores in total) machine.

You are still missing an explanation here about why this is safe to
do. Is there are
architectural guarantee for forward progress, or do you rely on
specific microarchitectural
behavior?

> > Could you base the patch on [1]?
> >
> > [1] https://lore.kernel.org/linux-riscv/20220621144920.2945595-2-guoren@kernel.org/raw
> I found that whether we use qspinlock or tspinlock, we always use
> qrwlock, so maybe it is better like this?
>
> #ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> #include <asm/qspinlock.h>
> #else
> #include <asm-generic/tspinlock.h>
> #endif
>
> #include <asm/qrwlock.h>

Yes, that seems better, but I would go one step further and include
asm-generic/qspinlock.h
in place of asm/qspinlock.h here: The two architectures that have a
custom asm/qspinlock.h
also have a custom asm/spinlock.h, so they have no need to include
asm-generic/spinlock.h
either.

        Arnd
