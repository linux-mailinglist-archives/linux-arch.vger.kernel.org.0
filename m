Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A035B15C4
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIHHhC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 03:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiIHHhB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 03:37:01 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D2BD1EB;
        Thu,  8 Sep 2022 00:36:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id B11592B05F1B;
        Thu,  8 Sep 2022 03:36:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 03:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662622615; x=1662626215; bh=fczRBUafZA
        b4RaXJzlTRQu/tA13OrDvjbdcplYkYK0Q=; b=KYC9GwDVAiDSqJoafeGR6xgqIn
        u2V5ZePsZlHt04gAtkSEZNWPe+Vr0ia3erf2Ac0RxEheFHfFv8yS5kFB8CKcFmOa
        P+f+Mk7oqEgzxx74Kli6kSlFVKElrrUUYIzuER839ay3Z8I7x1EmBZjwyf4w3NbJ
        p2efCDw7/pdjmuQN0sUaZi9wI5F/AyND9toXg6SLiLRM4a/UBLKOE4KyJFt+KReP
        DoizUMe0iKnr1OBAFMVbLv7Rz8B9FSikbe5RWDFgKerNqkv5WjsjpfsUPgOTtT7b
        OQVCyXbF6jsJjf65pnSGXNYKW3CUwl/ysKC1hAHRvOdhWv0dUJZbJluUyyOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662622615; x=1662626215; bh=fczRBUafZAb4RaXJzlTRQu/tA13O
        rDvjbdcplYkYK0Q=; b=GAN/KmWUPR3xfVYijN3Pa0JG8akP4pFFH6QV0xgZbuxx
        QD7qMzoSeZN8JivaxtILausWbCAEWc4DZdEaY3aXqOpJg7I+lEtxCtWVS5GGq8DR
        IEZybaN9fCu16aUcJa1PR2wdjtFdDWWDzwoFIN6mc+zask/5TffpHKFYuAx3Zi6u
        377Wy/R+ySpTyg+87XAOm+GGXnfXTJF2AWkKMWzW7wQCuhj3iqOiSZCC9qJLshjZ
        bhuh5vUXoDvu+z2FpgVYVQL0JE0VqbqMIybBqTm2kdaVHG3nGKUKTU6KXmaWAsJE
        k1KyDjgqq9TmIltMFzMpZgxKLL3F9D1lS0h4uqV5fg==
X-ME-Sender: <xms:lpsZY1Jpv4sBdOdHa8r2gDqOF7pmxBMX8zNwbUKITFR_tmon5oF6Eg>
    <xme:lpsZYxKgrfR4QP2GXNvXtx_7r-uUFOwDmkoDaYns8Oo2taq94IX4sQkVro6drr298
    rBImXk5qwTRpTe7pRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lpsZY9urtU-0GbZPLpopELSKTHkdA0YMKCEE1P7EkBO5otcHsDd-Rw>
    <xmx:lpsZY2ZaiMVDhLSJeBsE0z4pGDppm9txfP0UPhizkLApD1Hk_Oajhg>
    <xmx:lpsZY8blkaL1SFxluXrdBwOiut7Q3H5nnaq_SNjj-LanjlcxQK_zQA>
    <xmx:l5sZY5QF1DahoZrrWG2qX-8E4zYYVF5Pwjx8qFCQxJTjou-qMXmYH-PU1AdcEv6y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1A49FB60083; Thu,  8 Sep 2022 03:36:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
In-Reply-To: <20220908022506.1275799-9-guoren@kernel.org>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
Date:   Thu, 08 Sep 2022 09:35:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren@kernel.org, palmer@rivosinc.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org,
        "Huacai Chen" <chenhuacai@kernel.org>, apatel@ventanamicro.com,
        atishp@atishpatra.org, "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, bigeasy@linutronix.de
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Guo Ren" <guoren@linux.alibaba.com>,
        "Andreas Schwab" <schwab@suse.de>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 8, 2022, at 4:25 AM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> 0cac21b02ba5 ("risc v: use 16KB kernel stack on 64-bit") increase the
> thread size mandatory, but some scenarios, such as D1 with a small
> memory footprint, would suffer from that. After independent irq stack
> support, let's give users a choice to determine their custom stack size.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/Kconfig                   | 9 +++++++++
>  arch/riscv/include/asm/thread_info.h | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index da548ed7d107..e436b5793ab6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -442,6 +442,15 @@ config IRQ_STACKS
>  	  Add independent irq & softirq stacks for percpu to prevent kernel stack
>  	  overflows. We may save some memory footprint by disabling IRQ_STACKS.
> 
> +config THREAD_SIZE_ORDER
> +	int "Pages of thread stack size (as a power of 2)"
> +	range 1 4
> +	default "1" if 32BIT
> +	default "2" if 64BIT
> +	help
> +	  Specify the Pages of thread stack size (from 8KB to 64KB), which also
> +	  affects irq stack size, which is equal to thread stack size.

I would suggest hiding this under 'depends on EXPERT', no
need to bother normal users with that question because the
defaults are probably what everyone should use unless they are
extremely limited.

> #ifdef CONFIG_64BIT
> -#define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
> +#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
>  #else
> -#define THREAD_SIZE_ORDER	(1 + KASAN_STACK_ORDER)
> +#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
>  #endif

The two sides of the #ifdef are now the same, so you no longer
need both. You could also consider expressing the KASAN_STACK_ORDER
bit in Kconfig logic for consistency, and put those into the
defaults as well. Unless you actually use CONFIG_KASAN_STACK,
the stack requirements of KASAN are not too bad, so that way one
could decide to still use a smaller stack even with KASAN.

If you want to make the setting really useful, you can add two
more ideas:

- When VMAP_STACK is set, make it possible to select non-power-of-two
  stack sizes. Most importantly, 12KB should be a really interesting
  choice as 8KB is probably still not enough for many 64-bit workloads,
  but 16KB is often more than what you need. You probably don't
  want to allow 64BIT/8KB without VMAP_STACK anyway since that just
  makes it really hard to debug, so hiding the option when VMAP_STACK
  is disabled may also be a good idea.

- For testing purposes, you can even allow byte-exact stack sizes
  that allow finding out what the actual minimum is by adding a
  fixed offset during kernel entry. See add_random_kstack_offset()
  for how to adjust the stack.

With all those ideas added in, the Kconfig logic would be
something like (assuming you can use 

config THREAD_SIZE
       int "Kernel stack size (in bytes)" if VMAP_STACK && EXPERT
       range 4096 65536
       default 8192 if 32BIT && !KASAN
       default 32768 if 64BIT && KASAN
       default 16384

config THREAD_SIZE_ORDER
       int
       default 0 if THREAD_SIZE = 4096
       default 1 if THREAD_SIZE <= 8192 
       default 2 if THREAD_SIZE <= 16384
       default 3 if THREAD_SIZE <= 32768
       default 4

      Arnd
