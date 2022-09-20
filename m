Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620965BDDFD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 09:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiITHSL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiITHSK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 03:18:10 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5555A7;
        Tue, 20 Sep 2022 00:18:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 8FB5B2B05FC0;
        Tue, 20 Sep 2022 03:18:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 20 Sep 2022 03:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663658287; x=1663661887; bh=LvNsqUSk6C
        VCiNNoqcWQ4F99wUt4fhfxMlYywrwPN6k=; b=TVdtYthFfEARf+agjGfErq4CvH
        Z6FnpfSgA86pGm7O3Nt3OK2hqHCQs5nLA/n7OxxlgFa2CBQ53CulfjXa9TW6nGEC
        kQF0ny96tpYS9a8svyRyvMjRQrMXGMH5fjDWaWv3QwX7ctCECQ7wQE+GMWrX8gsF
        tpjyccoWR7vpIT7yTqTRRlrqCTg448qeWWLjHOLquZriUcjU/qvMjV2udRAuf4GB
        jutfDkTNmVgEJNAQA4RIdnWJrDtB1UKJ2ADb5eTmECh6HGGsTEmhqqkc+u+kp/Y6
        pv72xW/SIriFcRZ4w/on0GFbqP6Biw+RzqEHRAW8SYRgbp5GrchDfXgDED+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663658287; x=1663661887; bh=LvNsqUSk6CVCiNNoqcWQ4F99wUt4
        fhfxMlYywrwPN6k=; b=oOGiChK6G8Xoo6Lfj9nP4p1xdk3EMUm7DXOrH6kktuDl
        4l1UIDFy4iONbvI3/er6A5iGWw1QCHPxLvHQs/mKwbW63ul457G1Qzdsxi4vaMer
        hHModBqasatxyxQWnLoYIpTZ4ZZxeb9iiDn41Wi146u8rWnw+751VB8/ZM5Fdomj
        FD+alOr0WsUlshaNsfCGmLvZCX9Q3me+O35bKGshGa+tTHS1Oa5V7a8oOrrxeWF3
        mN+ZdwK9IEoDTUQ+r4fuUSd5tV+LCEzYD5tMUJrVACSy0EAJdEayYcqvNUXaL/FT
        6YxQvSNrGyaPmkmjbRf4SaL+KR8egYDXzed/0ZbxfA==
X-ME-Sender: <xms:LmkpYwuB0UAoGNFSv1ucS0G1jy8b4eSr6wI_6m1wccPSlAdeV31nZg>
    <xme:LmkpY9fvPZv9wRdzLdVXkdd1te9DmTw7rcJiUfnprBWWhJ-o10sJg4hCWSfFL-nPa
    lNOPb4Z3v6-qekA4xo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LmkpY7ygbkJaktw45WbT9SL2DxCR1ZzUpz7gtblg_eDR4mANmfGWfw>
    <xmx:LmkpYzPEtieCJGcAhgyW6oRWo9hcUxO_ADF4nB86WJJT-TGNYEPxMA>
    <xmx:LmkpYw8gX3IexwBknny5tso8GC8RBY6hn7sRQzH8u75dBzwPH60DpA>
    <xmx:L2kpYz1MiAkGixFYUIVdrL1tQTooNaO5qAj9CQcrz5Avm9Ay58Deb2kjUKFtEjTU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49279B60086; Tue, 20 Sep 2022 03:18:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <7a2379cf-c1cf-46af-9172-334d2b9b88d5@www.fastmail.com>
In-Reply-To: <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
 <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
 <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
Date:   Tue, 20 Sep 2022 09:17:45 +0200
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 20, 2022, at 2:46 AM, Guo Ren wrote:

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index dfe600f3526c..8def456f328c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -442,6 +442,16 @@ config IRQ_STACKS
>           Add independent irq & softirq stacks for percpu to prevent
> kernel stack
>           overflows. We may save some memory footprint by disabling IRQ_STACKS.
>
> +config THREAD_SIZE
> +       int "Kernel stack size (in bytes)" if EXPERT
> +       range 4096 65536
> +       default 8192 if 32BIT && !KASAN
> +       default 32768 if 64BIT && KASAN
> +       default 16384
> +       help
> +         Specify the Pages of thread stack size (from 4KB to 64KB), which also
> +         affects irq stack size, which is equal to thread stack size.

I still think this should be guarded in a way that prevents
setting the stack to smaller than default values unless VMAP_STACK
is set as well.

    Arnd
