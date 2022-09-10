Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C575B476B
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIJQHY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiIJQHW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 12:07:22 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD54362D;
        Sat, 10 Sep 2022 09:07:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F09EA5801FF;
        Sat, 10 Sep 2022 12:07:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 10 Sep 2022 12:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662826037; x=1662829637; bh=JrvbliJorV
        qJcIyq5312kNwoArSoX86rKwfhq5NsJN8=; b=STeBrkASEqh1rDzggSA2Quz6lu
        gFXWyGy86T1o1UqlDmevXam36R5kVo1ep8ybHc4olqkFkxw4XKIJqNq9AnkKwPJs
        ntmlGyc2YBwoaeA9wMgh+KfJXuXzhCA9zV9v0P/5ZBJ7d/TfMWoGjzdHffazjNtc
        FFHy9jq3oSNgf8fRk0k0xMRJ0ue6sKEchpgTdlpo7Vh0BdN3ojlLzKVqAPFqtnGz
        IusmJCczXXmTiKw4lBSHd5FhqeGFagra94aLUvUkNM0nnwmo2VQV+z+Wjz3KTAn7
        E4dlyvSxLbok/XL/tgqNvY4slCcFLkobenWsWZ1ob9/C4QNoaw7+TxkJxiEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662826037; x=1662829637; bh=JrvbliJorVqJcIyq5312kNwoArSo
        X86rKwfhq5NsJN8=; b=FWLd/CSp7xk4cuSozcoPlVb/R4Cx3RUo+U6kkWuZ1t48
        XPbIe2GWn6wjFczejmQqXxdP36jrrjRJDzdWxeZjToUY8zlFgLr+UJARHQSjv/4u
        DFJxuS48ywnJrBVeAWEnno6E7cMhwyOtE4Bcsj1A/7UB/+xIIEVMAEuzKRoRFATF
        CGR8ggYn3I6hWJOwH0ddwjmkUQXknNT1Pr4pb8hMX/asTj97rO0+ECbRmQovFiRg
        X0gHVK2JHInoVf4uLp2Fn6w9PkRDZYzeQsBzAF+EQ9Or+JMw45rpKmcFhXY7hHXC
        cW0H060xKTWdwhWjUziNZGJn92KFhbNj3BIWr5qqpQ==
X-ME-Sender: <xms:NLYcY37KTIfrS-nsJJ_f5bBBjaBbydE28ddI1ryVC_P4YNNN7Dhorg>
    <xme:NLYcY86HvdHl522_A0phDeIYTu_NmipiDQerEbjtka0Vm47JzapU8kq9fAU7HZ4Gi
    v9Gkdik-6KeGXzUAaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NLYcY-c-_mJ0Mw-3rq2l7-0t37EmQdPCIvH3IzZ44gg0D0HUJyBaBg>
    <xmx:NLYcY4K-myaiQupL-nhE2erh7Vg0AJ4J5D9ExXBUfwZtGnT4F3kQXQ>
    <xmx:NLYcY7KtlPUPRMjke3ijSC4DP56t9LgUttf_8qtu1cSpBIRHyZBpOQ>
    <xmx:NbYcYwCS8BEsVELg-FneYBGK_90erOPWOKjZfzoWsH085tMipSQBFp0IM0s>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 24B97B60089; Sat, 10 Sep 2022 12:07:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
In-Reply-To: <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
 <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
Date:   Sat, 10 Sep 2022 18:06:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, "Huacai Chen" <chenhuacai@kernel.org>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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

On Sat, Sep 10, 2022, at 2:52 PM, Guo Ren wrote:
> On Thu, Sep 8, 2022 at 3:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Sep 8, 2022, at 4:25 AM, guoren@kernel.org wrote:
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> - When VMAP_STACK is set, make it possible to select non-power-of-two
>>   stack sizes. Most importantly, 12KB should be a really interesting
>>   choice as 8KB is probably still not enough for many 64-bit workloads,
>>   but 16KB is often more than what you need. You probably don't
>>   want to allow 64BIT/8KB without VMAP_STACK anyway since that just
>>   makes it really hard to debug, so hiding the option when VMAP_STACK
>>   is disabled may also be a good idea.
> I don't want this config to depend on VMAP_STACK. Some D1 chips would
> run with an 8K stack size and !VMAP_STACK.

That sounds like a really bad idea, why would you want to risk
using such a small stack without CONFIG_VMAP_STACK?

Are you worried about increased memory usage or something else?

>  /* thread information allocation */
> -#ifdef CONFIG_64BIT
> -#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
> -#else
> -#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
> -#endif
> +#define THREAD_SIZE_ORDER      CONFIG_THREAD_SIZE_ORDER
>  #define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)

This doesn't actually allow additional THREAD_SIZE values, as you
still round up to the nearest power of two.

I think all the non-arch code can deal with non-power-of-2
sizes, so you'd just need

#define THREAD_SIZE round_up(CONFIG_THREAD_SIZE, PAGE_SIZE)

and fix up the risc-v specific code to do the right thing
as well. I now see that THREAD_SIZE_ORDER is not actually
used anywhere with CONFIG_VMAP_STACK, so I suppose that
definition can be skipped, but you still need a THREAD_ALIGN
definition that is a power of two and at least a page larger
than THREAD_SIZE.

     Arnd
