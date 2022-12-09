Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00BC647EC3
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 08:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLIHuC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Dec 2022 02:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLIHuB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2022 02:50:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDD4FF9D;
        Thu,  8 Dec 2022 23:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE9062190;
        Fri,  9 Dec 2022 07:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009B2C433EF;
        Fri,  9 Dec 2022 07:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670572199;
        bh=mgXmxfO0nJsJ5FTTISHf8DIRyMlAKW/tgC3rR79NvVc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=joLlxUe/NXeFxsP8LAZtung2Dnt3UjWGVOHPVdp5J6eogC97HfpJy8yeNgmMAhYVn
         RRtD4csXTHtUAo/gw/kXOCjeZp/rbq33WtVnuo+dZhNxHRhuQyycVLgu14ekGq23Io
         8jYa2qN7H9BMaQRe7REvhlg5EW5dM/4kZZ1HFEXU90zfOubP557Hp5VsqeM7RCll09
         GAOZVYo/cPc/phJ4D6XiKayCyH5H82RHEK4Ba8Y4NTliz6yiySHl6qhJ7rp6Md5yNt
         cVx2XCgvEHUCHN0JUx5IbIVE5NM5u7eDrbQ8Zv4dxhC7q+VvwHFgdIBieE615/xWp6
         9f6coiEY925AA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V10 09/10] riscv: stack: Support
 HAVE_SOFTIRQ_ON_OWN_STACK
In-Reply-To: <CAJF2gTT1YNubBG_RMzwsWVXk0X0nwQvTM2r5NjRvVN+1x1RHMw@mail.gmail.com>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-10-guoren@kernel.org>
 <87o7sew6ey.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTT1YNubBG_RMzwsWVXk0X0nwQvTM2r5NjRvVN+1x1RHMw@mail.gmail.com>
Date:   Fri, 09 Dec 2022 08:49:52 +0100
Message-ID: <874ju59ftr.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Thu, Dec 8, 2022 at 6:12 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> w=
rote:
>>
>> guoren@kernel.org writes:
>>
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config. T=
he
>> > irq and softirq use the same independent irq_stack of percpu by time
>> > division multiplexing.
>> >
>> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
>> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> > Signed-off-by: Guo Ren <guoren@kernel.org>
>> > ---
>> >  arch/riscv/Kconfig      |  7 ++++---
>> >  arch/riscv/kernel/irq.c | 33 +++++++++++++++++++++++++++++++++
>> >  2 files changed, 37 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 0a9d4bdc0338..bd4c4ae4cdc9 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -447,12 +447,13 @@ config FPU
>> >         If you don't know what to do here, say Y.
>> >
>> >  config IRQ_STACKS
>> > -     bool "Independent irq stacks" if EXPERT
>> > +     bool "Independent irq & softirq stacks" if EXPERT
>> >       default y
>> >       select HAVE_IRQ_EXIT_ON_IRQ_STACK
>> > +     select HAVE_SOFTIRQ_ON_OWN_STACK
>>
>> HAVE_IRQ_EXIT_ON_IRQ_STACK is used by softirq.c Shouldn't that be
>> selected introduced in this patch, instead of the previous one?
> This patch depends on the previous one. And the previous one could
> work separately.

Let me try to be more clear: IRQ_STACKS should be introduced in the
previous patch, which adds per-cpu stacks to hardirq. This patch adds
per-cpu stacks for softirq, and the softirq related selects:

 select HAVE_IRQ_EXIT_ON_IRQ_STACK
 select HAVE_SOFTIRQ_ON_OWN_STACK

Hence, the "HAVE_IRQ_EXIT_ON_IRQ_STACK" select should be part of *this*
patch, not the previous.

Or am I missing something?


Bj=C3=B6rn
