Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD458E1F8
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 23:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHIVm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiHIVmv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 17:42:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DD46AA13;
        Tue,  9 Aug 2022 14:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5682B8136E;
        Tue,  9 Aug 2022 21:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BBEC433C1;
        Tue,  9 Aug 2022 21:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660081368;
        bh=LWQCSC8FfjD55HWw0CaXRB1hieerDY6z05vJfxpHEHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eyZONta/AY5NtbKKWqKeonHKFZeLmxIazytRuQI+Am+sNzdG/wHdAvER4mdnvk2/z
         nj0myWJfmcgwLwZyaP+ZAVFFoNHljht/kTGTAZj+5MxOxKMfwbmHWGEqzZ7gofaKNn
         x+fLNSNPwuhuVt7/8GrrNieBPiIKHmkTZ2UMjG8bijFA7idZsvgUG7g6B1192pwsTW
         gCjHi4o+63/2JlkI+/pN5pyc/b502yiSLbIwbmhgERytcc95geCoqAERexkZu7vmw3
         axguioooj2XkvGSVfSrNRQi+qtBjgXzHrkDaPOGhcOzNvOeYoLv8Ako8+6vuR+j3RM
         UjN8N+P6FZXUw==
Received: by mail-wm1-f43.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso106999wmc.1;
        Tue, 09 Aug 2022 14:42:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo054Z5fiZSBfy9qlzoWuoXb63NBi/mEaAOS5az0WcO1Vi4PlLrk
        7FdSv9G7SBXRHESNS94LVkbzfEqFM9n5h0eAuhA=
X-Google-Smtp-Source: AA6agR46znHPnjXuMF0ESE8yshyOz9FwMBs5CzrB/1w3Ltrdqh36cdhHWvBCtR8W2w5FTqLo7Im4fOVR23KjCUL7o+g=
X-Received: by 2002:a05:600c:1e8f:b0:3a4:e0f0:4bad with SMTP id
 be15-20020a05600c1e8f00b003a4e0f04badmr224990wmb.133.1660081366742; Tue, 09
 Aug 2022 14:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
 <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com> <YvKD4hkZ3erf54DG@linutronix.de>
In-Reply-To: <YvKD4hkZ3erf54DG@linutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 9 Aug 2022 23:42:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1pvWK0GUikVG7H=AByOfS4x=JjXezorjF66Hv8FH8uBA@mail.gmail.com>
Message-ID: <CAK8P3a1pvWK0GUikVG7H=AByOfS4x=JjXezorjF66Hv8FH8uBA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: Conditionally enable do_softirq_own_stack()
 via Kconfig.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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

On Tue, Aug 9, 2022 at 5:57 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Remove the CONFIG_PREEMPT_RT symbol from the ifdef around
> do_softirq_own_stack() and move it to Kconfig instead.
>
> Enable softirq stacks based on SOFTIRQ_ON_OWN_STACK which depends on
> HAVE_SOFTIRQ_ON_OWN_STACK and its default value is set to !PREEMPT_RT.
> This ensures that softirq stacks are not used on PREEMPT_RT and avoids
> a 'select' statement on an option which has a 'depends' statement.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/Kconfig                          | 4 ++++
>  arch/arm/kernel/irq.c                 | 2 +-
>  arch/parisc/kernel/irq.c              | 2 +-
>  arch/powerpc/kernel/irq.c             | 4 ++--
>  arch/s390/include/asm/softirq_stack.h | 2 +-
>  arch/sh/kernel/irq.c                  | 2 +-
>  arch/sparc/kernel/irq_64.c            | 2 +-
>  arch/x86/include/asm/irq_stack.h      | 2 +-
>  arch/x86/kernel/irq_32.c              | 2 +-
>  include/asm-generic/softirq_stack.h   | 2 +-

Thanks for the patch, I assume Linus will want to pick this up himself.
Let me know if I should give it a spin in the asm-generic tree first for
additional build testing.

Acked-by: Arnd Bergmann <arnd@arndb.de>
