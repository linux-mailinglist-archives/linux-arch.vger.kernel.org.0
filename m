Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107B8779707
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjHKSYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjHKSYK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 14:24:10 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0F30DF;
        Fri, 11 Aug 2023 11:24:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 11EB65C0084;
        Fri, 11 Aug 2023 14:24:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 11 Aug 2023 14:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691778247; x=1691864647; bh=p0
        4Ig2LQORZjFjPeLJ6nDDxBJ784vjB9pUpH68JeUMY=; b=XPYyEEwqDc0SSIM93t
        LaifZep2YoUAJ/RsDg/1eFvFpKXpaA7qxVr0aYdsdalCvhzMDEt/ELCAKcQPF2bG
        QfFrh/iOHBsRqNfXnb8MmjbHBU0pPgLaQydWAAp3ctHPqkx9Suziar2uS+KctNfY
        r3+8mK5DnoP6IcWS4PsXYvXz73F9WojbPewTVsGP4fJfCuZ64WGOc/VvZvyrQ9cm
        kdnsNtvtkwAxk+actKB6319TiMgUKuaRqDW0EQ16ow8jw6eMhGWX1TjJ12IXvvua
        jeRJyARwmElnQN6I5i+RsR5n4rvYkpqOQWBIFm9oEKoXhfBP0pGogWmDZbenY9JM
        +AEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691778247; x=1691864647; bh=p04Ig2LQORZjF
        jPeLJ6nDDxBJ784vjB9pUpH68JeUMY=; b=RDoU4g0c98NP3tF3MD4/iv1dL2MeN
        HG7FlTum7bRF2L3bwCZuXCLEZsJJcybGrBr0/KwEOX+XCD5pZEWeS+q9HmsDmQbH
        dWxgeH2cAKrGd6NapydJQtoJnAQfRjsxMDhq/wOFXqGoKwF7EkxLkTTZDwqblB02
        9HlTMwNv9YmFd7mFV8za9mqFJGhBdQP15g3DQXFIQukBDB9/V0RaUWySZ0SmNAuz
        JuZDGs6W7NdHwg1cjvn4VMFesTHHphlsBJKubxmCWdBMZCdkHXyOI0ws9ZfIf0/v
        xWpsPopGOAhPlRg5XzC5k9ssoUNbi2NGH1vrenNhi8LurfsWvD+Bh2WQA==
X-ME-Sender: <xms:xXzWZEIlT8ILYYBeVsBX9t_HPEQuK8KzmwkySxudNQsEzrDFI0kppg>
    <xme:xXzWZEJF-rPJMqhbS41DkvbayQOrQHkDdIjjpTKqsZ1TpaS7UypBO8hc8fLqO7zDF
    Oem0A6JBD8MuZBSZHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xXzWZEshAYi2ZWO22sB1HA6kfQe5f0I9VNhHplC3i510rj9cExpfRA>
    <xmx:xXzWZBb7a-w_xPe2PBjg72F1R1ZzPSHCUeQsTxStKvrkQ2QPBPROXA>
    <xmx:xXzWZLZwG3areom4Brvdnfi_e1qY8MOeg8J1YeYAnW2m6Tm9tp2Njw>
    <xmx:x3zWZP6jZ7t6Z6jrKEUtMHsHLaswA41KYhfLfaExkP3tWtyfFLJMuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF3EAB60089; Fri, 11 Aug 2023 14:24:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <defc2883-659b-4805-a279-783fbd3357cc@app.fastmail.com>
In-Reply-To: <20230811160939.GA426470@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-10-arnd@kernel.org>
 <20230811160939.GA426470@dev-arch.thelio-3990X>
Date:   Fri, 11 Aug 2023 20:23:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Guenter Roeck" <linux@roeck-us.net>, "Lee Jones" <lee@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 9/9] [RFC] extrawarn: enable more W=1 warnings by default
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023, at 18:09, Nathan Chancellor wrote:
> On Fri, Aug 11, 2023 at 04:03:27PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> A number of warning options from the W=1 set are completely clean in current
>> kernels, so we should just enable them by default, including a lot of warnings
>> that are part of -Wextra, so just turn on -Wextra by default.
>> 
>> The -Woverride-init, -Wvoid-pointer-to-enum-cast and
>> -Wmissing-format-attribute warnings are part of -Wextra but still produce
>> some legitimate warnings that need to be fixed, so leave them at the
>> W=1 level but turn them off otherwise.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ...
>> -KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
>> -KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
>
> I am still running through my builds but I don't think that dropping
> these three is acceptable at the moment. I see a good number of all of
> these warnings in -next still. I see some patches that I have picked up
> to address a couple of the really noisy ones but some others that I
> looked at are not fixed. I'll have a list eventually.

Ok, thanks. I have a backlog of warning fixes in my randconfig
tree, which is currently clean with these warnings addressed, at
least on arm/arm64/x86 and it looks like there are a couple that
I've never sent out so far. I'll drop the above for now, as I
won't have time to send all the fixes before my vacation.

I can provide the ones I have off-list for reference, but there
are a couple that are missing changelog texts or that I'm not
entirely sure about myself.

    Arnd
