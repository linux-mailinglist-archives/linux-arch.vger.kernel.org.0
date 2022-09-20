Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997975BDDFA
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 09:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiITHQn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITHQ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 03:16:26 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032AE356D1;
        Tue, 20 Sep 2022 00:15:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id DFCE42B06063;
        Tue, 20 Sep 2022 03:15:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 20 Sep 2022 03:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663658139; x=1663661739; bh=41Je5rgJig
        gwYk1/1K8oAn+kRFxX2sdezVwPUGJRJnk=; b=U2i1/sSYv/UI8p9X1QbnDZ5S6J
        HxSDqnHHIz31mY/p2+icdxlly380iPZJDokDJJ9EHPlFKjdoMk+EiNA5H9K2akiD
        TThS8i9Mr5MY9eDEpz4a4XHr5UXa5TMi39/H0gW9O+VVRtRP9SR6+WvKHL7lDaM9
        1S0AHcaTwf6ZW7v5jhr6VZbCZJe/2ojRluhDMLfT4FT/bbEe51xGjJSdZBd1HWum
        vgTmOGlW8lmJZ7prjEJ0HTx4vQJZT/e6JdShH//b2v+yW469VxaPG0xpt1wiEOAC
        Uc4Fr4bv0EFXjW1C8yuiiFRG+mmT1XeBwV5U3TY/lUzFzYdnRsiN7m3HQQjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663658139; x=1663661739; bh=41Je5rgJiggwYk1/1K8oAn+kRFxX
        2sdezVwPUGJRJnk=; b=uSnRviBhBLxRCoWwApAskqVomu+4EqJ2O++CBuhbcTw4
        uSQMx4lDvg4SlZH9p4XZ6Kng4KiI27p58dFO/Y5J9NtTx3lQwu84XfHnY39M00h9
        Uloxh549qTjn8+mKitItF97nc3TgC3Rk0n8SZXGUjylTJ5BFLBnj+qjFYkCP26z1
        D2gZG6qZvYt9Z2D2QGrqDhkXCNgtZyzGe+Zae8bCgwdp72hSqmZE2FX/pNDBPNq2
        eVrYqPdL65ksEnHtAwV9ikM3Mcn9yyGgX/I2Ut2dOLy/Y80HVR152OyXlpJmJLXg
        sXGQ5m1b3LwJvD4n+jmLEJn0JW3158Qp6Qy/m4xu/g==
X-ME-Sender: <xms:mWgpYxxRt5aJq0pZMb2sGWHML8N3fbN319M7Vo7Hnc4ZlxGrIyvQZA>
    <xme:mWgpYxTNsjRxLxq_21OzR44wNm8lc-zEu8soGUzVVvyiYajumXXrw9IltutH0jyfk
    nWgzeS6eM1H3t4nGOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeethefgudekueejkeeludeiteefudejtdevleeiffetfffgffejheeltedt
    ieffveenucffohhmrghinhepvghnthhrhidrshgsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mWgpY7WhMXLy-QcIDiZgiW4p7JxP3YN9iGBNmfclRQHvMEFDO1fd4Q>
    <xmx:mWgpYzjkKYS4t3VWh7ZVKyVk6htqzr2gklPDP8WQxfciBH4rmoSlXQ>
    <xmx:mWgpYzBAxBhS94bvfNnMK-Zs19y87aOZqGv9Sjjr3u9K7pYgSxepCQ>
    <xmx:m2gpY75Brr7xYTdPBRO7xLzDLZRqYa222svXfWE0jXSQn1dZf_Igz47R5p-F0YUp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0767B60086; Tue, 20 Sep 2022 03:15:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <542a9b2e-016a-4e09-9edb-c268bfae885f@www.fastmail.com>
In-Reply-To: <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
 <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
 <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
Date:   Tue, 20 Sep 2022 09:15:12 +0200
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

>
> How about this one: (only THREAD_SIZE, no THREAD_ORDER&SHIFT.)
>
> -
>  /* thread information allocation */
> -#ifdef CONFIG_64BIT
> -#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
> -#else
> -#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
> -#endif
> -#define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
> +#define THREAD_SIZE            CONFIG_THREAD_SIZE


So far looks fine.

>
>  /*
>   * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
> - * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
> - * assembly.
> + * checking sp & THREAD_SIZE, which we can do cheaply in the entry assembly.
>   */
>  #ifdef CONFIG_VMAP_STACK
>  #define THREAD_ALIGN            (2 * THREAD_SIZE)
> @@ -36,7 +24,6 @@
>  #define THREAD_ALIGN            THREAD_SIZE
>  #endif

The THREAD_ALIGN does not, this only works for power-of-two numbers of
THREAD_SIZE, 

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 426529b84db0..1e35fb3bdae5 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -29,8 +29,8 @@ _restore_kernel_tpsp:
>
>  #ifdef CONFIG_VMAP_STACK
>         addi sp, sp, -(PT_SIZE_ON_STACK)
> -       srli sp, sp, THREAD_SHIFT
> -       andi sp, sp, 0x1
> +       srli sp, sp, PAGE_SHIFT
> +       andi sp, sp, (THREAD_SIZE >> PAGE_SHIFT)

I think this needs to use THREAD_ALIGN, not THREAD_SIZE.

      Arnd
