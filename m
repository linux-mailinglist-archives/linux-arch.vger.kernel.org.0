Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F5552719
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 00:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiFTWsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiFTWsM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 18:48:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6BC15A09;
        Mon, 20 Jun 2022 15:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B68DCE17AC;
        Mon, 20 Jun 2022 22:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE3BC3411B;
        Mon, 20 Jun 2022 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765288;
        bh=F1MFlX9p99cf5xJ+vWIrpSxEkV+myAxGug3dmZFii1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EscGU+l1+yRofgP4Cbam5CzzW4Y0q/yc/CAFQ2GCNZIjVdIN+keCY1ZDzpmQ7rC5G
         b1tmiQIMOl4plRI5KT5knyDGriY9DvFmHmV2a8RiyMyxjQLvEoYwhTkT5DD/QMXw5O
         K5zTMPm0iLeVpiwtsoxa5PoMLUnhUnoaVS9gHZ7zuNRO3dIl0gOlbp4PPfp9Ywy9K4
         5ZQ0bgwagU9J/ZNuSDxznJIlE0vh1tbwYcQSYOrB0Zcd5cX9hCklAbrBbHPmypwVMA
         jj/p5wogBKvWJ5ZppCKu6mg6sySqQzJc1NRM167f92EILJMjJN7xuN3esiexia9zBm
         lds8vhAHci3cQ==
Received: by mail-ua1-f54.google.com with SMTP id 75so2813161uav.9;
        Mon, 20 Jun 2022 15:48:08 -0700 (PDT)
X-Gm-Message-State: AJIora+urMeHrFHmdY1dBIbnA0P4MivqMxa8EpgnoPXJvgTCrigUBp+b
        /H4rUhSB4jVlh7lNu5e3XbO/9KBzb8eVTMEz8mg=
X-Google-Smtp-Source: AGRyM1sRx1+JA8cZQ05e7AUt1+f+8rCbotdZ08KaW9u7r0MGfLB3MMfclBmsXUd+QhSL8qbBsXd4XqT7NzihUgJyA84=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr8884819uao.114.1655765287621; Mon, 20
 Jun 2022 15:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220620155404.1968739-1-guoren@kernel.org> <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
 <f6513b4f-ef62-fd40-b031-27c9b7f57e00@redhat.com>
In-Reply-To: <f6513b4f-ef62-fd40-b031-27c9b7f57e00@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Jun 2022 06:47:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSQ17YQ41G+e0TBp2njPzx4LBGZw0GhyKCBqDW5AAuYaw@mail.gmail.com>
Message-ID: <CAJF2gTSQ17YQ41G+e0TBp2njPzx4LBGZw0GhyKCBqDW5AAuYaw@mail.gmail.com>
Subject: Re: [PATCH V5] riscv: Add qspinlock support
To:     Waiman Long <longman@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 21, 2022 at 5:16 AM Waiman Long <longman@redhat.com> wrote:
>
>
> On 6/20/22 16:42, Arnd Bergmann wrote:
> > On Mon, Jun 20, 2022 at 5:54 PM <guoren@kernel.org> wrote:
> >>> +config RISCV_USE_QUEUED_SPINLOCKS
> >> +       bool "Using queued spinlock instead of ticket-lock"
> > Maybe we can just make ARCH_USE_QUEUED_SPINLOCKS
> > user visible and give users the choice between the two generic
> > implementations across all architectures that support the qspinlock
> > variant.
> >
> > In arch/riscv, you'd then just have a
> >
> >          select ARCH_HAVE_QUEUED_SPINLOCKS
> >
> > diff --git a/arch/riscv/include/asm/spinlock.h
> > b/arch/riscv/include/asm/spinlock.h
> >> new file mode 100644
> >> index 000000000000..fd3fd09cff52
> >> --- /dev/null
> >> +++ b/arch/riscv/include/asm/spinlock.h
> >> @@ -0,0 +1,12 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef __ASM_SPINLOCK_H
> >> +#define __ASM_SPINLOCK_H
> >> +
> >> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> >> +#include <asm/qspinlock.h>
> >> +#include <asm/qrwlock.h>
> >> +#else
> >> +#include <asm-generic/spinlock.h>
> >> +#endif
> >> +
> > Along the same lines:
> >
> > I think I'd prefer the header changes to be done in the asm-generic
> > version of this file, so this can be shared across all architectures
> > that want to give the choice between ticket and queued spinlock.
>
> I concur. Qspinlock is only needed if we want to support systems with a
> large number of CPUs. For systems with a small number of CPUs. It
> doesn't matter if qspinlock or the ticket lock is being used.
RISC-V has had NUMA scenario. Think two AI chips with CCIX ports, they
could be flexibly connected when needed.

>
> Cheers,
> Longman
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
