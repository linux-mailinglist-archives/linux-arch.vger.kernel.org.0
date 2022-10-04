Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472EB5F4A4E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJDU2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDU2v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 16:28:51 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14EA6053D;
        Tue,  4 Oct 2022 13:28:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 642462B07588;
        Tue,  4 Oct 2022 16:28:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 04 Oct 2022 16:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664915325; x=1664918925; bh=L1dAVWM9hI
        49k06k8X7rdcp51n5V/7SEoorwe8xvFlI=; b=j8cpQrvHLhHNKhEn3FSlrRUTQj
        5lsbZnrGj2dMGEEfIx0TQ9xiYQabFZT4XLrcrcUp62XVyB8uA49q72FJXJlsLShr
        BCyzwPeo2aLCbThGQXpRcWByrlnPRpc6ZHtgjKRek/KM2FBFeKP4kdDHZ1Ehfxcy
        /ImnlH5l7ErXVwPNmMGtgAoa66tSAtkMr+1D05nvRkHjwMBH6XKnpTdQtWUubEon
        S3VbWx6IVb+GO1xRjlclEo6lvJT0SshFmsHMxot+4agGPGEcjuvVrlY1ndypU/L5
        fxxwx7TgvBtWGPXFf+sZoYqPumpurU+4wHGjsxCeKC4WJqPSEFRUN3dBJMug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664915325; x=1664918925; bh=L1dAVWM9hI49k06k8X7rdcp51n5V
        /7SEoorwe8xvFlI=; b=k5m7Y7OwQG6MkZMKZrFceyesFcpw6IFEcb05DnsbFqI7
        v66JTiurhtijoCTNJOYeoWtn2EtbP0WTnIIQ9qNKtDo07Ae1BTyYHgfXAetuULms
        ypQaVEdZrnEYsIYJk3H+4i4vha8QEi36nThhgAOrMsGRj5T3NmhXBpUc+Nc/o0jq
        e+ZPYZehNxhV9awc0dTxHIHmQ9xFWZ+hj9ExIl7LKQsSm8KRZkAIV52c7ENLWcdP
        MzlvcbSLagM/MlUP16rqxUg2uJXxzVHS0cWtb8kFBw7YATrK5vsTv5Pt34tHFQsR
        xhPUDYojtL5zpkwx/VmdbArMq5yGN4unrZ9w5xYQaQ==
X-ME-Sender: <xms:fZc8Y3MDoGyL29mpkOETlQkKiH25J4PoDdrmCj5jchVZ7XmRzn087Q>
    <xme:fZc8Yx_mNDO3KsnrP3EV7x2CV9XDaUA4Yd3IClI1uz7SVvrE_kncLRTQZLKGHNlZG
    zNwl9gbxNEhDCFGIiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fZc8Y2QtOlIOxcL_--d5LSeNWVL9VghAjvfb8rXHlF8G1E3m0kUHaA>
    <xmx:fZc8Y7uXoBxEqw1JYK0GWUOWivNzLLVhrZ6-AKD1ZiBucQ5kh8ZIuw>
    <xmx:fZc8Y_dgWr-_NqnE-hyNK1lTNeXRxJMkjZjn49L3YDkGcNr_4rl6Lw>
    <xmx:fZc8Y3QrMTDxJQYfsWXmsyuCh9niRZ8-z5vfjqWdcVA6POfwxz6pZ0WcgHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E61AB60086; Tue,  4 Oct 2022 16:28:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <2e110666-7519-4693-8a89-240cbb118c7e@app.fastmail.com>
In-Reply-To: <57200020-c460-74ec-c786-9a2c16f4870e@roeck-us.net>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <20221002224521.GA968453@roeck-us.net>
 <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
 <57200020-c460-74ec-c786-9a2c16f4870e@roeck-us.net>
Date:   Tue, 04 Oct 2022 22:28:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 4, 2022, at 9:42 PM, Guenter Roeck wrote:
> On 10/3/22 06:03, Arnd Bergmann wrote:
>> On Mon, Oct 3, 2022, at 12:45 AM, Guenter Roeck wrote:
>
> Looks like something was missed. When building alpha:allnoconfig
> in next-20221004:
>
> Building alpha:allnoconfig ... failed
> --------------
> Error log:
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> arch/alpha/kernel/core_marvel.c:807:1: error: conflicting types for 
> 'marvel_ioread8'; have 'unsigned int(const void *)'
>    807 | marvel_ioread8(const void __iomem *xaddr)
>        | ^~~~~~~~~~~~~~
> In file included from arch/alpha/kernel/core_marvel.c:10:
> arch/alpha/include/asm/core_marvel.h:335:11: note: previous declaration 
> of 'marvel_ioread8' with type 'u8(const void *)' {aka 'unsigned 
> char(const void *)'}
>    335 | extern u8 marvel_ioread8(const void __iomem *);
>        |           ^~~~~~~~~~~~~~

Right, I already noticed this and uploaded a fixed branch earlier today.
Should be ok tomorrow.

     Arnd
